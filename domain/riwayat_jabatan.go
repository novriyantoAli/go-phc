package domain

import "time"

type RiwayatJabatan struct {
	ID             *int64     `json:"id"`
	IDPegawai      *int64     `json:"id_pegawai"`
	Tipe           *string    `json:"tipe"`
	TerhitungMulai *time.Time `json:"terhitung_mulai"`
	NomorSK        *string    `json:"nomor_sk"`
	JabatanLama    *string    `json:"jabatan_lama"`
	JabatanBaru    *string    `json:"jabatan_baru"`
	DepartemenLama *string    `json:"departemen_lama"`
	DepartemenBaru *string    `json:"departemen_baru"`
	MasaKerja      *string    `json:"masa_kerja"`
	Keterangan     *string    `json:"keterangan"`
	CreatedAt      *time.Time `json:"created_at"`
}
