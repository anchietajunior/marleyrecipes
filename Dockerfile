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
RUN apt-get install -y --no-install-recommends nodejs postgresql-client \
      locales yarn

WORKDIR /mycontentful
COPY Gemfile /mycontentful/Gemfile
COPY Gemfile.lock /mycontentful/Gemfile.lock

# Deps
RUN gem install bundler:2.2.5
RUN bundle install
COPY . /mycontentful

# Create cache file for development environment
RUN touch /mycontentful/tmp/caching-dev.txt

ENTRYPOINT ["bundle", "exec"]

EXPOSE 3000

# Assets precompile
RUN bundle exec rails assets:precompile

CMD ["rails", "server", "-b", "0.0.0.0"]