;; Global variable for know if the volume was triggered
(global boolean triggered true)

;; Player 0 Variable
(script static unit player
        (unit (list_get (players) 0))
)

;; Optimize Blue Side Objects
(script continuous blue_objects_destroy
        (begin
                (if (= (sleep_until (volume_test_object blue_off (player)) 15) (= triggered true))
                        (begin
                                (object_destroy_containing "blue_trigger")
                                (object_create_containing "red_trigger")
                                (set developer_mode 127)
                                (print "Blue Objects Destroyed")
                                (print "Red Objects Restored")
                        )
                )
                (if (= (sleep_until (volume_test_object blue_on (player)) 15) (= triggered true))
                        (begin
                                (object_create_containing "blue_trigger")
                                (set developer_mode 127)
                                (print "Blue Objects Restored")
                        )
                )
        )
)

;; Optimize Red Side Objects
(script continuous red_objects_destroy
        (begin
                (if (= (sleep_until (volume_test_object red_off (player)) 15) (= triggered true))
                        (begin
                                (object_destroy_containing "red_trigger")
                                (object_create_containing "blue_trigger")
                                (set developer_mode 127)
                                (print "Red Objects Destroyed")
                                (print "Blue Objects Restored")
                        )
                )
                (if (= (sleep_until (volume_test_object red_on (player)) 15) (= triggered true))
                        (begin
                                (object_create_containing "red_trigger")
                                (set developer_mode 127)
                                (print "Red Objects Restored")
                        )
                )
        )
)