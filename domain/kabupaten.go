package domain

import (
	"context"
	"time"
)

type Kabupaten struct {
	ID            *int64     `json:"id"`
	IDProvinsi    *int64     `json:"id_provinsi"`
	NamaKabupaten *string    `json:"nama_kabupaten"`
	Provinsi      Provinsi   `json:"provinsi"`
	CreatedAt     *time.Time `json:"created_at"`
}

type KabupatenRepository interface {
	Search(ctx context.Context, kabupaten Kabupaten) (res []Kabupaten, err error)
}

type KabupatenUsecase interface {
	Search(c context.Context, namaKabupaten string, namaProvinsi string) (res []Kabupaten, err error)
}
