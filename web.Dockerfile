# this image is used for containers for the Rails app, the workers, and the webpacker dev server (where applicable).

FROM ruby:2.6.5
MAINTAINER yourstruly@jterhorst.com

# base packages, if needed
RUN apt-get update -qq && curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y build-essential nodejs postgresql postgresql-contrib libstdc++6 libpq-dev g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x dirmngr gnupg software-properties-common libcurl4-openssl-dev libgtk2.0-0 libnotify-dev libgconf-2-4 xvfb libnss3 libxss1 libasound2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update -qq && apt-get install -y yarn && apt-get install -y npm
RUN npm install npm@latest -g

VOLUME ["/web"]

WORKDIR /web
COPY Gemfile Gemfile.lock ./
COPY ./ ./
RUN gem install bundler && bundle install

RUN npm install
RUN yarn install --check-files

# Add a script to be executed every time the container starts. This frames up env vars.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD "./startup.sh"

EXPOSE 8080 3035