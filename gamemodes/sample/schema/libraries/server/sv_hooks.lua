local config_access = {
    ["YOURID"] = true,
}

function SCHEMA:CanPlayerModifyConfig(client)
    local steamid = client:SteamID()
    if (config_access[steamid]) then return true end

    return false
end