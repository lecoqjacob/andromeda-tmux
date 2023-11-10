{pkgs, ...}: {
  plugin = pkgs.tmuxPlugins.tmux-fzf;
  extraConfig = ''
    # Change default keybinding.
    TMUX_FZF_LAUNCH_KEY="C-f"
  '';
}
