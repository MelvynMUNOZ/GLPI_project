@echo off
setlocal enabledelayedexpansion

set "file=setup.sql"
set "tempfile=temp.txt"
set "search=DATAFILE "
set "sqlMDP=%1"
cd %~dp0

rem si il y a deux arguments d'entrée, mettre le deuxième dans la variable de chemin de la base de données
if "%2"=="" (
    if exist GLPIREPERTORY (
        rd /s /q GLPIREPERTORY
    )
    mkdir GLPIREPERTORY
    set "glpiPath=%~dp0GLPIREPERTORY"
    echo yeap
) else (
    if exist GLPIREPERTORY (
        rd /s /q GLPIREPERTORY
    )
    set "glpiPath=%2"
    echo nooo
)



set "replacement=DATAFILE '%glpiPath%\GLPI.DBF'"

if not exist "%file%" (
    echo Le fichier %file% n'existe pas.
    exit /b
)

rem Supprimer le fichier temporaire s'il existe déjà
if exist "%tempfile%" (
    del "%tempfile%"
)

rem Parcourir chaque ligne du fichier
for /f "delims=" %%a in (%file%) do (
    set "line=%%a"
    rem Vérifier si la ligne contient le mot recherché
    echo !line! | findstr /i /c:"%search%" >nul
    if !errorlevel! equ 0 (
        rem Si le mot est trouvé, remplacer la ligne
        echo %replacement%>>"%tempfile%"
    ) else (
        rem Sinon, conserver la ligne originale
        echo !line!>>"%tempfile%"
    )
)

rem Remplacer le fichier original par le fichier temporaire
move /y "%tempfile%" "%file%"
echo Remplacement terminé.


sqlplus -S system/%sqlMDP%@localhost/XE @%~dp0setupBatch.sql



