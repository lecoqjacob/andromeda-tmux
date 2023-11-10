{
  lib,
  pkgs,
}:
with lib.milkyway; let
  config-files = fs.get-files-recursive (fs.get-file "/modules/tmux/config");
  tmux-plugins =
    map (x: pkgs.callPackage x {})
    (fs.get-nix-files-recursive (fs.get-file "/modules/tmux/plugins"));

  ##########
  # * Config *
  ##########
  extra-config =
    lib.concatMapStringsSep
    "\n"
    (file: ''
      # ${file}
      # ${hr file}

      ${builtins.readFile file}
    '')
    config-files;

  ##########
  # * Plugins *
  ##########
  plugins = with pkgs.tmuxPlugins;
    [
      vim-tmux-navigator
    ]
    ++ tmux-plugins;
in
  lib.milkyway.mkConfig {
    inherit pkgs plugins extra-config;
  }
