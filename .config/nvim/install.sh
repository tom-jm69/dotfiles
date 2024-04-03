#!/bin/bash
#
# bash linter
npm i -g bash-language-server
sudo apt install shellcheck

sudo snap install go --classic
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# ansible

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

sudo apt-get install python3-pip
