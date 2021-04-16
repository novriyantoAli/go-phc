package domain

import (
	"context"
	"time"
)

type Pegawai struct {
	ID                     *int64             `json:"id"`
	IDKabupaten            *int64             `json:"id_kabupaten"`
	NIK                    *string            `json:"nik"`
	NamaLengkap            *string            `json:"nama_lengkap"`
	NamaPanggilan          *string            `json:"nama_panggilan"`
	Alamat                 *string            `json:"alamat"`
	NKTP                   *string            `json:"nktp"`
	NOHP                   *string            `json:"nohp"`
	JenisKelamin           *string            `json:"jenis_kelamin"`
	TempatLahir            *string            `json:"tempat_lahir"`
	TanggalLahir           *time.Time         `json:"tanggal_lahir"`
	Agama                  *string            `json:"agama"`
	StatusPerkawinan       *string            `json:"status_perkawinan"`
	Kewarganegaraan        *string            `json:"kewarganegaraan"`
	GolonganDarah          *string            `json:"golongan_darah"`
	Bahasa                 *string            `json:"bahasa"`
	Suku                   *string            `json:"suku"`
	DaerahAsal             *string            `json:"daerah_asal"`
	TanggalMulaiBekerja    *time.Time         `json:"tanggal_mulai_bekerja"`
	JabatanSekarang        *string            `json:"jabatan_sekarang"`
	Level                  *string            `json:"level"`
	Divisi                 *string            `json:"divisi"`
	Departemen             *string            `json:"departemen"`
	Seksi                  *string            `json:"seksi"`
	Bagian                 *string            `json:"bagian"`
	StatusKaryawan         *string            `json:"status_karyawan"`
	TanggalPengangkatan    *time.Time         `json:"tanggal_pengangkatan"`
	MasaKerja              *int               `json:"masa_kerja"`
	NoRekening             *string            `json:"no_rekening"`
	NoBPJSKesehatan        *string            `json:"no_bpjs_kesehatan"`
	NoBPJSKetenagakerjaan  *string            `json:"no_bpjs_ketenagakerjaan"`
	CreatedAt              *time.Time         `json:"created_at"`
	Kabupaten              *Kabupaten         `json:"kabupaten"`
	Keluarga               []Keluarga         `json:"keluarga"`
	KontakDarurat          []KontakDarurat    `json:"kontak_darurat"`
	RiwayatPendidikan      []Pendidikan       `json:"riwayat_pendidikan"`
	Lokakarya              []Lokakarya        `json:"lokakarya"`
	PengalamanKerja        []PengalamanKerja  `json:"pengalaman_kerja"`
	RiwayatJabatan         []Jabatan          `json:"riwayat_jabatan"`
	RiwayatPenghargaan     []Penghargaan      `json:"riwayat_penghargaan"`
	RiwayatTeguran         []Teguran          `json:"riwayat_teguran"`
	RiwayatSuratPeringatan []SPeringatan      `json:"riwayat_surat_peringatan"`
	RiwayatKehadiran       []RiwayatKehadiran `json:"riwayat_kehadiran"`
	RiwayatCuti            []RiwayatCuti      `json:"riwayat_cuti"`
}

type PegawaiRepository interface {
	Search(ctx context.Context, pegawai Pegawai) (res []Pegawai, err error)
	Find(ctx context.Context, pegawai Pegawai) (res Pegawai, err error)
	Insert(ctx context.Context, pegawai *Pegawai) (err error)
	Update(ctx context.Context, pegawai Pegawai) (err error)
	Delete(ctx context.Context, id int64) (err error)
}

type PegawaiUsecase interface {
	Get(c context.Context, nik string) (res Pegawai, err error)
	Store(c context.Context, pegawai *Pegawai) (err error)
	Update(c context.Context, pegawai Pegawai) (err error)
	Delete(c context.Context, id int64) (res Pegawai, err error)
}
