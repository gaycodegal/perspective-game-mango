(SpriteAlloc 10)
(TextureAlloc 10)
(ActionAlloc 11)

(set mysound (sound "GymnopedieNo1KevinMacleod.mp3" 1))
(set anim1
  (repeat
    (sequence
      (moveBy 50 -70 1000)
      (scale 1100 500)
      (rotate 360 500))
    5))
(set anim2
  (repeat
    (group
      (moveBy 50 -70 1000)
      (scale 750 500)
      (rotate 360 500))
    10))

(set button1 (Button 10 100 100 200 "whoops" (pprint "hi")))
button1
(set lowcat (Texture "lowpolycat.png"))
(set sprite1 (Sprite 100 100 lowcat))
(set sprite2 (Sprite 200 300 lowcat))
(addChild sprite2 100 0)
(addChild sprite1 -100 200)
(run anim1 sprite1)
(run mysound sprite2)
(run anim2 sprite2)
