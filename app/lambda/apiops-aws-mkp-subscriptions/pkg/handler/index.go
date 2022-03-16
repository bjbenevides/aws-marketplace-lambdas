package handler

import (
	"context"
//	"log"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
)

func Subscription(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
//	log.Print(req)

	return events.APIGatewayProxyResponse {
		StatusCode: http.StatusOK,
		Body:       http.StatusText(http.StatusOK),
	  }, nil
}