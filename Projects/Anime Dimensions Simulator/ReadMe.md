# ReadMe
Made by `Ghost-Ducky#7698`
### Notes 🗒️
This script still in **[W.I.P]** ⚠️.
Recommand use alt, on ur own risk!!!
## Changelogs
```lua
- Webhook: [Current are very useless]
```
#### Bugs 🪲
- Can't attack enemies [Blame Tween Function] - 🐛
- Wierd tween / teleport to enemy - 🐛
## How to use ❓
1. Run script in Dimensions / Raids / Boss Rush / Time Challenge.
2. (Save script to `autoexec`, if u want auto farm).
3. Enjoy!
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
	Webhook       = 	{Enabled  =  false, Url  =  "https://discord.com/api/webhooks/example/tokens"},
}

loadstring(game:HttpGet("[https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Projects/Anime Dimensions Simulator/source.lua](https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Projects/Anime%20Dimensions%20Simulator/source.lua)", true))("skull")
```
