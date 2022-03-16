# https://blog.rowanudell.com/getting-started-with-aws-sam-cli-and-golang/
# https://github.com/rowanu/sam-golang-starter
OUTPUT = main # Referenced as Handler in template.yaml
S3_BUCKET := $(S3_BUCKET)
STACK_NAME := $(STACK_NAME)
TEMPLATE = template.yaml

.PHONY: test
test:
	go test ./...

.PHONY: clean
clean:
	rm -f $(OUTPUT)


.PHONY: install
install:
	go get ./...

main: ./main.go
	go build -o $(OUTPUT) ./main.go

# compile the code to run in Lambda (local or real)
.PHONY: lambda
lambda:
	GOOS=linux GOARCH=amd64 $(MAKE) main

.PHONY: build
build: clean lambda

.PHONY: api
api: build
	sam local start-api
