##### dockerize builder: built from source to support arm & x86 #####
FROM golang:bullseye AS dockerize-builder

RUN mkdir /build
WORKDIR /build

# We want to populate the module cache based on the go.{mod,sum} files.
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .

RUN go mod graph | awk '{if ($1 !~ "@") print $2}' | xargs go get
RUN cd cmd/temporalite && go build -o /build/temporalite -v  .

##### base-server target #####
FROM debian:bullseye-slim AS base-server

RUN mkdir /opt/temporal
WORKDIR /opt/temporal
COPY --from=dockerize-builder /build/temporalite .

# executable
ENTRYPOINT ["/opt/temporal/temporalite","start"]
# arguments that can be overridden
CMD ["-n","default","-f","/opt/temporal/data.db" ]