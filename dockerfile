FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN chmod -R 777 $INSTALL_PATH

COPY Gemfile ./

ENV BUNDLE_PATH /gems

RUN gem install bundler && bundle install --jobs=3 --retry=3

COPY . .

CMD [ "bundle","exec", "puma", "config.ru"] # CMD ["rails","server"] # you can also write like this.