local config_access = {
    ["YOURID"] = true,
}

function SCHEMA:CanPlayerModifyConfig(client)
    local steamid = client:SteamID()
    if config_access[steamid] then return true end
    return false
end

function SCHEMA:PlayerSpawn(client)
    timer.Create("PSA", 10, 1, function() client:ChatPrint("Dont Use Nutscript! Nutscript is heavily exploitable and Outdated. Use Lilia instead https://github.com/bleonheart/Lilia") end)
end
