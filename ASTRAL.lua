--========================================================--
--                   A S T R A L  (Reboot)
--            Clean GUI Bootstrap – v0.1
--========================================================--

local ASTRAL = {}
ASTRAL.UI = {}
ASTRAL.Tabs = {}

--========================================================--
-- Load Rayfield
--========================================================--

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

ASTRAL.UI.Window = Rayfield:CreateWindow({
    Name = "ASTRAL Hub",
    Icon = 116531676650470,
    LoadingTitle = "ASTRAL Framework",
    LoadingSubtitle = "Rebooting UI...",
    Theme = "Default",
    DisableRayfieldPrompts = true,
})

--========================================================--
-- Create Tabs
--========================================================--

local Tabs = {}

Tabs.Main      = ASTRAL.UI.Window:CreateTab("Main", "home")
Tabs.Pets      = ASTRAL.UI.Window:CreateTab("Pets", "paw-print")
Tabs.Inventory = ASTRAL.UI.Window:CreateTab("Inventory", "box")
Tabs.Extras    = ASTRAL.UI.Window:CreateTab("Extras", "settings")
Tabs.Debug     = ASTRAL.UI.Window:CreateTab("Debug", "terminal")

ASTRAL.Tabs = Tabs

--========================================================--
-- MAIN TAB
--========================================================--

Tabs.Main:CreateSection("Welcome")
Tabs.Main:CreateLabel("ASTRAL Reboot Edition – GUI Online")

Tabs.Main:CreateButton({
    Name = "Reload ASTRAL",
    Callback = function()
        Rayfield:Notify({
            Title = "Reloading",
            Content = "Restarting ASTRAL...",
            Duration = 2
        })
        -- loadstring(game:HttpGet("YOUR_REPO/ASTRAL.lua"))()
    end
})

--========================================================--
-- PETS TAB (UI ONLY – no logic yet)
--========================================================--

Tabs.Pets:CreateSection("Pet Tools")

local PetDropdown = Tabs.Pets:CreateDropdown({
    Name = "Select Pet",
    Options = {"Loading..."},
    CurrentOption = {"Loading..."},
    MultipleOptions = false,
    Callback = function(option)
        print("Selected:", option[1])
    end
})

Tabs.Pets:CreateButton({
    Name = "Refresh Pet List",
    Callback = function()
        Rayfield:Notify({
            Title = "Pets",
            Content = "Backend not wired yet",
            Duration = 2
        })
    end
})

--========================================================--
-- INVENTORY TAB (UI ONLY)
--========================================================--

Tabs.Inventory:CreateSection("Inventory Viewer")

Tabs.Inventory:CreateButton({
    Name = "Refresh Inventory",
    Callback = function()
        Rayfield:Notify({
            Title = "Inventory",
            Content = "Backend not wired yet",
            Duration = 2
        })
    end
})

--========================================================--
-- EXTRAS TAB
--========================================================--

Tabs.Extras:CreateSection("Extra Tools")

Tabs.Extras:CreateToggle({
    Name = "Example Toggle",
    CurrentValue = false,
    Callback = function(v)
        print("Toggle:", v)
    end
})

--========================================================--
-- DEBUG TAB
--========================================================--

Tabs.Debug:CreateSection("Debug Tools")

Tabs.Debug:CreateButton({
    Name = "Print ASTRAL Table",
    Callback = function()
        print(ASTRAL)
    end
})

print("ASTRAL GUI Loaded (Reboot Edition)")
return ASTRAL
