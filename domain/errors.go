package domain

import "errors"

var (
	// ErrInternalServerError will throw if any the Internal Server Error happen
	ErrInternalServerError = errors.New("internal Server Error")
	// ErrNotFound will throw if the requested items is not exists
	ErrNotFound = errors.New("your requested Items is Not Found")
	// ErrConflict will throw if the current action already exists
	ErrConflict = errors.New("your item already exists")
	// ErrBadParamInput will throw if the given request-body or params is not valid
	ErrBadParamInput      = errors.New("given param is not valid")
	ErrInvalidCredentials = errors.New("invalid username or password")
)
