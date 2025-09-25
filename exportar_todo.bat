@echo off
title Exportador Completo de Roblox Studio
color 0A

echo.
echo ========================================
echo    EXPORTADOR TOTAL - ROBLOX STUDIO
echo ========================================
echo.

:: Crear estructura de carpetas para TODO
echo [1/4] Creando estructura completa de carpetas...

if not exist "src" mkdir "src"
if not exist "src\shared" mkdir "src\shared"
if not exist "src\server" mkdir "src\server"  
if not exist "src\client" mkdir "src\client"
if not exist "src\workspace" mkdir "src\workspace"
if not exist "src\gui" mkdir "src\gui"
if not exist "src\first" mkdir "src\first"
if not exist "src\lighting" mkdir "src\lighting"
if not exist "src\sounds" mkdir "src\sounds"
if not exist "src\tweens" mkdir "src\tweens"
if not exist "src\players" mkdir "src\players"
if not exist "src\teams" mkdir "src\teams"
if not exist "src\tools" mkdir "src\tools"
if not exist "src\http" mkdir "src\http"
if not exist "src\marketplace" mkdir "src\marketplace"
if not exist "src\badges" mkdir "src\badges"
if not exist "src\gamepasses" mkdir "src\gamepasses"

echo ✓ Estructura de carpetas creada

:: Detener procesos anteriores
echo [2/4] Limpiando procesos anteriores...
taskkill /f /im "rojo.exe" >nul 2>&1
timeout /t 2 >nul

echo ✓ Procesos limpiados

:: Generar archivo base
echo [3/4] Generando archivo base del juego...
rojo build --output "JuegoCompleto.rbxl"

if exist "JuegoCompleto.rbxl" (
    echo ✓ Archivo 'JuegoCompleto.rbxl' generado correctamente
) else (
    echo ✗ Error al generar el archivo base
    pause
    exit /b 1
)

echo [4/4] Iniciando servidor Rojo para sincronización...

echo.
echo ========================================
echo           INSTRUCCIONES
echo ========================================
echo.
echo 1. Abre Roblox Studio
echo 2. Abre el archivo: JuegoCompleto.rbxl
echo 3. Instala el plugin de Rojo si no lo tienes
echo 4. Haz clic en "Connect to Rojo" en el plugin
echo 5. Copia/pega todo tu contenido actual al Studio
echo 6. Guarda el archivo
echo.
echo Después ejecuta: sync_completo.bat
echo.
echo Presiona ENTER cuando hayas hecho los pasos...
pause >nul

echo.
echo ========================================
echo    LISTO PARA SINCRONIZACIÓN TOTAL
echo ========================================

rojo serve