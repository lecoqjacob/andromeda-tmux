{pkgs, ...}: {
  plugin = pkgs.tmuxPlugins.continuum;
  extraConfig = ''
    # Enable saving sessions.
    set -g @continuum-restore 'on'

    # Save every 10 minutes.
    set -g @continuum-save-interval '10'
  '';
}
