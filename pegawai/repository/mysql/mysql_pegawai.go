package mysql

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type mysqlRepository struct {
	Conn *sql.DB
}

func NewMysqlRepository(conn *sql.DB) domain.PegawaiRepository {
	return &mysqlRepository{Conn: conn}
}

func (m *mysqlRepository) fetch(ctx context.Context, query string, args ...interface{}) (res []domain.Pegawai, err error) {
	rows, err := m.Conn.QueryContext(ctx, query, args...)
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
			&t.Alamat,
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
			&t.Level,
			&t.Divisi,
			&t.Seksi,
			&t.Bagian,
			&t.StatusKaryawan,
			&t.TanggalPengangkatan,
			&t.NoRekening,
			&t.NoBPJSKesehatan,
			&t.NoBPJSKetenagakerjaan,
			&t.CreatedAt,
		)

		if err != nil {
			logrus.Error(err)
			return nil, err
		}

		// row location
		kabupaten := domain.Kabupaten{}
		provinsi := domain.Provinsi{}
		err = m.Conn.QueryRowContext(ctx, "SELECT kabupaten.*, provinsi.* FROM kabupaten INNER JOIN provinsi ON provinsi.id = kabupaten.id_provinsi WHERE kabupaten.id = ?", *t.IDKabupaten).Scan(
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
			err = rowsKeluarga.Scan(
				&kg.ID,
				&kg.IDPegawai,
				&kg.Nama,
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
			err = rowsKontakDarurat.Scan(
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
			err = rowsPendidikan.Scan(
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
			err = rowsLokakarya.Scan(
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
			err = rowsPengalamanKerja.Scan(
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
			err = rowsJabatan.Scan(
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
			err = rowsPenghargaan.Scan(
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
			err = rowsTeguran.Scan(
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
		t.RiwayatTeguran = tegurans
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
			err = rowsSperingatan.Scan(
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
		t.RiwayatSuratPeringatan = speringatans
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
		res = append(res, t)
	}

	return

}

// Search(ctx context.Context, pegawai Pegawai) (res []Pegawai, err error)
func (m *mysqlRepository) Search(ctx context.Context, pegawai domain.Pegawai) (res []domain.Pegawai, err error) {
	query := `SELECT * FROM pegawai `
	args := make([]interface{}, 0)

	addWhere := false

	if pegawai.ID != nil {
		if addWhere {
			query += " WHERE id LIKE '%?%' "
			addWhere = true
		} else {
			query += " OR id LIKE '%?%' "
		}
		args = append(args, *pegawai.ID)
	}

	if pegawai.NIK != nil {
		if !addWhere {
			query += " WHERE nik LIKE '%?%'"
			addWhere = true
		} else {
			query += " OR nik LIKE '%?%' "
		}
		args = append(args, *pegawai.NIK)
	}

	if pegawai.NamaLengkap != nil {
		if !addWhere {
			query += " WHERE nama_lengkap LIKE '%?%'"
			addWhere = true
		} else {
			query += " OR nama_lengkap LIKE '%?%' "
		}
		args = append(args, *pegawai.NamaLengkap)
	}

	if pegawai.NamaPanggilan != nil {
		if !addWhere {
			query += " WHERE nama_panggilan LIKE '%?%'"
			addWhere = true
		} else {
			query += " OR nama_panggilan LIKE '%?%' "
		}
		args = append(args, *pegawai.NamaPanggilan)
	}

	res, err = m.fetch(ctx, query, args)
	if err != nil {
		return nil, err
	}

	return
}

// Find(ctx context.Context, pegawai Pegawai) (res Pegawai, err error)
func (m *mysqlRepository) Find(ctx context.Context, pegawai domain.Pegawai) (res []domain.Pegawai, err error) {
	query := `SELECT * FROM pegawai `
	args := make([]interface{}, 0)

	addWhere := false

	if pegawai.ID != nil {
		if !addWhere {
			query += "WHERE id = ?"
			addWhere = true
		} else {
			query += ` AND id = ?`
		}
		args = append(args, *pegawai.ID)
	}

	if pegawai.NIK != nil {
		if !addWhere {
			query += "WHERE nik = ?"
			addWhere = true
		} else {
			query += ` AND nik = ?`
		}
		args = append(args, *pegawai.NIK)
	}

	if pegawai.NamaLengkap != nil {
		if !addWhere {
			query += "WHERE nama_lengkap = ?"
			addWhere = true
		} else {
			query += ` AND nama_lengkap = ?`
		}
		args = append(args, *pegawai.NamaLengkap)
	}

	if pegawai.NamaPanggilan != nil {
		if !addWhere {
			query += "WHERE nama_panggilan = ?"
			addWhere = true
		} else {
			query += ` AND nama_panggilan = ?`
		}
		args = append(args, *pegawai.NamaPanggilan)
	}

	res, err = m.fetch(ctx, query, args...)
	if err != nil {
		logrus.Error(err)
		return nil, err
	}

	return
}

// Insert(ctx context.Context, pegawai *Pegawai) (err error)
func (m *mysqlRepository) Insert(ctx context.Context, pegawai *domain.Pegawai) (err error) {
	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return
	}

	query := `
	INSERT INTO pegawai(
		id_kabupaten, 
		nik, 
		nama_lengkap, 
		nama_panggilan,
		alamat, 
		nktp, 
		nohp, 
		jenis_kelamin, 
		tempat_lahir, 
		tanggal_lahir, 
		agama, 
		status_perkawinan, 
		kewarganegaraan, 
		golongan_darah, 
		bahasa, 
		suku, 
		daerah_asal, 
		tanggal_mulai_bekerja, 
		level, 
		divisi, 
		seksi, 
		bagian, 
		status_karyawan,
		tanggal_pengangkatan, 
		no_rekening, 
		no_bpjs_kesehatan, 
		no_bpjs_ketenagakerjaan) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
	res, err := tx.ExecContext(
		ctx, query,
		*pegawai.IDKabupaten,
		*pegawai.NIK,
		*pegawai.NamaLengkap,
		*pegawai.NamaPanggilan,
		*pegawai.Alamat,
		*pegawai.NKTP,
		*pegawai.NOHP,
		*pegawai.JenisKelamin,
		*pegawai.TempatLahir,
		*pegawai.TanggalLahir,
		*pegawai.Agama,
		*pegawai.StatusPerkawinan,
		*pegawai.Kewarganegaraan,
		*pegawai.GolonganDarah,
		*pegawai.Bahasa,
		*pegawai.Suku,
		*pegawai.DaerahAsal,
		*pegawai.TanggalMulaiBekerja,
		*pegawai.Level,
		*pegawai.Divisi,
		*pegawai.Seksi,
		*pegawai.Bagian,
		*pegawai.StatusKaryawan,
		*pegawai.TanggalPengangkatan,
		*pegawai.NoRekening,
		*pegawai.NoBPJSKesehatan,
		*pegawai.NoBPJSKetenagakerjaan,
	)

	if err != nil {
		logrus.Error(err)

		tx.Rollback()
		return err
	}

	lastID, err := res.LastInsertId()
	if err != nil {
		logrus.Error(err)

		tx.Rollback()
		return
	}

	pegawai.ID = &lastID

	err = tx.Commit()
	if err != nil {
		logrus.Error(err)

		return err
	}

	return nil
}

// Update(ctx context.Context, pegawai Pegawai) (err error)
func (m *mysqlRepository) Update(ctx context.Context, pegawai domain.Pegawai) (err error) {
	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return
	}

	query := "UPDATE pegawai SET id_kabupaten = ?, nik = ?, nama_lengkap = ?, nama_panggilan = ?, alamat = ?, nktp = ?, nohp = ?, jenis_kelamin = ?, tempat_lahir = ?, tanggal_lahir = ?, agama = ?, status_perkawinan = ?, kewarganegaraan = ?, golongan_darah = ?, bahasa = ?, suku = ?, daerah_asal = ?, tanggal_mulai_bekerja = ?, level = ?, divisi = ?, seksi = ?, bagian = ?, status_karyawan = ?, no_rekening = ?, no_bpjs_kesehatan = ?, no_bpjs_ketenagakerjaan = ? WHERE id = ?"
	_, err = tx.ExecContext(
		ctx, query,
		*pegawai.IDKabupaten,
		*pegawai.NIK,
		*pegawai.NamaLengkap,
		*pegawai.NamaPanggilan,
		*pegawai.Alamat,
		*pegawai.NKTP,
		*pegawai.NOHP,
		*pegawai.JenisKelamin,
		*pegawai.TempatLahir,
		*pegawai.TanggalLahir,
		*pegawai.Agama,
		*pegawai.StatusPerkawinan,
		*pegawai.Kewarganegaraan,
		*pegawai.GolonganDarah,
		*pegawai.Bahasa,
		*pegawai.Suku,
		*pegawai.DaerahAsal,
		*pegawai.TanggalMulaiBekerja,
		*pegawai.Level,
		*pegawai.Divisi,
		*pegawai.Seksi,
		*pegawai.Bagian,
		*pegawai.StatusKaryawan,
		*pegawai.NoRekening,
		*pegawai.NoBPJSKesehatan,
		*pegawai.NoBPJSKetenagakerjaan,
		*pegawai.ID,
	)

	if err != nil {
		logrus.Error(err)

		tx.Rollback()
		return err
	}

	err = tx.Commit()
	if err != nil {
		logrus.Error(err)
		return err
	}

	return
}

// Delete(ctx context.Context, id int64) (err error)
func (m *mysqlRepository) Delete(ctx context.Context, id int64) (err error) {
	query := "DELETE FROM pegawai WHERE id = ?"

	stmt, err := m.Conn.PrepareContext(ctx, query)
	if err != nil {
		logrus.Error(err)
		return
	}

	res, err := stmt.ExecContext(ctx, id)
	if err != nil {
		logrus.Error(err)
		return
	}

	rowsAffected, err := res.RowsAffected()
	if err != nil {
		logrus.Error(err)
		return
	}

	if rowsAffected != 1 {
		err = fmt.Errorf("weird  behavior. total affected: %d", rowsAffected)
		logrus.Error(err)
		return
	}

	return
}
