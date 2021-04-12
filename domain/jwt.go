package domain

import "github.com/dgrijalva/jwt-go"

// JWTCustomClaims ...
type JWTCustomClaims struct {
	NIK            string  `json:"nik"`
	ID             int64   `json:"id"`
	Level          string  `json:"level"`
	Token          *string `json:"token"`
	jwt.StandardClaims
}
