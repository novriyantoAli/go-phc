package domain

import "time"

type RiwayatPenghargaan struct {
	ID               *int64     `json:"id"`
	IDPegawai        *int64     `json:"id_pegawai"`
	JenisPenghargaan *string    `json:"jenis_penghargaan"`
	TanggalDiterima  *time.Time `json:"tanggal_diterima"`
	Keterangan       *string    `json:"keterangan"`
	CreatedAt        *time.Time `json:"created_at"`
}
