local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

local TSB_Logic = {
    Enabled = false,
    Mode = "Blatant", 
    AltMode = false,
    Role = "None",
    TargetAlts = {},
    VoidPos = Vector3.new(-294.6696472167969, 346.9127502441406, -267.44158935546875)
}

local Theme = {
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar = Color3.fromRGB(18, 18, 20),
    Accent = Color3.fromRGB(255, 60, 90),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 170),
    Item = Color3.fromRGB(28, 28, 32)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TSB_Modern_V4"
ScreenGui.DisplayOrder = 100
ScreenGui.ResetOnSpawn = false
if getgenv and getgenv().protect_gui then
    getgenv().protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
end

local Blur = Instance.new("BlurEffect")
Blur.Name = "UI_Blur"
Blur.Size = 0
Blur.Parent = Lighting

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.Size = UDim2.fromOffset(520, 340)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Theme.Background
Main.BackgroundTransparency = 0.15
Main.ClipsDescendants = true
Main.Visible = false
Main.ZIndex = 5

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Theme.Accent
MainStroke.Transparency = 0.5
MainStroke.Thickness = 2

local Shadow = Instance.new("ImageLabel", Main)
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Image = "rbxassetid://6015667343"
Shadow.ImageColor3 = Color3.new(0,0,0)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = 4

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main
Sidebar.Size = UDim2.new(0, 170, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BackgroundTransparency = 0.1
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 6

local SideCorner = Instance.new("UICorner", Sidebar)
SideCorner.CornerRadius = UDim.new(0, 14)

local SideFix = Instance.new("Frame", Sidebar)
SideFix.Size = UDim2.new(0, 20, 1, 0)
SideFix.Position = UDim2.new(1, -20, 0, 0)
SideFix.BackgroundColor3 = Theme.Sidebar
SideFix.BorderSizePixel = 0
SideFix.ZIndex = 6

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "Auto Kill Farm"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Theme.Text
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 7

local Author = Instance.new("TextLabel", Sidebar)
Author.Size = UDim2.new(1, -20, 0, 20)
Author.Position = UDim2.new(0, 15, 0, 40)
Author.BackgroundTransparency = 1
Author.Text = "By Cap(CapLonerPo)"
Author.Font = Enum.Font.GothamMedium
Author.TextSize = 11
Author.TextColor3 = Theme.SubText
Author.TextXAlignment = Enum.TextXAlignment.Left
Author.ZIndex = 7
local Pills = Instance.new("Frame", ScreenGui)
Pills.Name = "PillButton"
Pills.Size = UDim2.fromOffset(130, 35)
Pills.Position = UDim2.new(0.5, 0, 0.05, 0)
Pills.AnchorPoint = Vector2.new(0.5, 0)
Pills.ClipsDescendants = true
Pills.BackgroundColor3 = Theme.Background
Pills.BackgroundTransparency = 0.2
Pills.ZIndex = 100

local PillCorner = Instance.new("UICorner", Pills)
PillCorner.CornerRadius = UDim.new(1, 0)

local PillStroke = Instance.new("UIStroke", Pills)
PillStroke.Color = Theme.Accent
PillStroke.Thickness = 2
PillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local PillBtn = Instance.new("TextButton", Pills)
PillBtn.Size = UDim2.new(1, 0, 1, 0)
PillBtn.BackgroundTransparency = 1 
PillBtn.Text = "Cap Kill Farm"
PillBtn.Font = Enum.Font.GothamBold
PillBtn.TextColor3 = Color3.new(1, 1, 1)
PillBtn.TextSize = 11
PillBtn.TextXAlignment = Enum.TextXAlignment.Right
PillBtn.ZIndex = 110

local PillPad = Instance.new("UIPadding", PillBtn)
PillPad.PaddingRight = UDim.new(0, 12)

local PillIcon = Instance.new("ImageLabel", Pills)
PillIcon.Size = UDim2.fromOffset(20, 20)            
PillIcon.Position = UDim2.new(0, 10, 0.5, 0)        
PillIcon.AnchorPoint = Vector2.new(0, 0.5)          
PillIcon.BackgroundTransparency = 1                 
PillIcon.Image = "rbxassetid://108666840619787"      
PillIcon.ImageColor3 = Color3.new(1, 1, 1)                    
PillIcon.ZIndex = 115
                                
local function ToggleMenu(state)
    local info = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    if state then
        -- Setup initial state before opening
        Main.Size = UDim2.fromOffset(480, 300) -- Start slightly smaller for a "pop-in" feel
        Main.BackgroundTransparency = 1
        Main.Visible = true
        Pills.Visible = false
        
        -- Modern Parallel Tween (Blur + Transparency + Size)
        TweenService:Create(Blur, info, {Size = 20}):Play()
        TweenService:Create(Main, info, {
            Size = UDim2.fromOffset(520, 340), 
            BackgroundTransparency = 0.15
        }):Play()
    else
        -- Close animation
        TweenService:Create(Blur, info, {Size = 0}):Play()
        local closeTween = TweenService:Create(Main, info, {
            Size = UDim2.fromOffset(480, 300), 
            BackgroundTransparency = 1
        })
        
        closeTween:Play()
        closeTween.Completed:Connect(function()
            Main.Visible = false
            Pills.Visible = true
        end)
    end
end

PillBtn.MouseEnter:Connect(function()
    TweenService:Create(PillIcon, TweenInfo.new(0.15), {ImageColor3 = Theme.Accent}):Play()
end)

PillBtn.MouseLeave:Connect(function()
    TweenService:Create(PillIcon, TweenInfo.new(0.15), {ImageColor3 = Theme.Text}):Play()
end)

PillBtn.MouseButton1Click:Connect(function() ToggleMenu(true) end)

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.fromOffset(30, 30)
MinBtn.Position = UDim2.new(1, -40, 0, 10)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "×"
MinBtn.TextColor3 = Theme.Accent
MinBtn.TextSize = 28
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 10

MinBtn.MouseButton1Click:Connect(function() ToggleMenu(false) end)

local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -100)
TabContainer.Position = UDim2.new(0, 0, 0, 80)
TabContainer.BackgroundTransparency = 1
TabContainer.ZIndex = 7

local TabList = Instance.new("UIListLayout", TabContainer)
TabList.Padding = UDim.new(0, 6)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -190, 1, -20)
Content.Position = UDim2.new(0, 180, 0, 10)
Content.BackgroundTransparency = 1
Content.ZIndex = 6

local Pages = {}
local Tabs = {}

local function SwitchTab(name)
    for _, p in pairs(Pages) do p.Visible = false end
    Pages[name].Visible = true
    for _, t in pairs(Tabs) do
        TweenService:Create(t.L, TweenInfo.new(0.2), {TextColor3 = Theme.SubText}):Play()
    end
    TweenService:Create(Tabs[name].L, TweenInfo.new(0.2), {TextColor3 = Theme.Accent}):Play()
end

local function CreateTab(name)
    local B = Instance.new("TextButton", TabContainer)
    B.Size = UDim2.new(0.9, 0, 0, 35)
    B.BackgroundColor3 = Theme.Item
    B.BackgroundTransparency = 0.8
    B.Text = ""
    B.ZIndex = 8
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
    
    local L = Instance.new("TextLabel", B)
    L.Size = UDim2.new(1, 0, 1, 0)
    L.BackgroundTransparency = 1
    L.Text = name
    L.Font = Enum.Font.GothamMedium
    L.TextSize = 13
    L.TextColor3 = Theme.SubText
    L.ZIndex = 9
    
    local P = Instance.new("ScrollingFrame", Content)
    P.Size = UDim2.new(1, 0, 1, 0)
    P.BackgroundTransparency = 1
    P.ScrollBarThickness = 0
    P.Visible = false
    
    local PL = Instance.new("UIListLayout", P)
    PL.Padding = UDim.new(0, 8)
    
    Tabs[name] = {B = B, L = L}
    Pages[name] = P
    
    B.MouseButton1Click:Connect(function() SwitchTab(name) end)
    return P
end

local function CreateToggle(parent, text, callback)
    local F = Instance.new("Frame", parent)
    F.Size = UDim2.new(1, -10, 0, 42)
    F.BackgroundColor3 = Theme.Item
    F.ZIndex = 8
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
    
    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.new(1, -50, 1, 0)
    L.Position = UDim2.new(0, 12, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = text
    L.Font = Enum.Font.Gotham
    L.TextColor3 = Theme.Text
    L.TextSize = 12
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.ZIndex = 9
    
    local T = Instance.new("TextButton", F)
    T.Size = UDim2.new(0, 34, 0, 18)
    T.Position = UDim2.new(1, -12, 0.5, 0)
    T.AnchorPoint = Vector2.new(1, 0.5)
    T.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    T.Text = ""
    T.ZIndex = 9
    Instance.new("UICorner", T).CornerRadius = UDim.new(1, 0)
    
    local C = Instance.new("Frame", T)
    C.Size = UDim2.new(0, 14, 0, 14)
    C.Position = UDim2.new(0, 2, 0.5, 0)
    C.AnchorPoint = Vector2.new(0, 0.5)
    C.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    C.ZIndex = 10
    Instance.new("UICorner", C).CornerRadius = UDim.new(1, 0)
    
    local active = false
    T.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(T, TweenInfo.new(0.2), {BackgroundColor3 = active and Theme.Accent or Color3.fromRGB(45, 45, 50)}):Play()
        TweenService:Create(C, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}):Play()
        callback(active)
    end)
end

local function CreateDropdown(parent, text, list, callback)
    local F = Instance.new("Frame", parent)
    F.Size = UDim2.new(1, -10, 0, 42)
    F.BackgroundColor3 = Theme.Item
    F.ClipsDescendants = true
    F.ZIndex = 8
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
    
    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.new(1, 0, 0, 42)
    L.Position = UDim2.new(0, 12, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = text
    L.Font = Enum.Font.Gotham
    L.TextColor3 = Theme.Text
    L.TextSize = 12
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.ZIndex = 9
    
    local D = Instance.new("TextButton", F)
    D.Size = UDim2.new(0, 100, 0, 24)
    D.Position = UDim2.new(1, -12, 0, 9)
    D.AnchorPoint = Vector2.new(1, 0)
    D.BackgroundColor3 = Theme.Background
    D.Text = "Select"
    D.TextColor3 = Theme.SubText
    D.TextSize = 11
    D.Font = Enum.Font.Gotham
    D.ZIndex = 9
    Instance.new("UICorner", D).CornerRadius = UDim.new(0, 6)
    
    local Container = Instance.new("Frame", F)
    Container.Size = UDim2.new(1, -20, 0, 0)
    Container.Position = UDim2.new(0, 10, 0, 45)
    Container.BackgroundTransparency = 1
    
    local CL = Instance.new("UIListLayout", Container)
    CL.Padding = UDim.new(0, 4)
    
    local open = false
    local function Rebuild(items)
        for _,v in pairs(Container:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for _,i in ipairs(items) do
            local I = Instance.new("TextButton", Container)
            I.Size = UDim2.new(1, 0, 0, 28)
            I.BackgroundColor3 = Theme.Background
            I.Text = i
            I.TextColor3 = Theme.SubText
            I.TextSize = 11
            I.Font = Enum.Font.Gotham
            I.ZIndex = 10
            Instance.new("UICorner", I).CornerRadius = UDim.new(0, 6)
            I.MouseButton1Click:Connect(function()
                D.Text = i
                open = false
                TweenService:Create(F, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 42)}):Play()
                callback(i)
            end)
        end
    end
    Rebuild(list)
    
    D.MouseButton1Click:Connect(function()
        open = not open
        TweenService:Create(F, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, open and (42 + (#list * 32) + 10) or 42)}):Play()
    end)
    
    return {
        Update = Rebuild,
        SetVisible = function(v) F.Visible = v end
    }
end

local Dragging, DragInput, DragStart, StartPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then Dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - DragStart
        Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)
local PillDragging, PillDragStart, PillStartPos

PillBtn.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        PillDragging = true
        PillDragStart = input.Position
        PillStartPos = Pills.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                PillDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if PillDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - PillDragStart
        Pills.Position = UDim2.new(
            PillStartPos.X.Scale,
            PillStartPos.X.Offset + delta.X,
            PillStartPos.Y.Scale,
            PillStartPos.Y.Offset + delta.Y
        )
    end
end)

local FarmPage = CreateTab("Farm Kills <:")
local ConfigPage = CreateTab("Settings")

CreateToggle(FarmPage, "Kill Farm On Players(Blatant)", function(v)
    TSB_Logic.Enabled = v
end)

local AltD, RoleD
CreateToggle(FarmPage, "Farm On Alt Account", function(v)
    TSB_Logic.AltMode = v
    if RoleD then RoleD.SetVisible(v) end
end)

RoleD = CreateDropdown(FarmPage, "Choose your role", {"Victim", "The Farmer"}, function(v)
    TSB_Logic.Role = v
    if AltD then AltD.SetVisible(v == "The Farmer") end
end)
RoleD.SetVisible(false)

AltD = CreateDropdown(FarmPage, "Select Alt Account", {}, function(v)
    table.insert(TSB_Logic.TargetAlts, v)
end)
AltD.SetVisible(false)

CreateToggle(FarmPage, "Fly method(inconsistent)", function(v)
    TSB_Logic.FlyMethod = v
end)

local function GetBox()
    local b = workspace:FindFirstChild("FarmBox")
    if not b then
        b = Instance.new("Model")
        b.Name = "FarmBox"
        b.Parent = workspace

        local size = Vector3.new(30, 60, 30)
        local thickness = 1
        local center = TSB_Logic.VoidPos - Vector3.new(0, 10, 0)

        local function wall(sz, pos)
            local p = Instance.new("Part")
            p.Size = sz
            p.Position = pos
            p.Anchored = true
            p.CanCollide = true
            p.Material = Enum.Material.Glass
            p.Transparency = 0.6
            p.Color = Theme.Accent
            p.Parent = b
        end

        wall(Vector3.new(size.X, thickness, size.Z), center - Vector3.new(0, size.Y/2, 0))
        wall(Vector3.new(size.X, size.Y, thickness), center + Vector3.new(0, 0, size.Z/2))
        wall(Vector3.new(size.X, size.Y, thickness), center - Vector3.new(0, 0, size.Z/2))
        wall(Vector3.new(thickness, size.Y, size.Z), center + Vector3.new(size.X/2, 0, 0))
        wall(Vector3.new(thickness, size.Y, size.Z), center - Vector3.new(size.X/2, 0, 0))
    end
    return b
end
RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local Root = Character.HumanoidRootPart
    [span_0](start_span)local Comm = Character:FindFirstChild("Communicate") -- The RemoteEvent used for attacks[span_0](end_span)

    -[span_1](start_span)- Helper to find the combat tool (required for moves)[span_1](end_span)
    local function GetTool()
        return Character:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
    end

    if TSB_Logic.Enabled then
        local t, d = nil, math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                local m = (Root.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if m < d then d = m; t = p.Character end
            end
        end
        
        if t and Comm then
            -- Teleport behind the target
            Root.CFrame = t.HumanoidRootPart.CFrame * CFrame.new(0,0,2.5)
            
            -[span_2](start_span)- Fire Remote for M1 (Spam)[span_2](end_span)
            Comm:FireServer({["Goal"] = "LeftClick", ["Mobile"] = true})
            
            -[span_3](start_span)- Randomly use a Move (Console Move)[span_3](end_span)
            if math.random(1, 100) > 92 then -- Adjustable chance for using skills
                local tool = GetTool()
                if tool then
                    Comm:FireServer({["Tool"] = tool, ["Goal"] = "Console Move"})
                end
            end
            
            -[span_4](start_span)- Release M1 quickly to register the hit[span_4](end_span)
            task.delay(0.05, function()
                if Comm then 
                    Comm:FireServer({["Goal"] = "LeftClickRelease", ["Mobile"] = true})
                end
            end)
        end
    end
    
    if TSB_Logic.AltMode then
        GetBox()
        -- Noclip inside box
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
        
        if TSB_Logic.Role == "Victim" then
            Root.CFrame = CFrame.new(TSB_Logic.VoidPos)
            Root.Velocity = Vector3.zero
        elseif TSB_Logic.Role == "The Farmer" then
            for _, a in pairs(TSB_Logic.TargetAlts) do
                local n = a:match("%((.+)%)") or a
                local p = Players:FindFirstChild(n)
                if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and Comm then
                    Root.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2.5)
                    
                    -- Attack the alt using Remotes
                    Comm:FireServer({["Goal"] = "LeftClick", ["Mobile"] = true})
                    task.delay(0.05, function()
                        if Comm then 
                            Comm:FireServer({["Goal"] = "LeftClickRelease", ["Mobile"] = true}) 
                        end
                    end)
                end
            end
        end
    end
end)


task.spawn(function()
    while task.wait(4) do
        local l = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(l, p.DisplayName.."("..p.Name..")") end
        end
        if AltD then AltD.Update(l) end
    end
end)

SwitchTab("Farm Kills <:")
