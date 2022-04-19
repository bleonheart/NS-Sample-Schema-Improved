local blacklist = {}
blacklist["STEAM_0:1:84945721"] = "Grooming Minors and posting CP"
blacklist["STEAM_0:0:243473705"] = "Known Pedophile // Multiple Attempts to groom underaged kids"

function SCHEMA:PlayerAuthed(ply, steamid, uniqueid)
    if blacklist[ply:SteamID()] then
        ply:Ban(0)
        ply:Kick("You were added to this server's blacklist. Reason:" .. blacklist[ply:SteamID()])
    end
end