#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi

fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install neovim
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp
brew install zsh

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install pyenv
brew install python
brew install python@3.7
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install gs
brew install imagemagick
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli

# Install java binaries.
brew tap homebrew/cask-versions
# brew tap adoptopenjdk/openjdk
brew install --cask adoptopenjdk
brew install --cask adoptopenjdk8
brew install --cask adoptopenjdk11
brew install jenv
brew install --cask eclipse-jee

# Install usefull dev tools
brew install --cask postman
brew install cmake
brew install ripgrep
brew install ctags
brew install ansible
brew install tmux
brew install tmate
brew install watch
brew install fzf
brew install bat
brew install rbenv
brew install cheat
brew install --cask figma
brew install --cask ubersicht
brew install pre-commit
brew install jq
brew install tailscale
brew install --cask firefox
brew install awscli
brew install --cask flutter
brew install go
brew install revive
brew install staticcheck
brew install bufbuild/buf/buf
brew install git-lfs
brew install firebase-cli
brew install clang-format
brew install android-platform-tools

# Management
brew install --cask slack

# Node
brew install node
brew install angular-cli

# Dotnet
brew install --cask dotnet-sdk

brew install --cask whatsapp

brew install yarn

# Install IDE tools
brew install --cask visual-studio-code

# Install database tools
brew install mysql
brew install --cask sequel-pro
brew install postgresql
brew install libpq
#brew install --cask pgadmin4

# Install docker and simillar tools VM/Kubernetes tools
brew install docker
brew install docker-compose
brew install docker-machine

brew install minikube

brew install helm
brew install k9s
brew install kubernates-helm
brew install derailed/popeye/popeye
brew install eksctl

brew tap blendle/blendle
brew install kns

brew install --cask lens

brew install --cask vagrant
brew install --cask vagrant-manager

brew tap batchcorp/public
brew install plumber

brew install terraform
brew install terraform-docs

# Install android tools
brew install ant
brew install maven
brew install gradle
brew install android-sdk
brew install android-ndk
brew install --cask android-studio

# Install browser, accessories and other tools
brew install --cask google-chrome
brew install --cask grammarly
brew install nextcloud
brew install --cask lastpass
brew install --cask notion

# Link vim
brew link vim

# Install yabi and skhd
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# Remove outdated versions from the cellar.
brew cleanup

exit 0
