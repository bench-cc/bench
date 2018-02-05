local args = { ... }

local function validateValue(value, typ)
    local t = type(value)

    if type(typ) == "string" then
        if t == typ then return true end


        local typ, pattern = typ:match("^(%a+):(.+)$")

        if pattern then
            if typ == "string" and t == typ then return value:match(pattern) ~= nil end
            --todo: number ranges?
        end

        return false
    elseif type(typ) == "table" then
        local out = false

        for i, v in ipairs(typ) do
            out = out or validateValue(value, v)
        end

        return out
    else
        error(("Invalid validator type - expected string/table, got %s for argument #2"):format(type(typ)) ,2)
    end
end

local function expect(arg, typ, n, errcb)
    local errfmt = "Expected %s, got %s for argument #%d"
    local errcb = type(errcb) == "function" and errcb or error

    if type(n) ~= "number" then errcb(errfmt:format("number", type(n), 3), 2) end

    local t = type(arg)

    if type(typ) == "string" then
        if t ~= typ then errcb(errfmt:format(typ, t, n), 3) end
    elseif type(typ) == "table" then
        for i, v in ipairs(typ) do
            if t == v then return arg end
        end

        errcb(errfmt:format(table.concat(typ, "/"), t, n), 3)
    else
        errcb(errfmt:format("string/table", type(typ), 2), 2)
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

local function addRepo(name, uri)
    expect(name, "string", 1)
    expect(uri, "string", 1)

    local userRepos = readConfig("customRepos", {})
    userRepos = type(userRepos) == "table" and userRepos or {}

    userRepos[name] = uri

    writeConfig("customRepos", userRepos)
end

local function validateSchema(tbl, schema, errcb)
    expect(tbl, "table", 1)
    expect(schema, "table", 2)
    local errcb = expect(errcb, { "function", "nil" }, 3) or error

    for k, v in pairs(schema) do
        if not validateValue(tbl[k], v) then
            errcb(("Validation failed - expected %s, got %s for key %s"):format(type(v) == "table" and table.concat(v, "/") or tostring(v), type(tbl[k]), k))
            return false
        end
    end

    return true
end

local packageSchema = {
    name = "string:^[a-zA-Z0-9_-]+$",
    description = { "nil", "string:^%C*$" },
    version = "number",
    author = { "nil", "string:^%C*$" },
    depends = { "nil", "table" },
    files = { "nil", "table" },
    launch = { "nil", "string" }
}

local function parseRepo(source, errcb)
    expect(source, "string", 1)
    local errcb = expect(errcb, { "function", "nil" }, 2) or error
    
    -- todo: detect and strip malicious if, while, for, repeat, function

    local loadenv = {}

    function loadenv.package(data) return data end

    function loadenv.repo(data)
        expect(data, "table", 1, errcb)

        local packages = {}

        for i, v in ipairs(type(data) == "table" and data or {}) do
            if validateSchema(v, packageSchema, errcb) then
                table.insert(packages, v)
            end
        end

        return packages
    end

    local f, err = load(source, nil, "t", loadenv)

    if not f then
        errcb(err)
    else
        local ok, got = pcall(f)

        if not ok then
            errcb(got)
        else
            return got or {}
        end
    end

    return {}
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
    validateValue = validateValue,
    expect = expect,
    protocols = protocols,
    readURI = readURI,
    rootDir = rootDir,
    userConfigFile = userConfigFile,
    readConfig = readConfig,
    writeConfig = writeConfig,
    getRepos = getRepos,
    addRepo = addRepo,
    validateSchema = validateSchema,
    packageSchema = packageSchema,
    parseRepo = parseRepo,
    loadRepos = loadRepos
}

return benchapi