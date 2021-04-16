package domain

import (
	"context"
	"time"
)

type Absen struct {
	ID            *int64     `json:"id"`
	IDPegawai     *int64     `json:"id_pegawai"`
	Tipe          *string    `json:"tipe"`
	DariTanggal   *time.Time `json:"dari_tanggal"`
	SampaiTanggal *time.Time `json:"sampai_tanggal"`
	Keterangan    *string    `json:"keterangan"`
	CreatedAt     *time.Time `json:"created_at"`
}

type RiwayatCuti struct {
	ID              *int64     `json:"id"`
	IDPegawai       *int64     `json:"id_pegawai"`
	Tahun           *int       `json:"tahun"`
	HakCuti         *int       `json:"hak_cuti"`
	PengambilanCuti *string    `json:"pengambilan_cuti"`
	SisaCuti        *int64     `json:"sisa_cuti"`
	CreatedAt       *time.Time `json:"created_at"`
}

type RiwayatKehadiran struct {
	ID         *int64     `json:"id"`
	IDPegawai  *int64     `json:"id_pegawai"`
	Tipe       *string    `json:"tipe"`
	Tahun      *string    `json:"tahun"`
	Keterangan *string    `json:"keterangan"`
	CreatedAt  *time.Time `json:"created_at"`
}

type AbsenRepository interface {
	Find(ctx context.Context, absen Absen) (res Absen, err error)
	Search(ctx context.Context, absen Absen) (res []Absen, err error)
	Insert(ctx context.Context, absen *Absen) (err error)
	Update(ctx context.Context, absen *Absen) (err error)
	Delete(ctx context.Context, id int64) (err error)
}

type AbsenUsecase interface {
	GroupIDPegawai(c context.Context, idPegawai int64) (res []Absen, err error)
	Update(c context.Context, absen *Absen) (err error)
	Store(c context.Context, absen *Absen) (err error)
	Delete(c context.Context, id int64) (res Absen, err error)
}
