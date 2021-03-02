PROMPT='%F{39}%B%~%b%f %# '

for zsh_source in $HOME/.zsh/configs/*.zsh; do
  source $zsh_source
done

# tmux 
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

export EDITOR='vim'
export PATH="$HOME/.bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH" # recommended by brew doctor

. /opt/homebrew/opt/asdf/asdf.sh

bindkey -v
