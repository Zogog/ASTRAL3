--========================================================--
--                 ASTRAL.Modules.Main
--            Advanced Session Overview (v3)
--========================================================--

local Main = {}
local startTime = tick()

--========================================================--
--                 INTERNAL HELPERS
--========================================================--

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02dh %02dm %02ds", h, m, s)
end

local function safeGet(fn, fallback)
    local ok, result = pcall(fn)
    return ok and result or fallback
end

--========================================================--
--                 INIT FUNCTION
--========================================================--

function Main.Init(Tabs, Core, UI)
    local Adopt = Core.AdoptMeAPI
    local Pets  = Core.Pets

    local tab = Tabs.Main
    tab:CreateSection("Session Overview")

    --------------------------------------------------------
    -- LIVE LABELS
    --------------------------------------------------------

    local lblStatus      = tab:CreateLabel("Status: Loading…")
    local lblMoney       = tab:CreateLabel("Money: Loading…")
    local lblTeam        = tab:CreateLabel("Team: Loading…")
    local lblInterior    = tab:CreateLabel("Interior: Loading…")
    local lblPet         = tab:CreateLabel("Active Pet: Loading…")
    local lblRuntime     = tab:CreateLabel("Runtime: 00h 00m 00s")
    local lblSessionBux  = tab:CreateLabel("Session Bucks: 0")
    local lblSessionAged = tab:CreateLabel("Pets Aged: 0")

    --------------------------------------------------------
    -- SESSION TRACKING
    --------------------------------------------------------

    local startMoney = safeGet(function()
        return Adopt.GetPlayerMoney()
    end, 0)

    local lastPetAge = 0
    local sessionAged = 0

    --------------------------------------------------------
    -- LIVE UPDATE LOOP
    --------------------------------------------------------

    task.spawn(function()
        while task.wait(1) do
            -- Status
            lblStatus:Set("Status: Connected")

            -- Money
            local money = safeGet(function()
                return Adopt.GetPlayerMoney()
            end, 0)
            lblMoney:Set("Money: " .. money)

            -- Team
            local team = safeGet(function()
                return game.Players.LocalPlayer.Team.Name
            end, "Unknown")
            lblTeam:Set("Team: " .. team)

            -- Interior
            local interior = safeGet(function()
                return Adopt.GetPlayerInterior() or "MainMap"
            end, "Unknown")
            lblInterior:Set("Interior: " .. interior)

            -- Active Pet
            local equipped = safeGet(function()
                return Adopt.GetPlayersEquippedPets()
            end, {})

            local petText = "None Equipped"

            for _, pet in pairs(equipped) do
                local cfg = Adopt.GetPlayersPetConfigs(pet.unique)
                petText = string.format(
                    "%s (Age %d)",
                    cfg.petKind or "Unknown",
                    cfg.petAge or 0
                )

                -- Track pet aging
                if cfg.petAge > lastPetAge then
                    sessionAged += (cfg.petAge - lastPetAge)
                end
                lastPetAge = cfg.petAge
            end

            lblPet:Set("Active Pet: " .. petText)

            -- Runtime
            local runtime = tick() - startTime
            lblRuntime:Set("Runtime: " .. formatTime(runtime))

            -- Session Bucks
            lblSessionBux:Set("Session Bucks: " .. (money - startMoney))

            -- Pets aged
            lblSessionAged:Set("Pets Aged: " .. sessionAged)
        end
    end)

    --------------------------------------------------------
    -- VERSION + SAFEMODE
    --------------------------------------------------------

    tab:CreateSection("System Info")
    tab:CreateLabel("ASTRAL Version: v3.0 (Reboot)")
    tab:CreateLabel("SafeMode: Enabled")
end

return Main
