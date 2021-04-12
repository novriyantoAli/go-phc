package usecase

import (
	"context"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
	"github.com/spf13/viper"
)

type usersUsecase struct {
	Timeout    time.Duration
	Repository domain.UsersRepository
}

// NewUsecase ...
func NewUsecase(t time.Duration, r domain.UsersRepository) domain.UsersUsecase {
	return &usersUsecase{Timeout: t, Repository: r}
}

// Login ...
func (uc *usersUsecase) Login(c context.Context, nik string, password string) (res domain.JWTCustomClaims, err error) {
	ctx, cancel := context.WithTimeout(c, uc.Timeout)
	defer cancel()

	user := domain.Users{}
	user.NIK = &nik
	user.Password = &password

	resUser, err := uc.Repository.Find(ctx, user)
	if err != nil {
		logrus.Error(err)
		return domain.JWTCustomClaims{}, err
	}

	if resUser == (domain.Users{}) {
		return domain.JWTCustomClaims{}, domain.ErrNotFound
	}

	claims := domain.JWTCustomClaims{
		NIK:   *resUser.NIK,
		ID:    *resUser.ID,
		Level: *resUser.Level,
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
