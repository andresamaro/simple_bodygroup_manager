util.AddNetworkString("SBMOpenMenu")
util.AddNetworkString("SBMSaveBodygroups")


net.Receive("SBMSaveBodygroups", function(_, ply)
    local target = net.ReadPlayer()
    local tblBodygroups = net.ReadTable()
    local skin = net.ReadUInt(5)
    local playerColor = net.ReadVector()


    if (!target or !target:IsPlayer() or !target:GetCharacter()) then return end

    if (!ix.config.Get("SBM.AltAlgorithm", false)) then
        for id, val in ipairs(tblBodygroups) do
            target:SetBodygroup(id, val)
        end
        target:GetCharacter():SetData("groups", tblBodygroups)

    else
        for key, value in pairs(tblBodygroups) do
            local bgId = target:FindBodygroupByName(key)
            if (bgId == -1) then continue end

            target:SetBodygroup(bgId, value)
            target:GetCharacter():SetData("SBM.AltAlgorithm.Bodygroups", tblBodygroups)
        end
    end

    target:SetSkin(skin)
    target:SetPlayerColor(playerColor)

    target:GetCharacter():SetData("SBMPlayerColor", playerColor)

end)