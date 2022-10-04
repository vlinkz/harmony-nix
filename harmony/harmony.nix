{
  pkgs ? import <nixpkgs> {},
  lib ? import <nixpkgs/lib>,
  pythonver ? pkgs.python310Packages,
}:
let
 automata-lib = (import ./automata-lib.nix { pkgs = pkgs; lib = lib; pythonver = pythonver; });
 antlr-denter = (import ./antlr-denter.nix { pkgs = pkgs; lib = lib; pythonver = pythonver; });
in
pythonver.buildPythonPackage rec {
  pname = "harmony";
  version = "1.2.2769";

  disabled = pythonver.pythonOlder "3.6";

  src = pythonver.fetchPypi {
    inherit pname version;
    sha256 = "sha256-RC1yUnMmTVMzxd4p4+jit99glFLbSNKJ8HiJD3Q42lg=";
  };

  propagatedBuildInputs = with pkgs; [
    automata-lib
    antlr-denter
    pythonver.antlr4_9-python3-runtime
    pythonver.requests
    pythonver.setuptools
  ];

  doCheck = false;

  pythonImportsCheck = [
    "harmony_model_checker"
  ];
}
