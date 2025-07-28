#!/usr/bin/env bash

# ---
# dotfiles setup script
# This script sets up oh-my-bash and oh-my-zsh using submodules.
# ---

set -e

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Functions ---

setup_bash() {
  echo "Setting up oh-my-bash..."

  ln -sfn "${DOTFILES_ROOT}/oh-my-bash" "${HOME}/.oh-my-bash"
  ln -sfn "${DOTFILES_ROOT}/bash-completion" "${HOME}/.dotfiles/bash-completion"

  cp "${DOTFILES_ROOT}/templates/bashrc.template" "${HOME}/.bashrc"

  echo -e '\n# Load Oh My Bash from dotfiles' >> "${HOME}/.bashrc"
  echo "export OSH=\"${HOME}/.oh-my-bash\"" >> "${HOME}/.bashrc"
  echo "source \"\$OSH/oh-my-bash.sh\"" >> "${HOME}/.bashrc"

  echo "✅ oh-my-bash setup complete."
}

setup_zsh() {
  echo "Setting up oh-my-zsh..."

  cp "${DOTFILES_ROOT}/templates/zshrc.template" "${HOME}/.zshrc"

  echo "✅ oh-my-zsh setup complete."
}


# --- Main Logic ---

main() {
  echo "🚀 Starting dotfiles setup..."

  echo "Ensuring ~/.dotfiles directory exists..."
  mkdir -p "${HOME}/.dotfiles"

  echo "Updating submodules..."
  git -C "${DOTFILES_ROOT}" submodule update --init --recursive
  echo "Submodules are up to date."
  
  setup_bash
  echo "---"
  setup_zsh
  
  echo -e "\n🎉 All tasks completed!"
  echo "Please start a new shell session (or run 'source ~/.bashrc' or 'source ~/.zshrc') to see the changes."
}

main
