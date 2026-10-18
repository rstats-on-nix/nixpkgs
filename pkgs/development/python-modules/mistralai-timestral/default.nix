{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  huggingface-hub,
  numpy,
  pytestCheckHook,
  safetensors,
  setuptools,
  torch,
}:

buildPythonPackage (finalAttrs: {
  pname = "timestral";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mistralai";
    repo = "timestral";
    rev = "a534bdbd244d64f3d9d743f46c7bf6fc330ed4ff";
    hash = "sha256-56yxYM/0BRjh9kZl/RRodjdnwe06V4pM4pbrOofEVx0=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    huggingface-hub
    numpy
    safetensors
    torch
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "timestral"
  ];

  meta = {
    description = "Standalone inference for Timestral time-series forecasting models";
    homepage = "https://github.com/mistralai/timestral";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ b-rodrigues ];
  };
})
