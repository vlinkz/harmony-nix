{
  pkgs ? import <nixpkgs> {},
  lib ? import <nixpkgs/lib>,
  pythonver ? pkgs.python310Packages,
}:

pythonver.buildPythonPackage rec {
  pname = "automata-lib";
  version = "5.0.0";

  disabled = pythonver.pythonOlder "3.6";

  src = pythonver.fetchPypi {
    inherit pname version;
    sha256 = "sha256-YMUmtNrWes4rile5OlPTi2UEBQsAiEXKclRa/ZvnuQw=";
  };

  propagatedBuildInputs = with pkgs; [
    pythonver.pydot
  ];

  doCheck = false;
}
