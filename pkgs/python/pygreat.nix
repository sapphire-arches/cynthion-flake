{
  lib,
  buildPythonPackage,
  isPy3k,
  fetchFromGitHub,
  future,
  pyusb,
  setuptools,
  setuptools-git-versioning,
}:
buildPythonPackage rec {
  pname = "pygreat-2024";
  version = "v2024.0.1";

  src = fetchFromGitHub {
    owner = "greatscottgadgets";
    repo = "libgreat";
    rev = "v2024.0.1";
    hash = "sha256-k+0dGBohKglQEFN13mGsw0C6pCeQDRp+CwPW2GuKfuY=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-git-versioning
  ];

  propagatedBuildInputs = [
    future
    pyusb
  ];

  pyproject = true;

  postPatch = ''
    substituteInPlace host/pyproject.toml \
      --replace-fail '"backports.functools_lru_cache",' "" \
      --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
  '';

  disabled = !isPy3k;

  preBuild = ''
    cd host
    substituteInPlace setup.py --replace "'backports.functools_lru_cache'" ""
    substituteInPlace pygreat/comms.py --replace "from backports.functools_lru_cache import lru_cache as memoize_with_lru_cache" "from functools import lru_cache as memoize_with_lru_cache"
    echo "$version" > ../VERSION
  '';

  meta = with lib; {
    description = "Python library for talking with libGreat devices";
    homepage = "https://greatscottgadgets.com/greatfet/";
    license = with licenses; [bsd3];
  };
}
