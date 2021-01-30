# Dockerize MyContentful Application
# https://docs.docker.com/compose/rails/#rebuild-the-application
FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /mycontentful
COPY Gemfile /mycontentful/Gemfile
COPY Gemfile.lock /mycontentful/Gemfile.lock

# Deps
RUN gem install bundler:2.2.5
RUN bundle install
COPY . /mycontentful

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]