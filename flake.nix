{
  description = "WallRizz";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qjs-ext-lib.url = "github:ctn-malone/qjs-ext-lib";
  };

  outputs =
    {
      self,
      nixpkgs,
      qjs-ext-lib,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          qjs-ext-lib-pkg = qjs-ext-lib.packages.${system}.qjs-ext-lib;
          wallrizz-pkg = pkgs.callPackage ./package.nix { qjs-ext-lib = qjs-ext-lib-pkg; };
        in
        {
          wallrizz = wallrizz-pkg;
          default = wallrizz-pkg;
        }
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
