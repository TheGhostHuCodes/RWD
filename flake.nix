{
  description = "Rust Web Development";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, utils, rust-overlay, ... }:
    let name = "rust-web-development";
    in utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in
      with pkgs; {
        devShells.default =
          mkShell {
            packages = [ fish ];
            buildInputs = [
              (rust-bin.stable.latest.default.override
                {
                  extensions = [ "rust-src" ];
                })
            ];
            shellHook = ''
              fish && exit
            '';
          };
      });
}
