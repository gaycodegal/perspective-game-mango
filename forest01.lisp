(SpriteAlloc 10)
(TextureAlloc 10)
(ActionAlloc 11)
(ButtonAlloc 10)


(set puzzlestate 0)

(set lowcat (Texture "lowpolycat.png"))
(set bg1 (Texture "forest01.png"))
(set bg2 (Texture "forest02.png"))

(set sprite3 (Sprite 480 320 bg1))
(set sprite4 (Sprite 480 320 bg2))
(addChild sprite3 0 0)

(set curplayer (Sprite 0 0 lowcat))
(addChild curplayer 0 0)

(set button1 (Button (/ (* 90 18) 30) (/ (* 150 18) 30) (/ (* 50 18) 30) (/ (* 50 18) 30) "first" (begin
(if (= puzzlestate 0) (begin
(set puzzlestate 1)
(unlock)
)
 ()))))


(set unlock (lambda ()

(begin
(addChild sprite4 0 0)
(removeChild sprite3)
(set button2 (Button (/ (* 180 18) 30) (/ (* -80 18) 30) (/ (* 180 18) 30) (/ (* 180 18) 30) "second" (loadScene "winSize")))

)


))

"(set SCENE_LOAD (quote ((unlock))))"
