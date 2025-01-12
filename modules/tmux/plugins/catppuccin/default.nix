{pkgs, ...}: {
  plugin = pkgs.tmuxPlugins.catppuccin;
  extraConfig = ''
    # manually source catpuccin plugin after options are applied
    set -g @catppuccin_window_left_separator "█"
    set -g @catppuccin_window_right_separator "█ "
    set -g @catppuccin_window_number_position "right"
    set -g @catppuccin_window_middle_separator "  █"

    set -g @catppuccin_window_default_fill "number"

    set -g @catppuccin_window_current_fill "number"
    set -g @catppuccin_window_current_text "#{pane_current_path}"

    set -g @catppuccin_status_modules_right "application session date_time"
    set -g @catppuccin_status_left_separator  ""
    set -g @catppuccin_status_right_separator " "
    set -g @catppuccin_status_right_separator_inverse "yes"
    set -g @catppuccin_status_fill "all"
    set -g @catppuccin_status_connect_separator "no"
  '';
}
