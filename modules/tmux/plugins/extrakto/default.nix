{
  lib,
  pkgs,
  ...
}: let
  extrakto = pkgs.tmuxPlugins.mkTmuxPlugin {
    name = "extrakto";
    pluginName = "extrakto";

    src = pkgs.fetchFromGitHub {
      owner = "laktak";
      repo = "extrakto";
      rev = "f8d15d9150f151305cc6da67fc7a0b695ead0321";
      sha256 = "0mkp9r6mipdm7408w7ls1vfn6i3hj19nmir2bvfcp12b69zlzc47";
    };

    nativeBuildInputs = [pkgs.makeWrapper];

    postInstall = ''
      for f in extrakto.sh open.sh tmux-extrakto.sh; do
        wrapProgram $target/scripts/$f \
          --prefix PATH : ${with pkgs;
        lib.makeBinPath (
          [pkgs.fzf pkgs.python3]
          ++ (
            lib.optionals pkgs.stdenv.isLinux
            (with pkgs; [
              xclip
              wl-clipboard
            ])
          )
        )}
      done
    '';
    meta = {
      license = lib.licenses.mit;
      platforms = lib.platforms.unix;
      homepage = "https://github.com/laktak/extrakto";
      description = "Fuzzy find your text with fzf instead of selecting it by hand ";
    };
  };
in {
  plugin = extrakto;
  extraConfig = ''
    # Create a vertical split to show search & results to keep
    # the content visible.
    set -g @extrakto_split_direction "v"

    # Override the way that Extrakto copies text. By default
    # it was trying to use xclip and would not properly pick
    # up on $XDG_SESSION_TYPE being wayland. Instead, use
    # Tmux's built-in clipboard functionality.
    set -g @extrakto_clip_tool_run "tmux_osc52"

    # @FIXME(jakehamilton): The current version of Extrakto in
    # NixPkgs is out of date and does not support wayland.
    # This overrides the clipping tool to ensure that it works
    # under wayland.
    set -g @extrakto_clip_tool "wl-copy"

  '';
}
