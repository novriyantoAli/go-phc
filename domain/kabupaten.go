package domain

type Kabupaten struct {
	ID            *int64   `json:"id"`
	IDProvinsi    *int64   `json:"id_provinsi"`
	NamaKabupaten *string  `json:"nama_kabupaten"`
	Provinsi      Provinsi `json:"provinsi"`
}
