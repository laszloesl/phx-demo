### BUILD APP

FROM elixir:1.9-alpine AS build

ARG BUILD_PATH=/tmp/src

ENV LANG=C.UTF-8 TERM=xterm
ENV MIX_ENV=prod SASL=true
ENV APPSIGNAL_BUILD_FOR_MUSL 1

RUN mkdir -p ${BUILD_PATH}
WORKDIR ${BUILD_PATH}

RUN apk upgrade --update musl && \
  apk add --no-cache bash bc curl g++ gcc git openssh-client make openssl unzip && \
  rm -rf /var/cache/apk/*

COPY . .

RUN mix local.hex --force && \
  mix local.rebar --force

RUN mix deps.get && mix release

### CREATE IMAGE

FROM alpine:3.9

ARG INSTALL_PATH=/app

# Setup environment
ENV LANG=C.UTF-8 TERM=xterm
ENV REPLACE_OS_VARS=true

RUN mkdir -p ${INSTALL_PATH}

# Add dependencies
RUN apk upgrade --update musl && \
  apk add --no-cache bc openssl && \
  rm -rf /var/cache/apk/*

WORKDIR ${INSTALL_PATH}

COPY --from=build /tmp/src/_build/prod/rel/demo/ "${INSTALL_PATH}/"

ENV PATH="${INSTALL_PATH}/bin:${PATH}"

ENTRYPOINT ["demo"]

CMD ["start"]
