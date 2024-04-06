{

  inputs =
  { nixpkgs.url = "github:NixOS/nixpkgs";

    release =
    { flake = false;
      url   = "https://github.com/ssddq/editor-release/releases/download/binary/editor";
    };
  };

  outputs = { self, nixpkgs, release }:
  let system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
  in
  { packages.${system}.default = pkgs.stdenv.mkDerivation
    { name = "editor";
      version = "0.1";

      src = ./.;

      nativeBuildInputs = [ pkgs.autoPatchelfHook ];

      buildInputs = with pkgs;
      [ bzip2
        elfutils
        gcc
        glibc
        gmp
        libffi
        libstdcxx5
        SDL2
        vulkan-loader
        xorg.libX11
        xorg.libXau
        xorg.libxcb
        xorg.libXcursor
        xorg.libXdmcp
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXrender
        xorg.libXScrnSaver
        xz
        zlib
        zstd
      ];

      installPhase =
      ''
        install -m755 -D ${release.outPath} $out/bin/editor
      '';
    };
  };

}
