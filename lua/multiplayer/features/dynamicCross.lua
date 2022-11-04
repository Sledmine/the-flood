------------------------------------------------------------------------------
-- Treason Dynamic Crosshairs Module
-- Mark Mc'Fuzz
-- This script is intended to provide dynamic crosshairs feature
------------------------------------------------------------------------------

local dynamicCross = {}

---------------------------------------DYNAMIC CROSSHAIR WEAPONS----------------------------------------------------------

--WEAPON TAG PATH
--local smg_name = "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7"
local ma38_path = "keymind\\halo_infinite\\weapons\\rifle\\ma40_assault_rifle\\variants\\the_flood\\assault_rifle_tf"
local needlert54c_path = "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c"
--local needlert54b_path = "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b"
--local mag_m6d_path = "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d"
local mag_m6s_path = "keymind\\the_flood\\weapons\\pistol\\magnum_m6s\\magnum_m6s"
local plasmap_path = "keymind\\the_flood\\weapons\\pistol\\plasma_pistol\\plasma_pistol"
local m90_path = "keymind\\the_flood\\weapons\\rifle\\shotgun_m90\\shotgun_m90"
--local dmr392_path = "keymind\\the_flood\\weapons\\rifle\\dmr\\dmr_392"
local sniper_path = "keymind\\the_flood\\weapons\\rifle\\sniper_rifle\\sniper_rifle_srs99c"
local non_path = "keymind\\the_flood\\weapons\\_shared\\empty_crosshair_ref" --ignore
--local vakara_path = "keymind\\halo_infinite\\weapons\\rifle\\vk78_commando\\vk78_commando" --VK78 Commando Rifle
local spnkr_path = "keymind\\halo_infinite\\weapons\\support_high\\m41_spknr\\m41_spknr"
local br65h_path = "keymind\\the_flood\\weapons\\rifle\\br65h\\br_65h"

-- WEAPON TAG PATH VARIABLE
--local smg_tag = read_dword(get_tag("weap", smg_name) + 0xC)
local ma38_tag = read_dword(get_tag("weap", ma38_path) + 0xC)
local needlert54c_tag = read_dword(get_tag("weap", needlert54c_path) + 0xC)
--local needlert54b_tag = read_dword(get_tag("weap", needlert54b_path) + 0xC)
--local mag_m6d_tag = read_dword(get_tag("weap", mag_m6d_path) + 0xC)
local mag_m6s_tag = read_dword(get_tag("weap", mag_m6s_path) + 0xC)
local non_tag = read_dword(get_tag("weap", non_path) + 0xC) --ignore
local plasmap_tag = read_dword(get_tag("weap", plasmap_path) + 0xC)
local m90_tag = read_dword(get_tag("weap", m90_path) + 0xC)
--local dmr392_tag = read_dword(get_tag("weap", dmr392_path) + 0xC)
local sniper_tag = read_dword(get_tag("weap", sniper_path) + 0xC)
--local vakara_tag = read_dword(get_tag("weap", vakara_path) + 0xc)
local spnkr_tag = read_dword(get_tag("weap", spnkr_path) + 0xc)
local br65h_tag = read_dword(get_tag("weap", br65h_path) + 0xc)


globals_tag = read_dword(get_tag("matg", "globals\\globals") + 0x14)

--CONFIG

-- DYNAMIC RETICLES
local dynamic_crosshairs = true

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

        --local vakara_tag_data = read_dword(get_tag("weap", "keymind\\halo_infinite\\weapons\\rifle\\vk78_commando\\vk78_commando") + 0x14)
        --local m6d_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d") + 0x14)
        local m6s_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\magnum_m6s\\magnum_m6s") + 0x14)
        local spknr_tag_data = read_dword(get_tag("weap", "keymind\\halo_infinite\\weapons\\support_high\\m41_spknr\\m41_spknr") + 0x14)
        local br65h_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\rifle\\br65h\\br_65h") + 0x14)

        -- change heat loss for a .weapon (since guerilla doesn't allow values above 1)
        
        --write_float(smg_tag_data + 0x35C, 5)
        --write_float(vakara_tag_data + 0x35C, 4.2)
        write_float(spknr_tag_data + 0x35C, 2.8)
        --write_float(m6d_tag_data + 0x35C, 4.2)
        write_float(m6s_tag_data + 0x35C, 4.2)
        --write_float(br65h_tag_data + 0x35C, 3.5)
        write_float(ma38_tag_data + 0x35C, 5)
        write_float(needlert54c_tag_data + 0x35C, 5)
        --write_float(needlert54b_tag_data + 0x35C, 5)

        --MAGNUM CROSSHAIR AND ZOOM SCALE
        m6d_reticle_initial_scale = 0.2
        m6d_reticle_additional_scale = 0.6
        m6d_zoom_mask_initial_scale = 1.5
        m6d_zoom_mask_additional_scale = 0.22
        m6d_zoom_initial_scale = 0.44
        m6d_zoom_additional_scale = 0.057
        --m6d_r_inverse_initial_scale = 0.25
        --m6d_r_inverse_additional_scale = 0.1

        --BR65H ZOOM SCALE
        br65h_zoom_mask_initial_scale = 3
        br65h_zoom_mask_additional_scale = 0.22
        br65h_zoom_initial_scale = 0.21
        br65h_zoom_additional_scale = 0.018

        --SPNKR ZOOM SCALE
        spnkr_zoom_mask_initial_scale = 1.7
        spnkr_zoom_mask_additional_scale = 0.6
        spnkr_zoom_initial_scale = 0.5
        spnkr_zoom_additional_scale = 0.15

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

        --VK78 ZOOM FULL
        vk78_zoom_full_initial_scale = 0.4
        vk78_zoom_full_additional_scale = 0.03

        ---VK78 ZOOM MASK
        vk78_zoom_mask_initial_scale = 2
        vk78_zoom_mask_additional_scale = 0.03
       
        ---VK78 ZOOM BLUR
        vk78_zoom_blur_initial_scale = 0.8
        vk78_zoom_blur_additional_scale = 0.2

        --VK78 CROSSHAIR SCALE
        vk78_reticle_initial_pos = 3
        vk78_reticle_additional_pos = 10   
        vk78_reticle_initial_scale = 0.2
        vk78_reticle_additional_scale = 0.255
        vk78_stroke_initial = 0.22
        vk78_stroke_additional = 0.001
        stroke_less = 0.08

        --DOT CROSSHAIR SCALE
        dot_reticle_initial_scale = 0.1
        dot_reticle_additional_scale = 0

        plasmap_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\plasma_pistol\\plasma_pistol") + 0x14)
        m90_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\shotgun_m90\\shotgun_m90") + 0x14)
        --dmr392_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\dmr\\dmr_392") + 0x14)
        sniper_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\sniper_rifle\\sniper_rifle") + 0x14)
        --vakara_hud = read_dword(get_tag("wphi", "keymind\\halo_infinite\\weapons\\rifle\\vk78_commando\\vk78_commando") + 0x14)
        --m6d_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d") + 0x14)
        m6s_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\magnum_m6s\\magnum_m6s") + 0x14)
        non_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\_shared\\empty_crosshair_ref") + 0x14)
        spnkr_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\support_high\\rocket_launcher_spnkr\\rocket_launcher_spnkr") + 0x14)
        br65h_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\br65h\\br_65h") + 0x14)

        -- disables multitex overlays
        --write_dword(dmr_hud2 + 0x60, 0)
        --write_dword(ma5k_hud + 0x60, 0)

        -- check whether hac2 hud scaling is enabled
        --local screen_h = read_word(0x637CF0)
        --local screen_w = read_word(0x637CF2)
        local static_address = read_dword(non_hud + 0x64)
        aspect_ratio_change = read_float(static_address + 0x28) --(4/3)/(screen_w/screen_h)*0.98
    end
end

set_timer(600, "InitializeSettings")


function dynamicCross.DynamicReticles()
    if dynamic_crosshairs and WEAPON_RETICLES ~= nil then
        local player = get_dynamic_player()
        if player ~= nil then
            local object = get_object(read_dword(player + 0x118))
            if object ~= nil and read_word(object + 0xB4) == 2 then --the object means a .weapon (0xB4 == 2)
                local zoom = read_char(player + 0x320) + 2
                local weap_obj = read_dword(object) --new variable for the .weapon
                if WEAPON_RETICLES[weap_obj] ~= nil then --Specify the weapon hud interface from player's weapon
                    --console_out(read_float(object + 0x23C))
                    --console_out("ERROR: "..read_float(object + 0x27C))
                    --write_float(object + 0x27C, read_float(object + 0x23C)) -- bungo is dumbo, veeeeeery dumbo
                    local heat = read_float(object + 0x23C) * WEAPON_RETICLES[weap_obj].additional --heat value on .weapon with respect on additinal value for crosshair position
                    local reticle_address = read_dword(WEAPON_RETICLES[weap_obj].hud + 0x88) --crosshairs section on weapon HUD
                    for j = 0, 4 do -- crosshair position table
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0) --????
                        local heatorig = read_float(object + 0x23C)
                        local reticle_overlay_address = read_dword(struct + 0x38) --offset position address (0x38)
                        local scale_dot = dot_reticle_initial_scale + heat * dot_reticle_additional_scale
                        local zoom_scale = zoom
                        if zoom == 2 then
                            zoom_scale = zoom * 0.85
                        end
                        if j == 0 then --first bitmap crosshair
                            write_short(reticle_overlay_address, floor((-WEAPON_RETICLES[weap_obj].initial - heat) * aspect_ratio_change * zoom_scale))
                        elseif j == 1 then -- second bitmap crosshair
                            write_short(reticle_overlay_address, ceil((WEAPON_RETICLES[weap_obj].initial + heat) * aspect_ratio_change * zoom_scale))
                        elseif j == 2 then -- third bitmap crosshair
                            write_short(reticle_overlay_address + 2, floor((-WEAPON_RETICLES[weap_obj].initial - heat) * zoom_scale))
                        elseif j == 3 then -- Fourth bitmap crosshair
                            write_short(reticle_overlay_address + 2, ceil((WEAPON_RETICLES[weap_obj].initial + heat) * zoom_scale))
                        elseif j == 4 then
                            write_float(reticle_overlay_address + 0x04, scale_dot *heatorig *aspect_ratio_change) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_dot *heatorig) --Vertical
                        end
                    end

                    --MAGNUM CROSSHAIR
                elseif weap_obj == mag_m6s_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(m6s_hud + 0x88)
                    for j = 0, 3 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        --change scale
                        --local zoom_scale = zoom
                        --if zoom == 2 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local scale = m6d_reticle_initial_scale + heat * m6d_reticle_additional_scale --* zoom_scale
                        local scalemask = m6d_zoom_mask_initial_scale + heat * m6d_zoom_mask_additional_scale
                        local scalezoom = m6d_zoom_initial_scale + heat * m6d_zoom_additional_scale
                        if j == 0 then
                            write_float(reticle_overlay_address + 0x04, scalemask * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then 
                            write_float(reticle_overlay_address + 0x04, scalezoom * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scalezoom)
                        elseif j == 2 then
                            write_float(reticle_overlay_address + 0x04, scale * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scale)
                        end
                    end

                    --BR65H CROSSHAIR
                elseif weap_obj == br65h_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(br65h_hud + 0x88)
                    for j = 0, 1 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        --change scale
                        --local zoom_scale = zoom
                        --if zoom == 2 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local scalemask = br65h_zoom_mask_initial_scale + heat * br65h_zoom_mask_additional_scale
                        local scalezoom = br65h_zoom_initial_scale + heat * br65h_zoom_additional_scale
                        if j == 0 then
                            write_float(reticle_overlay_address + 0x04, scalemask * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then 
                            write_float(reticle_overlay_address + 0x04, scalezoom * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scalezoom)
                        end
                    end

                    --SPNKR CROSSHAIR
                elseif weap_obj == spnkr_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(spnkr_hud + 0x88)
                    for j = 0, 2 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        --change scale
                        --local zoom_scale = zoom
                        --if zoom == 2 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local scalemask = spnkr_zoom_mask_initial_scale + heat * spnkr_zoom_mask_additional_scale
                        local scalezoom = spnkr_zoom_initial_scale + heat * spnkr_zoom_additional_scale

                        if j == 0 then
                            write_float(reticle_overlay_address + 0x04, scalemask * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then 
                            write_float(reticle_overlay_address + 0x04, scalezoom * aspect_ratio_change)
                            write_float(reticle_overlay_address + 0x08, scalezoom)
                        end
                    end

                    --VK78 COMMANDO RETICLE + ZOOM
                --elseif weap_obj == vakara_tag then
                --    local heat = read_float(object + 0x23C)
                --    local reticle_address = read_dword(vakara_hud + 0x88)
                --    for j = 1, 11 do
                --        local struct = reticle_address + j * 104
                --        write_byte(struct, 0)
                --        local reticle_overlay_address = read_dword(struct + 0x38)
                --        local scale = vk78_zoom_full_initial_scale + heat * vk78_zoom_full_additional_scale
                --        local scalemask = vk78_zoom_mask_initial_scale + heat * vk78_zoom_mask_additional_scale
                --        local scaleblur = vk78_zoom_blur_initial_scale + heat * vk78_zoom_blur_additional_scale
                --        local scale_reticle = vk78_reticle_initial_scale + heat*vk78_reticle_additional_scale
                --        local aditional_pos = heat*1.1*vk78_reticle_additional_pos
                --        local scale_stroke = vk78_stroke_initial + heat*vk78_stroke_additional
                --        local scale_dot = dot_reticle_initial_scale + heat * dot_reticle_additional_scale

                --        if j == 1 then
                --            write_float(reticle_overlay_address + 0x04, scalemask * aspect_ratio_change)
                --            write_float(reticle_overlay_address + 0x08, scalemask)
                --        elseif j == 2 then
                --            write_float(reticle_overlay_address + 0x04, scale * aspect_ratio_change)
                --            write_float(reticle_overlay_address + 0x08, scale)                           
                --        elseif j == 3 then
                --            write_float(reticle_overlay_address + 0x04, scale * aspect_ratio_change)
                --            write_float(reticle_overlay_address + 0x08, scale)
                --        elseif j == 4 then
                --            write_float(reticle_overlay_address + 0x04, scaleblur * aspect_ratio_change)
                --            write_float(reticle_overlay_address + 0x08, scaleblur)
                --        elseif j == 5 then
                --            write_float(reticle_overlay_address + 0x04, scaleblur * aspect_ratio_change)
                --            write_float(reticle_overlay_address + 0x08, scaleblur)     
                --        elseif j == 6 then
                --            write_float(reticle_overlay_address + 0x04, scale_reticle*aspect_ratio_change) --Horizontal
                --            write_float(reticle_overlay_address + 0x08, scale_reticle) --Vertical
                --        elseif j == 7 then 
                --            write_short(reticle_overlay_address, floor(-vk78_reticle_initial_pos - aditional_pos *heat *aspect_ratio_change))
                --            write_float(reticle_overlay_address + 0x04, scale_stroke - stroke_less *aspect_ratio_change) --Horizontal
                --            write_float(reticle_overlay_address + 0x08, scale_stroke) --Vertical
                --        elseif j == 8 then
                --            write_short(reticle_overlay_address, ceil(vk78_reticle_initial_pos + aditional_pos *heat *aspect_ratio_change))
                --            write_float(reticle_overlay_address + 0x04, scale_stroke - stroke_less *aspect_ratio_change) --Horizontal
                --            write_float(reticle_overlay_address + 0x08, scale_stroke) --Vertical
                --        elseif j == 9 then
                --            write_short(reticle_overlay_address + 2, floor(-vk78_reticle_initial_pos - aditional_pos *heat *aspect_ratio_change))
                --            write_float(reticle_overlay_address + 0x04, scale_stroke *aspect_ratio_change) --Horizontal
                --            write_float(reticle_overlay_address + 0x08, scale_stroke - stroke_less) --Vertical
                --        elseif j == 10 then
                --            write_short(reticle_overlay_address + 2, ceil(vk78_reticle_initial_pos + aditional_pos *heat *aspect_ratio_change))
                --            write_float(reticle_overlay_address + 0x04, scale_stroke *aspect_ratio_change) --Horizontal
                --            write_float(reticle_overlay_address + 0x08, scale_stroke - stroke_less) --Vertical
                --        elseif j == 11 then
                --            write_float(reticle_overlay_address + 0x04, scale_dot *heat *aspect_ratio_change) --Horizontal
                --            write_float(reticle_overlay_address + 0x08, scale_dot *heat) --Vertical
                --        end                                       
                --    end

                    --SNIPER CROSSHAIR------------------------------
                elseif weap_obj == sniper_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(sniper_hud + 0x88)
                    for j = 0, 0 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        --change scale
                        --local zoom_scale = zoom
                        --if zoom == 2 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local scale = sniper_reticle_initial_scale + heat * sniper_reticle_additional_scale --* zoom_scale
                        write_float(reticle_overlay_address + 0x04, scale * aspect_ratio_change)
                        write_float(reticle_overlay_address + 0x08, scale)
                    end

                    --M90 CROSSHAIR---------------------------------
                elseif weap_obj == m90_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(m90_hud + 0x88)
                    for j = 0, 0 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        --change scale
                        --local zoom_scale = zoom
                        --if zoom == 2 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local scale = m90_reticle_initial_scale + heat * m90_reticle_additional_scale --* zoom_scale
                        write_float(reticle_overlay_address + 0x04, scale * aspect_ratio_change)
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
                    for j = 0, 2 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        --change scale
                        --local zoom_scale = zoom
                        --if zoom == 2 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local scale = pp_reticle_initial_scale + heat * pp_reticle_additional_scale --* zoom_scale
                        write_float(reticle_overlay_address + 0x04, scale * aspect_ratio_change)
                        write_float(reticle_overlay_address + 0x08, scale)
                        --change position
                        --if zoom == 3 then
                        --	zoom_scale = zoom*0.7
                        --end
                        local position = heat * pp_reticle_additional_pos * 2 --* zoom_scale
                        if j == 0 then
                            write_short(reticle_overlay_address, floor(-position * aspect_ratio_change))
                            write_short(reticle_overlay_address + 2, ceil(position))
                        elseif j == 1 then
                            write_short(reticle_overlay_address + 2, floor(-position))
                        else
                            write_short(reticle_overlay_address, ceil(position * aspect_ratio_change))
                            write_short(reticle_overlay_address + 2, ceil(position))
                        end
                    end
                end
            end
        end
    end
end

return dynamicCross