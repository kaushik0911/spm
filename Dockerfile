FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /spm
WORKDIR /spm
COPY Gemfile /spm/Gemfile
COPY Gemfile.lock /spm/Gemfile.lock
RUN bundle install
COPY . /spm