# Etapa 1: Build
FROM golang:1.23-alpine AS builder

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./
RUN go build -o main cmd/web/main.go

# Etapa 2: Runtime
FROM alpine:3.18

WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
