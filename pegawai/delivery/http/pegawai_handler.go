package http

import (
	"github.com/labstack/echo"
	"github.com/novriyantoAli/go-phc/domain"
)

// ResponseError ...
type ResponseError struct {
	Message string `json:"error"`
}

type pegawaiHandler struct {
	ucase domain.PegawaiUsecase
}

func NewHandler(e *echo.Echo, usecase domain.PegawaiUsecase) {

}
