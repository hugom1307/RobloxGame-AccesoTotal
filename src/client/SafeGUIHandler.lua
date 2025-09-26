-- SafeGUIHandler.lua
-- LocalScript que muestra cómo acceder de forma segura a Player.Pets y Player.Data desde GUIs

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Función para actualizar la GUI de manera segura
local function updatePetGUI()
    -- Verificar si ClientDataWaiter ya cargó las funciones globales
    if _G.GetPlayerPets then
        local pets = _G.GetPlayerPets()
        print("Mascotas del jugador:", #pets)
        
        -- Aquí es donde actualizarías tu GUI con la información de las mascotas
        -- Por ejemplo:
        -- for i, pet in pairs(pets) do
        --     -- Crear elemento GUI para cada mascota
        -- end
        
    else
        warn("ClientDataWaiter no ha cargado aún - reintentando en 1 segundo")
        wait(1)
        updatePetGUI()
    end
end

-- Función para manejar clicks en botones de huevos de manera segura
local function onEggButtonClick(eggName)
    -- Verificar datos antes de permitir compra
    if _G.GetPlayerData then
        local maxStorage = _G.GetPlayerData("MaxStorage", 20)
        local currentPets = #_G.GetPlayerPets()
        
        if currentPets < maxStorage then
            print("Puede comprar huevo:", eggName)
            -- Aquí activarías la compra del huevo
        else
            print("Inventario lleno! Mascotas:", currentPets, "/", maxStorage)
        end
    else
        warn("Datos del jugador no disponibles aún")
    end
end

-- Esperar a que los datos estén listos antes de inicializar la GUI
if _G.OnPlayerDataReady then
    _G.OnPlayerDataReady(function()
        print("GUI: Datos del jugador listos - Inicializando interfaz")
        updatePetGUI()
    end)
else
    -- Fallback si ClientDataWaiter no ha cargado
    spawn(function()
        -- Esperar hasta que Player.Pets exista
        local petsFolder = Player:WaitForChild("Pets", 30)
        if petsFolder then
            updatePetGUI()
        end
    end)
end

-- Ejemplo de cómo conectar botones de huevos
-- local eggButton = script.Parent -- Asumiendo que este script está en un botón
-- eggButton.MouseButton1Click:Connect(function()
--     onEggButtonClick("Basic") -- O el nombre del huevo correspondiente
-- end)

print("SafeGUIHandler cargado")