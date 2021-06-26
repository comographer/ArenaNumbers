-- code for ArenaNumbers start
local U=UnitIsUnit

hooksecurefunc("CompactUnitFrame_UpdateName", function(F)
    if IsActiveBattlefieldArena() and F.unit:find("nameplate") then
        for i=1,5 do
            if U(F.unit,"arena"..i) then
                F.name:SetText(i)
                F.name:SetTextColor(1,1,0)
                break
            end 
        end 
    end 
end)
-- code for ArenaNumbers finish

-- code for Align start
SLASH_EA1 = "/align"

local f

SlashCmdList["EA"] = function()
	if f then
		f:Hide()
		f = nil		
	else
		f = CreateFrame('Frame', nil, UIParent) 
		f:SetAllPoints(UIParent)
		local w = GetScreenWidth() / 64
		local h = GetScreenHeight() / 36
		for i = 0, 64 do
			local t = f:CreateTexture(nil, 'BACKGROUND')
			if i == 32 then
				t:SetColorTexture(1, 1, 0, 0.5)
			else
				t:SetColorTexture(1, 1, 1, 0.15)
			end
			t:SetPoint('TOPLEFT', f, 'TOPLEFT', i * w - 1, 0)
			t:SetPoint('BOTTOMRIGHT', f, 'BOTTOMLEFT', i * w + 1, 0)
		end
		for i = 0, 36 do
			local t = f:CreateTexture(nil, 'BACKGROUND')
			if i == 18 then
				t:SetColorTexture(1, 1, 0, 0.5)
			else
				t:SetColorTexture(1, 1, 1, 0.15)
			end
			t:SetPoint('TOPLEFT', f, 'TOPLEFT', 0, -i * h + 1)
			t:SetPoint('BOTTOMRIGHT', f, 'TOPRIGHT', 0, -i * h - 1)
		end	
	end
end
-- code for Align finish

-- code for HideHotKeys start
local HideHotKeys_Frame = CreateFrame("Frame")

-- default enabled
if (HideHotKeys_HK_Hidden == nil) then
  HideHotKeys_HK_Hidden = true
end

-- default disabled
if (HideHotKeys_MN_Hidden == nil) then
  HideHotKeys_MN_Hidden = false
end


function HideHotKeys_EventHandler(self, event)
  if (event == "PLAYER_ENTERING_WORLD") then
    HideHotKeys_Update()
  end
end

-- the default ActionButton_UpdateHotkeys function will reget the first hotkey associated with a button
-- and show/hide if there is a bind or not, so we will rehide it if neccesary after the default function runs
function HideHotKeys_ActionButton_UpdateHotkeys(self, actionButtonType)
  local hkf = self.HotKey --_G[self:GetName().."HotKey"]
  
  if (hkf) then
    if (HideHotKeys_HK_Hidden and hkf:IsShown()) then
      hkf:Hide()
      
    elseif (not HideHotKeys_HK_Hidden and not hkf:IsShown()) then
      local action = self.action
      
      if action and HasAction(action) then
        -- only show hotkey if the default UI would
        local range = IsActionInRange(action)
        
        if hkf:GetText() ~= RANGE_INDICATOR or range or range == false then
          hkf:Show()
        end
      end
      
    end
  end
end


-- same with macro names, except i don't see any example of it actually being hidden/shown in the default UI
-- the macro name frame only has its text property changed to a space to "hide" it, but we will do this anyway
function HideHotKeys_ActionButton_Update(self)
  local mnf = self.Name --_G[self:GetName().."Name"]
  
  if (mnf) then
    if (HideHotKeys_MN_Hidden and mnf:IsShown()) then
      mnf:Hide()
    elseif (not HideHotKeys_MN_Hidden and not mnf:IsShown()) then
      mnf:Show()
    end
  end
end


--rehides if they should be hidden, called whenever the UI reshows them
function HideHotKeys_Update()
    if (HideHotKeys_HK_Hidden) then
      HideHotKeys_HK_HideAll()
    else
      HideHotKeys_HK_ShowAll()
    end
    if (HideHotKeys_MN_Hidden) then
      HideHotKeys_MN_HideAll()
    else
      HideHotKeys_MN_ShowAll()
    end
end


function HideHotKeys_HK_HideAll()
  HideHotKeys_HideBar("Action", "HotKey")
  HideHotKeys_HideBar("BonusAction", "HotKey")
  HideHotKeys_HideBar("PetAction", "HotKey")
  HideHotKeys_HideBar("MultiBarBottomLeft", "HotKey")
  HideHotKeys_HideBar("MultiBarBottomRight", "HotKey")
  HideHotKeys_HideBar("MultiBarRight", "HotKey")
  HideHotKeys_HideBar("MultiBarLeft", "HotKey")
  HideHotKeys_HK_Hidden = true
end


function HideHotKeys_HK_ShowAll()
  HideHotKeys_ShowBar("Action", "HotKey")
  HideHotKeys_ShowBar("BonusAction", "HotKey")
  HideHotKeys_ShowBar("PetAction", "HotKey")
  HideHotKeys_ShowBar("MultiBarBottomLeft", "HotKey")
  HideHotKeys_ShowBar("MultiBarBottomRight", "HotKey")
  HideHotKeys_ShowBar("MultiBarRight", "HotKey")
  HideHotKeys_ShowBar("MultiBarLeft", "HotKey")
  HideHotKeys_HK_Hidden = false
end


function HideHotKeys_HK_Slash()
  if (HideHotKeys_HK_Hidden) then
    HideHotKeys_HK_ShowAll()
  else
    HideHotKeys_HK_HideAll()
  end
end


function HideHotKeys_MN_HideAll()
  HideHotKeys_HideBar("Action", "Name")
  HideHotKeys_HideBar("BonusAction", "Name")
  HideHotKeys_HideBar("MultiBarBottomLeft", "Name")
  HideHotKeys_HideBar("MultiBarBottomRight", "Name")
  HideHotKeys_HideBar("MultiBarRight", "Name")
  HideHotKeys_HideBar("MultiBarLeft", "Name")
  HideHotKeys_MN_Hidden = true
end


function HideHotKeys_MN_ShowAll()
  HideHotKeys_ShowBar("Action", "Name")
  HideHotKeys_ShowBar("PetAction", "Name")
  HideHotKeys_ShowBar("BonusAction", "Name")
  HideHotKeys_ShowBar("MultiBarBottomLeft", "Name")
  HideHotKeys_ShowBar("MultiBarBottomRight", "Name")
  HideHotKeys_ShowBar("MultiBarRight", "Name")
  HideHotKeys_ShowBar("MultiBarLeft", "Name")
  HideHotKeys_MN_Hidden = false
end


function HideHotKeys_MN_Slash()
  if (HideHotKeys_MN_Hidden) then
    HideHotKeys_MN_ShowAll()
  else
    HideHotKeys_MN_HideAll()
  end
end


function HideHotKeys_HideBar(b, f)
  for i = 1, 12 do
    local o = _G[b.."Button"..i..f]
    if (o) then
      o:Hide()
    end
  end
end


function HideHotKeys_ShowBar(b, f)
  for i = 1, 12 do
    local o = _G[b.."Button"..i..f]
    if (o) then
      if f == "HotKey" then
        local action = _G[b.."Button"..i].action
        local range = IsActionInRange(action)
        if o:GetText() ~= RANGE_INDICATOR or range or range == false then
          o:Show()
        end
      else
        o:Show()
      end
    end
  end
end

HideHotKeys_Frame:SetScript("OnEvent", HideHotKeys_EventHandler)
HideHotKeys_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- register a hook for action button update functions
hooksecurefunc(ActionBarActionButtonMixin, "UpdateHotkeys", HideHotKeys_ActionButton_UpdateHotkeys)
hooksecurefunc(ActionBarActionButtonMixin, "Update", HideHotKeys_ActionButton_Update)

SLASH_HIDEHOTKEYSHK1 = "/hhk"
SlashCmdList["HIDEHOTKEYSHK"] = HideHotKeys_HK_Slash

SLASH_HIDEHOTKEYSMN1 = "/hmn"
SlashCmdList["HIDEHOTKEYSMN"] = HideHotKeys_MN_Slash
-- code for HideHotKeys finish

-- code for HideBagsBar start
local t = {
  "MicroButtonAndBagsBar",
}

local function showFoo(self)
	for _, v in ipairs(t) do
		_G[v]:Hide(0)
	end
end

local function hideFoo(self)
	for _, v in ipairs(t) do
		_G[v]:Hide(0)
	end
end

for _, v in ipairs(t) do
	v = _G[v]
	v:SetScript("OnEnter", showFoo)
	v:SetScript("OnLeave", hideFoo)
	v:Hide(0)
end
-- code for HideBagsBar finish

-- code for HideMicroMenu start
local ignore

local function setAlpha(b, a)
	if ignore then return end
	ignore = true
	if b:IsMouseOver() then
		b:Hide(1)
	else
		b:Hide(0)
	end
	ignore = nil
end

local function showFoo(self)
    for _, v in ipairs(MICRO_BUTTONS) do
        ignore = true
        _G[v]:Hide(1)
        ignore = nil
    end
end
 
local function hideFoo(self)
    for _, v in ipairs(MICRO_BUTTONS) do
        ignore = true
        _G[v]:Hide(0)
        ignore = nil
    end
end
 
for _, v in ipairs(MICRO_BUTTONS) do
    v = _G[v]
    hooksecurefunc(v, "SetAlpha", setAlpha)
    v:HookScript("OnEnter", showFoo)
    v:HookScript("OnLeave", hideFoo)
    v:SetAlpha(0)
end
-- code for HideMicroMenu finish