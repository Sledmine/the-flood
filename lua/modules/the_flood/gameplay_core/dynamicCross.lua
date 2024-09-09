------------------------------------------------------------------------------
-- Treason Dynamic Crosshairs Module
-- Mark Mc'Fuzz
-- This script is intended to provide dynamic crosshairs feature
------------------------------------------------------------------------------

local dynamicCross = {}

---------------------------------------DYNAMIC CROSSHAIR WEAPONS----------------------------------------------------------

--WEAPON TAG PATH
--local smg_name = "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7"
local ma38_path = "keymind\\the_flood\\weapons\\rifle\\assault_rifle\\assault_rifle_ma38"
local needlert54c_path = "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c"
--local needlert54b_path = "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b"
--local mag_m6d_path = "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d"
local mag_m6s_path = "keymind\\the_flood\\weapons\\pistol\\magnum_m6s\\magnum_m6s"
local plasmap_path = "keymind\\the_flood\\weapons\\pistol\\plasma_pistol\\plasma_pistol"
local m90_path = "keymind\\the_flood\\weapons\\rifle\\shotgun_m90\\shotgun_m90"
--local dmr392_path = "keymind\\the_flood\\weapons\\rifle\\dmr\\dmr_392"
local sniper_path = "keymind\\the_flood\\weapons\\rifle\\sniper_rifle\\sniper_rifle_srs99c"
local vakara_path = "keymind\\halo_infinite\\weapons\\rifle\\vk78_commando\\vk78_commando"
local spnkr_path = "keymind\\halo_infinite\\weapons\\support_high\\m41_spknr\\m41_spknr"
local br65h_path = "keymind\\the_flood\\weapons\\rifle\\br65h\\br_65h"
local stormR_path = "keymind\\halo_5\\weapons\\rifle\\cv_storm_rifle\\cv_storm_rifle"
local skewer_path = "keymind\\halo_infinite\\weapons\\support_high\\skewer\\skewer"
local plasma_caster_path = "keymind\\halo_5\\weapons\\rifle\\cv_grenade_launcher\\cv_grenade_launcher"
local lmg_saw_path = "keymind\\halo_5\\weapons\\rifle\\lmg_saw\\lmg_saw"
local arc_zapper_path = "keymind\\halo_infinite\\weapons\\pistol\\proto_arc_zapper\\proto_arc_zapper"
--local wasp_weap_path = "keymind\\halo_5\\vehicles\\unsc\\wasp\\wasp"

-- WEAPON TAG PATH VARIABLE
--local smg_tag = read_dword(get_tag("weap", smg_name) + 0xC)
local ma38_tag = read_dword(get_tag("weap", ma38_path) + 0xC)
local needlert54c_tag = read_dword(get_tag("weap", needlert54c_path) + 0xC)
--local needlert54b_tag = read_dword(get_tag("weap", needlert54b_path) + 0xC)
--local mag_m6d_tag = read_dword(get_tag("weap", mag_m6d_path) + 0xC)
local mag_m6s_tag = read_dword(get_tag("weap", mag_m6s_path) + 0xC)
local plasmap_tag = read_dword(get_tag("weap", plasmap_path) + 0xC)
local m90_tag = read_dword(get_tag("weap", m90_path) + 0xC)
--local dmr392_tag = read_dword(get_tag("weap", dmr392_path) + 0xC)
local sniper_tag = read_dword(get_tag("weap", sniper_path) + 0xC)
local vakara_tag = read_dword(get_tag("weap", vakara_path) + 0xc)
local spnkr_tag = read_dword(get_tag("weap", spnkr_path) + 0xc)
local br65h_tag = read_dword(get_tag("weap", br65h_path) + 0xc)
local stormR_tag = read_dword(get_tag("weap", stormR_path) + 0xc)
local skewer_tag = read_dword(get_tag("weap", skewer_path) + 0xc)
local plasma_caster_tag = read_dword(get_tag("weap", plasma_caster_path) + 0xC)
local lmg_saw_tag = read_dword(get_tag("weap", lmg_saw_path) + 0xc)
local arc_zapper_tag = read_dword(get_tag("weap", arc_zapper_path) + 0xc)
--local wasp_weap_tag = read_dword(get_tag("weap", wasp_weap_path) + 0xc)

globals_tag = read_dword(get_tag("matg", "globals\\globals") + 0x14)

-- DYNAMIC RETICLES
local dynamic_crosshairs = true

--END OF CONFIG
local rand = math.random
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local rad = math.rad
local pi = math.pi
local floor = math.floor
local ceil = math.ceil

function InitializeSettings()

        WEAPON_HUDS = {
            [ma38_tag] = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\assault_rifle\\assault_rifle_ma38") + 0x14),
            [needlert54c_tag] = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c") + 0x14),
            [mag_m6s_tag] = read_dword(get_tag("wphi", mag_m6s_path) + 0x14),
            [plasmap_tag] = read_dword(get_tag("wphi", plasmap_path) + 0x14),
            [m90_tag] = read_dword(get_tag("wphi", m90_path) + 0x14),
            [br65h_tag] = read_dword(get_tag("wphi", br65h_path) + 0x14),
            [spnkr_tag] = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\support_high\\rocket_launcher_spnkr\\rocket_launcher_spnkr") + 0x14),
            [sniper_tag] = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\sniper_rifle\\sniper_rifle") + 0x14),
            [vakara_tag] = read_dword(get_tag("wphi", vakara_path) + 0x14),
            [stormR_tag] = read_dword(get_tag("wphi", stormR_path) + 0x14),
            [skewer_tag] = read_dword(get_tag("wphi", skewer_path) + 0x14),
            [plasma_caster_tag] = read_dword(get_tag("wphi", plasma_caster_path) + 0x14),
            [lmg_saw_tag] = read_dword(get_tag("wphi", lmg_saw_path) + 0x14),
            [arc_zapper_tag] = read_dword(get_tag("wphi", arc_zapper_path) + 0x14),
        }
        ----local smg_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7") + 0x14)
        ----local smg_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\smg\\smg_m7a") + 0x14)
        ----local needlert54b_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b") + 0x14)
        ----local needlert54b_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\needler_short\\needler_t54b") + 0x14)

        WEAPON_RETICLES = {
            --[smg_tag] = {
            --  ["initial"] = 12,
            --   ["additional"] = 13,
            -- },
            [ma38_tag] = {
                ["initial"] = 4,
                ["additional"] = 16,
            },
            [lmg_saw_tag] = {
                ["initial"] = 4,
                ["additional"] = 16,
            },
            [needlert54c_tag] = {
                ["initial"] = 12,
                ["additional"] = 15,
            },
            --[needlert54b_tag] = {
            --    ["initial"] = 12,
            --    ["additional"] = 15,
            --},
        }

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
        pp_reticle_additional_scale = 0.08

        --PLASMA CASTER CROSSHAIR
        pcaster_reticle_initial_pos = 2
        pcaster_reticle_additional_pos = 4
        pcaster_reticle_initial_scale = 0.18
        pcaster_reticle_additional_scale = 0.025

        --SHOTGUN CROSSHAIR SCALE
        m90_reticle_initial_scale = 0.23
        m90_reticle_additional_scale = 0.07

        --DMR CROSSHAIR SCALE
        --dmr_reticle_additional_pos = 3
        --dmr_reticle_initial_scale = 0.15
        --dmr_reticle_additional_scale = 0.1

        --STORM RIFLE CROSSHAIR SCALE
        stormR_reticle_additional_pos = 3
        stormR_reticle_initial_scale = 0.3
        stormR_reticle_additional_scale = 0.07

        --SNIPER CROSSHAIR SCALE
        sniper_reticle_initial_scale = 0
        sniper_reticle_additional_scale = 0.3

        --SNIPER ZOOM MASK
        sniper_zoom_mask_initial_scale = 2.209
        sniper_zoom_mask_additional_scale = 0.03

        --SNIPER ZOOM SCOPE
        sniper_zoom_scope_initial_scale = 0.47
        sniper_zoom_scope_additional_scale = 0.03

        --SNIPER ZOOM LEVELS
        sniper_zoom_levels_initial_scale = 0.45
        sniper_zoom_levels_additional_scale = 0.12

        --SKEWER ZOOM MASK
        skewer_zoom_mask_initial_scale = 0.88
        skewer_zoom_mask_additional_scale = 0.1

        --SKEWER ZOOM SCOPE
        skewer_zoom_scope_initial_scale = 0.47
        skewer_zoom_scope_additional_scale = 0.1

        --SKEWER CROSSHAIR POSITION
        skewer_reticle_initial_pos = 0
        skewer_reticle_additional_pos = 10
        skewer_reticle_scale = 0.25
        skewer_reticle_scale_zero = 0 

        --ARC ZAPPER CROSSHAIR POSITION
        arczap_reticle_initial_pos = 0
        arczap_reticle_additional_pos = 1.5
        arczap_reticle_scale_initial = 0.22
        arczap_reticle_scale_additional = 0.26
        arczap_reticle_scale_zero = 0

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
        vk78_reticle_additional_scale = 0.16
        vk78_stroke_initial = 0.22
        vk78_stroke_additional = 0.001
        stroke_less = 0.08

        --DOT CROSSHAIR SCALE
        dot_reticle_initial_scale = 0.08
        dot_reticle_additional_scale = 0

        ----dmr392_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\rifle\\dmr\\dmr_392") + 0x14)
        ----m6d_hud = read_dword(get_tag("wphi", "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d") + 0x14)

    -- DYNAMIC RETICLES
    if dynamic_crosshairs then
        local m6s_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\magnum_m6s\\magnum_m6s") + 0x14)
        local ma38_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\rifle\\assault_rifle\\assault_rifle_ma38") + 0x14)
		local needlert54c_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\needler\\needler_t54c") + 0x14)
        local spknr_tag_data = read_dword(get_tag("weap", "keymind\\halo_infinite\\weapons\\support_high\\m41_spknr\\m41_spknr") + 0x14)
        local vakara_tag_data = read_dword(get_tag("weap", "keymind\\halo_infinite\\weapons\\rifle\\vk78_commando\\vk78_commando") + 0x14)
        local skewer_tag_data = read_dword(get_tag("weap", "keymind\\halo_infinite\\weapons\\support_high\\skewer\\skewer") + 0x14)
        --local m6d_tag_data = read_dword(get_tag("weap", "keymind\\the_flood\\weapons\\pistol\\magnum_m6d\\magnum_m6d") + 0x14)

        -- change heat loss (since guerilla doesn't allow values above 1)        
        write_float(ma38_tag_data + 0x35C, 5)
        write_float(needlert54c_tag_data + 0x35C, 5)
        write_float(m6s_tag_data + 0x35C, 4.2)
        write_float(spknr_tag_data + 0x35C, 2.8)
        write_float(vakara_tag_data + 0x35C, 4.2)
        write_float(skewer_tag_data + 0x35C, 2.8)
        --write_float(smg_tag_data + 0x35C, 5)
        --write_float(m6d_tag_data + 0x35C, 4.2)
        --write_float(needlert54b_tag_data + 0x35C, 5)
    end
end

--set_timer(600, "InitializeSettings")
InitializeSettings()

function dynamicCross.dynamicReticles()
    if dynamic_crosshairs and WEAPON_RETICLES ~= nil then
        local player = get_dynamic_player()
        if player ~= nil then
            local object = get_object(read_dword(player + 0x118))
            if object ~= nil and read_word(object + 0xB4) == 2 then --the object means a .weapon (0xB4 == 2)
                local zoom = read_char(player + 0x320) + 2
                local weap_obj = read_dword(object) --new variable for the .weapon
                local weapon_hud = WEAPON_HUDS[weap_obj]
                --	This extends the reticle when the weapon is making ready and reload animations
				local ready_timer = read_word(object + 0x23A) + read_word(object + 0x2B2) --+ read_byte(player + 0x505)
				if ready_timer > 20 then
					ready_timer = 20
				end
                local mag_ready_timer = read_word(object + 0x23A) -- + read_byte(player + 0x505)
                if mag_ready_timer > 10 then
                    mag_ready_timer = 6
                end	
                local mag_reload_timer = read_word(object + 0x2B2) * 0.4 
                if mag_reload_timer > 9 then
                    mag_reload_timer = 0
                end		
                if weapon_hud ~= nil then
					local reticle_address = read_dword(weapon_hud + 0x88)
                if WEAPON_RETICLES[weap_obj] ~= nil then --Specify the weapon hud interface from player's weapon
                    --console_out(read_float(object + 0x23C))
                    --console_out("ERROR: "..read_float(object + 0x27C))
                    --write_float(object + 0x27C, read_float(object + 0x23C)) -- bungo is dumbo, veeeeeery dumbo
                    local heat = read_float(object + 0x23C) * WEAPON_RETICLES[weap_obj].additional + ready_timer/2 --heat value on .weapon with respect on additinal value for crosshair position
                    --local reticle_address = read_dword(WEAPON_RETICLES[weap_obj].hud + 0x88) --crosshairs section on weapon HUD
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
                            write_short(reticle_overlay_address, floor((-WEAPON_RETICLES[weap_obj].initial - heat) * zoom_scale))
                        elseif j == 1 then -- second bitmap crosshair
                            write_short(reticle_overlay_address, ceil((WEAPON_RETICLES[weap_obj].initial + heat) * zoom_scale))
                        elseif j == 2 then -- third bitmap crosshair
                            write_short(reticle_overlay_address + 2, floor((-WEAPON_RETICLES[weap_obj].initial - heat) * zoom_scale))
                        elseif j == 3 then -- Fourth bitmap crosshair
                            write_short(reticle_overlay_address + 2, ceil((WEAPON_RETICLES[weap_obj].initial + heat) * zoom_scale))
                        elseif j == 4 then
                            write_float(reticle_overlay_address + 0x04, scale_dot *heatorig) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_dot *heatorig) --Vertical
                        end
                    end

                    --MAGNUM CROSSHAIR
                elseif weap_obj == mag_m6s_tag then
                    local heat = read_float(object + 0x23C) 
                    local reticle_address = read_dword(WEAPON_HUDS[mag_m6s_tag] + 0x88)
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
                            write_float(reticle_overlay_address + 0x04, scalemask)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then 
                            write_float(reticle_overlay_address + 0x04, scalezoom)
                            write_float(reticle_overlay_address + 0x08, scalezoom)
                        elseif j == 2 then
                            write_float(reticle_overlay_address + 0x04, scale + mag_ready_timer/8*0.5 + mag_reload_timer/8*0.4)
                            write_float(reticle_overlay_address + 0x08, scale + mag_ready_timer/8*0.5 + mag_reload_timer/8*0.4)
                        end
                    end

                    --BR65H CROSSHAIR
                elseif weap_obj == br65h_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(WEAPON_HUDS[br65h_tag] + 0x88)
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
                            write_float(reticle_overlay_address + 0x04, scalemask)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then 
                            write_float(reticle_overlay_address + 0x04, scalezoom)
                            write_float(reticle_overlay_address + 0x08, scalezoom)
                        end
                    end

                    --SPNKR CROSSHAIR
                elseif weap_obj == spnkr_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(WEAPON_HUDS[spnkr_tag] + 0x88)
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
                            write_float(reticle_overlay_address + 0x04, scalemask)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then 
                            write_float(reticle_overlay_address + 0x04, scalezoom)
                            write_float(reticle_overlay_address + 0x08, scalezoom)
                        end
                    end

                    --VK78 COMMANDO RETICLE + ZOOM
                elseif weap_obj == vakara_tag then
                    local reticle_address = read_dword(WEAPON_HUDS[vakara_tag] + 0x88)
                    local vk_ready_timer = read_word(object + 0x23A) + read_word(object + 0x2B2) -- + read_byte(player + 0x505)
                    if vk_ready_timer > 20 then
                        vk_ready_timer = 10
                    end
                    local heat = read_float(object + 0x23C) + vk_ready_timer/30
                    local heatorig = read_float(object + 0x23C)
                    for j = 1, 11 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local scale = vk78_zoom_full_initial_scale + heatorig * vk78_zoom_full_additional_scale
                        local scalemask = vk78_zoom_mask_initial_scale + heatorig * vk78_zoom_mask_additional_scale
                        local scaleblur = vk78_zoom_blur_initial_scale + heatorig * vk78_zoom_blur_additional_scale
                        local scale_reticle = vk78_reticle_initial_scale + heat*vk78_reticle_additional_scale
                        local aditional_pos = heat*1.1*vk78_reticle_additional_pos
                        local scale_stroke = vk78_stroke_initial + heat*vk78_stroke_additional
                        local scale_dot = dot_reticle_initial_scale + heat * dot_reticle_additional_scale
                        if j == 1 then
                            write_float(reticle_overlay_address + 0x04, scalemask)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 2 then
                            write_float(reticle_overlay_address + 0x04, scale)
                            write_float(reticle_overlay_address + 0x08, scale)                           
                        elseif j == 3 then
                            write_float(reticle_overlay_address + 0x04, scale)
                            write_float(reticle_overlay_address + 0x08, scale)
                        elseif j == 4 then
                            write_float(reticle_overlay_address + 0x04, scaleblur)
                            write_float(reticle_overlay_address + 0x08, scaleblur)
                        elseif j == 5 then
                            write_float(reticle_overlay_address + 0x04, scaleblur)
                            write_float(reticle_overlay_address + 0x08, scaleblur)     
                        elseif j == 6 then
                            write_float(reticle_overlay_address + 0x04, scale_reticle) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_reticle) --Vertical
                        elseif j == 7 then 
                            write_short(reticle_overlay_address, floor(-vk78_reticle_initial_pos - aditional_pos *heat))
                            write_float(reticle_overlay_address + 0x04, scale_stroke - stroke_less) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_stroke) --Vertical
                        elseif j == 8 then
                            write_short(reticle_overlay_address, ceil(vk78_reticle_initial_pos + aditional_pos *heat))
                            write_float(reticle_overlay_address + 0x04, scale_stroke - stroke_less) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_stroke) --Vertical
                        elseif j == 9 then
                            write_short(reticle_overlay_address + 2, floor(-vk78_reticle_initial_pos - aditional_pos *heat))
                            write_float(reticle_overlay_address + 0x04, scale_stroke) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_stroke - stroke_less) --Vertical
                        elseif j == 10 then
                            write_short(reticle_overlay_address + 2, ceil(vk78_reticle_initial_pos + aditional_pos *heat))
                            write_float(reticle_overlay_address + 0x04, scale_stroke) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_stroke - stroke_less) --Vertical
                        elseif j == 11 then
                            write_float(reticle_overlay_address + 0x04, scale_dot *heatorig) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_dot *heatorig) --Vertical
                        end                                       
                    end

                    --SNIPER CROSSHAIR------------------------------
                elseif weap_obj == sniper_tag then
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(WEAPON_HUDS[sniper_tag] + 0x88)
                    for j = 1, 4 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local scale = sniper_reticle_initial_scale + heat * sniper_reticle_additional_scale --* zoom_scale
                        local scalemask = sniper_zoom_mask_initial_scale + heat * sniper_zoom_mask_additional_scale
                        local scalezoomscope = sniper_zoom_scope_initial_scale + heat * sniper_zoom_scope_additional_scale
                        local scalezoomlevels = sniper_zoom_levels_initial_scale + heat * sniper_zoom_levels_additional_scale
                        if j == 1 then
                            write_float(reticle_overlay_address + 0x04, scale + mag_ready_timer/25*0.5)
                            write_float(reticle_overlay_address + 0x08, scale + mag_ready_timer/25*0.5)
                        elseif j == 2 then
                            write_float(reticle_overlay_address + 0x04, scalemask)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 3 then
                            write_float(reticle_overlay_address + 0x04, scalezoomscope)
                            write_float(reticle_overlay_address + 0x08, scalezoomscope)
                        elseif j == 4 then
                            write_float(reticle_overlay_address + 0x04, scalezoomlevels)
                            write_float(reticle_overlay_address + 0x08, scalezoomlevels)
                        end            
                    end

                    --SKEWER CROSSHAIR------------------------------
                elseif weap_obj == skewer_tag then
                    local skewer_ready_timer = read_word(object + 0x23A) * 2 + read_word(object + 0x2B2) * 2 --+ read_byte(player + 0x505)
                    if skewer_ready_timer > 20 then
                        skewer_ready_timer = 20
                    end
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(WEAPON_HUDS[skewer_tag] + 0x88)
                    local zoom_scale = zoom
                    if zoom == 2 then
                        zoom_scale = zoom
                    end
                    for j = 0, 5 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local aditionalpos = skewer_reticle_initial_pos + heat * skewer_reticle_additional_pos --* zoom_scale
                        local scalemask = skewer_zoom_mask_initial_scale + heat * skewer_zoom_mask_additional_scale --* zoom_scale
                        local scalezoomscope = skewer_zoom_scope_initial_scale + heat * skewer_zoom_scope_additional_scale --* zoom_scale
                        --local scalezoomlevels = skewer_zoom_levels_initial_scale + heat * skewer_zoom_levels_additional_scale
                        if j == 0 then
                            write_float(reticle_overlay_address + 0x04, scalemask)
                            write_float(reticle_overlay_address + 0x08, scalemask)
                        elseif j == 1 then
                            write_float(reticle_overlay_address + 0x04, scalezoomscope)
                            write_float(reticle_overlay_address + 0x08, scalezoomscope)
                        elseif j == 2 then
                            write_float(reticle_overlay_address + 0x04, scalezoomscope)
                            write_float(reticle_overlay_address + 0x08, scalezoomscope)
                        elseif j == 3 then
                            write_short(reticle_overlay_address, floor(-skewer_reticle_initial_pos - aditionalpos *heat - skewer_ready_timer/2*0.9)) 
                        elseif j == 4 then
                            write_short(reticle_overlay_address, ceil(skewer_reticle_initial_pos + aditionalpos *heat + skewer_ready_timer/2*0.9))
                        elseif j == 5 then
                            write_float(reticle_overlay_address + 0x04, (skewer_reticle_scale_zero - skewer_reticle_scale + skewer_ready_timer/30))
                            write_float(reticle_overlay_address + 0x08, (skewer_reticle_scale_zero - skewer_reticle_scale + skewer_ready_timer/30))
                        end            
                    end

                    --ARC ZAPPER CROSSHAIR------------------------------
                elseif weap_obj == arc_zapper_tag then
                    local arc_ready_timer = read_word(object + 0x23A) * 2 + read_word(object + 0x2B2) * 2 --+ read_byte(player + 0x505)
                    if arc_ready_timer > 20 then
                        arc_ready_timer = 20
                    end
                    local arc_reload_timer = read_word(object + 0x2B2) * 2 + arczap_reticle_scale_initial--+ read_byte(player + 0x505)
                    if arc_reload_timer > 20 then
                        arc_reload_timer = 10
                    end
                    local heat = read_float(object + 0x23C)
                    local reticle_address = read_dword(WEAPON_HUDS[arc_zapper_tag] + 0x88)
                    for j = 0, 2 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local aditionalpos = arczap_reticle_initial_pos + heat * arczap_reticle_additional_pos --* zoom_scale
                        local scale = arczap_reticle_scale_initial + heat * arczap_reticle_scale_additional
                        if j == 0 then
                            write_short(reticle_overlay_address, floor(-arczap_reticle_initial_pos - aditionalpos *heat - arc_ready_timer/4*0.9))
                            write_float(reticle_overlay_address + 0x04, scale) --scale horizontalOffset
                        elseif j == 1 then
                            write_short(reticle_overlay_address, ceil(arczap_reticle_initial_pos + aditionalpos *heat + arc_ready_timer/4*0.9))
                            write_float(reticle_overlay_address + 0x04, scale) --scale horizontalOffset
                        elseif j == 2 then
                            write_float(reticle_overlay_address + 0x04, (arczap_reticle_scale_zero - arczap_reticle_scale_initial + arc_ready_timer/42 - arc_reload_timer/70))
                            write_float(reticle_overlay_address + 0x08, (arczap_reticle_scale_zero - arczap_reticle_scale_initial + arc_ready_timer/42))
                        end            
                    end

                    --M90 CROSSHAIR---------------------------------
                elseif weap_obj == m90_tag then
                    local heat = read_float(object + 0x23C) + mag_ready_timer/6*0.5 + mag_reload_timer/6
                    local reticle_address = read_dword(WEAPON_HUDS[m90_tag] + 0x88)
                    for j = 0, 0 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local scale = m90_reticle_initial_scale + heat * m90_reticle_additional_scale --* zoom_scale
                        write_float(reticle_overlay_address + 0x04, scale)
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

                    --STORM RIFLE CROSSHAIR---------------------------------
                elseif weap_obj == stormR_tag then
                	local heat = read_float(object + 0x23C) + mag_ready_timer/6*0.5 + mag_reload_timer/6*0.4
                    local heatorig = read_float(object + 0x23C)
                	local reticle_address = read_dword( WEAPON_HUDS[stormR_tag] + 0x88)
                	for j=0,4 do
                		local struct = reticle_address + j * 104
                		write_byte(struct, 0)
                		local reticle_overlay_address = read_dword(struct + 0x38)
                		local scale = stormR_reticle_initial_scale + heat * stormR_reticle_additional_scale 
                        local positionstormR = heat * stormR_reticle_additional_pos * 2
                        local scale_dot = dot_reticle_initial_scale + heat * dot_reticle_additional_scale 
                        write_float(reticle_overlay_address + 0x04, scale)
                		write_float(reticle_overlay_address + 0x08, scale)
                		if j == 0 then
                			write_short(reticle_overlay_address, floor(-positionstormR))
                            write_short(reticle_overlay_address + 2, floor(-positionstormR))
                		elseif j == 1 then
                			write_short(reticle_overlay_address, ceil(positionstormR))
                            write_short(reticle_overlay_address + 2, ceil(positionstormR))
                        elseif j == 2 then
                			write_short(reticle_overlay_address + 2, floor(-positionstormR))
                            write_short(reticle_overlay_address, ceil(positionstormR))
                		elseif j == 3 then
                			write_short(reticle_overlay_address + 2, ceil(positionstormR))
                            write_short(reticle_overlay_address, floor(-positionstormR))
                        else
                            write_float(reticle_overlay_address + 0x04, scale_dot *heatorig) --Horizontal
                            write_float(reticle_overlay_address + 0x08, scale_dot *heatorig) --Vertical
                        end
                    end

                    --PLASMA PISTOL CROSSHAIR------------------------
                elseif weap_obj == plasmap_tag then
                    local heat = read_float(object + 0x23C) + mag_ready_timer/6*0.5 + mag_reload_timer/6*0.4
                    local reticle_address = read_dword(WEAPON_HUDS[plasmap_tag] + 0x88)
                    for j = 0, 2 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local scale = pp_reticle_initial_scale + heat * pp_reticle_additional_scale --* zoom_scale
                        local position = heat * pp_reticle_additional_pos * 2 
                        write_float(reticle_overlay_address + 0x04, scale)
                        write_float(reticle_overlay_address + 0x08, scale)
                        if j == 0 then
                            write_short(reticle_overlay_address, floor(-position))
                            write_short(reticle_overlay_address + 2, ceil(position))
                        elseif j == 1 then
                            write_short(reticle_overlay_address + 2, floor(-position))
                        else
                            write_short(reticle_overlay_address, ceil(position))
                            write_short(reticle_overlay_address + 2, ceil(position))
                        end
                    end
                        --PLASMA CASTER CROSSHAIR------------------------
                elseif weap_obj == plasma_caster_tag then
                    local caster_reload_timer = read_word(object + 0x2B2) * 2 --+ read_byte(player + 0x505)
                    if caster_reload_timer > 20 then
                        caster_reload_timer = 20
                    end
                    local heat = read_float(object + 0x23C) + mag_ready_timer/6*0.5 + caster_reload_timer/45
                    local reticle_address = read_dword(WEAPON_HUDS[plasma_caster_tag] + 0x88)
                    for j = 0, 2 do
                        local struct = reticle_address + j * 104
                        write_byte(struct, 0)
                        local reticle_overlay_address = read_dword(struct + 0x38)
                        local scale = pcaster_reticle_initial_scale + heat * pcaster_reticle_additional_scale --* zoom_scale
                        local position = heat * pcaster_reticle_additional_pos * 2 
                        write_float(reticle_overlay_address + 0x04, scale)
                        write_float(reticle_overlay_address + 0x08, scale)
                        if j == 0 then
                            write_short(reticle_overlay_address, floor(-pcaster_reticle_initial_pos - position))
                            write_short(reticle_overlay_address + 2, ceil(pcaster_reticle_initial_pos + position))
                        elseif j == 1 then
                            write_short(reticle_overlay_address + 2, floor(-pcaster_reticle_initial_pos - position))
                        else
                            write_short(reticle_overlay_address, ceil(pcaster_reticle_initial_pos + position))
                            write_short(reticle_overlay_address + 2, ceil(pcaster_reticle_initial_pos + position))
                        end
                    end
                end
            end
        end
        end
    end
end

return dynamicCross