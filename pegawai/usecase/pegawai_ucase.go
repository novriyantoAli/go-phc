package usecase

import (
	"context"
	"time"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type pegawaiUsecase struct {
	Timeout    time.Duration
	Repository domain.PegawaiRepository
}

func NewUsecase(timeout time.Duration, r domain.PegawaiRepository) domain.PegawaiUsecase {
	return &pegawaiUsecase{Timeout: timeout, Repository: r}
}

func (u *pegawaiUsecase) Get(c context.Context, nik string) (res domain.Pegawai, err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	pegawai := domain.Pegawai{}
	pegawai.NIK = &nik

	res, err = u.Repository.Find(ctx, pegawai)
	if err != nil {
		logrus.Error(err)
	}

	return
}

func (u *pegawaiUsecase) Store(c context.Context, pegawai *domain.Pegawai) (err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	err = u.Repository.Insert(ctx, pegawai)
	if err != nil {
		logrus.Error(err)
	}

	return
}
