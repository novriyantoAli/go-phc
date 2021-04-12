package http

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/novriyantoAli/go-phc/domain"
	"github.com/novriyantoAli/go-phc/helper"
	"github.com/sirupsen/logrus"
)

// ResponseError ...
type ResponseError struct {
	Message string `json:"error"`
}

type usersHandler struct {
	ucase domain.UsersUsecase
}

// NewHandler ...
func NewHandler(e *echo.Echo, uc domain.UsersUsecase) {
	handler := &usersHandler{ucase: uc}

	// isLoggedIn := middleware.JWTWithConfig(middleware.JWTConfig{
	// 	SigningKey: []byte(viper.GetString(`server.secret`)),
	// })

	e.POST("/api/users/login", handler.Login)

	// group := e.Group("/api/users", isLoggedIn)
	// group.GET("", handler.Fetch)
	// group.POST("", handler.Save)
	// group.POST("/find", handler.Find)
	// group.PUT("", handler.Update)
	// group.DELETE("/:id", handler.Delete)
}

// Login ...
func (hn *usersHandler) Login(e echo.Context) error {
	// get query param
	nik := e.FormValue("nik")
	password := e.FormValue("password")

	if nik == "" {
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: "nik required..."})
	}

	if password == "" {
		return e.JSON(http.StatusFailedDependency, ResponseError{Message: "password required..."})
	}

	res, err := hn.ucase.Login(e.Request().Context(), nik, password)
	if err != nil {
		logrus.Error(err)
		return e.JSON(helper.TranslateError(err), ResponseError{Message: err.Error()})
	}

	return e.JSON(http.StatusOK, res)
}
