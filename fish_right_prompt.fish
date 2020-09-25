function fish_right_prompt -d "Add date, time and timezone to the right prompt"
  echo -n time:
  set_color --bold
  echo -n (date +'%F %T %z')
  set_color normal
end
