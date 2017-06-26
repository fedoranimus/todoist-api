FROM ruby:2.4-onbuild
MAINTAINER PotHix <willian@doist.com>
VOLUME /usr/src/app/source
EXPOSE 4567

RUN apt-get update -qq && apt-get install -y nodejs \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]