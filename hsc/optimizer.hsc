;; Player Variable
(script static unit player
(unit (list_get (players) 0))
)

;; Optimize Scenerys
(script continuous objects_destroy
        (sleep_until (volume_test_object blue_off (player)) 0)
        (object_destroy_containing "blue_trigger")
        (sleep_until (volume_test_object blue_on (player)) 0)
        (object_create_containing "blue_trigger")
        (sleep_until (volume_test_object red_off (player)) 0)
        (object_destroy_containing "red_trigger")
        (sleep_until (volume_test_object red_on (player)) 0)
        (object_create_containing "red_trigger")
)