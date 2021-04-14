package domain

import "time"

type RiwayatPendidikan struct {
	ID                *int64     `json:"id"`
	IDPegawai         *int64     `json:"id_pegawai"`
	TingkatPendidikan *string    `json:"tingkat_pendidikan"`
	NamaSekolah       *string    `json:"nama_sekolah"`
	Tempat            *string    `json:"tempat"`
	Jurusan           *string    `json:"jurusan"`
	TahunLulus        *string    `json:"tahun_lulus"`
	CreatedAt         *time.Time `json:"created_at"`
}
