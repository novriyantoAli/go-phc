package domain

import "time"

type Provinsi struct {
	ID           *int64     `json:"id"`
	NamaProvinsi *string    `json:"nama_provinsi"`
	CreatedAt    *time.Time `json:"created_at"`
}
