nut.command.add("clearworlditems", {
    syntax = "",
    superAdminOnly = true,
    onRun = function(client, arguments)
        local count = 0

        for i, v in pairs(ents.FindByClass("nut_item")) do
            count = count + 1
            v:Remove()
        end

        client:ChatPrint("Cleared " .. count .. " world items!")
    end;
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("cleannpcs", {
    adminOnly = true,
    onRun = function(client, arguments)
        local count = 0

        if (not arguments[1]) then
            for k, v in pairs(ents.GetAll()) do
                if IsValid(v) and (v:IsNPC() or v.chance) and not IsFriendEntityName(v:GetClass()) then
                    count = count + 1
                    v:Remove()
                end
            end
        else
            local trace = client:GetEyeTraceNoCursor()
            local hitpos = trace.HitPos + trace.HitNormal * 5

            for k, v in pairs(ents.FindInSphere(hitpos, arguments[1] or 100)) do
                if IsValid(v) and (v:IsNPC() or v.chance) and not IsFriendEntityName(v:GetClass()) then
                    count = count + 1
                    v:Remove()
                end
            end
        end

        client:notify(count .. " NPCs and Nextbots have been cleaned up from the map.")
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("clearinv", {
    adminOnly = true,
    syntax = "<string name>",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])

        if (IsValid(target) and target:getChar()) then
            for k, v in pairs(target:getChar():getInv():getItems()) do
                v:remove()
            end

            client:notifyLocalized("resetInv", target:getChar():getName())
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("announce", {
    syntax = "<string msg>",
    adminOnly = true,
    onRun = function(ply, args, msg)
        if ply:IsSuperAdmin() then
            nut.util.notify("ANNOUNCEMENT: " .. args[1])
        else
            ply:ChatPrint("You need to be SuperAdmin")
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
if (SERVER) then
    util.AddNetworkString("OpenInvMenu")
    util.AddNetworkString("OpenRoster")

    function ItemCanEnterForEveryone(inventory, action, context)
        if (action == "transfer") then return true end
    end

    function CanReplicateItemsForEveryone(inventory, action, context)
        if (action == "repl") then return true end
    end
end

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("checkinventory", {
    adminOnly = true,
    syntax = "<string target>",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])

        if (IsValid(target) and target:getChar() and target ~= client) then
            local inventory = target:getChar():getInv()
            inventory:addAccessRule(ItemCanEnterForEveryone, 1)
            inventory:addAccessRule(CanReplicateItemsForEveryone, 1)
            inventory:sync(client)
            net.Start("OpenInvMenu")
            net.WriteEntity(target)
            net.WriteType(inventory:getID())
            net.Send(client)
        elseif (target == client) then
            client:notifyLocalized("This isn't meant for checking your own inventory.")
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("roster", {
    onRun = function(client, arguments)
        local class = nut.class.list[client:getChar():getClass()]

        if (IsValid(client) and client:getChar()) then
            net.Start("OpenRoster")
            net.WriteEntity(client)
            net.Send(client)
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("chargetmoney", {
    adminOnly = true,
    syntax = "<string target>",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local character = target:getChar()
        client:notifyLocalized(character:getName() .. " has " .. character:getMoney() .. " bullets.")
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("charaddmoney", {
    adminOnly = true,
    syntax = "<string target> <number amount>",
    onRun = function(client, arguments)
        local amount = tonumber(arguments[2])
        if (not amount or not isnumber(amount) or amount < 0) then return "@invalidArg", 2 end
        local target = nut.command.findPlayer(client, arguments[1])

        if (IsValid(target)) then
            local char = target:getChar()

            if (char and amount) then
                amount = math.Round(amount)
                char:giveMoney(amount)
                client:notify("You gave " .. nut.currency.get(amount) .. " to " .. target:Name())
            end
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("findallflags", {
    adminOnly = true,
    onRun = function(client, arguments)
        for k, v in pairs(player.GetAll()) do
            if IsValid(v) then
                if (v:getChar():getFlags() == "") then continue end
                client:ChatPrint(v:Name() .. " — " .. v:getChar():getFlags())
            end
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("checkallmoney", {
    adminOnly = true,
    syntax = "<string charname>",
    onRun = function(client, arguments)
        for k, v in pairs(player.GetAll()) do
            if v:getChar() then
                client:ChatPrint(v:Name() .. " has " .. v:getChar():getMoney())
            end
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("bringlostitems", {
    adminOnly = true,
    syntax = "",
    onRun = function(client, arguments)
        for k, v in pairs(ents.FindInSphere(client:GetPos(), 500)) do
            if v:GetClass() == "nut_item" then
                v:SetPos(client:GetPos())
            end
        end
    end
})

-------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
    net.Receive("OpenInvMenu", function()
        local target = net.ReadEntity()
        local index = net.ReadType()
        local targetInv = nut.inventory.instances[index]
        local myInv = LocalPlayer():getChar():getInv()
        local inventoryDerma = targetInv:show()
        inventoryDerma:SetTitle(target:getChar():getName() .. "'s Inventory")
        inventoryDerma:MakePopup()
        inventoryDerma:ShowCloseButton(true)
        local myInventoryDerma = myInv:show()
        myInventoryDerma:MakePopup()
        myInventoryDerma:ShowCloseButton(true)
        myInventoryDerma:SetParent(inventoryDerma)
        myInventoryDerma:MoveLeftOf(inventoryDerma, 4)
    end)

    net.Receive("OpenRoster", function()
        local client = net.ReadEntity()
        local class = nut.class.list[client:getChar():getClass()]
        local frame = vgui.Create("DFrame")
        frame:SetSize(ScrW() * nut.config.get("sbWidth"), ScrH() * nut.config.get("sbHeight"))
        frame:Center()
        frame:SetTitle("Roster")
        frame:MakePopup()
        local rosterList = frame:Add("DListView")
        rosterList:Dock(FILL)
        rosterList:SetMultiSelect(false)

        if (client:getChar()) then
            if (class) then
                rosterList:AddColumn(class.name)

                for k, v in pairs(nut.class.getPlayers(client:getChar():getClass())) do
                    rosterList:AddLine(v:getChar():getName())
                end
            else
                rosterList:AddColumn("None")
            end
        end
    end)
end