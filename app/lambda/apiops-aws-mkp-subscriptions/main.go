package main

import (
	"bitbucket.org/sensedia/marketplace-integration-lambda/apiops-aws-mkp-subscriptions-lambda/pkg/handler"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler.Subscription)
}
