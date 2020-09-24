function fish_prompt -d "A simple and elegant fish theme with compact vi mode support"
  set -l last_status $status
  set -l cwd (prompt_pwd)

  # Add exclamation point on non-zero exit status
  if test $last_status -ne 0
    set_color --bold white -b red
    echo -n " ! "
    set_color normal
  end

  # Display current path
  set_color black -b blue
  echo -n " $cwd "

  # Show git branch and dirty state
  command git diff --no-ext-diff --quiet --exit-code 2> /dev/null
  if test $status -ne 0
    set -g __fish_git_prompt_color black -b yellow
    echo -n (fish_git_prompt " %s ")
  else
    set -g __fish_git_prompt_color black -b green
    echo -n (fish_git_prompt " %s ")
  end

  # Add a space
  set_color normal
  echo -n " "
end
