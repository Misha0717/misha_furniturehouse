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