(SpriteAlloc 11)
(TextureAlloc 11)
(ActionAlloc 11)
(ButtonAlloc 1)

(set wintru (* (+ psize) (+ ptime) (+ pspace)))

(Button 0 0 480 320 (if wintru "you win" "back to manor") (if wintru (loadScene "winwin") (loadScene "manor")))

(if (+ psize) (addChild (Sprite 480 320 (Texture "psize.png")) 0 0)  ())
(if (+ ptime) (addChild (Sprite 480 320 (Texture "ptime.png")) 0 0) ())
(if (+ pspace) (addChild (Sprite 480 320 (Texture "pspace.png")) 0 0) ())
