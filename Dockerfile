# Dockerize MyContentful Application
# https://docs.docker.com/compose/rails/#rebuild-the-application
FROM ruby:2.7.2

# Node Version
ENV NODE_VERSION 12

# Setup Yarn
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install dependencies
RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nodejs postgresql-client locales yarn

WORKDIR /mycontentful
COPY Gemfile /mycontentful/Gemfile
COPY Gemfile.lock /mycontentful/Gemfile.lock
COPY package.json /mycontentful/package.json
COPY yarn.lock /mycontentful/yarn.lock

# Deps
RUN gem install bundler:2.2.5
RUN bundle install
RUN yarn
COPY . /mycontentful

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Create cache file for development environment
RUN touch /mycontentful/tmp/caching-dev.txt

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]