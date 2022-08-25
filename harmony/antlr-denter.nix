{
  pkgs ? import <nixpkgs> {},
  lib ? import <nixpkgs/lib>,
  pythonver ? pkgs.python310Packages,
}:

pythonver.buildPythonPackage rec {
  pname = "antlr-denter";
  version = "1.3.1";

  disabled = pythonver.pythonOlder "3.6";

  src = pythonver.fetchPypi {
    inherit pname version;
    sha256 = "sha256-yQg2d/NMeuAB1U5bCoOxJd6Hz8giOUziMMe4D0TAW88=";
  };

  propagatedBuildInputs = with pkgs; [
    pythonver.antlr4_9-python3-runtime
  ];

  doCheck = false;

  postPatch = ''
    sed -i '/^with/d' setup.py
    substituteInPlace setup.py \
      --replace "    long_description = fh.read()" "long_description = \"\""
  '';
}
