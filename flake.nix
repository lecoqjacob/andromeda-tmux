{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

    andromeda = {
      url = "https://flakehub.com/f/milkyway-org/andromeda-lib/0.1.*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {andromeda, ...}:
    andromeda.lib.mkFlake {
      inherit inputs;
      src = ./.;

      alias.packages.default = "tmux";

      andromeda = {
        namespace = "milkyway";
        meta = {
          name = "milkyway";
          title = "MilkyWay Galaxy";
        };
      };
    };
}
