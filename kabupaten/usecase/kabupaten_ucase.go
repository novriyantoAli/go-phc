package usecase

import (
	"context"
	"time"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type kabupatenUsecase struct {
	Timeout    time.Duration
	Repository domain.KabupatenRepository
}

func NewUsecase(timeout time.Duration, r domain.KabupatenRepository) domain.KabupatenUsecase {
	return &kabupatenUsecase{Timeout: timeout, Repository: r}
}

func (u *kabupatenUsecase) Search(c context.Context, namaKabupaten string, namaProvinsi string) (res []domain.Kabupaten, err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	kabupaten := domain.Kabupaten{}
	kabupaten.NamaKabupaten = &namaKabupaten
	kabupaten.Provinsi.NamaProvinsi = &namaProvinsi

	res, err = u.Repository.Search(ctx, kabupaten)
	if err != nil {
		logrus.Error(err)
	}

	return
}
