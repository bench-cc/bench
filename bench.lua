local args = { ... }

local function expect(arg, typ, n)
    local errfmt = "Expected %s, got %s for argument #%d"

    if type(n) ~= "number" then error(errfmt:format("number", type(n), 3), 2) end

    local t = type(arg)

    if type(typ) == "string" then
        if t ~= typ then error(errfmt:format(typ, t, n), 3) end
    elseif type(typ) == "table" then
        for i, v in ipairs(typ) do
            if t == v then return arg end
        end

        error(errfmt:format(table.concat(typ, "/"), t, n), 3)
    else
        error(errfmt:format("string/table", type(typ), 2), 2)
    end

    return arg
end

local function readFile(path)
    expect(path, "string", 1)

    if not fs.exists(path) then error("File not found: " .. path, 2) end
    if fs.isDir(path) then error("Cannot read directory: " .. path, 2) end

    local h = fs.open(path, "r")
    local data = h.readAll()
    h.close()

    return data
end

local function writeFile(path, data)
    expect(path, "string", 1)
    expect(data, "string", 2)

    local f = fs.open(path, "w")
    f.write(data)
    f.close()
end

local protocols = {}

local function readURI(uri)
    expect(uri, "string", 1)

    local protocol, path = uri:match("^(%w+):(.*)$")

    if protocol and path then
        return protocols[protocol](path, protocol)
    else
        error("Malformed URI: " .. uri, 2)
    end
end

protocols.file = readFile

function protocols.raw(data)
    return expect(data, "string", 1)
end

function protocols.http(url, protocol)
    expect(url, "string", 1)
    expect(protocol, "string", 2)

    local h = http.get(protocol .. ":" .. url)
    if not h then error(protocol:upper() .. " request failed") end
    local data = h.readAll()
    h.close()

    return data
end

function protocols.pastebin(id)
    expect(id, "string", 1)

    return readURI("https://pastebin.com/raw/" .. id)
end

protocols.https = protocols.http

protocols = setmetatable(protocols, { __index = function(t, k) error("Unknown protocol: " .. k) end })

local rootDir = settings.get("bench.root", "/.bench/")

local userConfigFile = fs.combine(rootDir, "userconfig.lua")

local function readConfig(key, default)
    expect(key, "string", 1)
    
    local cfg = (fs.exists(userConfigFile) and textutils.unserialize(readFile(userConfigFile))) or {}

    if cfg[key] == nil then return default end
    return cfg[key]
end

local function writeConfig(key, value)
    expect(key, "string", 1)

    local cfg = (fs.exists(userConfigFile) and textutils.unserialize(readFile(userConfigFile))) or {}
    cfg[key] = value

    writeFile(userConfigFile, textutils.serialize(cfg))
end

local function getRepos()
    local repos = {} -- todo: add default repos

    local userRepos = readConfig("customRepos", {})

    if type(userRepos) == "table" then
        for k, v in pairs(userRepos) do
            repos[k] = v
        end
    end

    return repos
end

local function parseRepo(source, errcb)
    expect(source, "string", 1)
    local errcb = expect(errcb, { "function", "nil" }, 2) or error
    
    -- todo: detect and strip malicious if, while, for, repeat, function

    local loadenv = {}

    -- todo: loadenv.repo, loadenv.package

    local f, err = load(source)

    if not f then
        errcb(err)
    else
        f()

        return {} -- placeholder
    end
end

local function loadRepos(errcb)
    local errcb = expect(errcb, { "function", "nil" }, 1) or error

    local repos = getRepos()
    local loaded = {}

    for k, v in pairs(repos) do
        local got = { pcall(readURI, v) }

        if got[1] then
            -- success
            loaded[k] = parseRepo(got[2], function(e) errcb("Error parsing repo " .. k .. ": " .. e) end)
        else
            -- error
            errcb("Error retrieving repo " .. k .. ": " .. got)
        end
    end

    return loaded
end

local benchapi = {
    expect = expect,
    protocols = protocols,
    readURI = readURI,
    rootDir = rootDir,
    userConfigFile = userConfigFile,
    readConfig = readConfig,
    writeConfig = writeConfig,
    getRepos = getRepos,
    parseRepo = parseRepo,
    loadRepos = loadRepos
}

return benchapi