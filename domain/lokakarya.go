package domain

import "time"

type Lokakarya struct {
	ID                    *int64     `json:"id"`
	IDPegawai             *int64     `json:"id_pegawai"`
	NamaSeminar           *string    `json:"nama_seminar"`
	LokasiPenyelenggaraan *string    `json:"lokasi_penyelenggaraan"`
	TanggalMulai          *time.Time `json:"tanggal_mulai"`
	TanggalSelesai        *time.Time `json:"tanggal_selesai"`
	LamaHari              *int       `json:"lama_hari"`
	CreatedAt             *time.Time `json:"created_at"`
}
