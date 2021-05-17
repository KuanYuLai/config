## Enables displaying colors in the terminal
export TERM=xterm-256color

export EDITOR='vim'
#PATH="$HOME/bin:$HOME/.local/bin:/usr/bin:$PATH"

## Automatically correct mistyped 'cd' directories
shopt -s cdspell

##alias
alias l='ls -h --color=auto'
alias ll='ls -alh --colo=auto'
alias ls='ls -ah --color=auto'
alias c='clear'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias grep='grep --color=always'
alias rl='source ~/.bashrc'
# git
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

##Prompt
PS1="\[\e[1;38;5;226m\]\u\[\e[m\] "; # user
PS1+="\[\e[1;91m\]::\[\e[m\] "; # double colon
PS1+="\[\e[1;38;5;40m\]\w\[\e[m\] "; # Working Directory
PS1+="\[\e[0m\][\[\e[1;38;5;231m\]\t\[\e[0m\]]\[\e[m\]"; # Time
PS1+="\[\e[0m\]\[\e[0;1;38;5;202m\] \`parse_git_branch\`\[\e[m\]"; # git status
PS1+="\n"
PS1+=" \[\e[0;1;38;5;26m\]»\[\e[m\] \[\e0"; # arrow

PS2=" \[\e[0;1;38;5;26m\]»\[\e[m\] \[\e0";

export PS1;
export PS2;

# start ssh-agent
{ eval `ssh-agent -s`&& ssh-add ~/.ssh/bitbucket; } &>/dev/null

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
