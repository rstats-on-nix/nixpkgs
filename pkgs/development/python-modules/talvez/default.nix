{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  setuptools,
}:

buildPythonPackage rec {
  pname = "talvez";
  version = "0.0.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "b-rodrigues";
    repo = "talvez";
    tag = "v${version}";
    hash = "sha256-Jrd8FQ8X7ThDayR1+r6lRbosrf1qtLdcbcO5LcFOyaI=";
  };

  build-system = [ setuptools ];

  doCheck = false;

  pythonImportsCheck = [ "talvez" ];

  meta = with lib; {
    description = "Implementation of the Maybe monad";
    homepage = "https://github.com/b-rodrigues/talvez";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ b-rodrigues ];
  };
}
