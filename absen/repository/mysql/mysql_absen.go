package mysql

import "database/sql"

type mysqlRepository struct {
	Conn *sql.DB
}

func NewMysqlRepository(conn *sql.DB) domain.