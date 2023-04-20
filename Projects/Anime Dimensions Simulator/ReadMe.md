# ReadMe
Made by `GhostyDuckyy#7698`, Game: [Anime Dimensions Simulator](https://roblox.com/games/6938803436/)
## Notes 🗒️
1. Don't look the source, i tried my best to beautiful it (hopefully don't hurt ur eyes). 🤍
## Supported Exploits 🗃️
`hookfunction` is broken on most Exploits, unable grab match result (💀)
### Status
1. ✅ - Working
2. ⚠️ - Broken / Script Issues
3. ❔ - (Untested but should be work)

### Paid
* [Synapse X](https://x.synapse.to/) - ✅
* [Script-Ware](https://script-ware.com/w) - ✅
### Free
* [Krnl](https://krnl.place/) - ❔
* [Fluxus](https://fluxteam.xyz/) - ❔
* [Comet](https://cometrbx.xyz/) - ❔
* [Oxygen-U](https://oxygenu.xyz/) - ❔
## Changelogs 🔧
```lua
- Improved CancelTween
- Changed matchUrl (check webhook url) to new Method
- Added a check on Executed
```
## How to use ❓
1. Run [script](https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Projects/Anime%20Dimensions%20Simulator/ReadMe.md#loadstring-) in Dimensions / Raids / Boss Rush / Time Challenge.
2. (Save [script](https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Projects/Anime%20Dimensions%20Simulator/ReadMe.md#loadstring-) to `autoexec`, if u want auto farm).
3. Enjoy! 💖
### Settings ⚙️
Configuration of script
- `AutoFarm`: Boolean - **Enable** / **Disable** script.
- `AutoRetry`: Boolean - Retry Dimensions.
- `Webhook`: Table - `Enabled`(Boolean) is **enable** / **disable** this feature, `Url` (String) replace with webhook ([Discord](https://discord.com/)) url.
### Loadstring 🌐
```lua
getgenv().Settings = {
	AutoFarm  	  =  	true,
	AutoRetry  	  =  	true,
	Webhook       = 	{Enabled = false, Url = "https://discord.com/api/webhooks/example/tokens"},
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/GhostDuckyy/main/Projects/Anime%20Dimensions%20Simulator/source.lua", true))("💀")
```
