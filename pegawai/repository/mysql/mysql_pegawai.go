package mysql

import (
	"context"
	"database/sql"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
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
		kabupaten := domain.Kabupaten{}
		provinsi := domain.Provinsi{}
		err := m.Conn.QueryRowContext(ctx, "SELECT kabupaten.*, provinsi.* FROM kabupaten INNER JOIN provinsi WHERE kabupaten.id_provinsi = provinsi.id WHERE kabupaten.id = ?", *t.IDKabupaten).Scan(
			&kabupaten.ID,
			&kabupaten.IDProvinsi,
			&kabupaten.NamaKabupaten,
			&kabupaten.CreatedAt,
			&provinsi.ID,
			&provinsi.NamaProvinsi,
			&provinsi.CreatedAt,
		)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		kabupaten.Provinsi = provinsi
		t.Kabupaten = &kabupaten

		// row keluarga
		rowsKeluarga, err := m.Conn.QueryContext(ctx, "SELECT * FROM keluarga WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		keluargas := make([]domain.Keluarga, 0)
		for rowsKeluarga.Next() {
			kg := domain.Keluarga{}
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
		t.Keluarga = keluargas
		rowsKeluarga.Close()

		// row kontak darurat
		rowsKontakDarurat, err := m.Conn.QueryContext(ctx, "SELECT * FROM kontak_darurat WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		kontakdarurats := make([]domain.KontakDarurat, 0)
		for rowsKontakDarurat.Next() {
			kd := domain.KontakDarurat{}
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
		t.KontakDarurat = kontakdarurats
		rowsKontakDarurat.Close()

		// row riwayat pendidikan
		rowsPendidikan, err := m.Conn.QueryContext(ctx, "SELECT * FROM pendidikan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		riwayatpendidikans := make([]domain.Pendidikan, 0)
		for rowsPendidikan.Next() {
			rp := domain.Pendidikan{}
			err := rowsPendidikan.Scan(
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
		t.RiwayatPendidikan = riwayatpendidikans
		rowsPendidikan.Close()

		// row lokakarya
		rowsLokakarya, err := m.Conn.QueryContext(ctx, "SELECT id, id_pegawai, nama_seminar, lokasi_penyelenggaraan, tanggal_mulai, tanggal_selesai, DATEDIFF(tanggal_selesai, tanggal_mulai) AS lama_hari, created_at FROM lokakarya WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		lokakaryas := make([]domain.Lokakarya, 0)
		for rowsLokakarya.Next() {
			lk := domain.Lokakarya{}
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
		t.Lokakarya = lokakaryas
		rowsLokakarya.Close()

		// row Pengalaman Kerja
		rowsPengalamanKerja, err := m.Conn.QueryContext(ctx, "SELECT * FROM pengalaman_kerja WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		pengalamankerjas := make([]domain.PengalamanKerja, 0)
		for rowsPengalamanKerja.Next() {
			pk := domain.PengalamanKerja{}
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
		t.PengalamanKerja = pengalamankerjas
		rowsPengalamanKerja.Close()

		// row Riwayat Jabatan
		rowsJabatan, err := m.Conn.QueryContext(ctx, "SELECT * FROM jabatan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		jabatans := make([]domain.Jabatan, 0)
		for rowsJabatan.Next() {
			rj := domain.Jabatan{}
			err := rowsJabatan.Scan(
				&rj.ID,
				&rj.IDPegawai,
				&rj.Tipe,
				&rj.TerhitungMulai,
				&rj.NomorSK,
				&rj.NamaJabatan,
				&rj.Departemen,
				&rj.Keterangan,
				&rj.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			jabatans = append(jabatans, rj)
		}
		t.RiwayatJabatan = jabatans
		rowsJabatan.Close()

		// row Penghargaan
		rowsPenghargaan, err := m.Conn.QueryContext(ctx, "SELECT * FROM penghargaan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		penghargaaans := make([]domain.Penghargaan, 0)
		for rowsPenghargaan.Next() {
			rj := domain.Penghargaan{}
			err := rowsPenghargaan.Scan(
				&rj.ID,
				&rj.IDPegawai,
				&rj.JenisPenghargaan,
				&rj.TanggalDiterima,
				&rj.Keterangan,
				&rj.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			penghargaaans = append(penghargaaans, rj)
		}
		t.RiwayatPenghargaan = penghargaaans
		rowsPenghargaan.Close()

		// row Teguran
		rowsTeguran, err := m.Conn.QueryContext(ctx, "SELECT * FROM teguran WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		tegurans := make([]domain.Teguran, 0)
		for rowsTeguran.Next() {
			rj := domain.Teguran{}
			err := rowsTeguran.Scan(
				&rj.ID,
				&rj.IDPegawai,
				&rj.JenisPelanggaran,
				&rj.TanggalDikeluarkan,
				&rj.Kesalahan,
				&rj.Keterangan,
				&rj.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			tegurans = append(tegurans, rj)
		}
		t.RiwayatPenghargaan = penghargaaans
		rowsTeguran.Close()

		// row Surat Peringatan
		rowsSperingatan, err := m.Conn.QueryContext(ctx, "SELECT * FROM speringatan WHERE id_pegawai = ?", *t.ID)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}
		speringatans := make([]domain.SPeringatan, 0)
		for rowsSperingatan.Next() {
			rj := domain.SPeringatan{}
			err := rowsSperingatan.Scan(
				&rj.ID,
				&rj.IDPegawai,
				&rj.JenisSP,
				&rj.TanggalDikeluarkan,
				&rj.MasaBerlaku,
				&rj.Kesalahan,
				&rj.Keterangan,
				&rj.CreatedAt,
			)
			if err != nil {
				logrus.Error(err)
				return nil, err
			}
			speringatans = append(speringatans, rj)
		}
		t.RiwayatPenghargaan = penghargaaans
		rowsSperingatan.Close()

				// row cuti
				// rowsSperingatan, err := m.Conn.QueryContext(ctx, "SELECT * FROM absen WHERE id_pegawai = ?", *t.ID)
				// if err != nil {
				// 	logrus.Error(err)
				// 	return nil, err
				// }
				// speringatans := make([]domain.SPeringatan, 0)
				// for rowsSperingatan.Next() {
				// 	rj := domain.SPeringatan{}
				// 	err := rowsSperingatan.Scan(
				// 		&rj.ID,
				// 		&rj.IDPegawai,
				// 		&rj.JenisSP,
				// 		&rj.TanggalDikeluarkan,
				// 		&rj.MasaBerlaku,
				// 		&rj.Kesalahan,
				// 		&rj.Keterangan,
				// 		&rj.CreatedAt,
				// 	)
				// 	if err != nil {
				// 		logrus.Error(err)
				// 		return nil, err
				// 	}
				// 	speringatans = append(speringatans, rj)
				// }
				// t.RiwayatPenghargaan = penghargaaans
				// rowsSperingatan.Close()

	}

	return

}

// Search(ctx context.Context, pegawai Pegawai) (res []Pegawai, err error)
func (m *mysqlRepository) Search(ctx context.Context, pegawai domain.Pegawai) (res []domain.Pegawai, err error) {
	query := `SELECT * FROM pegawai `
	args := make([]interface{}, 0)

	addWhere := false

	if pegawai.ID != nil {
		if addWhere == false {
			query += " WHERE id LIKE '%?%' "
			addWhere = true
		} else {
			query += " OR id LIKE '%?%' "
		}
		args = append(args, *pegawai.ID)
	}

	if pegawai.NIK != nil {
		if addWhere == false {
			query += " WHERE nik LIKE '%?%'"
			addWhere = true
		} else {
			query += " OR nik LIKE '%?%' "
		}
		args = append(args, *pegawai.NIK)
	}

	if pegawai.NamaLengkap != nil {
		if addWhere == false {
			query += " WHERE nama_lengkap LIKE '%?%'"
			addWhere = true
		} else {
			query += " OR nama_lengkap LIKE '%?%' "
		}
		args = append(args, *pegawai.NamaLengkap)
	}

	if pegawai.NamaPanggilan != nil {
		if addWhere == false {
			query += " WHERE nama_panggilan LIKE '%?%'"
			addWhere = true
		} else {
			query += " OR nama_panggilan LIKE '%?%' "
		}
		args = append(args, *&pegawai.NamaPanggilan)
	}

	res, err = m.fetch(ctx, query, args)
	if err != nil {
		return nil, err
	}

	return
}

// Find(ctx context.Context, pegawai Pegawai) (res Pegawai, err error)
// Insert(ctx context.Context, pegawai *Pegawai) (err error)
// Update(ctx context.Context, pegawai Pegawai) (err error)
// Delete(ctx context.Context, id int64) (err error)
