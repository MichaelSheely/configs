# address common typos
alias emacs=vi
alias clera=clear
alias clera=clear
alias cler=clear
alias claer=clear
alias xit=exit
alias eixt=exit
alias sl=ls
# helpful things
alias mkcdir=mkdir_and_cd
alias dirsize='du -hs'
alias xclip="xclip -selection c"
# reminders
alias irc='echo use \`irssi\`'

if ! command -v g4 &> /dev/null
then
    # google has ruined me forever
    alias g4=git
    alias xlock=/usr/share/goobuntu-desktop-files/xsecurelock.sh
    alias xsecurelock='echo use `xlock` instead'
fi
