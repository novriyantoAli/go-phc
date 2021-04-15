package domain

import "time"

type Jabatan struct {
	ID             *int64     `json:"id"`
	IDPegawai      *int64     `json:"id_pegawai"`
	Tipe           *string    `json:"tipe"`
	TerhitungMulai *time.Time `json:"terhitung_mulai"`
	NomorSK        *string    `json:"no_sk"`
	NamaJabatan    *string    `json:"jabatan"`
	Departemen     *string    `json:"departemen"`
	MasaKerja      *string    `json:"masa_kerja"`
	Keterangan     *string    `json:"keterangan"`
	CreatedAt      *time.Time `json:"created_at"`
}
