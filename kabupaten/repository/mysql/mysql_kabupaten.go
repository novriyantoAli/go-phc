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

func NewMysqlRepository(conn *sql.DB) domain.KabupatenRepository {
	return &mysqlRepository{Conn: conn}
}

func (m *mysqlRepository) fetch(ctx context.Context, query string, args ...interface{}) (res []domain.Kabupaten, err error) {
	rows, err := m.Conn.QueryContext(ctx, query, args...)
	if err != nil {
		logrus.Error(err)
		return
	}
	defer rows.Close()

	for rows.Next() {
		kabupaten := domain.Kabupaten{}
		provinsi := domain.Provinsi{}

		err = rows.Scan(
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
			return
		}

		kabupaten.Provinsi = provinsi

		res = append(res, kabupaten)
	}

	return
}
func (m *mysqlRepository) Search(ctx context.Context, kabupaten domain.Kabupaten) (res []domain.Kabupaten, err error) {
	query := "SELECT kabupaten.*, provinsi.* FROM kabupaten INNER JOIN provinsi ON provinsi.id = kabupaten.id_provinsi "
	addWhere := false
	like := "%"

	if kabupaten.NamaKabupaten != nil {
		if addWhere {
			query += "OR kabupaten.nama_kabupaten LIKE '" + like + *kabupaten.NamaKabupaten + like + "' "
		} else {
			addWhere = true
			query += "WHERE kabupaten.nama_kabupaten LIKE '" + like + *kabupaten.NamaKabupaten + like + "' "
		}
	}

	if kabupaten.Provinsi.NamaProvinsi != nil {
		if addWhere {
			query += "OR provinsi.nama_provinsi LIKE '" + like + *kabupaten.Provinsi.NamaProvinsi + like + "' "
		} else {
			addWhere = true
			query += "WHERE provinsi.nama_provinsi LIKE '" + like + *kabupaten.Provinsi.NamaProvinsi + like + "' "
		}
	}

	res, err = m.fetch(ctx, query)
	if err != nil {
		logrus.Error(err)
	}

	return
}
