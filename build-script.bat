
@echo off

set "dirProject=diretorio do seu projeto"
set "nomeApp=nome do seu app"
set "dirInit=diretorio inicial do seu projeto"
set "dirDist=diretorio da pasta dist do projeto"
set "dirApp=pasta destino para o arquivo.app"

set "dirAppServer=C:\TOTVS\Protheus2310\Protheus\bin\appserver"
set "includes=C:\TOTVS\Includes\2210"
set "env=desenv"

set "prog=SIGAMDI"
set "conec=TCP"
set "smartClient=C:\TOTVS\Protheus2310\Protheus\bin\smartclient\"
set "param=-m -p=%prog% -c=%conec% -e=%env%"

@REM // Navigate to the frontend directory
cd /d "%dirProject%"

@REM // Run Angular build
call ng build

@REM // Navigate back to the project root directory
cd /d "%dirInit%"

@REM // Accessing dist folder
cd /d "%dirInit%\%dirDist%"

@REM // Compressing files using PowerShell
powershell.exe Compress-Archive "%nomeApp%" "%nomeApp%.zip" -Force

@REM // Renaming the compressed file
rename "%nomeApp%.zip" "%nomeApp%.app"

@REM // Moving the compressed file to the backendprotheus folder
move "%nomeApp%.app" "%dirInit%\%dirApp%"

@REM // Compiling in Protheus
cd /d "%dirAppServer%"
appserver.exe -compile -files="%dirInit%\%dirApp%" -includes="%includes%" -src="%dirInit%\%dirApp%" -env="%env%"

@REM // Run smartClient with parameters
cd /d "%smartClient%"
start "" "smartclient.exe" %param%

@REM // Returning to the frontend directory
cd /d "%dirProject%"
