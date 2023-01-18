#!/data/data/com.termux/files/usr/bin/bash

echo "Backing up zsh and bash-dotfiles"

cd ~/ ;
mkdir -p ~/oneplus-zsh-dotfiles;
cp -v .zshrc ~/oneplus-zsh-dotfiles/;
cp -v .profile  .bashrc ~/oneplus-zsh-dotfiles/;
cp -rv  ~/.oh-my-zsh/ ~/.nanorc   ~/oneplus-zsh-dotfiles/ ~/.oh-my-zsh;

echo "done";


