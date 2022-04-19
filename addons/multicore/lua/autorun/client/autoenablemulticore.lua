RunConsoleCommand("gmod_mcore_test", "1")   -- Enables Multicore
RunConsoleCommand("mat_queue_mode", "2")   -- Optimial Material Processing
RunConsoleCommand("r_drawmodeldecals", "0")  -- Disables decals from being drawn on non-world models (done to prevent a client-side crash issue associated with vehicles & decal stretching)
RunConsoleCommand("cl_playerspraydisable", "1") -- Disables sprays for players
RunConsoleCommand("mat_bumpmap", "1")
RunConsoleCommand("mat_specular", "1")

-- TFA Safeynet Commands : Ensures player uses correct settings
RunConsoleCommand("cl_tfa_hud_crosshair_enable_custom", "0")  -- Disables TFA Weapon Custom Hitmarker
RunConsoleCommand("cl_tfa_hud_hitmarker_scale", "0.5")  -- Changes TFA Weapon Hitmarker Scale
RunConsoleCommand("cl_tfa_hud_hitmarker_color_r", "64")  -- Changes TFA Weapon Hitmarker Coloration
RunConsoleCommand("cl_tfa_hud_hitmarker_color_g", "220")  -- Changes TFA Weapon Hitmarker Coloration
RunConsoleCommand("cl_tfa_hud_hitmarker_color_b", "255")  -- Changes TFA Weapon Hitmarker Coloration
RunConsoleCommand("cl_tfa_hud_hitmarker_color_a", "200")  -- Changes TFA Weapon Hitmarker Coloration
RunConsoleCommand("cl_tfa_fx_gasblur", "0")   -- Disables TFA Weapon Muzzle Gas Blur
RunConsoleCommand("cl_tfa_fx_muzzlesmoke", "0")   -- Disables TFA Weapon Muzzle Smoke
RunConsoleCommand("cl_tfa_fx_ejectionsmoke", "0") -- Disables TFA Weapon Ejection FX
RunConsoleCommand("cl_tfa_fx_impact_enabled", "0") -- Disables TFA Weapon Impact FX
RunConsoleCommand("cl_tfa_hud_enabled", "0") -- Disables TFA Weapon HUD

-- Misc Commands
RunConsoleCommand("pac_debug_clmdl", "1") -- Fixes PAC after 2020 Gmod Update Broke it
