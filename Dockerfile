############################
# STEP 1 build executable binary
############################

FROM golang:1.12 AS builder

WORKDIR /go/src/app
COPY . /go/src/app

RUN go get -d -v ./...
RUN go build -o /go/bin/app

############################
# STEP 2 build the image using a stale version
############################

FROM golang:1.12

# Copy our static executable
COPY --from=builder /go/bin/app /app
WORKDIR /

# Run the hello binary.
CMD ["/app"]

LABEL Name=app-demo Version=0.0.1
