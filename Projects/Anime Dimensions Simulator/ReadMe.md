# ReadMe
Made by `Ghost-Ducky#7698`
### Notes 🗒️
This script still in **[W.I.P]** ⚠️.

Recommand use alt, use on ur **own risk**!!!

Also don't look the source, i try my best to beautiful it (hope don't hurt ur eyes). <3
## Changelogs 🔧
```lua
- Webhook: [Current are very useless]
```
### Bugs 🪲
- Can't attack enemies - 🐛
- Wierd tween / teleport to enemy - 🐛

Both bugs are my skill issues. 💀
## How to use ❓
1. Run [script](https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Projects/Anime%20Dimensions%20Simulator/ReadMe.md#loadstring-) in Dimensions / Raids / Boss Rush / Time Challenge.
2. (Save [script](https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Projects/Anime%20Dimensions%20Simulator/ReadMe.md#loadstring-) to `autoexec`, if u want auto farm).
3. Enjoy! 💖
### Settings ⚙️
Configuration of script
- `AutoFarm` / Boolean - set `false` to Abort Script.
- `AutoRetry` / Boolean - Retry Dimensions.
- `FpsBooster` / Boolean - less use CPU / GPU usage.
- `Webhook` / Table - `Enabled`(Boolean) is enable / disable this feature, `Url` (String) replace with webhook ([Discord](https://discord.com/)) url.
### Loadstring 🌐
```lua
getgenv().Settings = {
	AutoFarm  	  =  	true,
	AutoRetry  	  =  	true,
	FpsBooster    =  	false,
	Webhook       = 	{Enabled  =  false, Url =  "https://discord.com/api/webhooks/example/tokens"},
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Projects/Anime%20Dimensions%20Simulator/source.lua", true))("skull")
```
