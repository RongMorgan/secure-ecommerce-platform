FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o product-service

FROM gcr.io/distroless/static-debian11
WORKDIR /
COPY --from=builder /app/product-service /product-service
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/product-service"]
