package main

import (
	"fmt"
	"os"
	"runtime"
)

func main() {
	var person = "someone"
	if len(os.Args) > 1 {
		person = os.Args[1]
	}
	fmt.Printf("hello %s from: %s/%s\n", person, runtime.GOOS, runtime.GOARCH)
}
