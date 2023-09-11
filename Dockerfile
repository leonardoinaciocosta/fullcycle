FROM golang:1.21.1-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY  *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /fullcycle

FROM gcr.io/distroless/static-debian11 AS package

WORKDIR /

COPY --from=build /fullcycle /fullcycle

EXPOSE 8080

ENTRYPOINT [ "/fullcycle" ]