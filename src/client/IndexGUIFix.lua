-- IndexGUIFix.lua
-- LocalScript que debe reemplazar el script problemático en la GUI Index

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- Esperar a que los RemoteEvents existan
local remoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents", 30)
local playerDataReady = remoteEvents and remoteEvents:WaitForChild("PlayerDataReady", 30)

-- Variables para datos del jugador
local playerData = {
    MaxStorage = 20,
    TripleEggOwned = false,
    AutoEggOwned = false
}

-- Función para acceso seguro a mascotas
local function getSafePets()
    if Player:FindFirstChild("Pets") then
        return Player.Pets:GetChildren()
    else
        return {}
    end
end

-- Función para contar mascotas de forma segura
local function countPets()
    return #getSafePets()
end

-- Función para verificar si se puede comprar un huevo
local function canBuyEgg()
    local currentPets = countPets()
    return currentPets < playerData.MaxStorage
end

-- Recibir datos del servidor
if playerDataReady then
    playerDataReady.OnClientEvent:Connect(function(data)
        playerData = data
        print("Cliente: Datos recibidos del servidor", data)
        
        -- Actualizar GUI aquí si es necesario
        updateEggGUI()
    end)
end

-- Función para actualizar la GUI de huevos
function updateEggGUI()
    -- Esta función debe reemplazar el código original que causaba el error
    print("Actualizando GUI de huevos...")
    
    -- Ejemplo de actualización segura:
    local currentPets = countPets()
    local maxPets = playerData.MaxStorage
    
    print("Mascotas actuales:", currentPets, "/", maxPets)
    
    -- Aquí es donde actualizarías los elementos de la GUI
    -- Por ejemplo, habilitar/deshabilitar botones de compra
    
    --[[
    local gui = Player.PlayerGui:FindFirstChild("Index")
    if gui then
        local scrollFrame = gui:FindFirstChild("Index")
        if scrollFrame then
            -- Actualizar elementos GUI de forma segura
        end
    end
    --]]
end

-- Función para manejar clicks en huevos (reemplazo del código original)
local function onEggClick(eggName)
    print("Click en huevo:", eggName)
    
    -- Verificar si se puede comprar
    if canBuyEgg() then
        print("Intentando comprar huevo:", eggName)
        -- Aquí invocarías el RemoteFunction del servidor
        local eggOpenRemote = remoteEvents:FindFirstChild("EggOpened")
        if eggOpenRemote then
            -- eggOpenRemote:InvokeServer(eggName, "Single")
        end
    else
        print("No se puede comprar - inventario lleno")
    end
end

-- Inicialización con fallback
spawn(function()
    -- Esperar un poco por si los datos llegan del servidor
    wait(3)
    
    -- Si no han llegado datos, usar valores por defecto
    if playerData.MaxStorage == 20 and not Player:FindFirstChild("Data") then
        print("Cliente: Usando valores por defecto - servidor no respondió")
    end
    
    -- Inicializar GUI
    updateEggGUI()
end)

-- Escuchar cambios en la carpeta Pets
if Player:FindFirstChild("Pets") then
    Player.Pets.ChildAdded:Connect(updateEggGUI)
    Player.Pets.ChildRemoved:Connect(updateEggGUI)
else
    -- Esperar a que se cree la carpeta
    Player.ChildAdded:Connect(function(child)
        if child.Name == "Pets" then
            child.ChildAdded:Connect(updateEggGUI)
            child.ChildRemoved:Connect(updateEggGUI)
            updateEggGUI()
        end
    end)
end

print("IndexGUIFix cargado - Listo para manejar GUI de huevos de forma segura")

--[[
INSTRUCCIONES PARA APLICAR ESTE FIX:

1. En Roblox Studio, ve a PlayerGui > Index > Index > ScrollingFrame > "Rare Egg" > Slot7
2. Encuentra el LocalScript llamado "Index"
3. REEMPLAZA todo el código de ese LocalScript con este código
4. O mejor aún, elimina ese LocalScript y crea uno nuevo con este código

Esto solucionará el error "Pets is not a valid member of Player" en el cliente.
--]]