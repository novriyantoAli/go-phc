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

type provinsiHandler struct {
	Usecase domain.ProvinsiUsecase
}

func NewHandler(e *echo.Echo, usecase domain.ProvinsiUsecase) {
	handler := &provinsiHandler{Usecase: usecase}

	isLoggedIn := middleware.JWTWithConfig(middleware.JWTConfig{
		SigningKey: []byte(viper.GetString(`server.secret`)),
	})

	g := e.Group("/api/provinsi", isLoggedIn)
	g.GET("", handler.SearchProvinsi)
}

func (h *provinsiHandler) SearchProvinsi(e echo.Context) error {
	namaProvinsi := e.QueryParam("provinsi")

	res, err := h.Usecase.Search(e.Request().Context(), namaProvinsi)
	if err != nil {
		logrus.Error(err)
		e.JSON(helper.TranslateError(err), helper.ResponseErrorMessage{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, res)

}
