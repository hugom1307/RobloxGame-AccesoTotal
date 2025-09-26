-- PlayerDataManager.lua
-- Script que maneja la creación y carga de datos del jugador

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- DataStore para guardar datos del jugador
local PlayerDataStore = DataStoreService:GetDataStore("PlayerData")

-- Datos por defecto para nuevos jugadores
local DEFAULT_DATA = {
    MaxStorage = 20,
    TripleEggOwned = false,
    AutoEggOwned = false,
    -- Agregar más datos según necesites
}

-- Función para crear la estructura de datos del jugador
local function createPlayerData(player)
    -- Crear carpeta Data
    local dataFolder = Instance.new("Folder")
    dataFolder.Name = "Data"
    dataFolder.Parent = player
    
    -- Crear carpeta Pets
    local petsFolder = Instance.new("Folder")
    petsFolder.Name = "Pets"
    petsFolder.Parent = player
    
    -- Crear valores de datos
    local maxStorage = Instance.new("IntValue")
    maxStorage.Name = "MaxStorage"
    maxStorage.Value = DEFAULT_DATA.MaxStorage
    maxStorage.Parent = dataFolder
    
    local tripleEggOwned = Instance.new("BoolValue")
    tripleEggOwned.Name = "TripleEggOwned"
    tripleEggOwned.Value = DEFAULT_DATA.TripleEggOwned
    tripleEggOwned.Parent = dataFolder
    
    local autoEggOwned = Instance.new("BoolValue")
    autoEggOwned.Name = "AutoEggOwned"
    autoEggOwned.Value = DEFAULT_DATA.AutoEggOwned
    autoEggOwned.Parent = dataFolder
    
    return dataFolder
end

-- Función para cargar datos del jugador
local function loadPlayerData(player)
    local success, data = pcall(function()
        return PlayerDataStore:GetAsync(player.UserId)
    end)
    
    if success and data then
        -- Si hay datos guardados, aplicarlos
        if player.Data.MaxStorage then
            player.Data.MaxStorage.Value = data.MaxStorage or DEFAULT_DATA.MaxStorage
        end
        if player.Data.TripleEggOwned then
            player.Data.TripleEggOwned.Value = data.TripleEggOwned or DEFAULT_DATA.TripleEggOwned
        end
        if player.Data.AutoEggOwned then
            player.Data.AutoEggOwned.Value = data.AutoEggOwned or DEFAULT_DATA.AutoEggOwned
        end
        
        print("Datos cargados para:", player.Name)
    else
        print("Usando datos por defecto para:", player.Name)
        if not success then
            warn("Error cargando datos para " .. player.Name .. ":", data)
        end
    end
end

-- Función para guardar datos del jugador
local function savePlayerData(player)
    if not player.Data then return end
    
    local dataToSave = {
        MaxStorage = player.Data.MaxStorage.Value,
        TripleEggOwned = player.Data.TripleEggOwned.Value,
        AutoEggOwned = player.Data.AutoEggOwned.Value,
    }
    
    local success, error = pcall(function()
        PlayerDataStore:SetAsync(player.UserId, dataToSave)
    end)
    
    if success then
        print("Datos guardados para:", player.Name)
    else
        warn("Error guardando datos para " .. player.Name .. ":", error)
    end
end

-- Cuando un jugador se une
Players.PlayerAdded:Connect(function(player)
    print("Jugador conectado:", player.Name)
    
    -- Crear estructura de datos
    createPlayerData(player)
    
    -- Esperar un poco para asegurar que la estructura esté creada
    wait(1)
    
    -- Cargar datos guardados
    loadPlayerData(player)
    
    -- Asegurar que el personaje esté cargado antes de hacer disponible los datos
    player.CharacterAdded:Connect(function(character)
        -- Los datos ya están listos cuando el personaje aparece
        print("Personaje cargado para:", player.Name, "- Datos disponibles")
    end)
    
    -- Si el personaje ya existe, no hay problema
    if player.Character then
        print("Personaje ya existe para:", player.Name, "- Datos disponibles")
    end
end)

-- Cuando un jugador se va
Players.PlayerRemoving:Connect(function(player)
    print("Jugador desconectado:", player.Name)
    
    -- Guardar datos antes de que se vaya
    savePlayerData(player)
end)

-- Guardar datos cada 5 minutos (auto-save)
spawn(function()
    while true do
        wait(300) -- 5 minutos
        for _, player in pairs(Players:GetPlayers()) do
            savePlayerData(player)
        end
    end
end)

print("PlayerDataManager cargado correctamente")