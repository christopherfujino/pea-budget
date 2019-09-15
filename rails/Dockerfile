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

VOLUME ["/myapp", "/usr/local/bundle"]

RUN groupadd budget-user -g "$GROUP_ID"
RUN useradd -r -u "$USER_ID" -g "$GROUP_ID" --create-home budget-user

# Add a script to handle locally installing dependencies
ENTRYPOINT ["/myapp/dev-entrypoint.sh"]

WORKDIR /myapp
EXPOSE 3000

USER budget-user

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
