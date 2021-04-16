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

type ResponseError struct {
	Message string `json:"error"`
}

type absenHandler struct {
	ucase domain.AbsenUsecase
}

func NewHandler(e *echo.Echo, u domain.AbsenUsecase) {
	handler := &absenHandler{ucase: u}

	isLoggedIn := middleware.JWTWithConfig(middleware.JWTConfig{
		SigningKey: []byte(viper.GetString(`server.secret`)),
	})

	group := e.Group("api/absen", isLoggedIn)
	group.GET("/:idPegawai", handler.GetAbsen)
	group.POST("", handler.PostAbsen)
	group.PUT("", handler.PutAbsen)
	group.DELETE("/:idPegawai", handler.DeleteAbsen)
}

func (h *absenHandler) GetAbsen(e echo.Context) error {
	idPegawai := e.Param("idPegawai")
	idPegawaiInt64, err := strconv.ParseInt(idPegawai, 10, 64)
	if err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: err.Error()})
	}

	res, err := h.ucase.GroupIDPegawai(e.Request().Context(), idPegawaiInt64)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, res)
}

func (h *absenHandler) PostAbsen(e echo.Context) error {
	u := new(domain.Absen)
	if err := e.Bind(u);err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: err.Error()})
	}

	err := h.ucase.Store(e.Request().Context(), u)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), helper.ResponseErrorMessage{Message: err.Error()})
	}

	return e.JSON(http.StatusCreated, u)
}

func (h *absenHandler) PutAbsen(e echo.Context) error {
	u := new(domain.Absen)
	if err := e.Bind(u); err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: err.Error()})
	}

	err := h.ucase.Update(e.Request().Context(), u)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusAccepted, u)
}

func (h *absenHandler) DeleteAbsen(e echo.Context) error {
	idPegawai := e.Param("idPegawai")
	idPegawaiInt64, err := strconv.ParseInt(idPegawai, 10, 64)
	if err != nil {
		logrus.Error(err)
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: err.Error()})
	}

	res, err := h.ucase.Delete(e.Request().Context(), idPegawaiInt64)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusAccepted, res)
}
