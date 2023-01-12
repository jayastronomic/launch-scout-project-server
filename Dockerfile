FROM ruby:3.0.0

RUN apt-get update -qq \
&& apt-get install -y build-essential libgmp-dev libxml2-dev libxslt1-dev zlib1g-dev

ADD . /server
ADD Gemfile /server/Gemfile
ADD Gemfile.lock /server/Gemfile.lock
WORKDIR /server
RUN bundle install

EXPOSE 4000

RUN bundle install
CMD ["bundle", "exec", "rails", "s", "-p", "4000", "-b", "0.0.0.0"]