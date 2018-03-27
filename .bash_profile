# Utility functions
confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# For use in .vimrc
export HOST="$(hostname)"

alias tmuxa="tmux -CC attach"
alias grepr="grep -R -I -n --include=*.cpp --include=*.cu --include=*.h --include=*.py --include=*.sh --include=*.c --include=*.cxx"

alias rm_osx="find . -type f -name '._*' -exec rm -i {} \;"
alias refresh="source ~/.bash_profile; source ~/.bashrc"
alias server='python -m SimpleHTTPServer 8887'

function videofy {
    ffmpeg -i $1.wav -filter_complex "[0:a]avectorscope=s=640x518,pad=1280:720[vs]; [0:a]showspectrum=mode=separate:color=intensity:scale=cbrt:s=640x518[ss]; [0:a]showwaves=s=1280x202:mode=line[sw]; [vs][ss]overlay=w[bg]; [bg][sw]overlay=0:H-h[out]" -map "[out]" -map 0:a -c:v libx264 -preset fast -crf 18 -c:a copy $2.mkv
}

#PS1="\e[0;32m[\W]\$ \e[m"
# PS1='\[\033[1m\033[37m\][\w]\[\033[0m\]\$ '

#----------------------------
# OSX Setup
#----------------------------
### Homebrew ###
#export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/homebrew/bin:$PATH
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH

# added by Anaconda2 4.1.0 installer
export PATH="/Users/jesseengel/anaconda/bin:$PATH"

#------------------------
###   SYSTEMS STUFF   ###
#------------------------

#Command Prompt
#PS1='\[\033[1m\033[37m\][\w]\[\033[0m\]\$ '

#ALIASES
alias sublimetext='open -a Sublime\ Text'

# Needs Brew install of 'coreutils'
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brew install coreutils
# brew tap homebrew/dupes; brew install grep
HB="${HOME}/homebrew"
if [[ -x "${HB}/bin/gdircolors" ]]; then
    #LS_COLORS=$LS_COLORS:'di=1;35:' ; export LS_COLORS
    test -e ~/.dircolors && eval `gdircolors -b ~/.dircolors`
    alias ls='gls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'

    PATH="${HB}/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="${HB}/opt/coreutils/libexec/gnuman:${MANPATH}"

    # Base16 Shell Colors
    BASE16_SHELL="${HOME}/dotfiles/base16-shell/base16-default.dark.sh"
    [[ -s "${BASE16_SHELL}" ]] && source "${BASE16_SHELL}"
fi


if [ -f ~/.git-completion.bash ]; then
. ~/.git-completion.bash
fi

#----------------
# PATHS
# --------------
### CUDA ###
#export PATH=/Developer/NVIDIA/CUDA-7.5/bin:$PATH
#export CUDA_BIN_PATH=/Developer/NVIDIA/CUDA-7.5/bin
#export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.5/lib:$DYLD_LIBRARY_PATH
# export PATH=/usr/local/:$PATH #Use Homebrew

### CUDNN ###
# export DYLD_LIBRARY_PATH=$HOME/cuda/cudnn_v3:$DYLD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH=$HOME/cuda/cudnn_v5:$DYLD_LIBRARY_PATH
#export CPATH=$HOME/cuda/cudnn_v5/include:$CPATH
#export LIBRAY_PATH=$HOME/cuda/cudnn_v5/lib:$LIBRARY_PATH

### TENSORFLOW ##

### PYTHON ###
# USE ANACONDA PYTHON
###########
#export PYTHONPATH=~/anaconda/lib/python2.7/site-packages:$PYTHONPATH
#export PATH=~/anaconda/bin:$PATH
# export DYLD_FALLBACK_LIBRARY_PATH=~/anaconda/lib # For Theano

# USE SYSTEM PYTHON
###########
# export PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/

# FUEL
#########
#export FUEL_DATA_PATH=$HOME/datasets


### LUA/TORCH ###
#export PATH=$HOME/torch/install/bin:$PATH  # Added automatically by torch-dist
#export LD_LIBRARY_PATH=$HOME/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist
#export DYLD_LIBRARY_PATH=$HOME/torch/install/lib:$DYLD_LIBRARY_PATH  # Added automatically by torch-dist
#. /Users/jesseengel/torch/install/bin/torch-activate


# CAFFE
##########
# Compile: (http://hoondy.com/2015/04/03/how-to-install-caffe-on-mac-os-x-10-10-for-dummies-like-me/)
# export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/cuda/lib:$HOME/anaconda/lib:/usr/local/lib
# export PYTHONPATH=$HOME/caffe/python:$PYTHONPATH  # Run

### Lilypond ###
#export PATH=$PATH:/Applications/LilyPond.app/Contents/Resources/bin/

### Android ###
#export ANDROID_HOME=/Developer/AndroidSDK
#export PATH=/Developer/AndroidSDK/platform-tools:/Developer/AndroidSDK/tools:$PATH


### Love2D ###
#alias love="/Applications/love.app/Contents/MacOS/love"   source ~/.bash_osx

## Additonal Config
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
