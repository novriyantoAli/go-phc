package mysql

import (
	"context"
	"database/sql"

	"github.com/novriyantoAli/go-phc/domain"
)

type mysqlRepository struct {
	Conn *sql.DB
}

func NewMysqlRepository(conn *sql.DB) domain.PegawaiRepository {
	return mysqlRepository{Conn: conn}
}

func (m *mysqlRepository) fetch(ctx context.Context, query string, args ...interface{}) (res []domain.Pegawai, err error) {
	rows, err := m.Conn.QueryContext(ctx, query, args)
	if err != nil {
		logrus.Error(err)
		return nil, err
	}

	defer func() {
		errRow := rows.Close()
		if errRow != nil {
			logrus.Error(errRow)
		}
	}()

	res = make([]domain.Pegawai, 0)
	for rows.Next() {
		t := domain.Pegawai{}
		err = rows.Scan(
			&t.ID,
			&t.IDKabupaten,
			&t.NIK,
			&t.NamaLengkap,
			&t.NamaPanggilan,
			&t.NKTP,
			&t.NOHP,
			&t.JenisKelamin,
			&t.TempatLahir,
			&t.TanggalLahir,
			&t.Agama,
			&t.StatusPerkawinan,
			&t.Kewarganegaraan,
			&t.GolonganDarah,
			&t.Bahasa,
			&t.Suku,
			&t.DaerahAsal,
			&t.TanggalMulaiBekerja,
			&t.JabatanSekarang,
			&t.Level,
			&t.Divisi,
			&t.Departemen,
			&t.Seksi,
			&t.Bagian,
			&t.StatusKaryawan,
			&t.TanggalPengangkatan,
			&t.MasaKerja,
			&t.NoRekening,
			&t.NoBPJSKesehatan,
			&t.NoBPJSKetenagakerjaan,
		)

		if err != nil {
			logrus.Error(err)
			return nil, err
		}

		// row location
		kabupaten := Kabupaten{}
		provinsi := Provinsi{}
		err := m.Conn.QueryRowContext(ctx, "SELECT kabupaten.*, provinsi.* FROM kabupaten INNER JOIN provinsi WHERE kabupaten.id_provinsi = provinsi.id WHERE kabupaten.id = ?", *t.IDKabupaten).Scan(
			&kabupaten.ID,
			&kabupaten.IDProvinsi,
			&kabupaten.NamaKabupaten,
			&provinsi.ID,
			&provinsi.NamaProvinsi,
		)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		kabupaten.Provinsi = &provinsi
		res.Kabupaten = &kabupaten

		rowsKabupaten.Close()

		// row keluarga
		rowsKeluarga, err := m.Conn.QueryContext(ctx, "SELECT * FROM keluarga WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		keluargas := make([]Keluarga, 0)
		for rowsKeluarga.Next() {
			kg := Keluarga{}
			err := rowsKeluarga.Scan(
				&kg.ID,
				&kg.IDPegawai,
				&kg.TipeHubungan,
				&kg.JenisKelamin,
				&kg.TanggalLahir,
				&kg.Pendidikan,
				&kg.Pekerjaan,
				&kg.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			keluargas = append(keluargas, kg)
		}
		res.Keluarga = &keluargas
		rowsKeluarga.Close()

		// row kontak darurat
		rowsKontakDarurat, err := m.Conn.QueryContext(ctx, "SELECT * FROM kontak_darurat WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		kontakdarurats := make([]KontakDarurat, 0)
		for rowsKontakDarurat.Next() {
			kd := KontakDarurat{}
			err := rowsKontakDarurat.Scan(
				&kd.ID,
				&kd.IDPegawai,
				&kd.NamaLengkap,
				&kd.Hubungan,
				&kd.AlamatRumah,
				&kd.NOTelpRumah,
				&kd.NOTelpKantor,
				&kd.Keterangan,
				&kd.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			kontakdarurats = append(kontakdarurats, kd)
		}
		res.KontakDarurat = &kontakdarurats
		rowsKontakDarurat.Close()

		// row riwayat pendidikan
		rowsRiwayatPendidikan, err := m.Conn.QueryContext(ctx, "SELECT * FROM riwayat_pendidikan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		riwayatpendidikans := make([]RiwayatPendidikan, 0)
		for rowsRiwayatPendidikan.Next() {
			rp := RiwayatPendidikan{}
			err := rowsRiwayatPendidikan.Scan(
				&rp.ID,
				&rp.IDPegawai,
				&rp.TingkatPendidikan,
				&rp.NamaSekolah,
				&rp.Tempat,
				&rp.Jurusan,
				&rp.TahunLulus,
				&rp.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			riwayatpendidikans = append(riwayatpendidikans, rp)
		}
		res.RiwayatPendidikan = &riwayatpendidikans
		rowsRiwayatPendidikan.Close()

		// row lokakarya
		rowsLokakarya, err := m.Conn.QueryContext(ctx, "SELECT * FROM lokakarya WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		lokakaryas := make([]Lokakarya, 0)
		for rowsLokakarya.Next() {
			lk := Lokakarya{}
			err := rowsLokakarya.Scan(
				&lk.ID,
				&lk.IDPegawai,
				&lk.NamaSeminar,
				&lk.LokasiPenyelenggaraan,
				&lk.TanggalMulai,
				&lk.TanggalSelesai,
				&lk.LamaHari,
				&lk.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			lokakaryas = append(lokakaryas, lk)
		}
		res.Lokakarya = &lokakaryas
		rowsLokakarya.Close()

		// row Pengalaman Kerja
		rowsPengalamanKerja, err := m.Conn.QueryContext(ctx, "SELECT * FROM pengalaman_kerja WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		pengalamankerjas := make([]PengalamanKerja, 0)
		for rowsPengalamanKerja.Next() {
			pk := PengalamanKerja{}
			err := rowsPengalamanKerja.Scan(
				&pk.ID,
				&pk.IDPegawai,
				&pk.DariTahun,
				&pk.SampaiTahun,
				&pk.NamaPerusahaan,
				&pk.Jabatan,
				&pk.AlasanBerhenti,
				&pk.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			pengalamankerjas = append(pengalamankerjas, pk)
		}
		res.PengalamanKerja = &pengalamankerjas
		rowsPengalamanKerja.Close()

		// row Riwayat Jabatan
		rowsRiwayatJabatan, err := m.Conn.QueryContext(ctx, "SELECT * FROM riwayat_jabatan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		riwayatjabatans := make([]RiwayatJabatan, 0)
		for rowsRiwayatJabatan.Next() {
			rj := RiwayatJabatan{}
			err := rowsRiwayatJabatan.Scan(
				&rj.ID,
				&rj.IDPegawai,
				&rj.Tipe,
				&rj.TerhitungMulai,
				&rj.NomorSK,
				&rj.JabatanLama,
				&rj.JabatanBaru,
				&rj.DepartemenLama,
				&rj.DepartemenBaru,
				&rj.MasaKerja,
				&rj.Keterangan,
				&rj.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			riwayatjabatans = append(riwayatjabatans, rj)
		}
		res.RiwayatJabatan = &riwayatjabatans
		rowsRiwayatJabatan.Close()

		// row Riwayat Penghargaan
		rowsRiwayatPenghargaan, err := m.Conn.QueryContext(ctx, "SELECT * FROM riwayat_penghargaan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		riwayatpenghargaaans := make([]RiwayatJabatan, 0)
		for rowsRiwayatJabatan.Next() {
			rj := RiwayatJabatan{}
			err := rowsRiwayatJabatan.Scan(
				&rj.ID,
				&rj.IDPegawai,
				&rj.Tipe,
				&rj.TerhitungMulai,
				&rj.NomorSK,
				&rj.JabatanLama,
				&rj.JabatanBaru,
				&rj.DepartemenLama,
				&rj.DepartemenBaru,
				&rj.MasaKerja,
				&rj.Keterangan,
				&rj.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			riwayatjabatans = append(riwayatjabatans, rj)
		}
		res.RiwayatJabatan = &riwayatjabatans
		rowsRiwayatJabatan.Close()

	}

}

func (m *mysqlRepository) Search(ctx context.Context, pegawai domain.Pegawai) (res []domain.Pegawai, err error) {

}
