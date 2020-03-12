#!/bin/bash
set -e

# SOURCE: https://www.digitalocean.com/community/tutorials/how-to-create-a-cluster-of-docker-containers-with-docker-swarm-and-digitalocean-on-ubuntu-16-04

# Usage:: include DOTOKEN as a param in the command line, with your DigitalOcean API token

NODE_COUNT=2
NODE_PREFIX="taco-4-7"

for ((i=1;i<=$NODE_COUNT;i++))
do 
    
    # docker-machine ssh $NODE_PREFIX-node-$i ufw reload
    # docker-machine ssh $NODE_PREFIX-node-$i ufw enable
    # docker-machine ssh $NODE_PREFIX-node-$i systemctl restart docker --force

    if [ $i != 1 ]
    then
        # docker-machine ssh $NODE_PREFIX-node-$i ufw allow 2377/tcp
    fi
    
done

# SSL certs...
# source: https://finnian.io/blog/ssl-with-docker-swarm-lets-encrypt-and-nginx/
# docker-machine ssh $NODE_PREFIX-node-1 docker run --rm  -p 443:443 -p 80:80 --name letsencrypt -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly -n -m "yourstruly@jterhorst.com" -d supertaco.dev --standalone --agree-tos
# docker-machine ssh $NODE_PREFIX-node-1 docker run --rm  -p 443:443 -p 80:80 --name letsencrypt -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly -n -m "yourstruly@jterhorst.com" -d swarm.supertaco.dev --standalone --agree-tos


# then run our deploy.sh...

# via ssh
