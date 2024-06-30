# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:$HOME/Library/Python/2.7/bin

if ! [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "################################################"
    echo "Please install oh-my-zsh for full functionality!"
    echo ""
    echo "https://ohmyz.sh/#install"
    echo "################################################"
else
    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"
fi


zstyle :omz:plugins:ssh-agent agent-forwarding on

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="af-magic"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Revert to old pipe handling
unsetopt multios

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  brew
  colored-man-pages
  colorize
  dotenv
  gcloud
  git
  history
  iterm2
  macos
  pep8
  python
  ssh-agent
  sudo
  zsh-navigation-tools
)

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source $ZSH/oh-my-zsh.sh
fi

if [[ -d "$HOME/google-cloud-sdk/" ]]; then
    source "${HOME}/google-cloud-sdk/path.zsh.inc"
    source "${HOME}/google-cloud-sdk/completion.zsh.inc"
fi

# User configuration

# export SSH_AUTH_SOCK=~/.ssh/ykpiv-sock
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias sb="source bin/activate"

# Fuck virtualenv and the horse it rode in on
alias virtualenv="echo 'virtualenv is dead, use venv instead'; #"

# Dynamically build venv aliases
for py_path in $(ls -d /usr/local/opt/python@3*); do
    py_version="${${py_path//./}#*@}"
    alias "venv$py_version"="$py_path/bin/python3 -m venv"
done

function venv_cleanup () {

    # As this recursively removes bin, lib, etc...
    if [ ! -d .git ]; then
        echo "ERROR: For safety, this must be ran within a valid git repository"
        return 1
    fi
    rm -rf \
        man \
        bin \
        include \
        lib \
        .Python \
        htmlcov \
        __pycache__ \
        share \
        .mypy_cache \
        pyvenv.cfg \
        .coverage package-lock.json \
        pip-selfcheck.json
    return $?
}

function venv_dance () {
    set -e
    echo "Flushing any remaining venv paths..."
    if (! venv_cleanup); then
        set +e
        return
    fi
    echo "Creating venv..."
    venv3 .
    echo "Upgrading pip..."
    sb
    pip install --upgrade pip
    echo "Installing requirements if found..."
    if [ -f requirements.txt ]; then
        pip install -r requirements.txt
    else
        echo "\trequirements.txt not found, skipping..."
    fi
    if [ -f test_requirements.txt ]; then
        pip install -r test_requirements.txt
    else
        echo "\ttest_requirements.txt not found, skipping..."
    fi
    # zsh seems to hang onto paths for binaries, force it to do the right thing
    deactivate
    sb
    echo "Done!"
    set +e
}

function project () {
    project_path="$HOME/src/$1"
    if ! [[ -d "$project_path" ]]; then
        echo "Project path $project_path does not exist!"
        return
    fi
    if ! [[ -d "$project_path/.git" ]]; then
        echo "Project $1 is missing a git repository!"
        return
    fi

    cd ~/src/$1
    # Deactivate active venv if we're in one
    (( ${+functions[deactivate]} )) && deactivate

    # Activate current venv if possible
    [[ -f "bin/activate" ]] && sb

    # XXX Could we test python and notify if we need to rebuild
    # the venv?
}

function _project() {
    _files -W $HOME/src -/
}

# The following lines were added by compinstall
zstyle :compinstall filename '/home/pi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if ! [[ $(command -v compdef) ]]; then
    echo "Please run compinstall"
    echo "autoload -Uz compinstall && compinstall"
else
    compdef _project project
fi

if [ $(command -v thefuck) ]; then
    eval $(thefuck --alias)
    alias fek=fuck
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
