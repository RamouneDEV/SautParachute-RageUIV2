buyParachuteCoolDown =  false
OpenMenu = false
local sautParachute = RageUI.CreateMenu("Saut en parachute", "MENU", 0, 0, nil, nil, 0, 0, 0, 255)

sautParachute.Closed = function()
    OpenMenu = false
end

function ParachuteSaut()
    sautParachute:SetStyleSize(50)
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(sautParachute, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(sautParachute, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                RageUI.IsVisible(sautParachute, function()

                        RageUI.Button("Prendre un parachute", nil, {RightLabel = "~g~"..Config.Price.."$~s~ →→→"}, true, {
                            onSelected = function()
                                if buyParachuteCoolDown == false then
                                    TriggerServerEvent("Ramoune:parachutebuy", Config.Price)
                                    buyParachuteCoolDown = true
                                    Wait(Config.Cooldown)
                                    buyParachuteCoolDown = false
                                else
                                    ESX.ShowNotification("~r~Vous devez attendre "..Config.Cooldown.." secondes avant de racheter un parachute")
                                end
                            end
                        })
                end)
            end
        end)
    end
end



CreateThread(function()
    for k,v in pairs(Config.PositionActivite) do 

        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, Config.BlipSprite)
        SetBlipScale(blip, Config.BlipScale)
        SetBlipColour(blip, Config.BlipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipName)
        EndTextCommandSetBlipName(blip)

    end
    while true do
        timer = 750
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.PositionActivite) do
            local distance = #(playerCoords - vector3(v.x, v.y, v.z))
            if distance < Config.drawDistance then
                timer = 0
                if distance < Config.itrDistance then
                    DrawMarker(25, v.x - 0.5, v.y, v.z - 0.95, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0)
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu")
                    if IsControlJustPressed(0, 51) then
                        ParachuteSaut()
                    end
                end
            elseif distance > 5.0 and distance < 15.0 then
                timer = 750
            end
        end
        Wait(timer)
    end
end)