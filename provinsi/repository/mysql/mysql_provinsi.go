package mysql

import (
	"context"
	"database/sql"
	"strconv"

	"github.com/novriyantoAli/go-phc/domain"
	"github.com/sirupsen/logrus"
)

type mysqlRepository struct {
	Conn *sql.DB
}

func NewRepository(conn *sql.DB) domain.ProvinsiRepository {
	return &mysqlRepository{Conn: conn}
}

func (m *mysqlRepository) fetch(ctx context.Context, query string, args ...interface{}) (res []domain.Provinsi, err error) {
	rows, err := m.Conn.QueryContext(ctx, query, args)
	if err != nil {
		logrus.Error(err)
		return nil, err
	}
	defer rows.Close()

	provinsis := make([]domain.Provinsi, 0)
	for rows.Next() {
		provinsi := domain.Provinsi{}
		err = rows.Scan(
			&provinsi.ID,
			&provinsi.NamaProvinsi,
			&provinsi.CreatedAt,
		)
		if err != nil {
			logrus.Error(err)
			return nil, err
		}

		provinsis = append(provinsis, provinsi)
	}
	return
}

func (m *mysqlRepository) Get(ctx context.Context, provinsi domain.Provinsi) (res []domain.Provinsi, err error) {
	query := "SELECT * FROM provinsi "
	args := make([]interface{}, 0)
	addWhere := false

	if provinsi.ID != nil {
		if addWhere {
			query += "AND id = ? "
		} else {
			query += "WHERE id = ? "
			addWhere = true
		}
		args = append(args, *provinsi.ID)
	}

	if provinsi.NamaProvinsi != nil {
		if addWhere {
			query += "AND nama_provinsi = ? "
		} else {
			query += "WHERE nama_provinsi = ? "
		}
		args = append(args, *provinsi.NamaProvinsi)
	}

	res, err = m.fetch(ctx, query, args...)
	if err != nil {
		logrus.Error(err)
		return nil, err
	}

	return
}

func (m *mysqlRepository) Search(ctx context.Context, provinsi domain.Provinsi) (res []domain.Provinsi, err error) {
	query := "SELECT * FROM provinsi "
	addWhere := false

	likeValue := "%"
	if provinsi.ID != nil {
		if addWhere {
			query += "OR id LIKE '" + likeValue + strconv.FormatInt(*provinsi.ID, 64) + likeValue + "' "
		} else {
			query += "WHERE id LIKE '" + likeValue + strconv.FormatInt(*provinsi.ID, 64) + likeValue + "' "
		}
	}

	if provinsi.NamaProvinsi != nil {
		if addWhere {
			query += "OR nama_provinsi LIKE '" + likeValue + strconv.FormatInt(*provinsi.ID, 64) + likeValue + "' "
		} else {
			query += "WHERE nama_provinsi LIKE '" + likeValue + *provinsi.NamaProvinsi + likeValue + "' "
		}
	}

	res, err = m.fetch(ctx, query)

	return
}

func (m *mysqlRepository) Update(ctx context.Context, provinsi *domain.Provinsi) (err error) {
	query := "UPDATE provinsi SET nama_provinsi = ? WHERE id = ? "
	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return err
	}

	_, err = tx.ExecContext(ctx, query, *provinsi.NamaProvinsi, *provinsi.ID)
	if err != nil {
		logrus.Error(err)

		tx.Rollback()
		return err
	}

	err = tx.Commit()
	if err != nil {
		logrus.Error(err)
	}

	return

}

func (m *mysqlRepository) Insert(ctx context.Context, provinsi *domain.Provinsi) (err error) {
	query := "INSERT INTO provinsi(nama_provinsi) VALUES(?) "

	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return err
	}

	_, err = tx.ExecContext(ctx, query, *provinsi.NamaProvinsi)
	if err != nil {
		logrus.Error(err)
		return err
	}

	err = tx.Commit()
	if err != nil {
		logrus.Error(err)
	}

	return
}

func (m *mysqlRepository) Delete(ctx context.Context, id int64) (err error) {
	query := "DELETE FROM provinsi WHERE id = ?"

	tx, err := m.Conn.BeginTx(ctx, nil)
	if err != nil {
		logrus.Error(err)
		return
	}

	_, err = tx.ExecContext(ctx, query, id)
	if err != nil {
		tx.Rollback()
		logrus.Error(err)
		return
	}

	err = tx.Commit()
	if err != nil {
		logrus.Error(err)
	}

	return
}
