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
  set_color normal

  # Show git branch and dirty state
  command git diff --no-ext-diff --quiet --exit-code 2> /dev/null
  if test $status -ne 0
    set -g __fish_git_prompt_color_prefix white -b yellow
    set -g __fish_git_prompt_color --bold white -b yellow
  else
    set -g __fish_git_prompt_color_prefix white -b green
    set -g __fish_git_prompt_color --bold white -b green
  end
  echo -n (fish_git_prompt " git:%s ")
  set_color normal

  # Show conda environment, if any
  if set -q CONDA_DEFAULT_ENV
    set_color white -b cyan
    echo -n " conda:"
    set_color --bold
    echo -n (basename (dirname $CONDA_DEFAULT_ENV))"/"(basename $CONDA_DEFAULT_ENV)" "
    set_color normal
  end

  # Add a new line and arrow on local machines, just a space on remotes
  if set -q SSH_TTY
    echo " "
  else
    echo
    echo -n "↳ "
  end
end
