package domain

import "time"

type Keluarga struct {
	ID           *int64     `json:"id"`
	IDPegawai    *int64     `json:"id_pegawai"`
	Nama         *string    `json:"nama"`
	TipeHubungan *string    `json:"tipe_hubungan"`
	JenisKelamin *string    `json:"jenis_kelamin"`
	TanggalLahir *time.Time `json:"tanggal_lahir"`
	Pendidikan   *string    `json:"pendidikan"`
	Pekerjaan    *string    `json:"pekerjaan"`
	CreatedAt    *time.Time `json:"created_at"`
}
