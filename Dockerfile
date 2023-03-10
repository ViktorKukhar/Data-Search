# syntax=docker/dockerfile:1
FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /data_search
COPY Gemfile /data_search/Gemfile
COPY Gemfile.lock /data_search/Gemfile.lock
RUN gem install bundler -v 2.0.1
RUN bundle install
EXPOSE 3000
EXPOSE 80
EXPOSE 8080
# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
