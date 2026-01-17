local core = game:GetService("StarterGui")
local run = game:GetService("RunService")
local cam = workspace.CurrentCamera
local meta = getrawmetatable(game)
local old = meta.__index

core:SetCore("SendNotification", {
    Title = "No camera shake script",
    Text = "By Cap(CapLonerPo)",
    Duration = 4
})

setreadonly(meta, false)

meta.__index = newcclosure(function(obj, key)
    if key == "CamShakeCF" and obj == _G then
        return CFrame.new()
    end
    
    if key == "CameraOffset" and obj:IsA("Humanoid") then
        return Vector3.new(0, 0, 0)
    end

    return old(obj, key)
end)

setreadonly(meta, true)

run.Heartbeat:Connect(function()
    rawset(_G, "CamShakeCF", CFrame.new())
end)
