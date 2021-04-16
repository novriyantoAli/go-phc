package usecase

import (
	"context"
	"time"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type absenUsecase struct {
	Timeout    time.Duration
	Repository domain.AbsenRepository
}

func NewUsecase(t time.Duration, r domain.AbsenRepository) domain.AbsenUsecase {
	return &absenUsecase{Timeout: t, Repository: r}
}

func (u *absenUsecase) GroupIDPegawai(c context.Context, idPegawai int64) (res []domain.Absen, err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	absen := domain.Absen{}
	absen.ID = &idPegawai

	res, err = u.Repository.Search(ctx, absen)
	if err != nil {
		logrus.Error(err)
	}

	return
}

func (u *absenUsecase) Store(c context.Context, absen *domain.Absen) (err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	err = u.Repository.Insert(ctx, absen)
	if err != nil {
		logrus.Error(err)
	}

	return
}

func (u *absenUsecase) Update(c context.Context, absen *domain.Absen) (err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	err = u.Repository.Update(ctx, absen)

	return
}

func (u *absenUsecase) Delete(c context.Context, id int64) (res domain.Absen, err error) {
	ctx, cancel := context.WithTimeout(c, u.Timeout)
	defer cancel()

	absen := domain.Absen{}
	absen.ID = &id

	res, err = u.Repository.Find(ctx, absen)
	if err != nil {
		logrus.Error(err)
		return
	}

	if res == (domain.Absen{}) {
		logrus.Error("item not found")
		return res, domain.ErrNotFound
	}

	err = u.Repository.Delete(ctx, id)
	if err != nil {
		logrus.Error(err)
		return domain.Absen{}, err
	}

	return res, nil
}
