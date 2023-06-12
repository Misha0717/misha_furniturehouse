CachedData = {
    Peds = {}
}

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