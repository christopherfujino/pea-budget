FROM ruby:2.7.0-preview1-buster

RUN apt-get update -qq && \
  apt-get install -y nodejs \
    postgresql-client \
    less \
    yarnpkg && \
  apt-get clean

RUN ["ln", "-s", "/usr/bin/yarnpkg", "/usr/bin/yarn"]

VOLUME ["/myapp", "/usr/local/bundle"]
#RUN mkdir /myapp
WORKDIR /myapp
#COPY Gemfile /myapp/Gemfile
#COPY Gemfile.lock /myapp/Gemfile.lock
#RUN bundle install
#COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["/bin/bash"]
