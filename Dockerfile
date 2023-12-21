FROM golang:1.18.0-alpine3.14 AS builder

WORKDIR /app

COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o is_blocked main.go

FROM alpine:3.14

ARG PORT=8080

COPY --from=builder /app/is_blocked /usr/local/bin/is_blocked

ENTRYPOINT ["/usr/local/bin/is_blocked"]
