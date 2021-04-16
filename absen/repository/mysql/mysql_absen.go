package mysql

import (
	"context"
	"database/sql"
	"fmt"
	"strconv"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type mysqlRepository struct {
	Conn *sql.DB
}

func NewMysqlRepository(conn *sql.DB) domain.AbsenRepository {
	return &mysqlRepository{Conn: conn}
}

func (m *mysqlRepository) fetch(ctx context.Context, query string, args ...interface{}) (res []domain.Absen, err error) {
	rows, err := m.Conn.QueryContext(ctx, query, args...)
	if err != nil {
		logrus.Error(err)
		return
	}

	defer rows.Close()

	for rows.Next() {
		absen := domain.Absen{}
		err = rows.Scan(
			&absen.ID,
			&absen.IDPegawai,
			&absen.Tipe,
			&absen.DariTanggal,
			&absen.SampaiTanggal,
			&absen.Keterangan,
			&absen.CreatedAt,
		)

		if err != nil {
			logrus.Error(err)
			return
		}
		res = append(res, absen)
	}

	return
}

func (m *mysqlRepository) Find(ctx context.Context, absen domain.Absen) (res domain.Absen, err error) {
	query := "SELECT * FROM absen "
	args := make([]interface{}, 0)
	addWhere := false

	if absen.ID != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE id = ? "
		} else {
			query += " AND id = ? "
		}
		args = append(args, *absen.ID)
	}

	if absen.IDPegawai != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE id_pegawai = ? "
		} else {
			query += " AND id_pegawai = ? "
		}
		args = append(args, *absen.IDPegawai)
	}

	if absen.Tipe != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE tipe = ? "
		} else {
			query += " AND id = ? "
		}

		args = append(args, *absen.Tipe)
	}

	if absen.Keterangan != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE keterangan = ? "
		} else {
			query += " AND id = ? "
		}

		args = append(args, *absen.Keterangan)
	}

	resArr, err := m.fetch(ctx, query, args...)
	if err != nil {
		logrus.Error(err)
	}

	if len(resArr) > 0 {
		return resArr[0], nil
	}

	return
}

func (m *mysqlRepository) Search(ctx context.Context, absen domain.Absen) (res []domain.Absen, err error) {
	query := "SELECT * FROM absen "
	args := make([]interface{}, 0)

	contains := "%"

	addWhere := false

	if absen.ID != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE id LIKE ? "
		} else {
			query += " OR id LIKE ? "
		}
		args = append(args, contains+strconv.FormatInt(*absen.ID, 10)+contains)
	}

	if absen.IDPegawai != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE id_pegawai LIKE ? "
		} else {
			query += " OR id_pegawai LIKE ? "
		}
		args = append(args, contains+strconv.FormatInt(*absen.ID, 10)+contains)
	}

	if absen.Tipe != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE tipe LIKE ? "
		} else {
			query += " OR tipe LIKE ? "
		}
		args = append(args, contains+*absen.Tipe+contains)
	}

	if absen.Keterangan != nil {
		if !addWhere {
			addWhere = true
			query += " WHERE keterangan LIKE ? "
		} else {
			query += " OR keterangan LIKE ? "
		}
		args = append(args, contains+*absen.Keterangan+contains)
	}

	res, err = m.fetch(ctx, query, args...)
	if err != nil {
		logrus.Error(err)
	}

	return
}

func (m *mysqlRepository) Insert(ctx context.Context, absen *domain.Absen) (err error) {
	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return
	}

	query := `
	INSERT INTO absen(id_pegawai, tipe, dari_tanggal, sampai_tanggal, keterangan) VALUES(?,?,?,?)`
	res, err := tx.ExecContext(
		ctx, query,
		*absen.IDPegawai,
		*absen.Tipe,
		*absen.DariTanggal,
		*absen.SampaiTanggal,
		*absen.Keterangan,
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

	absen.ID = &lastID

	err = tx.Commit()
	if err != nil {
		logrus.Error(err)

		return err
	}

	return nil
}

func (m *mysqlRepository) Update(ctx context.Context, absen *domain.Absen) (err error) {
	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return
	}

	query := "UPDATE absen SET id_pegawai = ?, tipe = ?, dari_tanggal = ?, sampai_tanggal = ?, keterangan = ? WHERE id = ?"
	_, err = tx.ExecContext(
		ctx, query,
		*absen.IDPegawai,
		*absen.Tipe,
		*absen.DariTanggal,
		*absen.SampaiTanggal,
		*absen.Keterangan,
		*absen.ID,
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

func (m *mysqlRepository) Delete(ctx context.Context, id int64) (err error) {
	query := "DELETE FROM absen WHERE id = ?"

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
