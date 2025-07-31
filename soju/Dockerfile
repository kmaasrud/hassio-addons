# Stage 1: build Soju binaries
FROM golang:1.21-alpine3.18 AS builder
ENV SOJU_VERSION v0.9.0
RUN apk add --no-cache git make build-base
WORKDIR /go/src/soju
RUN git clone https://codeberg.org/emersion/soju . \
    && git checkout $SOJU_VERSION \
    && make soju sojuctl sojudb

# Stage 2: runtime image (Home Assistant Alpine base)
ARG BUILD_FROM
FROM $BUILD_FROM
# Copy the compiled binaries from builder
COPY --from=builder /go/src/soju/soju /usr/bin/soju
COPY --from=builder /go/src/soju/sojuctl /usr/bin/sojuctl
COPY --from=builder /go/src/soju/sojudb /usr/bin/sojudb

# Prepare Soju runtime environment
RUN mkdir -p /run/soju
# Copy the add-on entrypoint
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Metadata for Home Assistant
LABEL io.hass.type="addon" \
      io.hass.version="${BUILD_VERSION}" \
      io.hass.arch="aarch64,armv7,amd64,i386"

CMD [ "/run.sh" ]
