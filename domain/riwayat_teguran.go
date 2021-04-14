package domain

import "time"

type RiwayatTeguran struct {
	ID                 *int64     `json:"id"`
	IDPegawai          *int64     `json:"id_pegawai"`
	JenisPelanggaran   *string    `json:"jenis_pelanggaran"`
	TanggalDikeluarkan *string    `json:"tanggal_dikeluarkan"`
	Kesalahan          *string    `json:"kesalahan"`
	Keterangan         *string    `json:"keterangan"`
	CreatedAt          *time.Time `json:"created_at"`
}
