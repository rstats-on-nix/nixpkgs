{
  lib,
  attrs,
  buildPythonPackage,
  certifi,
  fetchPypi,
  jsonschema,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "sphobjinv";
  version = "2.4";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-RNV+fofhfYx7BTyFPcw2+Ay/fR/BUtV2NP17yuOMpIo=";
  };

  build-system = [ setuptools ];

  dependencies = [
    attrs
    certifi
    jsonschema
  ];

  # Tests are broken due to flaky/sphinx version incompatibilities
  doCheck = false;

  pythonImportsCheck = [ "sphobjinv" ];

  meta = {
    description = "Sphinx objects.inv Inspection/Manipulation Tool";
    homepage = "https://github.com/bskinn/sphobjinv";
    changelog = "https://github.com/bskinn/sphobjinv/blob/main/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "sphobjinv";
  };
}
