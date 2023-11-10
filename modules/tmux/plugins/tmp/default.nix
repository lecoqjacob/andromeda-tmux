{pkgs, ...}:
pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "tpm";
  version = "v0.1.0";
  src = builtins.fetchTarball {
    name = "tpm";
    sha256 = "sha256:01ribl326n6n0qcq68a8pllbrz6mgw55kxhf9mjdc5vw01zjcvw5";
    url = "https://github.com/tmux-plugins/tpm/archive/99469c4a9b1ccf77fade25842dc7bafbc8ce9946.tar.gz";
  };
}
