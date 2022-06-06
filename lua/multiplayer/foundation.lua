clua_version = 2.042

------------------------------------------------------------------------------
-- Teason Script Map
-- Mark Mc'Fuzz
-- This script is intended to provide functions and features to Treason map
------------------------------------------------------------------------------

blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses

-- Project modules
local core = require "multiplayer.features.core"

-- Local scope variables
local rotation = 0

function RotateWeapons()
    if (rotation < 360) then
        rotation = rotation + 1
    else
        rotation = 0
    end
    local objects = blam.getObjects()
    for _, objectIndex in pairs(objects) do
        local tempObject = blam.object(get_object(objectIndex))
        if (tempObject and tempObject.type == objectClasses.weapon and tempObject.playerId ==
            0xFFFFFFFF) then
            core.rotateObject(objectIndex, rotation, 0, 0)
        end
    end
    return false
end

---------------------------------------DYNAMIC CROSSHAIR WEAPONS----------------------------------------------------------

--WEAPON TAG PATH
--local smg_name = "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7"
local ma38_path = "keymind\\halo_infinite\\weapons\\rifle\\ma40_assault_rifle\\variants\\the_flood\\assault_rifle_tf"
local needlert54c_path = "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c"
--local needlert54b_path = "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b"
local mag_m6d_path = "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d"
local plasmap_path = "keymind\\the_flood\\weapons\\pistol\\plasma_pistol\\plasma pistol"
local m90_path = "keymind\\the_flood\\weapons\\rifle\\shotgun_m90\\shotgun_m90"
--local dmr392_path = "keymind\\the_flood\\weapons\\rifle\\dmr\\dmr_392"
local sniper_path = "keymind\\the_flood\\weapons\\rifle\\sniper_rifle\\sniper_rifle_srs99c"
local non_path = "keymind\\the_flood\\weapons\\_shared\\empty_crosshair_ref" --ignore


-- WEAPON TAG PATH VARIABLE
--local smg_tag = read_dword(get_tag("weap", smg_name) + 0xC)
local ma38_tag = read_dword(get_tag("weap", ma38_path) + 0xC)
local needlert54c_tag = read_dword(get_tag("weap", needlert54c_path) + 0xC)
--local needlert54b_tag = read_dword(get_tag("weap", needlert54b_path) + 0xC)
local mag_m6d_tag = read_dword(get_tag("weap", mag_m6d_path) + 0xC)
local non_tag = read_dword(get_tag("weap", non_path) + 0xC) --ignore
local plasmap_tag = read_dword(get_tag("weap", plasmap_path) + 0xC)
local m90_tag = read_dword(get_tag("weap", m90_path) + 0xC)
--local dmr392_tag = read_dword(get_tag("weap", dmr392_path) + 0xC)
local sniper_tag = read_dword(get_tag("weap", sniper_path) + 0xC)

globals_tag = read_dword(get_tag("matg", "globals\\globals") + 0x14)

--CONFIG

	-- DYNAMIC RETICLES
    local dynamic_crosshairs = true

	--DEBUG
	
        local debug_console = false -- prints all messages that were sent by the server
        local debug_msg_per_s = false -- prints how many rcon messages per second were recieved (even if they don't show up)

--END OF CONFIG

set_callback("tick", "OnTick")

local rand = math.random
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local rad = math.rad
local pi = math.pi
local floor = math.floor
local ceil = math.ceil


function InitializeSettings()

	-- change settings if they were set using a script
	if get_global("settings_changed") then
        console_out("Settings changed")
		dynamic_crosshairs = get_global("dynamic_crosshairs")
	end

    -- DYNAMIC RETICLES
    if dynamic_crosshairs then
        --local smg_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7") + 0x14)
        --local smg_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7a") + 0x14)
        local ma38_tag_data = read_dword(get_tag("weap", "keymind\\halo_infinite\\weapons\\rifle\\ma40_assault_rifle\\variants\\the_flood\\assault_rifle_tf") + 0x14)
        local ma38_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\assault_rifle\\assault_rifle_ma38") + 0x14)
        local needlert54c_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c") + 0x14)
        local needlert54c_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c") + 0x14)
        --local needlert54b_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b") + 0x14)
        --local needlert54b_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b") + 0x14)

         WEAPON_RETICLES = {
             --[smg_tag] = {
               --  ["initial"] = 12,
              --   ["additional"] = 13,
             --    ["hud"] = smg_hud,
           -- },
            [ma38_tag] = {
                ["initial"] = 4,
                ["additional"] = 16,
                ["hud"] = ma38_hud,
            },
            [needlert54c_tag] = {
                ["initial"] = 12,
                ["additional"] = 15,
                ["hud"] = needlert54c_hud,
            },
            --[needlert54b_tag] = {
            --    ["initial"] = 12,
            --    ["additional"] = 15,
            --    ["hud"] = needlert54b_hud,
            --},
            
        }
    
        -- change heat loss for a .weapon (since guerilla doesn't allow values above 1)
        --write_float(smg_tag_data + 0x35C, 5)
        write_float(ma38_tag_data + 0x35C, 5) 
        write_float(needlert54c_tag_data + 0x35C, 5)
        ---write_float(needlert54b_tag_data + 0x35C, 5)
        
        --MAGNUM CROSSHAIR SCALE AND PATH
        m6d_reticle_initial_scale = 0.2
        m6d_reticle_additional_scale = 0.45
        --m6d_r_inverse_initial_scale = 0.25
        --m6d_r_inverse_additional_scale = 0.1

        --PLASMA PISTOL CROSSHAIR 
		pp_reticle_additional_pos = 2
        pp_reticle_initial_scale = 0.19
        pp_reticle_additional_scale = 0.12

        --SHOTGUN CROSSHAIR SCALE
        m90_reticle_initial_scale = 0.2
        m90_reticle_additional_scale = 0.07

        --DMR CROSSHAIR SCALE
        --dmr_reticle_additional_pos = 3
        --dmr_reticle_initial_scale = 0.15
        --dmr_reticle_additional_scale = 0.1

        --SNIPER CROSSHAIR SCALE
        sniper_reticle_initial_scale = 0
        sniper_reticle_additional_scale = 0.3

        plasmap_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\plasma_pistol\\plasma_pistol") + 0x14)
        m90_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\shotgun_m90\\shotgun_m90") + 0x14)
        --dmr392_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\dmr\\dmr_392") + 0x14)
        sniper_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\sniper_rifle\\sniper_rifle") + 0x14)
        m6d_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d") + 0x14)
        non_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\_shared\\empty_crosshair_ref") + 0x14)
        
        -- disables multitex overlays
        --write_dword(dmr_hud2 + 0x60, 0) 
        --write_dword(ma5k_hud + 0x60, 0)
        
        -- check whether hac2 hud scaling is enabled
        --local screen_h = read_word(0x637CF0)
        --local screen_w = read_word(0x637CF2)
        local static_address = read_dword(non_hud + 0x64)
        aspect_ratio_change = read_float(static_address + 0x28)--(4/3)/(screen_w/screen_h)*0.98
    end  
end

set_timer(600, "InitializeSettings")

function OnTick()
	DynamicReticles()
    RotateWeapons()
end

function DynamicReticles()
    if dynamic_crosshairs and WEAPON_RETICLES ~= nil then
        local player = get_dynamic_player()
        if player ~= nil then
            local object = get_object(read_dword(player + 0x118))
            if object ~= nil and read_word(object + 0xB4) == 2 then --the objects means a .weapon (0x84 == 2)
                local zoom = read_char(player + 0x320)+2
                local weap_obj = read_dword(object) --new variable for the .weapon
                if WEAPON_RETICLES[weap_obj] ~= nil then --Specify the crosshair from player's weapon
                    --console_out(read_float(object + 0x23C))
                    --console_out("ERROR: "..read_float(object + 0x27C))
                    --write_float(object + 0x27C, read_float(object + 0x23C)) -- bungo is dumbo, veeeeeery dumbo
                    local heat = read_float(object + 0x23C)*WEAPON_RETICLES[weap_obj].additional --heat value on .weapon with respect on additinal value for crosshair position
                    local reticle_address = read_dword(WEAPON_RETICLES[weap_obj].hud + 0x88) --crosshairs section on weapon HUD
                    for j=0,3 do -- crosshair position table 
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0) --????
                        local reticle_overlay_address = read_dword(struct + 0x38) --offset position address (0x38)
                        local zoom_scale = zoom
                        if zoom == 2 then
                            zoom_scale = zoom*0.85
                        end
                        if j == 0 then --first bitmap crosshair
                            write_short(reticle_overlay_address, floor((-WEAPON_RETICLES[weap_obj].initial - heat)*aspect_ratio_change*zoom_scale))
                        elseif j == 1 then -- second bitmap crosshair
                            write_short(reticle_overlay_address, ceil((WEAPON_RETICLES[weap_obj].initial + heat)*aspect_ratio_change*zoom_scale))
                        elseif j == 2 then -- third bitmap crosshair
                            write_short(reticle_overlay_address + 2, floor((-WEAPON_RETICLES[weap_obj].initial - heat)*zoom_scale))
                        else -- fourth bitmap crosshair
                            write_short(reticle_overlay_address + 2, ceil((WEAPON_RETICLES[weap_obj].initial + heat)*zoom_scale))
                        end
                    end

                    --MAGNUM CROSSHAIR-------------------------------
				elseif weap_obj == mag_m6d_tag then 
					local heat = read_float(object + 0x23C)
					local reticle_address = read_dword(m6d_hud + 0x88)
					for j=0,0 do 
						local struct = reticle_address + j * 104
						write_byte(struct, 0)
						local reticle_overlay_address = read_dword(struct + 0x38)
						--change scale
						--local zoom_scale = zoom
						--if zoom == 2 then
						--	zoom_scale = zoom*0.7
						--end
						local scale = m6d_reticle_initial_scale + heat*m6d_reticle_additional_scale --* zoom_scale                       
						write_float(reticle_overlay_address + 0x04, scale*aspect_ratio_change)
						write_float(reticle_overlay_address + 0x08, scale)
                    end

                    --SNIPER CROSSHAIR------------------------------
                elseif weap_obj == sniper_tag then 
					local heat = read_float(object + 0x23C)
					local reticle_address = read_dword(sniper_hud + 0x88)
					for j=0,0 do 
						local struct = reticle_address + j * 104
						write_byte(struct, 0)
						local reticle_overlay_address = read_dword(struct + 0x38)
						--change scale
						--local zoom_scale = zoom
						--if zoom == 2 then
						--	zoom_scale = zoom*0.7
						--end
						local scale = sniper_reticle_initial_scale + heat*sniper_reticle_additional_scale --* zoom_scale                       
						write_float(reticle_overlay_address + 0x04, scale*aspect_ratio_change)
						write_float(reticle_overlay_address + 0x08, scale)
                    end

                    --M90 CROSSHAIR---------------------------------
                elseif weap_obj == m90_tag then 
					local heat = read_float(object + 0x23C)
					local reticle_address = read_dword(m90_hud + 0x88)
					for j=0,0 do 
						local struct = reticle_address + j * 104
						write_byte(struct, 0)
						local reticle_overlay_address = read_dword(struct + 0x38)
						--change scale
						--local zoom_scale = zoom
						--if zoom == 2 then
						--	zoom_scale = zoom*0.7
						--end
						local scale = m90_reticle_initial_scale + heat*m90_reticle_additional_scale --* zoom_scale                       
						write_float(reticle_overlay_address + 0x04, scale*aspect_ratio_change)
						write_float(reticle_overlay_address + 0x08, scale)
                    end

                    --DMR CROSSHAIR---------------------------------
                --elseif weap_obj == dmr392_tag then 
				--	local heat = read_float(object + 0x23C)
				--	local reticle_address = read_dword(dmr392_hud + 0x88)
				--	for j=0,3 do 
				--		local struct = reticle_address + j * 104
				--		write_byte(struct, 0)
				--		local reticle_overlay_address = read_dword(struct + 0x38)
						--change scale
						--local zoom_scale = zoom
						--if zoom == 2 then
						--	zoom_scale = zoom*0.7
						--end
				--		local scale = dmr_reticle_initial_scale + heat*dmr_reticle_additional_scale --* zoom_scale                       
				--		write_float(reticle_overlay_address + 0x04, scale*aspect_ratio_change)
				--		write_float(reticle_overlay_address + 0x08, scale)

                --      local positiondmr = heat*dmr_reticle_additional_pos --* zoom_scale
				--		if j == 0 then
				--			write_short(reticle_overlay_address, floor(-positiondmr*aspect_ratio_change))
				--		elseif j == 1 then
				--			write_short(reticle_overlay_address, ceil(positiondmr*aspect_ratio_change))
                --        elseif j == 2 then
				--			write_short(reticle_overlay_address + 2, floor(-positiondmr))
				--		else
				--			write_short(reticle_overlay_address + 2, ceil(positiondmr))
                --        end
                --    end

                    --PLASMA PISTOL CROSSHAIR------------------------
				elseif weap_obj == plasmap_tag then 
					local heat = read_float(object + 0x23C)
					local reticle_address = read_dword(plasmap_hud + 0x88)
					for j=0,2 do
						local struct = reticle_address + j * 104
						write_byte(struct, 0)
						local reticle_overlay_address = read_dword(struct + 0x38)
						--change scale
						--local zoom_scale = zoom
						--if zoom == 2 then
						--	zoom_scale = zoom*0.7
						--end
						local scale = pp_reticle_initial_scale + heat*pp_reticle_additional_scale --* zoom_scale
						write_float(reticle_overlay_address + 0x04, scale*aspect_ratio_change)
						write_float(reticle_overlay_address + 0x08, scale)
						--change position
						--if zoom == 3 then
						--	zoom_scale = zoom*0.7
						--end
						local position = heat*pp_reticle_additional_pos * 2 --* zoom_scale
						if j == 0 then
							write_short(reticle_overlay_address, floor(-position*aspect_ratio_change))
							write_short(reticle_overlay_address + 2, ceil(position))
						elseif j == 1 then
							write_short(reticle_overlay_address + 2, floor(-position))
						else
							write_short(reticle_overlay_address, ceil(position*aspect_ratio_change))
							write_short(reticle_overlay_address + 2, ceil(position))
						end
					end
                end
            end
        end
    end
end


----------------------------------------------------------------------------------------------------------------------