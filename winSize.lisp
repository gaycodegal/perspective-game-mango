(SpriteAlloc 1)
(TextureAlloc 0)
(ActionAlloc 0)
(ButtonAlloc 1)



(Button 0 0 480 320 "back to manor" (loadScene "manor"))
(set bg (Texture "psize.png"))

(set bgs (Sprite 480 320 bg))
(addChild bgs 0 0)

(set psize 1)
