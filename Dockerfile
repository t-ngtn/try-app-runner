FROM golang:1.20

WORKDIR /app
COPY go.mod ./
COPY *.go ./

RUN go mod tidy \
    && go build -o /try-app-runner

EXPOSE 8080

CMD ["./try-app-runner"]