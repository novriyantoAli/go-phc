package domain

import (
	"context"
	"time")


type Provinsi struct {
	ID           *int64     `json:"id"`
	NamaProvinsi *string    `json:"nama_provinsi"`
	CreatedAt    *time.Time `json:"created_at"`
}

type ProvinsiRepository interface {
	Get(ctx context.Context, provinsi Provinsi) (res []Provinsi, err error)
	Search(ctx context.Context, provinsi Provinsi)(res []Provinsi, err error)
	Insert(ctx context.Context, provinsi *Provinsi)(err error)
	Update(ctx context.Context, provinsi *Provinsi)(err error)
	Delete(ctx context.Context, id int64)(err error)
}
