# Goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh

# NVM lazy load
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi

# Fix Interop Error that randomly occurs in vscode terminal when using WSL2
fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}

# Kubectl Functions
# ---
#
alias k="kubectl"
alias h="helm"

kn() {
    if [ "$1" != "" ]; then
	kubectl config set-context --current --namespace=$1
        echo -e "\e[1;32m⚓ Namespace set to $1\e[0m" 
    else
	echo -e "\e[1;31m❗Error, please provide a valid Namespace\e[0m"
    fi
}

knd() {
    kubectl config set-context --current --namespace=default
    echo -e "\e[1;32m⚓ Namespace set to Default\e[0m"
}

ku() {
    kubectl config unset current-context
    echo -e "\e[1;32m⚓ unset kubernetes current-context\e[0m"
}

# Colormap
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# ALIAS COMMANDS
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -l"
alias g="goto"
alias grep='grep --color'

# find out which distribution we are running on
_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# set an icon based on the distro
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *)                       ICON="";;
esac

# Load Starship
export STARSHIP_DISTRO="$ICON "
eval "$(starship init zsh)"