with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "bspwm-scripts-1.01";
    builder = "${bash}/bin/bash";
    args = [ ./builder.sh ];
    inherit coreutils xdotool bspwm xtitle wmctrl;
    wmutils = wmutils-core;
    src = ./scripts;
    unpackPhase = "true";
    system = builtins.currentSystem;
}
