FROM alpine:latest as builder
RUN apk update \
      && apk upgrade
RUN apk add rust cargo openssl openssl-dev
RUN cargo install \
      --git https://git.sr.ht/~int80h/gemserv \
      gemserv

FROM alpine:latest as gemserv
LABEL Author="Daniel Jongepier <daniel@famjongepier.nl>"
RUN apk update \
      && apk upgrade
RUN apk add openssl libgcc
      

COPY --from=builder /root/.cargo/bin/gemserv /usr/local/bin/gemserv

CMD ["gemserv", "/gemserv/config.toml"]
