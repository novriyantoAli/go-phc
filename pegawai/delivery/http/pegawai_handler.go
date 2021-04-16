package http

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
	"github.com/novriyantoAli/go-phc/domain"
	"github.com/novriyantoAli/go-phc/helper"
	"github.com/sirupsen/logrus"
	"github.com/spf13/viper"
)

// ResponseError ...
type ResponseError struct {
	Message string `json:"error"`
}

type pegawaiHandler struct {
	ucase domain.PegawaiUsecase
}

func NewHandler(e *echo.Echo, usecase domain.PegawaiUsecase) {
	handler := &pegawaiHandler{ucase: usecase}

	isLoggedIn := middleware.JWTWithConfig(middleware.JWTConfig{
		SigningKey: []byte(viper.GetString(`server.secret`)),
	})

	g := e.Group("/api/pegawai", isLoggedIn)
	g.GET("", handler.GetPegawai)
}

func (h *pegawaiHandler) GetPegawai(e echo.Context) error {
	// get query param
	nik := e.QueryParam("nik")

	res, err := h.ucase.Get(e.Request().Context(), nik)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, res)
}
