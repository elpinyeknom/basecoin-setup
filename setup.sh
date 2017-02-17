#!/bin/sh
echo "avoid rabid dogs"
rm -rf ~/.tendermint $GOPATH/src/github.com/tendermint
go get -u github.com/tendermint/tendermint/cmd/tendermint
cd $GOPATH/src/github.com/tendermint/tendermint
git checkout develop
glide install
go -u github.com/tendermint/basecoin
cd $GOPATH/src/github.com/tendermint/basecoin
git checkout develop
glide install
go install github.com/tendermint/tendermint/cmd/tendermint
go install github.com/tendermint/basecoin
basecoin start
tendermint init
tendermint node
