#!/usr/bin/env bash
# This script sets up a tor socket proxy on the 127.0.0.1:9050 allowing all the computer connections to go through the TOR network.


#display banner
echo "$(tput setaf 64)" # green
figlet "Tor Black Hole"
echo "$(tput sgr0)" # color reset
echo "Author: Pietro Boccaletto"
echo "Mac Edition"
echo "Please exit this script by Ctrl-C three times to revert the proxy-changes\n"

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macosx'
fi

if [[ "$platform" == 'macosx' ]]; then 
    echo "Veryifing all the dependecies for MacOSX:"
    if type brew &> /dev/null;  then
        echo "[OK] - Homebrew"
    else
        echo "[ERROR] - Homebrew is not installed - proceding with the installation"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    if type tor &> /dev/null ; then
        echo "[OK] - Tor services"
    else
        echo "[ERROR] - Tor is not installed - proceeding with the installation"
        brew install tor
    fi
elif [[ "$platform" == 'linux' ]]; then
    echo "Veryfing all the dependencies for Linux:"
    if type tor &> /dev/null ; then
        echo "[OK] - Tor services - but this software doesn't work with linux right now"
        exit 0
    else
        echo "[ERROR] - Tor is not installed - please install it"
        exit 0
    fi
fi
        
echo "\n"
#show list of available devices:
networksetup -listallnetworkservices

#ask user witch device to use.
echo "\nType the name of the Network interface that you want to use followed by [ENTER]:"
read INTERFACE

if [[ $INTERFACE == "" ]]
then INTERFACE="AX88x72A"
     echo "Standard network interface $INTERFACE selected"
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# trap ctrl-c and call disable_proxy()
trap disable_proxy INT

function disable_proxy() {
    sudo networksetup -setsocksfirewallproxystate $INTERFACE off
    echo "$(tput setaf 64)" #green
    echo "SOCKS proxy disabled."
    echo "$(tput sgr0)" # color reset
    exit 0
}

# Let's roll
sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
sudo networksetup -setsocksfirewallproxystate $INTERFACE on

echo "$(tput setaf 64)" # green
echo "SOCKS proxy 127.0.0.1:9050 enabled."
echo "$(tput setaf 136)" # orange
echo "Starting Tor..."
echo "$(tput sgr0)" # color reset

tor
