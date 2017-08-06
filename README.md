# CS810 Project - Steph Oro & Gregory Johnson

*I pledge my honor that I have abided by the Stevens Honor System*

## Currently Implemented Features

### New
1) Space Canyon Path Scene & Puzzle Added. -steph

### Previously
1) Buttons creatable from scripting language. -steph
1) Event management for anamation ending, music ending, button presses, scene loading, and device interrupts. -steph
1) Load Scenes from files. -steph
1) A scripting language.
1) Can display media (images) on screen via Sniffle (the scripting language)
1) Can attach animations to media via Sniffle
1) Can play sounds via Sniffle
1) Animations can be played in sequence or parallel. So can music, which can be intermixed with animations as desired.

## App Contents

### Technical Features
1) A scripting language
1) Can display media (images) on screen via Sniffle (the scripting language)
1) Can attach animations to media via Sniffle
1) Can play sounds via Sniffle
1) Can display clickable buttons and areas via Sniffle
1) Can load a series of the above as a "Scene"
1) Sniffle lambdas can be bound to animation ending, music ending, button presses, scene loading, and device interrupts (any time the user leaves the app context).
1) Can write/read stateful information to/from an on disk save file format via Sniffle.

### Game Content
Imagine a small worn down house squeezed in between skyscrapers. This is the house of the late Dr. Charles S. Laudner. This house has been willed to You (the player) as part of his will. You are the grandchild of this eccentric man, and his favorite grandchild.

Upon entering this house, You find Yourself suddenly standing in front of an open tall iron gate in the middle of a fence. The fence surrounds a forest. The forest is split by a path. You may choose to follow the path.

Following the path, You find a beautiful Manor. This, in time, You will find was Your grandfather's true home and center of The Estate. When You enter the Manor via front door, You will find inside a jumble of rooms whose connections do not seem to follow the natural laws of Time and Space. In the Manor, You will unlock the key to the Forest of Size, where You will discover the Perspective of Size (a totem part), after encountering puzzles whose solution involves seeing things as larger or smaller than they actually are (via in game items).

Upon recovery of the Perspective of Size, to which You will add to the Pillar.

Again entering the Manor, You will find the key to the Canyons of Space. During which You will encounter various puzzles solved by seeing things as connected in different ways than You originally saw. Upon completion of the Canyons of Space, You wil find the Perspective of Space. This You will add to the Pillar and return to the Manor.

In the Manor You will find the key to the Caves of Time. Here You will solve puzzles by seeing things differently in terms of their age and time of existence. Upon solving these puzzles, You will gain the Perspective of Time. Adding this final totem to the Pillar, You shall restore Life to the estate, and the credit sequence will play.

That's the game!

## Project Timeline

### 1st Deliverable - the Basics June 25th
- Scripting language supports environment variables, lambda functions, and basic math and conditional operators (+,-,*,/,>,<,=,>=,<=)
  - Steph (Completed During Course Beginning)
- Sounds can be loaded and played.
  - Greg (Completed)
- Tests show scripting langauge creating the ```factorial``` function and evaluation of ```(factorial 5)``` yields ```120```.
  - Steph (Completed)
- Tests play a sound from a file.
  - Greg (Completed)

### 2nd Deliverable - Content Support
- On screen "Actors" which consist of images, coordinates, and sizing information can be put on screen via the scripting language.
  - Steph (Already Complete)
- Basic Animations can be launched from the scripting language.
  - Steph & Greg (This week)
- Sound Effects can be played from the scripting language
  - Greg (This Week)
- Tests show an image being put on a screen and then moving around.
  - Steph or Greg (Next Week)
- Tests show a sound playing triggered through the scripting language. 
  - Greg (Next Week)

### 3rd Deliverable - Event Management
- Buttons can be created/removed via the scripting language.
  - Greg (Week After 2nd Deliverable Due)
- Events can be bound to animation ending, music ending, buttons, scene loading, and device interrupts (for emergency state-saving).
  - Steph (Week After 2nd Deliverable Due)
- Tests show buttons that make images move, and change the images/buttons on the screen.
  - Greg (Two Weeks After 2nd Deliverable Due)

### 4th Deliverable - Game Content
- Menus created.
  - Greg (Week After 3rd Deliverable)
- Basic scenes and story material appear in game and are nagivable.
  - Greg & Steph (Week After 3rd Deliverable Due)
- App loads with a selection menu of scenes to go to. Able to navigate back to the menu and between various scenes.
  - Greg & Steph (Week After 3rd Deliverable Due)

### Final - Finished Game
- App opens to a game, instructions provided on how to play through the game.
  - Greg & Steph (Throughout Semester)

## Project Rational and Technolgies

The purpose of this project shall be to produce a game/game-engine for iOS, leveraging important iOS technologies, frameworks, and libraries in the process. The learning from interacting with these technologies at the level of understanding and involvement necessary to produce a functioning and well made game of the type to be built should be considered sufficient an in depth dive into iOS to serve the purposes of the course project.

The main three main technologies that this app will interact with, which are important iOS technologies are Core Audio, Core Graphics, and SpriteKit. Additionally, the app shall use some standard interface components such as buttons. Taken together, these most of these technologies are used in the majority of commercial apps in some form, which suggests the learnings from the creation of this app will be valuable.

As the *spice* of this application, we will be building our own scripting language, which will enable us to support various ammenities that are favorable such as: the ability to provide downloadable content for the application, the ability for end-users to modify the application, the ability to clearly separate the iOS application as a game-engine and supporting resources as the game content. The scripting language will be written in C++, and can be interacted with from Swift code through the use of Objective-C.

## Project Description

The game we produce shall be a 2d diorama of sorts, in the category of "point and click" games and will be composed of images cut up and put together to create scenes. Our game engine will support musical accompanyment, animations, the loading/unloading of levels and level resources such as images (sprites), positioning information, and custom scripting events tied to triggers such as scene loading, button presses, animation endings, or events created by the scripts themselves.

A sample of the kind of diorama look can be found [here](http://www.suzannemoxhay.com/diorama). A sample of the thematic musical accompanyment chosen for this work can be found by Googling "Suite Bergamasque" or "Gymnopedies". The source images for our project will be pulled from [pexels](https://www.pexels.com). All resources chosen will be either in the public domain due to age, as with the music, or free for commercial use, as with pexels. For a sample of what a point and click game can be like, one might look to [Myst](https://en.wikipedia.org/wiki/Myst) as a prime an example of the genre of our game.
