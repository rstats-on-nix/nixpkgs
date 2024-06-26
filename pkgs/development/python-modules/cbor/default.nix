{
  lib,
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "cbor";
  version = "1.0.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1dmv163cnslyqccrybkxn0c9s1jk1mmafmgxv75iamnz5lk5l8hk";
  };

  # Tests are excluded from PyPI and four unit tests are also broken:
  # https://github.com/brianolson/cbor_py/issues/6
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/brianolson/cbor_py";
    description = "Concise Binary Object Representation (CBOR) library";
    license = licenses.asl20;
    maintainers = with maintainers; [ oxzi ];
  };
}
