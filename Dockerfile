# syntax=docker/dockerfile:1

FROM golang AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./
RUN go build -o /istio-unittest-time-client

##
## Deploy
##
FROM alpine

WORKDIR /

COPY --from=build /istio-unittest-time-client /istio-unittest-time-client

EXPOSE 8081

USER nonroot:nonroot

ENTRYPOINT ["/istio-unittest-time-client"]