-- ArenaNumbers start
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
-- ArenaNumbers finish

-- Align start
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
    -- need to do 84 for 21:9 additional ratio to be found 21:9, 16:9, 10:9
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
-- Align finish

-- HotKeys start
local HotKeys_Frame = CreateFrame("Frame")

-- default enabled
if (HotKeys_HK_Hidden == nil) then
  HotKeys_HK_Hidden = true
end

-- default disabled
if (HotKeys_MN_Hidden == nil) then
  HotKeys_MN_Hidden = false
end


function HotKeys_EventHandler(self, event)
  if (event == "PLAYER_ENTERING_WORLD") then
    HotKeys_Update()
  end
end

-- the default ActionButton_UpdateHotkeys function will reget the first hotkey associated with a button
-- and show/hide if there is a bind or not, so we will rehide it if neccesary after the default function runs
function HotKeys_ActionButton_UpdateHotkeys(self, actionButtonType)
  local hkf = self.HotKey --_G[self:GetName().."HotKey"]
  
  if (hkf) then
    if (HotKeys_HK_Hidden and hkf:IsShown()) then
      hkf:Hide()
      
    elseif (not HotKeys_HK_Hidden and not hkf:IsShown()) then
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
function HotKeys_ActionButton_Update(self)
  local mnf = self.Name --_G[self:GetName().."Name"]
  
  if (mnf) then
    if (HotKeys_MN_Hidden and mnf:IsShown()) then
      mnf:Hide()
    elseif (not HotKeys_MN_Hidden and not mnf:IsShown()) then
      mnf:Show()
    end
  end
end


--rehides if they should be hidden, called whenever the UI reshows them
function HotKeys_Update()
    if (HotKeys_HK_Hidden) then
      HotKeys_HK_HideAll()
    else
      HotKeys_HK_ShowAll()
    end
    if (HotKeys_MN_Hidden) then
      HotKeys_MN_HideAll()
    else
      HotKeys_MN_ShowAll()
    end
end


function HotKeys_HK_HideAll()
  HotKeys_HideBar("Action", "HotKey")
  HotKeys_HideBar("BonusAction", "HotKey")
  HotKeys_HideBar("PetAction", "HotKey")
  HotKeys_HideBar("MultiBarBottomLeft", "HotKey")
  HotKeys_HideBar("MultiBarBottomRight", "HotKey")
  HotKeys_HideBar("MultiBarRight", "HotKey")
  HotKeys_HideBar("MultiBarLeft", "HotKey")
  HotKeys_HK_Hidden = true
end


function HotKeys_HK_ShowAll()
  HotKeys_ShowBar("Action", "HotKey")
  HotKeys_ShowBar("BonusAction", "HotKey")
  HotKeys_ShowBar("PetAction", "HotKey")
  HotKeys_ShowBar("MultiBarBottomLeft", "HotKey")
  HotKeys_ShowBar("MultiBarBottomRight", "HotKey")
  HotKeys_ShowBar("MultiBarRight", "HotKey")
  HotKeys_ShowBar("MultiBarLeft", "HotKey")
  HotKeys_HK_Hidden = false
end


function HotKeys_HK_Slash()
  if (HotKeys_HK_Hidden) then
    HotKeys_HK_ShowAll()
  else
    HotKeys_HK_HideAll()
  end
end


function HotKeys_MN_HideAll()
  HotKeys_HideBar("Action", "Name")
  HotKeys_HideBar("BonusAction", "Name")
  HotKeys_HideBar("MultiBarBottomLeft", "Name")
  HotKeys_HideBar("MultiBarBottomRight", "Name")
  HotKeys_HideBar("MultiBarRight", "Name")
  HotKeys_HideBar("MultiBarLeft", "Name")
  HotKeys_MN_Hidden = true
end


function HotKeys_MN_ShowAll()
  HotKeys_ShowBar("Action", "Name")
  HotKeys_ShowBar("PetAction", "Name")
  HotKeys_ShowBar("BonusAction", "Name")
  HotKeys_ShowBar("MultiBarBottomLeft", "Name")
  HotKeys_ShowBar("MultiBarBottomRight", "Name")
  HotKeys_ShowBar("MultiBarRight", "Name")
  HotKeys_ShowBar("MultiBarLeft", "Name")
  HotKeys_MN_Hidden = false
end


function HotKeys_MN_Slash()
  if (HotKeys_MN_Hidden) then
    HotKeys_MN_ShowAll()
  else
    HotKeys_MN_HideAll()
  end
end


function HotKeys_HideBar(b, f)
  for i = 1, 12 do
    local o = _G[b.."Button"..i..f]
    if (o) then
      o:Hide()
    end
  end
end


function HotKeys_ShowBar(b, f)
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

HotKeys_Frame:SetScript("OnEvent", HotKeys_EventHandler)
HotKeys_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- register a hook for action button update functions
hooksecurefunc(ActionBarActionButtonMixin, "UpdateHotkeys", HotKeys_ActionButton_UpdateHotkeys)
hooksecurefunc(ActionBarActionButtonMixin, "Update", HotKeys_ActionButton_Update)

SLASH_HotKeysHK1 = "/hk"
SlashCmdList["HotKeysHK"] = HotKeys_HK_Slash

SLASH_HotKeysMN1 = "/hm"
SlashCmdList["HotKeysMN"] = HotKeys_MN_Slash
-- HotKeys finish

-- HideBagsBar start
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
-- HideBagsBar finish

-- HideMicroMenu start
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
-- HideMicroMenu finish
