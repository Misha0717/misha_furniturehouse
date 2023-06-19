InMovingObject = false
CachedData = {
    Peds = {}
}

test

AddEventHandler("onResourceStop", function(res)
    if res ~= GetCurrentResourceName() then
        return
    end

    for k,v in pairs(CachedData) do
        if k == "Peds" then
            for k,v in pairs(CachedData.Peds) do
                if DoesEntityExist(k) then
                    DeletePed(k)
                end
            end
        end
    end
end)

AddEventHandler("onResourceStart", function(res)
    if res ~= GetCurrentResourceName() then
        return
    end

    if not IsEntityVisible(PlayerPedId()) then
        SetEntityVisible(PlayerPedId(), true)
    end

    for k,v in pairs(Config.Market) do
        for i=1, #Config.Market[k]["Positions"] do
            if #(GetEntityCoords(PlayerPedId()) - Config.Market[k]["Positions"][i].coords) < 30 then
                StartMarketThread(true, k)
            end
        end
    end
end)