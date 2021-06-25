-- local for align start
SLASH_EA1 = "/align"

local f
-- local for align finish

-- local for arena number start
local U=UnitIsUnit
-- local for arena number finish

-- code for arena number start
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
-- code for arena number finish

-- code for align start
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
-- code for align finish

