-------------------------------------------------------------------------------------------------------------------------
function SCHEMA:CanDeleteChar(ply, char)
    if char:getMoney() < nut.config.get("defMoney", 0) then return true end
end

-------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSwitchFlashlight(ply, on)
    return true
end

-------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpray(client)
    return true
end

-------------------------------------------------------------------------------------------------------------------------
function SCHEMA:GetGameDescription()
    return "Sample"
end

-------------------------------------------------------------------------------------------------------------------------    
if SERVER then
    function SCHEMA:EntityTakeDamage(client, dmg)
        if IsValid(client) and client:IsPlayer() and dmg:IsDamageType(DMG_CRUSH) and not IsValid(client.nutRagdoll) then
            dmg:ScaleDamage(0)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
hook.Add("PlayerNoClip", "nsClippyClip", function(player, state) -- INVIS NOCLIP
    if (player:IsAdmin()) then
        if (state) then
            player:SetNoDraw(true)
        else
            player:SetNoDraw(false)
        end

        return true
    else
        return false
    end
end)

-------------------------------------------------------------------------------------------------------------------------
local modelList = {"model1", "model2", "model3"}

for _, v in pairs(modelList) do
    nut.anim.setModelClass(v, "player")
end

------------------------------------------------------------------------------------------------------------------------