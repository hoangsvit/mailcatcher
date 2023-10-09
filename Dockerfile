FROM ruby:3.2-alpine
MAINTAINER Samuel Cochran <sj26@sj26.com>

# Use --build-arg VERSION=... to override
# or `rake docker VERSION=...`
ARG VERSION=0.9.0

# sqlite3 aarch64 is broken on alpine, so use ruby:
# https://github.com/sparklemotion/sqlite3-ruby/issues/372
RUN apk add --no-cache build-base sqlite-libs sqlite-dev && \
    ( [ "$(uname -m)" != "aarch64" ] || gem install sqlite3 --version="~> 1.3" --platform=ruby ) && \
    gem install mailcatcher -v "$VERSION" && \
    apk del --rdepends --purge build-base sqlite-dev

EXPOSE 80 1080

ENTRYPOINT ["mailcatcher", "--foreground"]
CMD ["--ip", "127.0.0.1"]
