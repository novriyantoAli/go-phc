package domain

import "time"

type RiwayatCuti struct {
	ID              *int64     `json:"id"`
	IDPegawai       *int64     `json:"id_pegawai"`
	Tahun           *int       `json:"tahun"`
	HakCuti         *int       `json:"hak_cuti"`
	PengambilanCuti *string    `json:"pengambilan_cuti"`
	SisaCuti        *int64     `json:"sisa_cuti"`
	CreatedAt       *time.Time `json:"created_at"`
}
