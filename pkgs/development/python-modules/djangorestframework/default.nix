{ lib
, buildPythonPackage
, fetchFromGitHub

# build-system
, setuptools

# dependencies
, django

# tests
, coreapi
, django-guardian
, inflection
, pytest-django
, pytestCheckHook
, pyyaml
, uritemplate
}:

buildPythonPackage rec {
  pname = "djangorestframework";
  version = "3.15.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "encode";
    repo = "django-rest-framework";
    rev = version;
    hash = "sha256-G914NvxRmKGkxrozoWNUIoI74YkYRbeNcQwIG4iSeXU=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    django
  ];

  nativeCheckInputs = [
    pytest-django
    pytestCheckHook

    # optional tests
    coreapi
    django-guardian
    inflection
    pyyaml
    uritemplate
  ];

  pythonImportsCheck = [ "rest_framework" ];

  meta = with lib; {
    changelog = "https://www.django-rest-framework.org/community/${lib.versions.majorMinor version}-announcement/";
    description = "Web APIs for Django, made easy";
    homepage = "https://www.django-rest-framework.org/";
    maintainers = with maintainers; [ desiderius ];
    license = licenses.bsd2;
  };
}
