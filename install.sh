#!/usr/bin/env bash

# ---
# dotfiles setup script
# This script sets up oh-my-bash and oh-my-zsh using submodules.
# ---

set -e # エラーが発生したらスクリプトを終了する

# スクリプトが置かれているディレクトリの絶対パスを取得
# これにより、どこから実行されてもパスがずれないようにする
DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Functions ---

# oh-my-bashのセットアップ
setup_bash() {
  echo "Setting up oh-my-bash..."

  # 1. ~/.oh-my-bash へのシンボリックリンクを作成
  #    -s: シンボリックリンク
  #    -f: リンク先が既に存在する場合、強制的に上書き
  #    -n: リンク先がディレクトリの場合に、その中ではなくリンク自体を置き換える
  ln -sfn "${DOTFILES_ROOT}/oh-my-bash" "${HOME}/.oh-my-bash"

  # 2. bashrcのテンプレートをホームディレクトリにコピー
  cp "${DOTFILES_ROOT}/templates/bashrc.template" "${HOME}/.bashrc"

  # 3. .bashrc に oh-my-bash を読み込む設定を追記
  echo -e '\n# Load Oh My Bash from dotfiles' >> "${HOME}/.bashrc"
  echo "source \"${HOME}/.oh-my-bash/oh-my-bash.sh\"" >> "${HOME}/.bashrc"

  echo "✅ oh-my-bash setup complete."
}

# oh-my-zshのセットアップ
setup_zsh() {
  echo "Setting up oh-my-zsh..."

  # 1. ~/.oh-my-zsh へのシンボリックリンクを作成
  ln -sfn "${DOTFILES_ROOT}/oh-my-zsh" "${HOME}/.oh-my-zsh"

  # 2. zshrcのテンプレートをホームディレクトリにコピー
  #    oh-my-zshはテンプレート内で読み込み設定を行うため、追記は不要
  cp "${DOTFILES_ROOT}/templates/zshrc.template" "${HOME}/.zshrc"

  echo "✅ oh-my-zsh setup complete."
}


# --- Main Logic ---

main() {
  echo "🚀 Starting dotfiles setup..."
  
  setup_bash
  echo "---"
  setup_zsh
  
  echo -e "\n🎉 All tasks completed!"
  echo "Please start a new shell session (or run 'source ~/.bashrc' or 'source ~/.zshrc') to see the changes."
}

# スクリプトの実行
main
