@echo off
title Configurador Git para Acceso Total
color 0E

echo.
echo ========================================
echo     CONFIGURADOR GIT PARA GITHUB
echo ========================================
echo.

echo [1/5] Inicializando repositorio Git...
git init

echo [2/5] Configurando archivo .gitignore...
if not exist ".gitignore" (
    echo Creando .gitignore...
)

echo [3/5] Añadiendo todos los archivos...
git add .

echo [4/5] Creando commit inicial...
git commit -m "Proyecto Roblox completo - Acceso total configurado"

echo [5/5] Configuración de GitHub...
echo.
echo Para subir a GitHub:
echo 1. Ve a: https://github.com/new
echo 2. Nombre del repositorio: RobloxGame-AccesoTotal
echo 3. Marca como público (para que pueda acceder)
echo 4. No inicialices con README
echo 5. Crea el repositorio
echo.
echo Después ejecuta estos comandos:
echo.
echo git remote add origin https://github.com/TUUSUARIO/RobloxGame-AccesoTotal.git
echo git branch -M main
echo git push -u origin main
echo.
echo ========================================
echo            ACCESO TOTAL LISTO
echo ========================================
echo.
echo Una vez subido a GitHub:
echo 1. Comparte el enlace del repositorio
echo 2. Tendré acceso completo para leer y editar TODO
echo 3. Podremos trabajar en tiempo real
echo.

pause