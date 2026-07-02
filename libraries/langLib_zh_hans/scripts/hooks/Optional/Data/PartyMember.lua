local PM, super = Class(PartyMember)

function PM:getName()   return Game:loc(self.name,                  "chara_"..self.id.."_name") end
function PM:getTitle()  return Game:loc("LV[var:lv] [var:title]",   "chara_getTitle", {lv = self:getLevel(), title = Game:loc(self.title, "chara_"..self.id.."_title")}) end

function PM:getXActName() return Game:loc(self.xact_name, "chara_"..self.id.."_xactName") end

return PM