# ReadMe
Made by `GhostyDuckyy#7698`
Game: [Anime Dimensions Simulator](https://roblox.com/games/6938803436/)
### Notes 🗒️
This script still in **[W.I.P]** ⚠️.

Recommand use alt, use on ur **own risk**!!!

Also don't look the source, i try my best to beautiful it (hope don't hurt ur eyes). <3
## Changelogs 🔧
```lua
- Big Update for Webhook
```
## How to use ❓
1. Run [script](https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Projects/Anime%20Dimensions%20Simulator/ReadMe.md#loadstring-) in Dimensions / Raids / Boss Rush / Time Challenge.
2. (Save [script](https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Projects/Anime%20Dimensions%20Simulator/ReadMe.md#loadstring-) to `autoexec`, if u want auto farm).
3. Enjoy! 💖
### Settings ⚙️
Configuration of script
- `AutoFarm` / Boolean - set `false` to Abort Script.
- `AutoRetry` / Boolean - Retry Dimensions.
- `Webhook` / Table - `Enabled`(Boolean) is enable / disable this feature, `Url` (String) replace with webhook ([Discord](https://discord.com/)) url.
### Loadstring 🌐
```lua
getgenv().Settings = {
	AutoFarm  	  =  	true,
	AutoRetry  	  =  	true,
	Webhook       = 	{Enabled  =  false, Url =  "https://discord.com/api/webhooks/example/tokens"},
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Projects/Anime%20Dimensions%20Simulator/source.lua", true))("skull")
```
