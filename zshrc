# If you come from bash you might have to change your $PATH.
export LC_ALL=en_US.UTF-8
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.pyenv/shims:$GOPATH/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/go"
export SDKMAN_DIR="$HOME/.sdkman"
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_SHELL=zsh
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# set ranger editor
export EDITOR=nvim
export GPG_TTY=$(tty)

# workaround for nvim plugins work over virtualenv
# https://vi.stackexchange.com/questions/7644
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-wakatime docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# vi
alias vi="nvim"
alias vim="nvim"

# cat
alias cat="bat"

# docker
alias dps='docker ps'
alias dsa='docker stop $(docker ps --format "{{.ID}}")'
dsh() { dex $1 sh }
dbash() { dex $1 bash }
dex() { docker exec -it $1 $2 }

alias gw='./gradlew'
alias gwcb='gw clean build'
alias rg=ranger
alias vg=vagrant
alias play=ansible-playbook
alias wproxy='sh ~/.http-proxy/sshproxy.sh'
alias gist='gist -c'
alias weather='curl wttr.in/moscow'

tmp() {
  mkdir -p "/tmp/$1" && cd "/tmp/$1"
}

# spring eureka server
eureka() {
  if [[ "$1" == "start" ]]; then
      java -jar $HOME/Projects/ALFA/sign/eureka-server/build/libs/*.jar --server.port=8761 > /dev/null &
  elif [[ "$1" == "stop" ]]; then
      kill $(pgrep -f eureka-server)
  fi
}

# ssh tunnels
tun() {
  ssh -tNL $2:'localhost':$2 $1
}

# tmux attach when terminal startup
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

### added by the bluemix cli
source /usr/local/bluemix/bx/zsh_autocomplete

### Pyenv for switch python versions
source '/usr/local/Cellar/pyenv/1.2.11/completions/pyenv.zsh'
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

#this must be at the end of the file for sdkman to work!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
