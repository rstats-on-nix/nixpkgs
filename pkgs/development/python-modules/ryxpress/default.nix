{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  setuptools,
}:

buildPythonPackage rec {
  pname = "ryxpress";
  version = "0.1.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "b-rodrigues";
    repo = "ryxpress";
    tag = "v${version}";
    hash = "sha256-vmlbpYG3sVUdOLBHWFuPq7Rfb+lbomHPKXAdYuRxY/Q=";
  };

  build-system = [ setuptools ];

  doCheck = false;

  pythonImportsCheck = [ "ryxpress" ];

  meta = with lib; {
    description = "Reproducible Analytical Pipelines with Nix";
    homepage = "https://github.com/b-rodrigues/ryxpress";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ b-rodrigues ];
  };
}
