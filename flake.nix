{
  description = "Lab environment for investigating nuxt/nuxt issue #31638";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs_22
            git
            jq
          ];

          shellHook = ''
            echo "nuxt-issue-31638-lab shell"
            echo "Node: $(node -v)"
            echo
            echo "Next:"
            echo "  cd vendor/nuxt"
            echo "  corepack pnpm install --frozen-lockfile"
            echo "  corepack pnpm dev:prepare"
          '';
        };
      });
}