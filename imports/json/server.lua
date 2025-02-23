local LoadResourceFile <const> = LoadResourceFile
local SaveResourceFile <const> = SaveResourceFile

--- sl.json.load
---@param filePath string
---@param resourceName? string
---@return string
local function Loadjson(filePath, resourceName)
    local resource <const> = resourceName or sl.env or sl.name
    local path <const> = filePath:gsub('%.json$', ''):gsub('%.', '/')
    local str <const> = json.decode(LoadResourceFile(resource, ("%s.json"):format(path)))
    if not str then
        error(('[ERROR] : Le fichier (%s) dans la ressource => %s, n\'a pas pu être chargé'):format(path, resource), 2)
    end
    return str
end

--- sl.json.write
---@param filePath string
---@param data table
---@param resourceName? string|nil
---@param dataLength? integer
---@return boolean
local function Writejson(filePath, data, resourceName, dataLength)
    local resource <const> = resourceName or sl.env or sl.name
    local lenght <const> = dataLength or -1
    local path <const> = filePath:gsub('%.json$', ''):gsub('%.', '/')
    local writeFile <const> = SaveResourceFile(resource, ("%s.json"):format(path), json.encode(data, {indent = true}), lenght)
    if not writeFile then
        error(('[ERROR] : Le fichier (%s) dans la ressource => %s, n\'a pas pu être sauvegardé'):format(path, resource), 2)
        return false
    end
    return true
end

return {
    load = Loadjson,
    save = Writejson
}