# 補完の有効化
autoload -Uz compinit && compinit
# 部分一致や大文字小文字を無視して補完する設定
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# default editor
export EDITOR=$(which vim)

# ヒストリ設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# 重複したものは残さない
setopt hist_ignore_dups
setopt share_history

# zaw.zsh
bindkey '^H' zaw-history

# .local/bin
if [ -e ${HOME}/.local/bin ]; then
  export PATH=${PATH}:${HOME}/.local/bin
fi

# .cargo/bin
if [ -e ${HOME}/.cargo/bin ]; then
  export PATH=${PATH}:${HOME}/.cargo/bin
fi

# .nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/t0m0h1de/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# sheldon
eval "$(sheldon source)"

# startship
eval "$(starship init zsh)"


# zsh vi mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# oc completion
if [ -e ${HOME}/.oc-completion-zsh.sh ]; then
  source ${HOME}/.oc-completion-zsh.sh
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
eval "$(~/.local/bin/mise activate zsh)"
