function HS_SplitString(str, seperatorPattern)
    local tbl = {};
    local pattern = "(.-)" .. seperatorPattern;
    local lastEnd = 1;
    local s, e, cap = string.find(str, pattern, 1);
   
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(tbl,cap);
        end
        lastEnd = e + 1;
        s, e, cap = string.find(str, pattern, lastEnd);
    end
    
    if lastEnd <= string.len(str) then
        cap = string.sub(str, lastEnd);
        table.insert(tbl, cap);
    end
    
    return tbl
end

function HS_OnSwap(...)
    local arg = select(1, ...);
    
    local args = HS_SplitString(arg, " ");
    if not (#args > 2) then
        return;
    end
    
    local plr1, plr2, subgroup = args[1], args[2], args[3];
    local index, tmpSubGroup;
    
    for i=1, 40 do
        local currentName = UnitName("raid"..i);
        
        if currentName == plr1 or currentName == plr2 then
            if not index then
                index = i;
                local _,_,currentSubGroup = GetRaidRosterInfo(i);
                tmpSubGroup = currentSubGroup;
                SetRaidSubgroup(i, subgroup);
            else
                local _,_,currentSubGroup = GetRaidRosterInfo(i);
                SetRaidSubgroup(i, tmpSubGroup);
                SetRaidSubgroup(index, currentSubGroup);
            end
        end
    end
    
    
end

SlashCmdList["HOTSWAP"] = HS_OnSwap;
SLASH_HOTSWAP1 = "/swap";