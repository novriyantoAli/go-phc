package domain

import "time"

type PengalamanKerja struct {
	ID             *int64     `json:"id"`
	IDPegawai      *int64     `json:"id_pegawai"`
	DariTahun      *int       `json:"dari_tahun"`
	SampaiTahun    *int       `json:"sampai_tahun"`
	NamaPerusahaan *string    `json:"nama_perusahaan"`
	Jabatan        *string    `json:"jabatan"`
	AlasanBerhenti *string    `json:"alasan_berhenti"`
	CreatedAt      *time.Time `json:"created_at"`
}
