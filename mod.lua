local function mapNameKey(id)
    return "map_" .. tostring(id):gsub("[^%w_]", "_") .. "_name"
end

function Mod:init()
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    print(Game:loc("Loaded [var:name]!", "mod.loaded", {name = self.info.name}))
end

function Mod:updateMapName()
    if Game.world and Game.world.map and Game.world.map.id and Game.loc then
        local map = Game.world.map
        map.name = Game:loc(map.name or map.id, mapNameKey(map.id))
    end
end

function Mod:updateBattleLocalization()
    if Game.battle then
        for _, enemy in ipairs(Game.battle.enemies or {}) do
            if enemy.applyLocalization then
                enemy:applyLocalization(true)
            end
        end
    end
end

function Mod:postUpdate()
    self:updateMapName()
end

function Mod:onKeyPressed(key, is_repeat)
    if is_repeat or key ~= "f6" or not Game.setLanguage then
        return
    end

    local next_language = Game:getLanguage() == "zh_hans" and "en" or "zh_hans"
    if Game:setLanguage(next_language) then
        self:updateMapName()
        self:updateBattleLocalization()

        local message = Game:loc("* Language switched to [var:language].", "mod.language_switched", {
            language = Game:getLanguageName()
        })
        print(message)

        if Game.world and not Game.world:hasCutscene() and not Game.world.menu then
            Game.world:showText(message)
        end

        return true
    end
end
