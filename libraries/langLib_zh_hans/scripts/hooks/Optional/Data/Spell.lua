local Spell, super = HookSystem.hookScript(Spell)

function Spell:getName()        return Game:loc(self.name,                                  "spell_"..self.id.."_name")     end
function Spell:getCastName()    return Game:loc(self.cast_name or StringUtils.upper(self:getName()), "spell_"..self.id.."_castName") end

function Spell:getDescription()         return Game:loc(self.description,   "spell_"..self.id.."_description")  end
function Spell:getBattleDescription()   return Game:loc(self.effect,        "spell_"..self.id.."_effect")       end

function Spell:getCastMessage(user, target)
    return Game:loc("* [var:userName] cast [var:castName]!", "spell_castMessage", {userName = user.chara:getName(), castName = self:getCastName()})
end

return Spell
