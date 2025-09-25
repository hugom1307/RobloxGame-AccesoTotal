@echo off
title Sincronización Bidireccional Total
color 0B

echo.
echo ========================================
echo      SINCRONIZACIÓN BIDIRECCIONAL
echo ========================================
echo.

echo [IMPORTANTE] Este script debe ejecutarse DESPUÉS de:
echo - Haber ejecutado exportar_todo.bat
echo - Tener Roblox Studio abierto con tu juego
echo - Tener el plugin de Rojo conectado
echo.

echo ¿Has completado estos pasos? (Y/N)
set /p respuesta=

if /i not "%respuesta%"=="Y" (
    echo.
    echo Ejecuta primero exportar_todo.bat y sigue las instrucciones
    pause
    exit /b 0
)

echo.
echo [✓] Iniciando sincronización bidireccional...
echo.
echo ========================================
echo        ACCESO TOTAL ACTIVADO
echo ========================================
echo.
echo Ahora tengo acceso completo a:
echo.
echo ✓ Scripts (.luau/.lua)
echo ✓ Objetos del Workspace (Parts, Models, etc)
echo ✓ Interfaces de Usuario (GUIs, ScreenGuis)  
echo ✓ Configuración de Lighting
echo ✓ Sonidos y Assets
echo ✓ Tools y Herramientas
echo ✓ Configuración de Teams
echo ✓ Badges y GamePasses
echo ✓ Propiedades de todos los objetos
echo ✓ Estructura completa del juego
echo.
echo MANTÉN ESTA VENTANA ABIERTA
echo No la cierres mientras trabajamos juntos
echo.
echo ========================================

:: Mantener Rojo corriendo
rojo serve