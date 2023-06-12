--
-- Making NPC'S
--

Citizen.CreateThread(function()
    for k,v in pairs(Config.Sell) do
        LoadModel(v.Model)

        ped = CreatePed(4, v.Model, v.Coords.x, v.Coords.y, v.Coords.z, v.Heading, true, false)

        CachedData.Peds[ped] = true
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

--
-- Thread Loops
--

-- seller thread
Citizen.CreateThread(function()
    DoScreenFadeIn(500)
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for k,v in pairs(Config.Sell) do
            local dist = #(coords - v.Coords)

            if dist < 2.0 then
                sleep = 0

                if IsControlJustPressed(0, 38) then
                    OpenSellerMenu()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- marker thread
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local teleportcoords

        for k,v in pairs(Config.Market) do
            for k2,v2 in pairs(Config.Market[k]) do
                if type(v2) ~= "table" then
                    local dist = #(coords - v2)
                    local closeToLeaveCoords = (#(coords - Config.Market[k]["LeaveCoords"]) < 2)
                    local closeToEnterCoords = (#(coords - Config.Market[k]["EnterCoords"]) < 2)

                    if dist < 2 then
                        sleep = 0

                        DrawMarker(2, v2, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 0, 0, 200, true, true, false, true)

                        if IsControlJustPressed(0, 38) then
                            if closeToLeaveCoords then
                                teleportcoords = Config.Market[k]["EnterCoords"]
                            else
                                teleportcoords = Config.Market[k]["LeaveCoords"]
                                StartMarketThread(k)
                            end

                            DoTeleport(teleportcoords)
                        end
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

local MarkerThreadRunning = false
function StartMarketThread(bool, store)
    if MarkerThreadRunning then
        return
    end

    while bool do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for i=1, #Config.Market[store]["Positions"] do
            local MarkerCoords = Config.Market[store]["Positions"][i].coords
            local dist = #(coords - MarkerCoords)

            if dist < 5.0 then
                sleep = 0

                DrawMarker(2, MarkerCoords, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 0, 0, 200, true, true, false, true)

                if dist < 1.5 then
                    local text

                    if InMovingObject then
                        text = "Press ~g~   ~INPUT_REPLAY_BACK~ ~w~ to scroll trough the furnitures"
                    else
                        text = "Press ~g~E~w~ to see the furnitures"
                    end
                    Draw3DText(MarkerCoords, text, 0.5)
                    if IsControlJustPressed(0, 38) then
                        SetInObj(MarkerCoords)
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end