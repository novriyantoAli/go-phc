package usecase

import (
	"context"
	"fmt"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
	"github.com/spf13/viper"
	"golang.org/x/crypto/bcrypt"
)

type usersUsecase struct {
	Timeout    time.Duration
	Repository domain.UsersRepository
}

// NewUsecase ...
func NewUsecase(t time.Duration, r domain.UsersRepository) domain.UsersUsecase {
	return &usersUsecase{Timeout: t, Repository: r}
}

func hashAndSalt(pwd []byte) string {

	// Use GenerateFromPassword to hash & salt pwd.
	// MinCost is just an integer constant provided by the bcrypt
	// package along with DefaultCost & MaxCost.
	// The cost can be any value you want provided it isn't lower
	// than the MinCost (4)
	hash, err := bcrypt.GenerateFromPassword(pwd, bcrypt.MinCost)
	if err != nil {
		logrus.Error(err)
	}
	// GenerateFromPassword returns a byte slice so we need to
	// convert the bytes to a string and return it
	return string(hash)
}

func comparePasswords(hashedPwd string, plainPwd []byte) bool {
	// Since we'll be getting the hashed password from the DB it
	// will be a string so we'll need to convert it to a byte slice
	byteHash := []byte(hashedPwd)
	err := bcrypt.CompareHashAndPassword(byteHash, plainPwd)
	if err != nil {
		logrus.Error(err)
		return false
	}

	return true
}

func (uc *usersUsecase) ResetPassword(c context.Context, nik string) (err error) {
	return domain.ErrBadParamInput
}

func (uc *usersUsecase) Register(c context.Context, nik string, telegramID string) (res string, err error) {
	return "", domain.ErrBadParamInput
}

func (uc *usersUsecase) ImportUsers(c context.Context, nik []string) (err error) {
	return domain.ErrBadParamInput
}

// Login ...
func (uc *usersUsecase) Login(c context.Context, nik string, password string) (res domain.JWTCustomClaims, err error) {
	ctx, cancel := context.WithTimeout(c, uc.Timeout)
	defer cancel()

	fmt.Println("password: ", hashAndSalt([]byte(password)))

	user := domain.Users{}
	user.NIK = &nik

	resUser, err := uc.Repository.Find(ctx, user)
	if err != nil {
		logrus.Error(err)
		return domain.JWTCustomClaims{}, err
	}

	if len(resUser) != 1 {
		logrus.Error("weird behaviour for result items")
		err = domain.ErrInvalidCredentials
		return domain.JWTCustomClaims{}, err
	}

	if !comparePasswords(*resUser[0].Password, []byte(password)) {
		return domain.JWTCustomClaims{}, domain.ErrInvalidCredentials
	}

	claims := domain.JWTCustomClaims{
		NIK:   *resUser[0].NIK,
		ID:    *resUser[0].ID,
		Level: *resUser[0].Level,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(time.Hour * 72).Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	t, err := token.SignedString([]byte(viper.GetString(`server.secret`)))
	if err != nil {
		logrus.Error(err)
		return domain.JWTCustomClaims{}, err
	}

	claims.Token = &t

	return claims, nil
}
