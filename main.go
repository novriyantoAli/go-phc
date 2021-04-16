package main

import (
	"database/sql"
	"fmt"
	"io"
	"log"
	"net/url"
	"os"
	"time"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
	"github.com/sirupsen/logrus"
	"github.com/spf13/viper"

	_ "github.com/go-sql-driver/mysql"

	_usersHandler "github.com/novriyantoAli/go-phc/users/delivery/http"
	_usersRepository "github.com/novriyantoAli/go-phc/users/repository/mysql"
	_usersUsecase "github.com/novriyantoAli/go-phc/users/usecase"

	_pegawaiHandler "github.com/novriyantoAli/go-phc/pegawai/delivery/http"
	_pegawaiRepository "github.com/novriyantoAli/go-phc/pegawai/repository/mysql"
	_pegawaiUsecase "github.com/novriyantoAli/go-phc/pegawai/usecase"

	_absenHandler "github.com/novriyantoAli/go-phc/absen/delivery/http"
	_absenRepository "github.com/novriyantoAli/go-phc/absen/repository/mysql"
	_absenUsecase "github.com/novriyantoAli/go-phc/absen/usecase"
)

type responseError struct {
	Message string `json:"error"`
}

func init() {
	logrus.SetFormatter(&logrus.TextFormatter{
		FullTimestamp: true,
	})

	logrus.SetReportCaller(true)
	viper.SetConfigFile(`config.json`)
	err := viper.ReadInConfig()

	if err != nil {
		panic(err)
	}

	if viper.GetBool(`debug`) {
		logrus.Infoln("SERVICE RUN IN DEBUG MODE")
	}
}

func main() {
	// initialize
	f, err := os.OpenFile(`go-phc.log`, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if err != nil {
		log.Fatalf("error opening file: %v", err)
	}

	defer f.Close()

	wrt := io.MultiWriter(os.Stdout, f)

	logrus.SetOutput(wrt)

	// database initialize
	dbHost := viper.GetString(`database.host`)
	dbPort := viper.GetString(`database.port`)
	dbUser := viper.GetString(`database.user`)
	dbPass := viper.GetString(`database.pass`)
	dbName := viper.GetString(`database.name`)

	connection := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPass, dbHost, dbPort, dbName)
	val := url.Values{}
	val.Add(`parseTime`, "1")
	val.Add(`loc`, "Asia/Makassar")

	dsn := fmt.Sprintf("%s?%s", connection, val.Encode())

	dbConn, err := sql.Open(`mysql`, dsn)
	if err != nil {
		logrus.Fatalln(err)
		// log.Fatal(err)
	}

	err = dbConn.Ping()
	if err != nil {
		logrus.Fatalln(err)
		// log.Fatal(err)
	}

	defer func() {
		err := dbConn.Close()
		if err != nil {
			logrus.Fatalln(err)
			// log.Fatal(err)
		}
	}()

	e := echo.New()

	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Format: "method=${method}, uri=${uri}, status=${status}\n",
	}))

	timeout := time.Duration(viper.GetInt("context.timeout")) * time.Second

	/**
	 * Defined Application Repository
	 */
	usersRepository := _usersRepository.NewMysqlRepository(dbConn)
	pegawaiRepository := _pegawaiRepository.NewMysqlRepository(dbConn)
	absenRepository := _absenRepository.NewMysqlRepository(dbConn)

	/**
	 * Defined Application Usecase
	 */
	usersUsecase := _usersUsecase.NewUsecase(timeout, usersRepository)
	pegawaiUsecase := _pegawaiUsecase.NewUsecase(timeout, pegawaiRepository)
	absenUsecase := _absenUsecase.NewUsecase(timeout, absenRepository)

	/**
	 * Call all Handler here
	 */
	_usersHandler.NewHandler(e, usersUsecase)
	_pegawaiHandler.NewHandler(e, pegawaiUsecase)
	_absenHandler.NewHandler(e, absenUsecase)

	/**
	 * Call Echo Framework function for run this app
	 */

	logrus.Fatal(e.Start(viper.GetString("server.address")))
}
