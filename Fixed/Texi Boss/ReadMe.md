## [Texi boss](https://www.roblox.com/games/7305309231/) autofarm
#### Made by [Samuell](https://v3rmillion.net/member.php?action=profile&uid=610035) | ( Owner of **samuelhook** )
#### Click to [Thread](https://v3rmillion.net/showthread.php?tid=1182130)

## How to use:
- Step 1: execute script
- Step 2: Load your car
- Step 3: Get into your car
- Step 4: Enjoy the autofarm

## Picture:
I guess is **Patched**

![](https://cdn.discordapp.com/attachments/1003648116488155177/1007978298036457534/unknown.png)

### Loadstring:
```lua
  getgenv().RatingTarget  = 1; -- It will targets that have your set amount or above
  getgenv().HighestRatingTarget = 2; -- The cap of rating target (so you aren't targetting rating 8+ or something)

  loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Fixed/Texi%20Boss/source.lua",true))()
```

Fixed:
```lua
Change "game.VirtualInputManager" to "game:GetService("VirtualInputManager")"
````
