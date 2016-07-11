local extra_manabar_loaded = false

HOLY_POWER_FLARE_ANIMATION = 0

RUNE_TIMER_ANIMATIONS = {}
RUNE_TIMER_ANIMATIONS[1] = 0
RUNE_TIMER_ANIMATIONS[2] = 0
RUNE_TIMER_ANIMATIONS[3] = 0
RUNE_TIMER_ANIMATIONS[4] = 0
RUNE_TIMER_ANIMATIONS[5] = 0
RUNE_TIMER_ANIMATIONS[6] = 0

local CLASS_POWERS = {}




local CLASS_POWER_TYPE = 0
local CLASS_POWER_MAX = 0
local CLASS_POWER = 0
local PLAYER_CLASS = 0
local PLAYER_SPECIALIZATION = 0


function create_classpowers()
    local playerClassName, playerClassEng, playerClass = UnitClass('player')
    
    
    PLAYER_CLASS = playerClass
    
    local classPowerFrame = CreateFrame('Frame','GwPlayerClassPower',UIParent,'GwPlayerClassPower')
    GwPlayerClassPower:SetScript('OnEvent',function(self,event) GW_UPDATE_CLASSPOWER(self,event) end)
    
    GwPlayerClassPower:RegisterEvent("UNIT_POWER");
    GwPlayerClassPower:RegisterEvent("UNIT_MAX_POWER");

    classPowerFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    classPowerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    classPowerFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")
    classPowerFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    
    select_altpower_type()
    GW_UPDATE_CLASSPOWER()
end





function select_altpower_type()
    
    PLAYER_SPECIALIZATION = GetSpecialization();
    
    GW_SET_BARTYPE()
   
end

function GW_UPDATE_CLASSPOWER(self,event)
    
    
    
    if event=='PLAYER_SPECIALIZATION_CHANGED'  or  event=='CHARACTER_POINTS_CHANGED' or event=='UPDATE_SHAPESHIFT_FORM' then
        select_altpower_type()
    end
    
    if  CLASS_POWERS[PLAYER_CLASS]~=nil and CLASS_POWERS[PLAYER_CLASS][PLAYER_SPECIALIZATION]~=nil then
          
         CLASS_POWERS[PLAYER_CLASS][PLAYER_SPECIALIZATION]()
    end
    
    
   
end


function GW_POWERTYPE_SOULSHARD()
    
    CLASS_POWER_MAX = UnitPowerMax('player',7)
    CLASS_POWER = UnitPower('player',7)    

    GwPlayerClassPowerBackground:SetTexCoord(0,1,0.125*CLASS_POWER_MAX,0.125*(CLASS_POWER_MAX+1))   
    GwPlayerClassPowerFill:SetTexCoord(0,1,0.125*CLASS_POWER,0.125*(CLASS_POWER+1))

end
function GW_POWERTYPE_HOLYPOWER()
    
    local old_power = CLASS_POWER
    CLASS_POWER_MAX =  UnitPowerMax('player',9)
    CLASS_POWER =  UnitPower('player',9)
    local p = CLASS_POWER - 1

    GwPlayerClassPowerBackground:SetTexCoord(0,1,0.125*CLASS_POWER_MAX,0.125*(CLASS_POWER_MAX+1))   
    GwPlayerClassPowerFill:SetTexCoord(0,1,0.125*p,0.125*(p+1))
    
    if old_power<CLASS_POWER then
        HOLY_POWER_FLARE_ANIMATION = 1
        old_power = CLASS_POWER
        GwPlayerClassPowerFlare:ClearAllPoints()
        GwPlayerClassPowerFlare:SetPoint('CENTER',GwPlayerClassPower,'LEFT',(32*CLASS_POWER),0)
        addToAnimation('HOLY_POWER_FLARE_ANIMATION',HOLY_POWER_FLARE_ANIMATION,0,GetTime(),0.5,function()
            GwPlayerClassPowerFlare:SetAlpha(animations['HOLY_POWER_FLARE_ANIMATION']['progress'])
           
        end)
        
        
    end

end
function GW_POWERTYPE_CHI()
    
    local old_power = CLASS_POWER
    CLASS_POWER_MAX =  UnitPowerMax('player',12)
    CLASS_POWER =  UnitPower('player',12)
    local p = CLASS_POWER - 1

    GwPlayerClassPowerBackground:SetTexCoord(0,1,0.125*(CLASS_POWER_MAX+1),0.125*(CLASS_POWER_MAX+2))   
    GwPlayerClassPowerFill:SetTexCoord(0,1,0.125*p,0.125*(p+1))
    
    if old_power<CLASS_POWER then
        HOLY_POWER_FLARE_ANIMATION = 1
        old_power = CLASS_POWER
        GwPlayerClassPowerFlare:ClearAllPoints()
        GwPlayerClassPowerFlare:SetPoint('CENTER',GwPlayerClassPower,'LEFT',(32*CLASS_POWER),0)
        addToAnimation('HOLY_POWER_FLARE_ANIMATION',HOLY_POWER_FLARE_ANIMATION,0,GetTime(),0.5,function()
            GwPlayerClassPowerFlare:SetAlpha(animations['HOLY_POWER_FLARE_ANIMATION']['progress'])
           
        end)
        
        
    end

end
function GW_POWERTYPE_COMBOPOINT()
    
    local old_power = CLASS_POWER
    CLASS_POWER_MAX =  UnitPowerMax('player',4)
    CLASS_POWER =  UnitPower('player',4)
    local p = CLASS_POWER - 1

    GwPlayerClassPowerBackground:SetTexCoord(0,1,0.125*(CLASS_POWER_MAX-1),0.125*(CLASS_POWER_MAX))
    GwPlayerClassPowerFill:SetTexCoord(0,1,0.125*p,0.125*(p+1))
    
    if old_power<CLASS_POWER then
        HOLY_POWER_FLARE_ANIMATION = 1
        old_power = CLASS_POWER
        GwPlayerClassPowerFlare:ClearAllPoints()
        GwPlayerClassPowerFlare:SetPoint('CENTER',GwPlayerClassPower,'LEFT',(40*CLASS_POWER),0)
        addToAnimation('HOLY_POWER_FLARE_ANIMATION',HOLY_POWER_FLARE_ANIMATION,0,GetTime(),0.5,function()
            GwPlayerClassPowerFlare:SetAlpha(animations['HOLY_POWER_FLARE_ANIMATION']['progress'])
           
        end)
        
        
    end

end
function GW_POWERTYPE_RUNE()
    
    for i=1,6 do
        local rune_start, rune_duration, rune_ready = GetRuneCooldown(i)
        if rune_start==nil then
            rune_start = 0 
            rune_duration = 0 
        end
        if rune_ready then
            _G['GwRuneTextureFill'..i]:SetTexCoord(0.5,1,0,1)
            if animations['RUNE_TIMER_ANIMATIONS'..i] then
                animations['RUNE_TIMER_ANIMATIONS'..i]['completed']=true
                animations['RUNE_TIMER_ANIMATIONS'..i]['duration'] = 0
            end
        else
            
            local startTime = rune_start
            local endTime = rune_start +rune_duration
            
            startTime = startTime 
            endTime = endTime 
            
            addToAnimation('RUNE_TIMER_ANIMATIONS'..i,RUNE_TIMER_ANIMATIONS[i],1,startTime,endTime-startTime,function()                    
                _G['GwRuneTextureFill'..i]:SetTexCoord(0.5,1,1-animations['RUNE_TIMER_ANIMATIONS'..i]['progress'],1)
                 _G['GwRuneTextureFill'..i]:SetHeight(32*animations['RUNE_TIMER_ANIMATIONS'..i]['progress'])
            end,'noease', function()
                      
                    local runpadding = (42 * i) - 42
                    HOLY_POWER_FLARE_ANIMATION = 1
                    GwPlayerClassPowerFlare:ClearAllPoints()
                    GwPlayerClassPowerFlare:SetPoint('CENTER',GwPlayerClassPower,'LEFT',(runpadding*i),0)
                    addToAnimation('HOLY_POWER_FLARE_ANIMATION',HOLY_POWER_FLARE_ANIMATION,0,GetTime(),0.5,function()

                        GwPlayerClassPowerFlare:SetAlpha(animations['HOLY_POWER_FLARE_ANIMATION']['progress'])
                    end)
                
            end)
            RUNE_TIMER_ANIMATIONS[i] = 0
            
        end
        _G['GwRuneTexture'..i]:SetTexCoord(0,0.5,0,1)
    end

end

function GW_POWERTYPE_MANABAR()
    if extra_manabar==true then return end

    extra_manabar = true
    local GwExtraPlayerPowerBar = CreateFrame('Frame', 'GwExtraPlayerPowerBar',UIParent, 'GwPlayerPowerBar');
    
    
   GwExtraPlayerPowerBar:SetParent(GwPlayerClassPower)
   GwExtraPlayerPowerBar:ClearAllPoints()
    GwExtraPlayerPowerBar:SetPoint('BOTTOMLEFT',GwPlayerClassPower,'BOTTOMLEFT',0,0)
    
    
    GwExtraPlayerPowerBar:SetScript('OnEvent',function(self,event,unit)
            if unit=='player' then
                update_power_data(GwExtraPlayerPowerBar,0,'MANA','GwExtraPowerBar')
            end
    end)
    
    _G['GwExtraPlayerPowerBarBarString']:SetFont(DAMAGE_TEXT_FONT,14)

    GwExtraPlayerPowerBar:RegisterEvent("UNIT_POWER");
    GwExtraPlayerPowerBar:RegisterEvent("UNIT_MAX_POWER");
    GwExtraPlayerPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD");
    
    update_power_data(GwExtraPlayerPowerBar,0,'MANA','GwExtraPowerBar')
end


function GW_SET_BARTYPE()
    
    GwPlayerClassPower:Show()
    
    if  CLASS_POWERS[PLAYER_CLASS]==nil or CLASS_POWERS[PLAYER_CLASS][PLAYER_SPECIALIZATION]==nil then
          GwPlayerClassPower:Hide()
        return
    end
    
    if PLAYER_CLASS==2 then
        GwPlayerClassPowerBackground:SetHeight(32)
        GwPlayerClassPowerBackground:SetWidth(320)
        
        GwPlayerClassPower:SetHeight(32)
        GwPlayerClassPower:SetWidth(320)
        GwPlayerClassPowerBackground:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\holypower')
        GwPlayerClassPowerBackground:SetTexCoord(0,1,0.5,1)   

        GwPlayerClassPowerFill:SetHeight(32)
        GwPlayerClassPowerFill:SetWidth(320)
        GwPlayerClassPowerFill:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\holypower')
        return
   end 
    if PLAYER_CLASS==4 then
        GwPlayerClassPowerBackground:SetHeight(32)
        GwPlayerClassPowerBackground:SetWidth(256)
        
        GwPlayerClassPower:SetHeight(40)
        GwPlayerClassPower:SetWidth(320)
        GwPlayerClassPowerFlare:SetWidth(128)
        GwPlayerClassPowerFlare:SetHeight(128)
        GwPlayerClassPowerBackground:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\combo-bg')
        GwPlayerClassPowerFlare:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\combo-flash')
        GwPlayerClassPowerBackground:SetTexCoord(0,1,0.5,1)

        GwPlayerClassPowerFill:SetHeight(40)
        GwPlayerClassPowerFill:SetWidth(320)
        GwPlayerClassPowerFill:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\combo')
        return
   end
    
    if PLAYER_CLASS==5 then
        return 
    end
    if PLAYER_CLASS==6 then
        GwRuneBar:Show()     
        GwPlayerClassPowerBackground:SetTexture(nil)
        GwPlayerClassPowerFill:SetTexture(nil)
        return
   end
    if PLAYER_CLASS==7 then
        return 
    end

    if PLAYER_CLASS==9 then
        GwPlayerClassPowerBackground:SetHeight(32)
        GwPlayerClassPowerBackground:SetWidth(128)
        GwPlayerClassPower:SetHeight(32)
        GwPlayerClassPower:SetWidth(256)
        GwPlayerClassPowerBackground:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\shadoworbs-bg')

        GwPlayerClassPowerFill:SetHeight(32)
        GwPlayerClassPowerFill:SetWidth(256)
        GwPlayerClassPowerFill:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\shadoworbs')
        return
    end
    if PLAYER_CLASS==10 then
        GwPlayerClassPowerBackground:SetHeight(32)
        GwPlayerClassPowerBackground:SetWidth(320)
        
        GwPlayerClassPower:SetHeight(32)
        GwPlayerClassPower:SetWidth(256)
        GwPlayerClassPowerBackground:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\chi')
        GwPlayerClassPowerFlare:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\chi-flare')
        GwPlayerClassPowerBackground:SetTexCoord(0,1,0.5,1)   

        GwPlayerClassPowerFill:SetHeight(32)
        GwPlayerClassPowerFill:SetWidth(256)
        GwPlayerClassPowerFill:SetTexture('Interface\\AddOns\\GW2_UI\\textures\\altpower\\chi')
        return
   end
   local s = GetShapeshiftFormID()
    if PLAYER_CLASS==11 and s==5 or s==1 or s==31 then
        return
    end
    GwPlayerClassPower:Hide()
end



CLASS_POWERS[2] = {}
CLASS_POWERS[2][3]= GW_POWERTYPE_HOLYPOWER

CLASS_POWERS[6] = {}
CLASS_POWERS[6][1]= GW_POWERTYPE_RUNE
CLASS_POWERS[6][2]= GW_POWERTYPE_RUNE
CLASS_POWERS[6][3]= GW_POWERTYPE_RUNE

CLASS_POWERS[4] = {}
CLASS_POWERS[4][1]= GW_POWERTYPE_COMBOPOINT
CLASS_POWERS[4][2]= GW_POWERTYPE_COMBOPOINT
CLASS_POWERS[4][3]= GW_POWERTYPE_COMBOPOINT

CLASS_POWERS[5] = {}
CLASS_POWERS[5][3]= GW_POWERTYPE_MANABAR

CLASS_POWERS[7] = {}
CLASS_POWERS[7][2]= GW_POWERTYPE_MANABAR

CLASS_POWERS[9] = {}
CLASS_POWERS[9][1]= GW_POWERTYPE_SOULSHARD
CLASS_POWERS[9][2]= GW_POWERTYPE_SOULSHARD
CLASS_POWERS[9][3]= GW_POWERTYPE_SOULSHARD

CLASS_POWERS[10] = {}
CLASS_POWERS[10][3]= GW_POWERTYPE_CHI


CLASS_POWERS[11] = {}
CLASS_POWERS[11][1]= GW_POWERTYPE_MANABAR
CLASS_POWERS[11][2]= GW_POWERTYPE_MANABAR
CLASS_POWERS[11][3]= GW_POWERTYPE_MANABAR
CLASS_POWERS[11][4]= GW_POWERTYPE_MANABAR



create_classpowers()