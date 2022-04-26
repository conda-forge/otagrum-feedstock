curl -fsSLO https://github.com/openturns/build-modules/releases/download/v1.19rc1/%PKG_NAME%-%PKG_VERSION%-py%PY_VER%-x86_64.exe
if errorlevel 1 exit 1

%PKG_NAME%-%PKG_VERSION%-py%PY_VER%-x86_64.exe /userlevel=1 /S /FORCE /D=%PREFIX%
if errorlevel 1 exit 1
