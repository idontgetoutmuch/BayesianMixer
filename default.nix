{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, ad, base, bytestring, cassava, diagrams-lib
      , diagrams-rasterific, foldl, histogram-fill, hmatrix, monad-loops
      , mtl, plots, random-fu, random-fu-multivariate, random-source
      , stdenv, vector
      }:
      mkDerivation {
        pname = "HaskellX";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          ad base bytestring cassava diagrams-lib diagrams-rasterific foldl
          histogram-fill hmatrix monad-loops mtl plots random-fu
          random-fu-multivariate random-source vector
        ];
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
