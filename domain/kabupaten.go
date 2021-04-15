package domain

import "time"

type Kabupaten struct {
	ID            *int64     `json:"id"`
	IDProvinsi    *int64     `json:"id_provinsi"`
	NamaKabupaten *string    `json:"nama_kabupaten"`
	Provinsi      Provinsi   `json:"provinsi"`
	CreatedAt     *time.Time `json:"created_at"`
}
