# default editor
export EDITOR=nano

# ls colors
LS_COLORS='rs=0:di=00;36:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

# Powerlevel9k theme
DEFAULT_USER=$USER
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time root_indicator context dir rbenv vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs history ram load_joined)

POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_BACKGROUND=green
POWERLEVEL9K_STATUS_OK_FOREGROUND=black
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=red
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=black
POWERLEVEL9K_RAM_BACKGROUND=cyan
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND=$POWERLEVEL9K_RAM_BACKGROUND
POWERLEVEL9K_LOAD_WARNING_BACKGROUND=$POWERLEVEL9K_RAM_BACKGROUND
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND=$POWERLEVEL9K_RAM_BACKGROUND

# useful aliases
alias sudo='sudo '
alias youtube-dl-mp3="youtube-dl --extract-audio --audio-format mp3"
alias youtube-dl-wav="youtube-dl --extract-audio --audio-format wav"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias rsync-mtp='rsync -e "ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -p 22"  --verbose --progress --no-perms --recursive --inplace --ignore-existing'
alias untar="tar xvf"
alias ungzip="tar xvfz"
alias unbzip="tar xvfj"
alias git="hub"

# functions
upload() {
    curl -F "file=@$1" https://0x0.st
}

upload-url() {
    curl -F "url=$1" https://0x0.st
}

shorten() {
    curl -F "shorten=$1" https://0x0.st
}

# that's supposed to fix some issues
export SDL_VIDEO_FULLSCREEN_HEAD=1
export SDL_VIDEO_FULLSCREEN_DISPLAY=1
export vblank_mode=0
setxkbmap -option grab:break_actions

# check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# include zplug
source ~/.zplug/init.zsh

# init zplug plugins
zplug "plugins/git",   from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "bhilburn/powerlevel9k", as:theme
#zplug "themes/nanotech", from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-autosuggestions"

# install missing plugins if needed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# load zplug
zplug load

# command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
