{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.wallrizz;
  inherit (self.packages.${pkgs.system}) wallrizz;
in
{
  options.programs.wallrizz = {
    enable = lib.mkEnableOption "WallRizz";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ wallrizz ];
  };
}
