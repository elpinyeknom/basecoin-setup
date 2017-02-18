#!/bin/sh
#Prints "installing Basecoin and Tendermint"
echo "Removing Prior Configuration"
#removes tendermint configuration
rm -rf ~/.tendermint $GOPATH/src/github.com/tendermint $GOPATH/src/github.com/tendermint/basecoin
echo "Installing Glide"
#Uses curl to get the text of https://glide.sh/get then pipes that text into the shell to be executed
curl https://glide.sh/get | sh
#gets the latest basecoin code
echo "Installing Basecoin"
#changes to the basecoin folder
go get -u github.com/tendermint/basecoin/cmd/basecoin
cd $GOPATH/src/github.com/tendermint/basecoin
#checks out the develop branch of basecoin's git repository
git checkout develop
#uses glide to vendor the dependencies of basecoin
glide install
#2nd method of vendoring basecoin dependencies
make get_vendor_deps
# makes install but not start
make install
#installs basecoin
go install github.com/tendermint/basecoin/cmd/basecoin
echo -e "Installing tendermint"
#gets the latest tendermint code
go get -u github.com/tendermint/tendermint/cmd/tendermint
#changes to tendermint folder
cd $GOPATH/src/github.com/tendermint/cmd/tendermint
#installs tendermint
go install github.com/tendermint/tendermint/cmd/tendermint
#checks out the develop branch of basecoin's git repository
git checkout develop
#uses glide to vendor the dependencies of tendermint
glide install

#executing Basecoin (Always execute basecoin first!)
echo "starting basecoin"
nohup basecoin start&
#executing Tendermint
echo "Initializing Tendermint.  This will place a few files on your machine in path ~/.tendermint: \n genesis.json, \n priv_validator.json"
tendermint init
echo "Running 'tendermint node'"
tendermint node
