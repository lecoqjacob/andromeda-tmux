{pkgs, ...}: {
  plugin = pkgs.tmuxPlugins.resurrect;
  extraConfig = ''
    set -g @resurrect-strategy-vim 'session'
    set -g @resurrect-strategy-nvim 'session'
    set -g @resurrect-capture-pane-contents 'on'
    set -g @resurrect-save 'S'
    set -g @resurrect-restore 'R'
    set -g @resurrect-dir '~/.config/tmux/resurrect'
  '';
}
