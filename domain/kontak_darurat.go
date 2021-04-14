package domain

import "time"

type KontakDarurat struct {
	ID           *int64     `json:"id"`
	IDPegawai    *int64     `json:"id_pegawai"`
	NamaLengkap  *string    `json:"nama_lengkap"`
	Hubungan     *string    `json:"hubungan"`
	AlamatRumah  *string    `json:"alamat_rumah"`
	NOTelpRumah  *string    `json:"no_telp_rumah"`
	NOTelpKantor *string    `json:"no_telp_kantor"`
	Keterangan   *string    `json:"keterangan"`
	CreatedAt    *time.Time `json:"created_at"`
}
