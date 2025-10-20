FROM golang:1.21-alpine3.20

RUN adduser -D gouser

WORKDIR /app

COPY . .
RUN go mod download

RUN go build -o server .

EXPOSE 8080

FROM scratch
COPY --from=0 /app/server /server
CMD ["/server"]