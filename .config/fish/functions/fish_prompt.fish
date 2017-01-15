function fish_prompt --description "Write out the prompt"
  set -l last_status $status
  set -l bgcolor '#3c3836'
  set -l envcolor '#fe8019'
  echo
  if math "$last_status > 0" > /dev/null
    set_color white -b red
    echo -n " $last_status "
    set_color red -b $bgcolor
    echo -n \UE0B0
  else
    set_color white -b blue
    echo -n "  "
    set_color blue -b $bgcolor
    echo -n \UE0B0
  end
  set_color normal -b $bgcolor
  echo -n " "(prompt_pwd)
  echo -n (__fish_git_prompt)
  echo -n " "
  if test -n "$VAULTED_ENV"
    set_color $bgcolor -b $envcolor
    echo -n \UE0B0
    echo -n " $VAULTED_ENV "
    set_color $envcolor -b normal
    echo -n \UE0B0
  else
    set_color $bgcolor -b normal
    echo -n \UE0B0
  end
  echo -n " "
end
