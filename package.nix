{
  stdenv,
  fetchFromGitHub,
  quickjs,
  qjs-ext-lib,
}:
let
  justjs = fetchFromGitHub {
    owner = "5hubham5ingh";
    repo = "justjs";
    rev = "main";
    sha256 = "FWIS6f16wIvTgpEUxhCeYL94Jp8b19X4Nx6oww7sbU0=";
  };
in
stdenv.mkDerivation {
  pname = "WallRizz";
  version = "v1.4.0";

  src = fetchFromGitHub {
    owner = "5hubham5ingh";
    repo = "WallRizz";
    rev = "v1.4.0";
    sha256 = "v3dulDrbvAvwgeDlDt7um2qmZOkBkd5alaq8hyfgGfQ=";
  };

  nativeBuildInputs = [ quickjs ];
  buildInputs = [
    qjs-ext-lib
    justjs
  ];

  # Build from sources
  buildPhase = ''
    runHook preBuild

    ln -s ${justjs} ../justjs
    mkdir -p ../qjs-ext-lib/src
    ln -s ${qjs-ext-lib}/bin/ext/* ../qjs-ext-lib/src/

    cd ./src
    qjsc -D extensionHandlerWorker.js -o WallRizz main.js

    runHook postBuild
  '';

  # Install final binary
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 WallRizz $out/bin

    runHook postInstall
  '';
}
