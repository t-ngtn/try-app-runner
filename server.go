package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", helloAppRunner)
	e.Logger.Fatal(e.Start(":8080"))
}

func helloAppRunner(c echo.Context) error {
	return c.String(http.StatusOK, "Hello, AWS App Runner from GitHub Actions!!\n sucessfully deployed!!")
}