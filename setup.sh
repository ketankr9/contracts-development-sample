#!/bin/bash


install_ganache-cli(){
  echo "Do you want to install ganache-cli (comandline) or ganache(GUI), <ganache-cli requires npm to be installed, don't panic>: [cli/gui]?"; read gui_cli;
  if [ "$gui_cli" = "gui" ]; then
    # @TODO
    echo "pending"
  elif [ "$gui_cli" = "cli" ]; then
    if [ ! "$(which npm)" ]; then
      sudo apt-get install npm
      # @IMPR0 check if last command was successful
    fi
    sudo npm install -g ganache-cli
    # @IMPRO check if the last command was successful
  else
    echo "Command not recognized :( try again."
    install_ganache-cli
  fi
}

install_solc(){
  if [ ! "$(uname -v | grep -oi "ubuntu")" ]; then
    echo "Install solc by yourself."
    echo "Refer: http://solidity.readthedocs.io/en/v0.4.21/installing-solidity.html"
  exit
  fi

  sudo add-apt-repository ppa:ethereum/ethereum
  sudo apt-get update
  sudo apt-get install solc

}

# ganache-cli Installation
if [ ! "$(which ganache-cli)" ]; then
  echo "ganache-cli NOT_INSTALLED";
  install_ganache-cli
else
  echo "ganache-cli already INSTALLED";
fi
echo "ganache installed"
# solc installation
if [ ! "$(which solc)" ]; then
  echo "solc NOT_INSTALLED"
  install_solc
else
  echo "solc already INSTALLED"
fi
echo "solc installed"

# workspace setup
echo "Enter your workspace location (default $HOME/ethereum): "; read location
if [ -z "$location" ]; then
  mkdir -p "$HOME/ethereum"
else
  mkdir "$location"
fi
