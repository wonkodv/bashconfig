alias diff='colordiff'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -m'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5 -O '
alias shred='shred -uz'
alias clip='xclip -selection clipboard'

alias bd="lsblk --output name,mountpoint,ro,fstype,size,label,partlabel,model"
alias l='ls --color=auto -lh --file-type'

alias ln='ln -i'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias crontab='crontab -i'

alias sudo='sudo '

alias :q='false'
alias :wq='false'

alias ipython='ipython --no-confirm-exit'


alias ?="_status"
function _status() {
    local bold="\e[1m"
    local red="\e[1;31m"
    local clear="\e[0m"

    if [[ $(jobs |wc -l ) -gt 0 ]]
    then
        echo -e "${bold}Jobs${clear}"
        jobs
    fi

    if [ -n "$VIRTUAL_ENV" ]
    then
        echo -ne"${bold}VENV${clear}    "
        echo "$VIRTUAL_ENV"
    fi

    if [ -n "$SSH_CLIENT" ]
    then
        echo -ne "${bold}SSH${clear}   "
        echo "$SSH_CONNECTION"
    fi

    echo -en "${bold}ID${clear}      "
    [ "$USER" == root ] && echo -ne ${red}
    echo -e $USER${clear}@$HOSTNAME

    if [ -r /sys/class/power_supply/BAT0/ ]
    then
        echo -en "${bold}BATTERY${clear} "
        full=`cat /sys/class/power_supply/BAT0/energy_full`
        now=`cat /sys/class/power_supply/BAT0/energy_now`
        echo -n "$((now*100/full))% "
        cat /sys/class/power_supply/BAT0/status
    fi

    if   git rev-parse &>/dev/null
    then
        echo -e "${bold}GIT${clear}"
        git status -bs --show-stash --ahead-behind -M
    fi

    echo -en "${bold}PWD${clear}     "
    echo  "$PWD"
}

o(){
(
    (
    while [ -n "$1" ]
    do
        case `file --mime-type --brief "$1"` in
            application/pdf)evince    "$1";;
            image/*)		feh       "$1";;
            *)				xdg-open  "$1";;
        esac
        shift;
    done
    ) &>/dev/null &
)
}

if [ -r ~/bin/s ]
then
s() {
    source ~/bin/s
}
s -complete
fi
