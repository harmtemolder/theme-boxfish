function fish_mode_prompt -d "Prefix a single, colored block indicating vi mode"
  # Add iTerm2 prompt mark (see https://www.iterm2.com/documentation-shell-integration.html)
  if functions -q iterm2_prompt_mark
    iterm2_prompt_mark
  end

  # Prefix a single, colored block indicating vi mode
  if [ $fish_key_bindings = fish_vi_key_bindings ]
    switch $fish_bind_mode
      case default
        set_color -b red
      case insert
        set_color -b green
      case visual
        set_color -b yellow
      case replace-one
        set_color -b magenta
    end
    echo -n " "
  end
end
