{
  lib,
  pkgs,
}: let
  hr = text: let
    parts = builtins.split "." text;
  in
    builtins.foldl'
    (
      text: part:
        if builtins.isList part
        then "${text}-"
        else text
    )
    ""
    (builtins.tail parts);

  config-files = lib.andromeda.fs.get-files-recursive ./config;
  extra-config =
    lib.concatMapStringsSep
    "\n"
    (file: ''
      # ${file}
      # ${hr file}

      ${builtins.readFile file}
    '')
    config-files;

  # Extrakto with wl-clipboard patched in.
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

  plugins =
    [extrakto]
    ++ (with pkgs.tmuxPlugins; [
      nord
      tilish
      tmux-fzf
      resurrect
      continuum
      vim-tmux-navigator
    ]);
in
  lib.milkyway.mkConfig {
    inherit pkgs plugins extra-config;
  }
