package helper

import (
	"net/http"

	"github.com/novriyantoAli/go-phc/domain"
)

type ResponseErrorMessage struct {
	Message string `json:"error"`
}

// TranslateError ...
func TranslateError(err error) int {
	switch err {
	case domain.ErrBadParamInput:
		return http.StatusBadRequest
	case domain.ErrConflict:
		return http.StatusConflict
	case domain.ErrNotFound:
		return http.StatusNotFound
	default:
		return http.StatusInternalServerError
	}
}
