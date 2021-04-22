package domain

import "context"

// Users ...
type Users struct {
	ID         *int64  `json:"id"`
	IDTelegram *string `json:"id_telegram"`
	NIK        *string `json:"nik"`
	Password   *string `json:"password"`
	Level      *string `json:"level"`
	CreatedAt  *string `json:"created_at"`
}

// UsersRepository ...
type UsersRepository interface {
	Find(ctx context.Context, user Users) (res []Users, err error)
	Search(ctx context.Context, user Users) (res []Users, err error)
	Insert(ctx context.Context, user *Users) (err error)
	Update(ctx context.Context, user Users) (err error)
	Delete(ctx context.Context, id int64) (err error)
}

// UsersUsecase ...
type UsersUsecase interface {
	Login(c context.Context, username string, password string) (res JWTCustomClaims, err error)
}
