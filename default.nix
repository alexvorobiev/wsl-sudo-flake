{ lib
, stdenv
, python3
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "wsl-sudo";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Chronial";
    repo = "wsl-sudo";
    rev = "master";
    hash = "sha256-nbvXUvJWtXeDgtaBIh/5Cl732t+WS8l5J3/J2blgYWM=";
  };

  nativeBuildInputs = [ python3 python3.pkgs.wrapPython ];

  dontBuild = true;

  installPhase = ''
    install -Dm0755 wsl-sudo.py $out/bin/wsl-sudo
    patchShebangs $out/bin
    patchPythonScript $out/bin/wsl-sudo
  '';

  meta = with lib; {
    homepage = "https://github.com/Chronial/wsl-sudo";
    description = "Sudo for WSL";
    licene = licenses.gpl3;
    maintainers = [ maintainers.alexvorobiev ];
  };
}
