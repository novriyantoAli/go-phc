package domain

import "time"

type RiwayatKehadiran struct {
	ID         *int64     `json:"id"`
	IDPegawai  *int64     `json:"id_pegawai"`
	Tipe       *string    `json:"tipe"`
	Tahun      *string    `json:"tahun"`
	Keterangan *string    `json:"keterangan"`
	CreatedAt  *time.Time `json:"created_at"`
}
