FROM ruby:2.7.0-preview1-buster

ARG USER_ID
ARG GROUP_ID

RUN apt-get update -qq && \
  apt-get install -y nodejs \
    postgresql-client \
    less \
    yarnpkg && \
  apt-get clean

RUN ["ln", "-s", "/usr/bin/yarnpkg", "/usr/bin/yarn"]

RUN mkdir "/home/budget-user"

VOLUME ["/home/budget-user/myapp", "/usr/local/bundle"]

RUN groupadd budget-user
RUN useradd -r -u "$USER_ID" -g "$GROUP_ID" budget-user
RUN chown "$USER_ID":"$GROUP_ID" /home/budget-user
#RUN chown "$USER_ID":"$GROUP_ID" -R /home/budget-user/myapp
#RUN mkdir /myapp
#COPY Gemfile /myapp/Gemfile
#COPY Gemfile.lock /myapp/Gemfile.lock
#RUN bundle install
#COPY . /myapp

# Add a script to handle locally installing dependencies
COPY dev-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/dev-entrypoint.sh
ENTRYPOINT ["dev-entrypoint.sh"]

WORKDIR /home/budget-user/myapp
EXPOSE 3000

USER budget-user

# Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["/bin/bash"]
