{
  lib,
  black,
  buildPythonPackage,
  click,
  fetchPypi,
  griffe,
  importlib-metadata,
  importlib-resources,
  plum-dispatch,
  pydantic,
  pythonAtLeast,
  pythonOlder,
  pyyaml,
  requests,
  setuptools,
  setuptools-scm,
  sphobjinv,
  syrupy,
  tabulate,
  typing-extensions,
  watchdog,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "quartodoc";
  version = "0.11.1";
  pyproject = true;

  disabled = pythonOlder "3.10" || pythonAtLeast "3.14";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-wSFibho2OS0WhjHzPE0+f9SNGF3heIWfjq+9oU+/6S8=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    black
    click
    griffe
    importlib-metadata
    importlib-resources
    plum-dispatch
    pydantic
    pyyaml
    requests
    sphobjinv
    tabulate
    typing-extensions
    watchdog
  ];

  nativeCheckInputs = [
    pytestCheckHook
    syrupy
  ];

  pythonImportsCheck = [ "quartodoc" ];

  meta = {
    description = "Generate API documentation with Quarto";
    homepage = "https://machow.github.io/quartodoc";
    changelog = "https://github.com/machow/quartodoc/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "quartodoc";
  };
}
