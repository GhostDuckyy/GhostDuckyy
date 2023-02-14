local Data = {}

Data.Quests = {
    --// World 1
    BanditQuest1 = {
        {
            Enemy = "Bandit",
            Count = 5,
            LowestLevel = 0,
            MaxLevel = 10,
        },
    },
    MarineQuest = {
        {
            Enemy = "Trainee",
            Count = 5,
            LowestLevel = 0,
            MaxLevel = 10,
        },
    },
    JungleQuest = {
        {
            Enemy = "Monkey",
            Count = 6,
            LowestLevel = 10,
            MaxLevel = 15,
        },
        {
            Enemy = "Gorilla",
            Count = 8,
            LowestLevel = 15,
            MaxLevel = 30,
        },
    },
    BuggyQuest1 = {
        {
            Enemy = "Pirate",
            Count = 8,
            LowestLevel = 30,
            MaxLevel = 40,
        },
        {
            Enemy = "Brute",
            Count = 8,
            LowestLevel = 40,
            MaxLevel = 60,
        },
    },
    DesertQuest = {
        {
            Enemy = "Desert Bandit",
            Count = 8,
            LowestLevel = 60,
            MaxLevel = 75,
        },
        {
            Enemy = "Desert Officer",
            Count = 6,
            LowestLevel = 75,
            MaxLevel = 90
        },
    },
    SnowQuest = {
        {
            Enemy = "Snow Bandit",
            Count = 8,
            LowestLevel = 90,
            MaxLevel = 100,
        },
        {
            Enemy = "Snowman",
            Count = 8,
            LowestLevel = 100,
            MaxLevel = 120,
        },
    },
    MarineQuest2 = {
        {
            Enemy = "Chief Petty Officer",
            Count = 8,
            LowestLevel = 120,
            MaxLevel = 150,
        },
    },
    SkyQuest = {
        {
            Enemy = "Sky Bandit",
            Count = 7,
            LowestLevel = 150,
            MaxLevel = 175,
        },
        {
            Enemy = "Dark Master",
            Count = 8,
            LowestLevel = 175,
            MaxLevel = 190,
        },
    },
    PrisonerQuest = {
        {
            Enemy = "Prisoner",
            Count = 8,
            LowestLevel = 190,
            MaxLevel = 210,
        },
        {
            Enemy = "Dangerous Prisoner",
            Count = 8,
            LowestLevel = 210,
            MaxLevel = 250,
        },
    },
    ColosseumQuest = {
        {
            Enemy = "Toga Warrior",
            Count = 7,
            LowestLevel = 250,
            MaxLevel = 275,
        },
        {
            Enemy = "Gladiator",
            Count = 8,
            LowestLevel = 275,
            MaxLevel = 300,
        },
    },
    MagmaQuest = {
        {
            Enemy = "Military Soldier",
            Count = 7,
            LowestLevel = 300,
            MaxLevel = 325,
        },
        {
            Enemy = "Military Spy",
            Count = 8,
            LowestLevel = 325,
            MaxLevel = 375,
        },
    },
    FishmanQuest = {
        {
            Enemy = "Fishman Warrior",
            Count = 8,
            LowestLevel = 375,
            MaxLevel = 400,
        },
        {
            Enemy = "Fishman Commando",
            Count = 7,
            LowestLevel = 375,
            MaxLevel = 450,
        },
    },
    SkyExp1Quest = {
        {
            Enemy = "God's Guard",
            Count = 7,
            LowestLevel = 450,
            MaxLevel = 475,
        },
        {
            Enemy = "Shanda",
            Count = 9,
            LowestLevel = 475,
            MaxLevel = 525,
        },
    },
    SkyExp2Quest = {
        {
            Enemy = "Royal Squad",
            Count = 8,
            LowestLevel = 525,
            MaxLevel = 550,
        },
        {
            Enemy = "Royal Soldier",
            Count = 8,
            LowestLevel = 550,
            MaxLevel = 625,
        },
    },
    FountainQuest = {
        {
            Enemy = "Galley Pirate",
            Count = 8,
            LowestLevel = 625,
            MaxLevel = 650,
        },
        {
            Enemy = "Galley Captain",
            Count = 9,
            LowestLevel = 650,
            MaxLevel = 700,
        }
    },

    --// World 2
    Area1Quest = {
        {
            Enemy = "Raider",
            Count = 8,
            LowestLevel = 700,
            MaxLevel = 725,
        },
        {
            Enemy = "Mercenary",
            Count = 8,
            LowestLevel = 725,
            MaxLevel = 775,
        },
    },
    Area2Quest = {
        {
            Enemy = "Swan Pirate",
            Count = 8,
            LowestLevel = 775,
            MaxLevel = 800,
        },
        {
            Enemy = "Factory Staff",
            Count = 8,
            LowestLevel = 800,
            MaxLevel = 875,
        },
    },
    MarineQuest3 = {
        {
            Enemy = "Marine Lieutenant",
            Count = 8,
            LowestLevel = 875,
            MaxLevel = 900,
        },
        {
            Enemy = "Marine Captain",
            Count = 9,
            LowestLevel = 900,
            MaxLevel = 950,
        },
    },
    ZombieQuest = {
        {
            Enemy = "Zombie",
            Count = 8,
            LowestLevel = 950,
            MaxLevel = 975,
        },
        {
            Enemy = "Vampire",
            Count = 8,
            LowestLevel = 975,
            MaxLevel = 1000,
        },
    },
    SnowMountainQuest = {
        {
            Enemy = "Snow Trooper",
            Count = 8,
            LowestLevel = 1000,
            MaxLevel = 1050,
        },
        {
            Enemy = "Winter Warrior",
            Count = 9,
            LowestLevel = 1050,
            MaxLevel = 1100,
        },
    },
    IceSideQuest = {
        {
            Enemy = "Lab Subordinate",
            Count = 8,
            LowestLevel = 1100,
            MaxLevel = 1125,
        },
        {
            Enemy = "Horned Warrior",
            Count = 9,
            LowestLevel = 1125,
            MaxLevel = 1175,
        },
    },
    FireSideQuest = {
        {
            Enemy = "Magma Ninja",
            Count = 8,
            LowestLevel = 1175,
            MaxLevel = 1200,
        },
        {
            Enemy = "Lava Pirate",
            Count = 8,
            LowestLevel = 1200,
            MaxLevel = 1250,
        },
    },
    ShipQuest1 = {
        {
            Enemy = "Ship Deckhand",
            Count = 8,
            LowestLevel = 1250,
            MaxLevel = 1275,
        },
        {
            Enemy = "Ship Engineer",
            Count = 8,
            LowestLevel = 1275,
            MaxLevel = 1300,
        },
    },
    ShipQuest2 = {
        {
            Enemy = "Ship Steward",
            Count = 8,
            LowestLevel = 1300,
            MaxLevel = 1325,
        },
        {
            Enemy = "Ship Officer",
            Count = 8,
            LowestLevel = 1325,
            MaxLevel = 1350,
        },
    },
    FrostQuest = {
        {
            Enemy = "Arctic Warrior",
            Count = 8,
            LowestLevel = 1350,
            MaxLevel = 1375,
        },
        {
            Enemy = "Snow Lurker",
            Count = 8,
            LowestLevel = 1375,
            MaxLevel = 1425,
        },
    },
    ForgottenQuest = {
        {
            Enemy = "Sea Soldier",
            Count = 8,
            LowestLevel = 1425,
            MaxLevel = 1450,
        },
        {
            Enemy = "Water Fighter",
            Count = 8,
            LowestLevel = 1450,
            MaxLevel = 1500,
        },
    },

    --// World 3
    PiratePortQuest = {
        {
            Enemy = "Pirate Millionaire",
            Count = 8,
            LowestLevel = 1500,
            MaxLevel = 1525,
        },
        {
            Enemy = "Pistol Billionaire",
            Count = 8,
            LowestLevel = 1525,
            MaxLevel = 1575,
        },
    },
    AmazonQuest = {
        {
            Enemy = "Dragon Crew Warrior",
            Count = 8,
            LowestLevel = 1575,
            MaxLevel = 1600,
        },
        {
            Enemy = "Dragon Crew Archer",
            Count = 8,
            LowestLevel = 1600,
            MaxLevel = 1625,
        },
    },
    AmazonQuest2 = {
        {
            Enemy = "Female Islander",
            Count = 8,
            LowestLevel = 1625,
            MaxLevel = 1650
        },
        {
            Enemy = "Giant Islander",
            Count = 8,
            LowestLevel = 1650,
            MaxLevel = 1700,
        },
    },
    MarineTreeIsland = {
        {
            Enemy = "Marine Commodore",
            Count = 8,
            LowestLevel = 1700,
            MaxLevel = 1725,
        },
        {
            Enemy = "Marine Rear Admiral",
            Count = 8,
            LowestLevel = 1725,
            MaxLevel = 1775,
        },
    },
    DeepForestIsland3 = {
        {
            Enemy = "Fishman Raider",
            Count = 8,
            LowestLevel = 1775,
            MaxLevel = 1800,
        },
        {
            Enemy = "Fishman Captain",
            Count = 8,
            LowestLevel = 1800,
            MaxLevel = 1825,
        },
    },
    DeepForestIsland = {
        {
            Enemy = "Forest Pirate",
            Count = 8,
            LowestLevel = 1825,
            MaxLevel = 1850,
        },
        {
            Enemy = "Forest Pirate",
            Count = 8,
            LowestLevel = 1850,
            MaxLevel = 1900,
        },
    },
    DeepForestIsland2 = {
        {
            Enemy = "Jungle Pirate",
            Count = 8,
            LowestLevel = 1900,
            MaxLevel = 1925,
        },
        {
            Enemy = "Musketeer Pirate",
            Count = 8,
            LowestLevel = 1925,
            MaxLevel = 1975,
        },
    },
    HauntedQuest1 = {
        {
            Enemy = "Reborn Skeleton",
            Count = 8,
            LowestLevel = 1975,
            MaxLevel = 2000,
        },
        {
            Enemy = "Living Zombie",
            Count = 8,
            LowestLevel = 2000,
            MaxLevel = 2025,
        },
    },
    HauntedQuest2 = {
        {
            Enemy = "Demonic Soul",
            Count = 8,
            LowestLevel = 2025,
            MaxLevel = 2050,
        },
        {
            Enemy = "Posessed Mummy",
            Count = 8,
            LowestLevel = 2050,
            MaxLevel = 2075,
        },
    },
    NutsIslandQuest = {
        {
            Enemy = "Peanut Scout",
            Count = 8,
            LowestLevel = 2075,
            MaxLevel = 2100,
        },
        {
            Enemy = "Peanut President",
            Count = 8,
            LowestLevel = 2100,
            MaxLevel = 2125,
        },
    },
    IceCreamIslandQuest = {
        {
            Enemy = "Ice Cream Chef",
            Count = 8,
            LowestLevel = 2125,
            MaxLevel = 2150,
        },
        {
            Enemy = "Ice Cream Commander",
            Count = 8,
            LowestLevel = 2150,
            MaxLevel = 2200,
        },
    },
    CakeQuest1 = {
        {
            Enemy = "Cookie Crafter",
            Count = 8,
            LowestLevel = 2200,
            MaxLevel = 2225,
        },
        {
            Enemy = "Cake Guard",
            Count = 8,
            LowestLevel = 2225,
            MaxLevel = 2250,
        },
        {
            Enemy = "Baking Staff",
            Count = 8,
            LowestLevel = 2250,
            MaxLevel = 2275,
        },
        {
            Enemy = "Head Baker",
            Count = 8,
            LowestLevel = 2275,
            MaxLevel = 2300,
        },
    },
    ChocQuest1 = {
        {
            Enemy = "Cocoa Warrior",
            Count = 8,
            LowestLevel = 2300,
            MaxLevel = 2325,
        },
        {
            Enemy = "Chocolate Bar Battler",
            Count = 8,
            LowestLevel = 2325,
            MaxLevel = 2350,
        },
    },
    ChocQuest2 = {
        {
            Enemy = "Sweet Thief",
            Count = 8,
            LowestLevel = 2350,
            MaxLevel = 2375,
        },
        {
            Enemy = "Candy Rebel",
            Count = 8,
            LowestLevel = 2375,
            MaxLevel = 2400,
        },
    },
    CandyQuest1 = {
        {
            Enemy = "Candy Pirate",
            Count = 8,
            LowestLevel = 2400,
            MaxLevel = 2425,
        },
        {
            Enemy = "Snow Demon",
            Count = 8,
            LowestLevel = 2425,
            MaxLevel = math.huge
        },
    },
}

Data.Bosses = {
    JungleQuest = {
        [3] = {
            Enemy = "Gorilla King",
            LowestLevel = 20,
        },
    },
    BuggyQuest1 = {
        [3] = {
            Enemy = "Bobby",
            LowestLevel =  55
        },
    },
    SnowQuest = {
        [3] = {
            Enemy = "Yeti",
            LowestLevel = 105,
        },
    },
    MarineQuest2 = {
        [2] = {
            Enemy = "Vice Admiral",
            LowestLevel = 130,
        },
    },
    ImpelQuest = {
        [1] = {
            Enemy = "Warden",
            LowestLevel = 220,
        },
        [2] = {
            Enemy = "Chief Warden",
            LowestLevel = 230,
        },
        [3] = {
            Enemy = "Swan",
            LowestLevel = 240,
        },
    },
    MagmaQuest = {
        [3] = {
            Enemy = "Magma Admiral",
            LowestLevel = 350,
        },
    },
    FishmanQuest = {
        [3] = {
            Enemy = "Fishman Lord",
            LowestLevel = 425,
        },
    },
    SkyExp1Quest = {
        [3] = {
            Enemy = "Wysper",
            Count = 1,
            LowestLevel = 500,
        },
    },
    SkyExp2Quest = {
        [3] = {
            Enemy = "Thunder God",
            LowestLevel = 575,
        },
    },
    FountainQuest = {
        [3] = {
            Enemy = "Cyborg",
            LowestLevel = 675,
        },
    },
    Area1Quest = {
        [3] = {
            Enemy = "Diamond",
            LowestLevel = 750,
        },
    },
    Area2Quest = {
        [3] = {
            Enemy = "Jeremy",
            LowestLevel = 850
        },
    },
    MarineQuest3 = {
        [3] = {
            Enemy = "Fajita",
            LowestLevel = 925
        },
    },
    IceSideQuest = {
        [3] =  {
            Enemy = "Smoke Admiral",
            LowestLevel = 1150,
        },
    },
    FrostQuest = {
        [3] = {
            Enemy = "Awakened Ice Admiral",
            LowestLevel = 1400,
        },
    },
    ForgottenQuest = {
        [3] = {
            Enemy = "Tide Keeper",
            LowestLevel = 1475
        },
    },
    PiratePortQuest = {
        [3] = {
            Enemy = "Stone",
            LowestLevel = 1550,
        },
    },
    AmazonQuest2 = {
        [3] = {
            Enemy = "Island Empress",
            LowestLevel = 1675
        },
    },
    MarineTreeIsland = {
        [3] = {
            Enemy = "Kilo Admiral",
            LowestLevel = 1750,
        },
    },
    DeepForestIsland = {
        [3] = {
            Enemy = "Captain Elephant",
            LowestLevel = 1875,
        },
    },
    DeepForestIsland2 = {
        [3] = {
            Enemy = "Beautiful Pirate",
            LowestLevel = 1950,
        },
    },
    IceCreamIslandQuest = {
        {
            Enemy = "Cake Queen",
            LowestLevel = 2175,
        },
    },
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function Data.requestQuest(value)
    if value == nil then return end

    for i,v in pairs(Data.Quests) do
        for i2, v2 in next, (v) do
            if (value >= v2.LowestLevel and v2.MaxLevel > value) then
                getgenv().Setting.Farm.MobName = v2.Enemy
                return i, i2, v2.LowestLevel, v2.Count
            end
        end
    end

    getgenv().Setting.Farm.MobName = nil
    return false, false, false, false
end

function Data.requestBoss(value, check)
    if value == nil then return end

    if type(value) == "string" then
        for i,v in pairs(Data.Bosses) do
            for i2, v2 in next, (v) do
                if v2.Enemy == value or (string.find(value, v2.Enemy) or string.match(value, v2.Enemy)) or (string.find(v2.Enemy, value) or string.match(v2.Enemy, value)) then
                    if type(check) == "boolean" and check == true then
                        if LocalPlayer:WaitForChild("Data", 5):WaitForChild("Level", 5).Value >= v2.LowestLevel then
                            getgenv().Setting.Farm.MobName = v2.Enemy
                            return i, i2, v2.LowestLevel, 1
                        end
                    else
                        getgenv().Setting.Farm.MobName = v2.Enemy
                        return i, i2, v2.LowestLevel, 1
                    end
                end
            end
        end
    elseif type(value) == "number" then
        for i,v in pairs(Data.Bosses) do
            for i2, v2 in next, (v) do
                if type(check) == "boolean" and check == true then
                    if value >= v2.LowestLevel then
                        getgenv().Setting.Farm.MobName = v2.Enemy
                        return i, i2, v2.LowestLevel, 1
                    end
                else
                    if value == v2.LowestLevel then
                        getgenv().Setting.Farm.MobName = v2.Enemy
                        return i, i2, v2.LowestLevel, 1
                    end
                end
            end
        end
        return false
    end

    getgenv().Setting.Farm.MobName = nil
    return false, false, false, 1
end

return Data
