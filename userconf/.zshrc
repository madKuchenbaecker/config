# clone pluginmanager if not exist
if ! [ -d ~/.zinit/bin ]; then
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
# clone oh-my-zsh if not exist
if ! [ -d ~/.oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="agnoster"
#ZSH_THEME="essembeh"
#ZSH_THEME="lukerandall"
#ZSH_THEME="clean"
#ZSH_THEME="gentoo"

if [[ $SSH_TTY ]]
then
    ZSH_THEME="alanpeabody"
elif [[ $UID == 0 ]]
then
    ZSH_THEME="jaischeema"
fi

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

bgnotify_threshold=5
plugins=(git gitignore pip colored-man-pages sudo history-substring-search bgnotify tmuxinator kubectl)
source $ZSH/oh-my-zsh.sh

zstyle ':completion:*:default' list-colors \
  "di=1;34" "ln=1;36" "so=1;32" "pi=33" "ex=1;32" "bd=34;46" "cd=1;33" \
  "su=30;41" "sg=30;46" "tw=30;42" "ow=30;43"

VI_MODE_CURSOR_INSERT='\e[2 q'
VI_MODE_CURSOR_NORMAL='\e[6 q'


function chpwd() {
    emulate -L zsh
    ls
}

if [[ -r ~/.envrc ]]; then
    . ~/.envrc
fi

if [[ -r ~/.aliasrc ]]; then
    . ~/.aliasrc
fi

# pluins
source "$HOME/.zinit/bin/zinit.zsh"
#zinit light "mattberther/zsh-pyenv"
#zinit light "lukechilds/zsh-nvm"
zinit light "zdharma/fast-syntax-highlighting"
zinit light "MichaelAquilina/zsh-you-should-use"
zinit light "kutsan/zsh-system-clipboard"
zinit light "madKuchenbaecker/vi-mode.zsh"
#zinit light "robbyrussell/oh-my-zsh"
#zinit light "zdharma/history-search-multi-word"
#zinit plugin light "zsh-users/zsh-autosuggestions"
#zinit light "zsh-users/zsh-completions"



autoload -Uz compinit && compinit -i

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

unset correctall

exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

bindkey "^?" backward-delete-char

# fix interaction of plugins: sudo vi-mode.zsh
export KEYTIMEOUT=0

setopt noextendedhistory
setopt nosharehistory

if [[ -z $ZSH_THEME ]]
then
    function my_git_prompt_info() {
        ref=$(git symbolic-ref HEAD 2> /dev/null) || return
        GIT_STATUS=$(git_prompt_status)
        if [[ -n $GIT_STATUS ]]
        then
            GIT_STATUS=" $GIT_STATUS"
        else
            GIT_STATUS=" ✔"
        fi
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
    }

    PROMPT='%{$fg_bold[green]%}%n%F{178}@%f%{$fg_bold[green]%}%m%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B»%b '

    ZSH_THEME_GIT_PROMPT_PREFIX="%F{3} "
    ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
    ZSH_THEME_GIT_PROMPT_ADDED="+"
    ZSH_THEME_GIT_PROMPT_MODIFIED="*"
    ZSH_THEME_GIT_PROMPT_RENAMED="~"
    ZSH_THEME_GIT_PROMPT_DELETED="!"
    ZSH_THEME_GIT_PROMPT_UNMERGED="?"
fi

RPS1='%(?..%F{1}%B%?%b%f )% %w %B%F{11}%T%f%b'
