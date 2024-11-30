# generated with claude for npm by someone who just got here

{
  description = "Next.js TypeScript project with Tailwind";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Node.js environment - matching your Dockerfile's version
            nodejs_18
            yarn

            # Docker tools for deployment
            docker
            docker-compose

            # Utilities
            # watchexec  # For file watching
          ];

          shellHook = ''
            # Set up local Node environment
            mkdir -p .npm-global
            export NPM_CONFIG_PREFIX=$PWD/.npm-global
            export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
            
            # Ensure node_modules/.bin is in PATH
            export PATH=$PWD/node_modules/.bin:$PATH

            # Set development ports
            export PORT=3000
            export NEXT_TELEMETRY_DISABLED=1

            echo "🚀 Next.js development environment ready!"
            echo "Node.js version: $(node --version)"
            echo "Yarn version: $(yarn --version)"
            echo ""
            echo "Available commands:"
            echo "  yarn dev        - Start development server"
            echo "  yarn build      - Build for production"
            echo "  yarn start      - Start production server"
            echo "  yarn lint       - Run ts-standard linting"
            echo "  yarn tailwind   - Watch Tailwind CSS changes"
            echo ""
            echo "Development server will run on port $PORT"
          '';
        };
      }
    );
}