#!/bin/bash

export GOOS=linux 
export GOARCH=amd64 
go build -o bin/hello_linux_amd64

export GOOS=linux 
export GOARCH=arm64 
go build -o bin/hello_linux_arm64

export GOOS=darwin
export GOARCH=amd64 
go build -o bin/hello_darwin_amd64

export GOOS=darwin
export GOARCH=arm64 
go build -o bin/hello_darwin_arm64

tar -czvf hello.tar.gz bin/
cp hello.sh run.sh
cat hello.tar.gz >> run.sh
rm hello.tar.gz
rm -rf bin/
