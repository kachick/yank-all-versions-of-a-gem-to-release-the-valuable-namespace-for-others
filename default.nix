{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/e521a883757b06720d28d4a303e0b4f7f0d7fcfc.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nil
    pkgs.nixpkgs-fmt
    pkgs.dprint
    pkgs.ruby_3_1
    pkgs.jq
    pkgs.curl
  ];
}
