(SpriteAlloc 1)
(TextureAlloc 0)
(ActionAlloc 0)
(ButtonAlloc 1)


(set state 0)
(Button 0 0 480 320 "" (if (= state 0)
(begin (set state 1) (removeChild bgs) (set bgs (Sprite 480 320 bg1)) (addChild bgs 0 0 ))
(loadScene "manor")
))
(set bg (Texture "gateclosed.png"))
(set bg1 (Texture "gateopen.png"))
(set bgs (Sprite 480 320 bg))
(addChild bgs 0 0)


