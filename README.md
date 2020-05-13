# taco-rails-docker
Experiment with Rails, Docker/Docker Machine, local domains, and delayed jobs

### objectives:
- [x] Dummy Rails 6 app, with React/webpack running, basic controller and tests
- [x] webpack-dev-server should do hot reloading on docker local.
- [x] Delayed Jobs and cron to create a new daily taco special
- [x] Run a postgres node for dev/test, but on prod use a hosted instance.
- [x] Use a local domain - `taco.local` or `taco.test` - to access this Rails app running in (almost) the same env as it would in the cloud.
- [x] Use docker machine and create a setup of multiple Rails services and DelayedJob workers, which auto restart when they crash.
- [ ] Basic tests which run with Github Actions and push a build to Docker Hub when successful. Then deploy to the cloud on success.

## goals for later:
- [ ] (Maybe?) Switch from nginx to Traefik for load balancer/frontend to use it for SSL with Certbot, allowing for DNS challenge and wildcard cert. (Currently, we have to manually specify all domains in the docker-compose file.) ([more about wildcards and Traefik here](https://docs.traefik.io/v1.7/configuration/acme/) and [here](https://docs.traefik.io/v1.7/user-guide/docker-and-lets-encrypt/)) - [Docker](https://hub.docker.com/_/traefik/)

## Other TODO tasks

* Clean up these warnings:
```
npm WARN npm npm does not support Node.js v10.15.2
npm WARN npm You should probably upgrade to a newer version of node as we
npm WARN npm can't make any promises that npm will work with this version.
npm WARN npm Supported releases of Node.js are the latest release of 4, 6, 7, 8, 9.
npm WARN npm You can find the latest version at https://nodejs.org/
npm WARN fsevents@1.2.11 had bundled packages that do not match the required version(s). They have been replaced with non-bundled versions.
npm WARN react-hot-loader@4.12.20 requires a peer of @types/react@^15.0.0 || ^16.0.0 but none is installed. You must install peer dependencies yourself.
```

## Local domain

In your `/etc/hosts` file, add the line `127.0.0.1   taco.docker`
(If you want a different address, you'll need to update the instructions for mkcert below)

## Local SSL

https://codewithhugo.com/docker-compose-local-https/

`brew install mkcert`
then `mkcert -install`
(more here https://github.com/FiloSottile/mkcert#installation)

mkcert taco.docker localhost 127.0.0.1

cp ./taco.docker.pem ./nginx/certs/taco.docker.crt
cp ./taco.docker-key.pem ./nginx/certs/taco.docker.key

For webpack dev server, you might need something to accept the self-signed cert.

For debugging in Safari, open Keychain and remove existing items for `localhost` from this project. Then navigate to `/node_modules/webpack-dev-server/ssl/` and import `server.pem` into your default keychain (probably login). You must then "Get Info" on this localhost certificate, and set it to "Always Trust".

## Webpack-dev-server and SSL locally

The webpack-dev-server in development starts itself with a self-signed SSL cert.
You'll need to direct your browser to that page at `https://localhost:3035/` and accept the cert manually. Within the container, taco.docker communicates with webpack-dev-server just fine.

## About webpack-dev-server and docker

It's been an impossible task to have the dev server in a separate container and acheive SSL and HMR (hot reloading). 
The compromise was to put them in the same container, and use a script to call Foreman (with processes outlined in Procfile.dev) to launch both the puma (Rails server) and webpack-dev-server (via npm start). 

## Local Docker compose

For local environment for development, use Docker Compose on a macOS system with Mojave or later. Linux might work, but untested. Windows is unknown.

To start dev environemnt...

Add the file `config/master.key` into the app project with the contents of the key, and call this:

```docker-compose -f docker-compose.development.yml up```

## Running tests

With the above running compose stack, run...

```
docker-compose run -e "RAILS_ENV=test" taco_web rake db:create db:migrate
docker-compose run -e "RAILS_ENV=test" taco_web rake test
```

## swarm deploy

_(IMPORTANT: If you don't add the master key with one of the above methods, it will fail to deploy. This is an additional layer to protect secrets in this repo. Do not share the master key, and don't commit the master key in Git or other version control systems.)_

source: https://medium.com/softonic-eng/docker-compose-from-development-to-production-88000124a57c

for image builds to Docker Hub:
```
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml push
```

```
env $(cat .env | grep ^[A-Z] | xargs) docker stack deploy --compose-file docker-compose.yml stack-name
```

(Replace `stack-name` with the name you wish to use.)


### Node setup

Use `docker-machine-node-init.sh` locally to create the nodes you need.

### Export machines

```
npm install -g machine-share
machine-export {machine-name}
machine-import {machine-name.zip}
```