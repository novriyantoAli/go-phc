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

type kabupatenHandler struct {
	ucase domain.KabupatenUsecase
}

func NewHandler(e *echo.Echo, usecase domain.KabupatenUsecase) {
	handler := &kabupatenHandler{ucase: usecase}

	isLoggedIn := middleware.JWTWithConfig(middleware.JWTConfig{
		SigningKey: []byte(viper.GetString(`server.secret`)),
	})

	g := e.Group("/api/kabupaten", isLoggedIn)
	g.GET("", handler.GetSearch)
}

func (h *kabupatenHandler) GetSearch(e echo.Context) error {
	keyword := e.QueryParam("keyword")

	res, err := h.ucase.Search(e.Request().Context(), keyword, keyword)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), helper.ResponseErrorMessage{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, res)
}
