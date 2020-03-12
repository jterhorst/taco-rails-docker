#!/bin/bash
set -e

# SOURCE: https://www.digitalocean.com/community/tutorials/how-to-create-a-cluster-of-docker-containers-with-docker-swarm-and-digitalocean-on-ubuntu-16-04

# Usage:: include DOTOKEN as a param in the command line, with your DigitalOcean API token

NODE_COUNT=2
NODE_PREFIX="taco-4-15"

for ((i=1;i<=$NODE_COUNT;i++))
do 
    docker-machine create --driver digitalocean --digitalocean-image ubuntu-16-04-x64 --digitalocean-size s-1vcpu-2gb --digitalocean-access-token $DOTOKEN $NODE_PREFIX-node-$i
    
    # docker-machine ssh $NODE_PREFIX-node-$i mkdir /root/.ssh
    docker-machine scp ~/.ssh/id_rsa $NODE_PREFIX-node-$i:/root/.ssh/id_rsa
    docker-machine scp ~/.ssh/id_rsa.pub $NODE_PREFIX-node-$i:/root/.ssh/id_rsa.pub
    docker-machine scp ~/.ssh/known_hosts $NODE_PREFIX-node-$i:/root/.ssh/known_hosts
    # docker-machine scp ~/.ssh/config $NODE_PREFIX-node-$i:/root/.ssh/config

    docker-machine ssh $NODE_PREFIX-node-$i chmod 644 /root/.ssh/id_rsa.pub
    docker-machine ssh $NODE_PREFIX-node-$i chmod 600 /root/.ssh/id_rsa
        
    docker-machine ssh $NODE_PREFIX-node-$i git clone git@github.com:jterhorst/taco-rails-docker.git taco-rails-docker

    docker-machine scp .env $NODE_PREFIX-node-$i:/root/taco-rails-docker/.env

    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 22/tcp
    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 2376/tcp
    # if [ $i == 1 ]
    # then
        # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 2377/tcp
    # fi
    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 7946/tcp
    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 4789/udp

    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow ssh
    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow http
    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow https
    # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 5432
    
    # docker-machine ssh $NODE_PREFIX-node-$i ufw reload
    # docker-machine ssh $NODE_PREFIX-node-$i ufw enable
    # docker-machine ssh $NODE_PREFIX-node-$i ufw reload

    # docker-machine ssh $NODE_PREFIX-node-$i sudo shutdown -r now
done

# echo "waiting for everything to restart..."
# sleep 10

NODE1ADDR=$(docker-machine ip $NODE_PREFIX-node-1)

docker-machine ssh $NODE_PREFIX-node-1 docker swarm init --advertise-addr "$NODE1ADDR"
SWARM_TOKEN=$(docker-machine ssh $NODE_PREFIX-node-1 docker swarm join-token worker --quiet)

for ((i=2;i<=$NODE_COUNT;i++))
do
    docker-machine ssh $NODE_PREFIX-node-$i docker swarm join --token $SWARM_TOKEN $NODE1ADDR:2377
done

docker-machine ssh $NODE_PREFIX-node-1 docker node ls

docker-machine ssh $NODE_PREFIX-node-1 cd taco-rails-docker && docker-machine ssh $NODE_PREFIX-node-1 sh ./deployment/deploy.sh

# I might be able to share these?
# https://medium.com/@cweinberger/docker-machine-export-and-import-34ae2899e9d7

