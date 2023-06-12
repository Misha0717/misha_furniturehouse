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

Citizen.CreateThread(function()
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