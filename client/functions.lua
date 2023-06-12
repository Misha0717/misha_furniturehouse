function LoadModel(model)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(500)
    end
end

--
-- Menu's
--

function OpenSellerMenu()

end

--
-- functions
--

function DoTeleport(coords)
    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(10)
    end

    Wait(500)
    SetEntityCoords(PlayerPedId(), coords)
    DoScreenFadeIn(1000)
end

--
-- UI
--

function Draw3DText(coords, text, size)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

--
-- obj stuff
--

function SetInObj(ObjCoords)
    InMovingObject = true
    SetEntityVisible(PlayerPedId(), false)
    local obj = CreateObject("apa_mp_h_din_chair_08", ObjCoords.x, ObjCoords.y, ObjCoords.z - 1.0, false, true)
    local objCoords = GetEntityCoords(obj)
    local coords = GetOffsetFromEntityInWorldCoords(obj, 0.0, -2.0, 2.5)
    local pointCoords = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, 0.5)
    CurrentCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z - 0.8 , 0.0, 0.0, 0.0, 65.00, false, false)
    SetCamActive(CurrentCamera, true)
    PointCamAtCoord(CurrentCamera, pointCoords.x, pointCoords.y, pointCoords.z )
    RenderScriptCams(true, true, 2000, true, true)
end