local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/CapLonerPoalt/I-wanna-pee/refs/heads/main/Windui-because-ummm.lua"))()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

local Mode = "Keybind"
local Keybind = Enum.KeyCode.Space
local Fired = false

local function SuperJump()
    if Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then return end

    local right = Camera.CFrame.RightVector.X
    local moveKey = right > 0 and Enum.KeyCode.D or Enum.KeyCode.A

    VIM:SendKeyEvent(true, moveKey, false, game)
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)

    task.wait(0.015)

    VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    VIM:SendKeyEvent(false, moveKey, false, game)
end

UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if Mode == "Keybind" and i.KeyCode == Keybind then
        SuperJump()
    end
end)

RunService.Heartbeat:Connect(function()
    if Mode ~= "Auto" then
        Fired = false
        return
    end

    if Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
        if not Fired then
            Fired = true
            task.wait(0.03)
            SuperJump()
        end
    else
        Fired = false
    end
end)

local Window = WindUI:CreateWindow({
    Title = "auto super jump :)",
    Author = "By CapLonerPo",
    Folder = "TSB-AutoSuperJump",
    Size = UDim2.fromOffset(320,240),
    Theme = "Dark"
})

local Tab = Window:Tab({
    Title = "Main",
    Icon = "rocket"
})

local KeyDropdown

Tab:Dropdown({
    Title = "Activation Mode",
    Values = {"Keybind","Auto","Mobile"},
    Default = "Keybind",
    Callback = function(v)
        Mode = v
        if KeyDropdown then
            KeyDropdown:SetVisible(v == "Keybind")
        end
    end
})

KeyDropdown = Tab:Dropdown({
    Title = "Keybind",
    Values = {"Space","E","F"},
    Default = "Space",
    Callback = function(v)
        Keybind = Enum.KeyCode[v]
    end
})

local Gui = Instance.new("ScreenGui")
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Button = Instance.new("TextButton")
Button.Size = UDim2.fromOffset(70,70)
Button.Position = UDim2.fromScale(0.8,0.6)
Button.BackgroundColor3 = Color3.fromRGB(200,0,0)
Button.Text = ""
Button.Visible = false
Button.Parent = Gui

Instance.new("UICorner",Button).CornerRadius = UDim.new(0.25,0)

local Dragging,DragStart,StartPos

Button.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = i.Position
        StartPos = Button.Position
        SuperJump()
    end
end)

Button.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

UIS.InputChanged:Connect(function(i)
    if Dragging and i.UserInputType == Enum.UserInputType.Touch then
        local d = i.Position - DragStart
        Button.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + d.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + d.Y
        )
    end
end)

RunService.RenderStepped:Connect(function()
    Button.Visible = Mode == "Mobile" and UIS.TouchEnabled
end)

Player.CharacterAdded:Connect(function(c)
    Character = c
    Humanoid = c:WaitForChild("Humanoid")
end)
