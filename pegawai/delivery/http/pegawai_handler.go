package http

import (
	"net/http"
	"strconv"

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
	g.POST("", handler.PostPegawai)
	g.PUT("", handler.PutPegawai)
	g.DELETE("/:id", handler.DeletePegawai)
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

func (h *pegawaiHandler) PostPegawai(e echo.Context) error {
	u := new(domain.Pegawai)
	if err := e.Bind(u); err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusBadRequest, ResponseError{Message: err.Error()})
	}

	if err := h.ucase.Store(e.Request().Context(), u); err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, u)
}

func (h *pegawaiHandler) PutPegawai(e echo.Context) error {
	u := new(domain.Pegawai)
	if err := e.Bind(u); err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusBadRequest, ResponseError{Message: err.Error()})
	}

	if err := h.ucase.Update(e.Request().Context(), *u); err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, u)
}

func (h *pegawaiHandler) DeletePegawai(e echo.Context) error {
	id := e.Param("id")

	idInt64, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: err.Error()})
	}

	res, err := h.ucase.Delete(e.Request().Context(), idInt64)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusAccepted, res)
}
