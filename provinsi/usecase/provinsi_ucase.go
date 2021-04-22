package usecase

import (
	"context"
	"time"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type provinsiUsecase struct {
	Timeout    time.Duration
	Repository domain.ProvinsiRepository
}

func NewUsecase(timeout time.Duration, r domain.ProvinsiRepository) domain.ProvinsiUsecase {
	return &provinsiUsecase{Timeout: timeout, Repository: r}
}

func (u *provinsiUsecase) Get(c context.Context, id int64) (res []domain.Provinsi, err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	provinsi := domain.Provinsi{}
	provinsi.ID = &id

	res, err = u.Repository.Get(ctx, provinsi)
	if err != nil {
		logrus.Error(err)
	}

	return
}

func (u *provinsiUsecase) Search(c context.Context, nama string) (res []domain.Provinsi, err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	provinsi := domain.Provinsi{}
	provinsi.NamaProvinsi = &nama

	res, err = u.Repository.Search(ctx, provinsi)
	if err != nil {
		logrus.Error(err)
	}

	return
}
