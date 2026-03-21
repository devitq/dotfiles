# ZSH completion cache
ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"

# Compinit setup
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Hyphen-insensitive completion.
HYPHEN_INSENSITIVE="false"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' verbosity minimal

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Disable compfix
DISABLE_COMPFIX="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(aliases alias-finder ansible argocd bun colored-man-pages colorize copybuffer copyfile dnf docker docker-compose git git-lfs golang helm kubectl kubectx nmap npm perl pm2 podman poetry poetry-env postgres rsync rust salt ssh ssh-agent sudo systemd tailscale terraform zsh-navigation-tools)

# Brew

eval "$(brew shellenv)"

# Run Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch arm64"

# Disable pager
export SYSTEMD_PAGER=

# Talos config
export TALOSCONFIG=/Users/itq/.talos/config

# Aliases
alias tf=terraform
alias calc='_(){ awk "BEGIN{print $*}";};_'
alias dive='docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock docker.io/wagoodman/dive'
alias cdt='cd $(mktemp -d)'
alias c=clear
alias ipy='ipython --no-autoindent'
alias py='python3'
alias bat='bat --style=plain'
alias netshoot='docker run -it --rm --net host docker.io/nicolaka/netshoot:latest'
alias vim='nvim'
alias yz=''
# K8S
alias ktx=kubectx
alias kns=kubens
alias k=kubectl
alias ktop='watch -n 0.5 -d -c kubectl top pod -A --containers=true --show-swap=true --sort-by=memory --sum=true'
alias ka='kubectl apply -f'
alias kd='kubectl delete -f'
# InfoSec Aliases
alias dirsearch=/Users/itq/Infosec/tools/dirsearch/.venv/bin/dirsearch
alias pwn=/Users/itq/Infosec/tools/pwntools/.venv/bin/pwn
alias pwni=/Users/itq/Infosec/tools/pwntools/.venv/bin/python
alias vol2='python2 /Users/itq/Infosec/tools/volatility_2/vol.py'
alias vol3=/Users/itq/Infosec/tools/volatility_3/.venv/bin/vol
alias stegoveritas='docker run -it --rm -v /:/mnt bannsec/stegoveritas'
alias jadx='java -jar /Users/itq/Infosec/tools/jadx-1.5.5-all.jar'
alias jd-gui='java -jar /Users/itq/Infosec/tools/jd-gui-1.6.6-min.jar'
alias пороль='head -c64 /dev/random | base64 | tr -d "/" | head -c32'

# Brew
HOMEBREW_NO_AUTO_UPDATE=1

# fzf
source <($(brew --prefix)/bin/fzf --zsh)

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Yandex Cloud CLI
if [ -f '/Users/itq/.yandex-cloud/path.bash.inc' ]; then source '/Users/itq/.yandex-cloud/path.bash.inc'; fi
if [ -f '/Users/itq/.yandex-cloud/completion.zsh.inc' ]; then source '/Users/itq/.yandex-cloud/completion.zsh.inc'; fi

# Show hidden files and folders
setopt globdots

# No pager for systemd
export SYSTEMD_PAGER=

# Go binaries
export PATH=$PATH:$(go env GOPATH)/bin

# load custom zsh snippets
for f in ~/.zshrc.d/*.zsh; do source "$f"; done

# prioritize binaries in /usr/bin
export PATH=/usr/bin:$PATH

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# sdkman, must be at the end of file!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

