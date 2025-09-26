-- ClientDataWaiter.lua
-- LocalScript que espera a que los datos del jugador estén disponibles del lado del cliente

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Función para esperar a que existan los datos del jugador
local function waitForPlayerData()
    -- Esperar a que Player.Data exista
    local dataFolder = Player:WaitForChild("Data", 30)
    if not dataFolder then
        warn("Timeout esperando Player.Data para:", Player.Name)
        return false
    end
    
    -- Esperar a que Player.Pets exista
    local petsFolder = Player:WaitForChild("Pets", 30)
    if not petsFolder then
        warn("Timeout esperando Player.Pets para:", Player.Name)
        return false
    end
    
    print("Datos del jugador cargados correctamente en el cliente:", Player.Name)
    return true
end

-- Función para acceso seguro a datos del jugador desde el cliente
local function getPlayerData(dataName, defaultValue)
    if Player:FindFirstChild("Data") and Player.Data:FindFirstChild(dataName) then
        return Player.Data[dataName].Value
    else
        warn("Dato no encontrado en cliente:", dataName, "- Usando valor por defecto:", defaultValue)
        return defaultValue
    end
end

-- Función para acceso seguro a las mascotas del jugador
local function getPlayerPets()
    if Player:FindFirstChild("Pets") then
        return Player.Pets:GetChildren()
    else
        warn("Player.Pets no existe aún en el cliente")
        return {}
    end
end

-- Esperar a que los datos estén disponibles al iniciar
spawn(function()
    local success = waitForPlayerData()
    if success then
        -- Disparar evento personalizado para notificar que los datos están listos
        local dataReadyEvent = Instance.new("BindableEvent")
        dataReadyEvent.Name = "PlayerDataReady"
        dataReadyEvent.Parent = Player
        
        dataReadyEvent:Fire()
        
        -- También crear funciones globales para acceso seguro
        _G.GetPlayerData = getPlayerData
        _G.GetPlayerPets = getPlayerPets
        
        print("Cliente: Funciones de datos disponibles globalmente")
    end
end)

-- Crear evento para que otros scripts puedan suscribirse
local function onPlayerDataReady(callback)
    if Player:FindFirstChild("Data") and Player:FindFirstChild("Pets") then
        -- Los datos ya están listos
        callback()
    else
        -- Esperar al evento
        local connection
        connection = Player.ChildAdded:Connect(function(child)
            if child.Name == "PlayerDataReady" then
                callback()
                connection:Disconnect()
            end
        end)
    end
end

-- Hacer disponible la función globalmente
_G.OnPlayerDataReady = onPlayerDataReady

print("ClientDataWaiter cargado - Esperando datos del jugador...")