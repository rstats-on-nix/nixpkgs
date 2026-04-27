{
  lib,
  beartype,
  buildPythonPackage,
  fetchPypi,
  hatch-vcs,
  hatchling,
  ipython,
  numpy,
  pythonAtLeast,
  pythonOlder,
  rich,
  sybil,
  typing-extensions,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "plum-dispatch";
  version = "2.8.0";
  pyproject = true;

  doCheck = false;

  disabled = pythonOlder "3.10" || pythonAtLeast "3.14";

  src = fetchPypi {
    pname = "plum_dispatch";
    inherit version;
    hash = "sha256-RT/HvGfSo5SSyDSwDJTYFocdFItaCl0/SeK78jkeJhk=";
  };

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    beartype
    rich
    typing-extensions
  ];

  nativeCheckInputs = [
    ipython
    numpy
    pytestCheckHook
    sybil
  ];

  pythonImportsCheck = [ "plum" ];

  meta = {
    description = "Multiple dispatch in Python";
    homepage = "https://github.com/wesselb/plum";
    changelog = "https://github.com/wesselb/plum/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
