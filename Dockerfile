FROM alpine:3.8

RUN apk --no-cache add ca-certificates
COPY skbn /usr/local/bin/skbn
RUN addgroup -g 1001 -S skbn \
    && adduser -u 1001 -D -S -G skbn skbn
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.16.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*
USER skbn
WORKDIR /home/skbn
CMD ["skbn"]
