package domain

import "time"

type SPeringatan struct {
	ID                 *int64     `json:"id"`
	IDPegawai          *int64     `json:"id_pegawai"`
	JenisSP            *string    `json:"jenis_sp"`
	TanggalDikeluarkan *time.Time `json:"tanggal_dikeluarkan"`
	MasaBerlaku        *string    `json:"masa_berlaku"`
	Kesalahan          *string    `json:"kesalahan"`
	Keterangan         *string    `json:"keterangan"`
	CreatedAt          *time.Time `json:"created_at"`
}
