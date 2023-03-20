{

description = "A TUI bitmap editor";

inputs = {
  nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
  };
};

outputs = { self, nixpkgs }:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    ghc = pkgs.haskellPackages.ghcWithPackages
      (a: with a; [
        ansi-terminal
      ]);
  in {
  packages.x86_64-linux.default =
    pkgs.stdenv.mkDerivation {
      name = "bitmap";
      meta = {
        license = pkgs.lib.licenses.agpl3Plus;
        description = "A TUI bitmap editor";
      };
      src = ./src;
      buildInputs = [
        ghc
      ];
      buildPhase = "ghc Main.hs -o bitmap";
      installPhase = "mkdir -p $out/bin; install -t $out/bin bitmap";
    };

  devShells.x86_64-linux.default = with pkgs;
    mkShell {
      packages = [
        ghcid
        hlint
      ];
      buildInputs = [
        ghc
      ];
    };
  };

}
