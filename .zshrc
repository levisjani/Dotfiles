# Homebrew for Zshell
eval "$(/opt/homebrew/bin/brew shellenv)"


# Starship Prompt
eval "$(starship init zsh)"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#   -----------------------------
#    MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
# alias which='type -all'                   # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias fzfcd='fzfcd() { cd "$(find -type d 2>/dev/null | fzf)" ;}; fzfcd'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.
#   Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }


#   ---------------------------
#    NETWORKING
#   ---------------------------

alias ip='curl -s https://icanhazip.com/'           # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache


#   ---------------------------------------
#    DEVELOPMENT
#   ---------------------------------------

alias edithosts='sudo vim /etc/hosts'
alias cheat='curl https://cheat.sh/$@'
#alias ve='python3 -m venv ./venv'
#alias va='source ./venv/bin/activate'
alias python='python3'
wt () { curl wttr.in/"$1"; }
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
alias genpass='python /Users/$user/Developer/Scripts/cli/genpasswd.py'


#   ---------------------------
# History Configuration
#   ---------------------------
HISTFILE=~/.zsh_history     # Where to save history to disk
HISTSIZE=100                # How many lines of history to keep in memory
SAVEHIST=5000               # Number of history entries to save to disk
#HISTDUP=erase              # Erase duplicates in the history file
setopt    appendhistory     # Append history to the history file (no overwriting)
setopt    sharehistory      # Share history across terminals
setopt    incappendhistory  # Immediately append to the history file, not just when a term is killed
setopt    extended_history  # Add timestamp


#   ---------------------------------------
#   FUNCTIONS
#   ---------------------------------------

### Archive Extraction
### usage: ex <file>

ex ()
{
    if [ -f "$1" ] ; then
        case $1 in
        *.tar.bz2)  tar xjf $1    ;;
        *.tar.gz)   tar xzf $1    ;;
        *.bz2)      bunzip2 $1    ;;
        *.rar)      unrar x $1    ;;
        *.gz)       gunzip $1     ;;
        *.tar)      tar xf $1     ;;
        *.tbz2)     tar xjf $1    ;;
        *.tgz)      tar xzf $1    ;;
        *.zip)      unzip $1      ;;
        *.Z)        uncompress $1 ;;
        *.7z)       7z x $1       ;;
        *.tar.xz)   tar xf $1     ;;
        *.tar.zst)  unzstd $1     ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi

}

### IP Geo Location
### usage geo <ip>

geo ()
{
	echo $1 | mmdbresolve -f /Users/$user/Developer/Maxmind/GeoLite2-City.mmdb
}

#   ---------------------------------------
#   Transfer.sh
#   ---------------------------------------

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

#   ---------------------------------------
#   iTerm INTEGRATION
#   ---------------------------------------

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/sbin:$PATH"
