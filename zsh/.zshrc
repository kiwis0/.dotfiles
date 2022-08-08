#source ~/.oh-my-zsh/custom/plugins/zsh-snap/znap.zsh
# source ~/.zplug/init.zsh

# path for zsh home
export ZSH="/Users/rt"

# CACHE
export ZSH_CACHE_DIR=$ZSH/.cache

ZSH_THEME="hyperzsh"

## PATH ##
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=/usr/local/bin:$PATH
export PATH=/usr/bin:$PATH ## <-- fixed recuring issue
# export PATH=/usr/local/share/python:$PATH
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin



# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git  macos docker copypath copyfile history zsh-autosuggestions zsh-syntax-highlighting ls-go-zsh zsh-vi-mode web-search zsh-pyenv )



ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
# fpath=(/usr/local/share/zsh/site-functions $fpath)
# autoload -Uz compinit
# compinit
# autoload -U +X bashcompinit && bashcompinit

# completion

autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
    compinit
done

compinit -C

# clone antidote if necessary and generate a static plugin file
zhome=${ZDOTDIR:-$HOME}
if [[ ! $zhome/.zsh_plugins.zsh -nt $zhome/.zsh_plugins.txt ]]; then
  [[ -e $zhome/.antidote ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $zhome/.antidote
  [[ -e $zhome/.zsh_plugins.txt ]] || touch $zhome/.zsh_plugins.txt
  (
    source $zhome/.antidote/antidote.zsh
    antidote bundle <$zhome/.zsh_plugins.txt >$zhome/.zsh_plugins.zsh
  )
fi

# uncomment if you want your session to have commands like `antidote update`
autoload -Uz $zhome/.antidote/functions/antidote

# source static plugins file
source $zhome/.zsh_plugins.zsh
unset zhome

## COMPLETIONS ##
# kubectl
# source <(kubectl completion zsh)

# source $ZSH/oh-my-zsh.sh
# source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

## KEYBINDS ##
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word
#bindkey "$terminfo[kcud1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd '^[[A' history-substring-search-up
bindkey -M vicmd '^[[Bj' history-substring-search-down

# autoload -U +X bashcompinit && bashcompinit

## ALIASES & FUNCTIONS ##
alias vimrc='vim ~/.vimrc'
alias zshrc="vim ~/.zshrc"
alias sourcezsh="source ~/.zshrc"
alias rm='rm -i'
alias cp='cp -i'

# exa
alias ls='exa --icons --color-scale --group-directories-first' # just replace ls by exa and allow all other exa arguments
alias l='ls -lbF' #   list, size, type
alias ll='ls -la' # long, all
alias llm='ll --sort=modified' # list, long, sort by modification date
alias la='ls -lbhHigUmuSa' # all list
alias lx='ls -lbhHigUmuSa@' # all list and extended
alias tree='exa --tree' # tree view
alias lS='exa -1' # one column by just names

# git alias'
alias galias='alias | ag "^g"'

## RUST ##
export PATH=$PATH:$HOME/.cargo/bin

## GIT ##
function facp() {
  git add .
  git commit --amend -no-edit
  gp -f
}
function fcp() {
  gc --amend --no-edit
  git push -f
}

## PYTHON ##
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_ROOT="$(pyenv root)"
export PATH="$(pyenv root)/shims:$PATH"

## CHECK FOR ITERM2 INTEGRATION ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# VSCODE ##
#export PATH=/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH

## ITERM2 ##
[ it2check ] && alias filecp='it2copy'

## ZOXIDE ##
eval "$(zoxide init zsh)"

## FZF ##
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## STARTSHIP ##
eval "$(starship init zsh)"

####### DIRENV #########
eval "$(direnv hook zsh)"
