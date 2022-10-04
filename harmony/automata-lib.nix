{
  pkgs ? import <nixpkgs> {},
  lib ? import <nixpkgs/lib>,
  pythonver ? pkgs.python310Packages,
}:

pythonver.buildPythonPackage rec {
  pname = "automata-lib";
  version = "6.0.2";

  disabled = pythonver.pythonOlder "3.6";

  src = pythonver.fetchPypi {
    inherit pname version;
    sha256 = "sha256-ABoGQEcz1mepjoMvK/WSfxAnTHjTJtJaq592fjDqxnU=";
  };

  propagatedBuildInputs = with pythonver; [
    pydot
    networkx
  ];

  doCheck = false;
}
