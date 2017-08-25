(SpriteAlloc 10)
(TextureAlloc 10)
(ActionAlloc 11)
(ButtonAlloc 10)

(set note1 (sound "note1.mp3" 1))
(set note2 (sound "note2.mp3" 1))
(set note3 (sound "note3.mp3" 1))
(set note4 (sound "note4.mp3" 1))

(set puzzlestate 0)

(set lowcat (Texture "lowpolycat.png"))
(set bg1 (Texture "spacecanyonenterance.png"))
(set bg2 (Texture "spacecanyonopen.png"))

(set sprite3 (Sprite 480 320 bg1))
(set sprite4 (Sprite 480 320 bg2))
(addChild sprite3 0 0)
(set curplayer (Sprite 0 0 lowcat))

(addChild curplayer 0 0)
(set button1 (Button (/ (* -100 18) 30) (/ (* -100 18) 30) (/ (* 100 18) 30) (/ (* 100 18) 30) "1" (begin
(run note1 curplayer)
(if (= puzzlestate 4) ()
(set puzzlestate 1)
))))
(set button2 (Button (/ (* 345 18) 30) (/ (* 0 18) 30) (/ (* 100 18) 30) (/ (* 500 18) 30) "2" (begin
(run note2 curplayer)
(if (= puzzlestate 4) ()
(if (= puzzlestate 1) (set puzzlestate 2) (set puzzlestate 0))
)
)))
(set button3 (Button (/ (* -300 18) 30) (/ (* -100 18) 30) (/ (* 100 18) 30) (/ (* 300 18) 30) "3" (begin
(run note3 curplayer)
(if (= puzzlestate 4) ()
(if (= puzzlestate 2) (set puzzlestate 3) (set puzzlestate 0))
))))
(set button4 (Button (/ (* 260 18) 30) (/ (* -110 18) 30) (/ (* 50 18) 30) (/ (* 200 18) 30) "4" (begin
(if (= puzzlestate 4) (run note4 curplayer) (begin
(if (= puzzlestate 3) (set puzzlestate 4) (begin (set puzzlestate 0) (run note4 curplayer)))
(pprint "puzzle state:" puzzlestate)
(if (= puzzlestate 4) (unlock) ())
)))))

(set unlock (lambda ()

(run (sequence note4 (event (begin
(addChild sprite4 0 0)
(removeChild sprite3)
(Button (/ (* 50 18) 30) (/ (* -50 18) 30) (/ (* 200 18) 30) (/ (* 200 18) 30) "5" (loadScene "winSpace"))
))) curplayer)

))

"(set SCENE_LOAD (quote ((unlock))))"
