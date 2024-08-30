FROM golang:1.23 AS builder

WORKDIR /app

COPY ./build/option5/go.mod ./

RUN go mod download

COPY ./build/option5/main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o main -ldflags "-s -w" main.go

FROM scratch

WORKDIR /root

COPY --from=builder /app/main .

CMD ["./main"]


