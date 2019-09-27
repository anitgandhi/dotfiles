#!/bin/bash

export PATH=$PATH:$HOME/bin

source ~/dotfiles/.bash_prompt
source ~/dotfiles/.bash_golang

if [[ -f ~/dotfiles/.bash_private ]]; then
    source ~/dotfiles/.bash_private
fi

export VISUAL=vim
export EDITOR="$VISUAL"

export DOCC_GITHUB_TOKEN=$(cat $HOME/.github-enterprise.vault.token)

# completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

source <(docc completion bash)

# aliases
alias grep="grep --color=auto"

alias ll="ls -ltr"
alias lla="ls -altr"

alias yaml2js="python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)'"

function delete_merged_branches() {
    branches_to_delete=$(git branch --merged | grep -v master)
    for b in "${branches_to_delete[@]}"; do
        git branch --delete $b
    done

}