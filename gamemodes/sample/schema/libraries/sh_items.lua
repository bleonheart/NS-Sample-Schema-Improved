nsitem = nsitem or {}
nsitem.register = nsitem.register or {}
nsitem.register = nsitem.register.weapons or {}

nsitem.register.misc = {
    ["copper_ore"] = {-- uniqueID
        ["name"] = "Copper Ore",
        ["desc"] = "A Copper Ore.",
        ["model"] = "models/clutter/abraxo.mdl",
        ["width"] = 1,
        ["height"] = 1,
        ["price"] = 2,
    }, 
    ["gold_ore"] = {
        ["name"] = "Gold Ore",
        ["desc"] = "A Gold Ore.",
        ["model"] = "models/clutter/abraxo.mdl",
        ["width"] = 1,
        ["height"] = 1,
        ["price"] = 2,
    },
}

nsitem.register.weapons = {
    ["drc_ma37_c"] = {
        ["name"] = "Ma37",
        ["desc"] = "Ma37.",
        ["model"] = "models/props_c17/BriefCase001a.mdl",
        ["class"] = "drc_ma37_c",
        ["width"] = 1,
        ["height"] = 1,
        ["price"] = 2,
    },
    ["drc_ma37_c"] = {
        ["name"] = "Ma37",
        ["desc"] = "Ma37",
        ["model"] = "models/props_c17/BriefCase001a.mdl",
        ["class"] = "drc_ma37_c",
        ["width"] = 1,
        ["height"] = 1,
        ["price"] = 2,
    },
}

function SCHEMA:InitializedPlugins()
    for i, v in pairs(nsitem.register) do
        if (i == "weapons") then
            for x, y in pairs(v) do
                SCHEMA:registerWeapon(x, y, i)
            end
        else
            for x, y in pairs(v) do
                SCHEMA:registerItem(x, y, i)
            end
        end
    end
end

function SCHEMA:registerWeapon(id, data, category)
    local ITEM = nut.item.register(id, "base_weapons", nil, nil, true)
    ITEM.name = data["name"]
    ITEM.desc = data["desc"]
    ITEM.model = data["model"]
    ITEM.class = data["class"]
    ITEM.weaponCategory = "primary"
    ITEM.width = data["width" or 2]
    ITEM.price = data["price"]
    ITEM.height = data["height"] or 2
end

function SCHEMA:registerItem(id, data, base)
    local ITEM = nut.item.register(id, "base_junk", nil, nil, true)
    ITEM.name = data["name"]
    ITEM.desc = data["desc"] or ITEM.name
    ITEM.model = data["model"] or "models/fallout/components/box.mdl"
    ITEM.price = data["price"]
    ITEM.width = data["width"] or 1
    ITEM.height = data["height"] or 1
end