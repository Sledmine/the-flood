
;; Menu UI Effects
(script static void menu_blur_off
    (begin
        (show_hud true)
        (cinematic_stop)
    )
)

(script static void menu_blur_on
    (begin
        (show_hud false)
        (cinematic_screen_effect_start true)
        (cinematic_screen_effect_set_convolution 3 2 1 2 0)
        (cinematic_screen_effect_start false)
    )
)

(script startup intro
(fade_in 0.0 0.0 0.0 120)
)

;; For some reason the sound play command does not work if the sound is not referenced
(script static void sounds
    (begin
        ;; HUD Sounds
        (sound_impulse_start
            "keymind\the_flood\sound\001_ui\001_ui_hud\001_ui_hud_grenades\001_frag_grenade"
            (list_get (players) 0)
            1.0
        )
        (sound_impulse_start
            "keymind\the_flood\sound\001_ui\001_ui_hud\001_ui_hud_grenades\001_plasma_grenade"
            (list_get (players) 0)
            1.0
        )
    )
)