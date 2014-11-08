Poorly Planned Pillaging Party
================================================================================
A simple platformer game that was created for the Ludum Dare game jam. 
Requires LÖVE 8.0 to run (https://love2d.org/).

![screenshot](https://cloud.githubusercontent.com/assets/2266175/4802811/2997c87c-5e4c-11e4-8e07-8702d90ea2b1.png)

Controls
--------------------------------------------------------------------------------

### Character Selection
* **up/down:** change class for the currently selected character
* **left/right:** change characters (the first level only has one character)
* **w,a,s,d:** move camera to show level layout 

### In Game
* **up:** jump
* **left/right:** move
* **space (wizard only:** fire projectile
* **escape:** move on to the next character 

Gameplay
--------------------------------------------------------------------------------
Choose a party of characters, each of whom can only live for 10 seconds. 
Collect all the treasure in the stage and bring it back to the entrance before 
your entire party is dead.

During Character Selection, you must select a number of characters to complete 
the stage with. Each character can be any of three classes and will be played 
one-by-one in order from left to right. 

During gameplay, you must collect each piece of treasure and bring it back to 
the entrance (the gap in the ceiling). Each character will die after 10 seconds 
and the next character's turn will begin. You must collect all the treasure for 
the stage before all of your characters die. When a character dies, he will 
drop the treasure he was holding, which must be collected by the next character. 

Each class has its own ability:

* **Warrior:** can push heavy objects
* **Theif:** can run quickly
* **Wizard:** can fire projectiles which activate objects (crates, buttons) 
  from afar 

Third Party Libraries and Resources
--------------------------------------------------------------------------------
 * [Lua Coroutine Wait Support](https://bitbucket.org/mohiji/luacoroutinedemo/ "Lua Coroutine Demo")
 * [Tiled](http://www.mapeditor.org/, "Tiled")
 * [Advanced Tiled Loader](https://github.com/Kadoba/Advanced-Tiled-Loader "Advanced Tiled Loader")
 * [LÖVE](http://www.love2d.org "LÖVE")
 * [cgMusic](http://codeminion.com/blogs/maciek/2008/05/cgmusic-computers-create-music/ "cgmusic")
 * [Adventure Mini-figs](http://quale-art.blogspot.ca/p/addventure-mini-figs.html "Adventure Mini-figs")
