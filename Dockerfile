FROM ruby:2.6.5

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install

COPY . .

RUN bundle install

EXPOSE 4567 

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]