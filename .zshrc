# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        git
        zsh-autosuggestions
        )

source $ZSH/oh-my-zsh.sh
source /usr/share/autojump/autojump.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias sai="sudo apt install"
alias sau="sudo apt remove"
alias ls="exa -1 --icons"
alias lst="exa --icons -1TL"
alias bat="batcat --theme ansi --italic-text always"
alias mcat="python3 ~/scripts/mdcat.py" This uses Pythons "rich" module to print formatted Markdown in the terminal

export CUSTOM_NVIM_PATH=/usr/local/bin/nvim.appimage
export COLORTERM=truecolor
# Use starship promp
# eval "$(starship init zsh)"
