# env variables
set -gx SHELL /usr/bin/fish
set -gx GOPATH $HOME/go
set -gx CHROME_BIN /usr/bin/google-chrome
set -gx PATH ~/bin $PATH
set -gx PATH /usr/local/go/bin $PATH
set -gx PATH ~/go/bin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx PATH ./node_modules/.bin $PATH
set -gx PATH ./.bin-override $PATH

# syntax colors
set fish_color_normal normal
set fish_color_command magenta
set fish_color_quote green
set fish_color_redirection magenta
set fish_color_end yellow
set fish_color_error red
set fish_color_param cyan
set fish_color_comment black -o
set fish_color_match blue
set fish_color_search_match cyan
set fish_color_operator brred
set fish_color_escape yellow
set fish_color_cwd green

# git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_char_dirtystate '⚡'

# gruvbox 256 colors
if status --is-interactive
  set -l GRUVBOX_SCRIPT ~/.config/nvim/bundle/gruvbox/gruvbox_256palette.sh
  if test -f $GRUVBOX_SCRIPT
    bash $GRUVBOX_SCRIPT
  end
end

# aliases
alias dcbuild 'docker-compose build'
alias dcup 'docker-compose up'
alias dcr 'docker-compose run --rm'
alias b 'bundle exec'
alias pbcopy 'xclip -selection clipboard'
alias pbpaste 'xclip -selection clipboard -o'
alias dotfiles 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# chruby
source /usr/local/share/chruby/chruby.fish
chruby ruby-2.4.1

# ssh agent
setenv SSH_ENV $HOME/.ssh/environment

function start_agent                                                                                                                                                                    
  echo "Initializing new SSH agent ..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "succeeded"
  chmod 600 $SSH_ENV 
  . $SSH_ENV > /dev/null
  ssh-add
end

function test_identities                                                                                                                                                                
  ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $status -eq 0 ]
    ssh-add
    if [ $status -eq 2 ]
      start_agent
    end
  end
end

if [ -n "$SSH_AGENT_PID" ] 
  ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
  if [ $status -eq 0 ]
    test_identities
  end  
else
  if [ -f $SSH_ENV ]
    . $SSH_ENV > /dev/null
  end  
  ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
  if [ $status -eq 0 ]
    test_identities
  else 
    start_agent
  end  
end
