(SpriteAlloc 10)
(TextureAlloc 10)
(ActionAlloc 11)

(set note1 (sound "note1.mp3" 1))
(set note2 (sound "note2.mp3" 1))
(set note3 (sound "note3.mp3" 1))
(set note4 (sound "note4.mp3" 1))

(set puzzlestate 0)

(set lowcat (Texture "lowpolycat.png"))
(set bg1 (Texture "spacecanyonenterance.png"))
(set bg2 (Texture "spacecanyonopen.png"))

(set sprite1 (Sprite 100 100 lowcat))
(set sprite2 (Sprite 200 300 lowcat))
(set sprite3 (Sprite 1920 1272 bg1))
(set sprite4 (Sprite 1920 1272 bg2))
(addChild sprite3 0 0)
(set curplayer (Sprite 0 0 lowcat))
(addChild curplayer 0 0)
(set button1 (Button -100 -100 100 100 "Touch 1" (begin
(run note1 curplayer)
(if (= puzzlestate 4) ()
(set puzzlestate 1)
))))
(set button2 (Button 325 0 100 500 "Touch 2" (begin
(run note2 curplayer)
(if (= puzzlestate 4) ()
(if (= puzzlestate 1) (set puzzlestate 2) (set puzzlestate 0))
)
)))
(set button3 (Button -300 -100 100 300 "Touch 3" (begin
(run note3 curplayer)
(if (= puzzlestate 4) ()
(if (= puzzlestate 2) (set puzzlestate 3) (set puzzlestate 0))
))))
(set button4 (Button 240 -110 50 200 "Touch 4" (begin
(if (= puzzlestate 4) (run note4 curplayer) (begin
(if (= puzzlestate 3) (set puzzlestate 4) (begin (set puzzlestate 0) (run note4 curplayer)))
(pprint "puzzle state:" puzzlestate)
(if (= puzzlestate 4) (unlock) ())
)))))

(set unlock (lambda ()

(run (sequence note4 (event (begin
(addChild sprite4 0 0)
(removeChild sprite3)
))) curplayer)

))

"(set SCENE_LOAD (quote ((unlock))))"
