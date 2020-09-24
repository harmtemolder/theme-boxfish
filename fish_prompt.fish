function fish_prompt -d "A simple and elegant fish theme with compact vi mode support"
  set -l last_status $status
  set -l cwd (prompt_pwd)

  # Add exclamation point on non-zero exit status
  if test $last_status -ne 0
    set_color --bold white -b red
    echo -n " ! "
    set_color normal
  end

  # Set background for user and host
  set_color white -b blue
  echo -n " "

  # If we're running via SSH, add underline
  if set -q SSH_TTY
    set_color --underline
  end

  # Add user and host
  echo -n "$USER@"(prompt_hostname)":"
  set_color normal

  # Display current path
  set_color --bold white -b blue
  echo -n "$cwd "

  # Show git branch and dirty state
  command git diff --no-ext-diff --quiet --exit-code 2> /dev/null
  if test $status -ne 0
    set -g __fish_git_prompt_color black -b yellow
    echo -n (fish_git_prompt " %s ")
  else
    set -g __fish_git_prompt_color black -b green
    echo -n (fish_git_prompt " %s ")
  end

  # Add a new line and arrow
  set_color normal
  echo
  echo -n "↳ "
end
