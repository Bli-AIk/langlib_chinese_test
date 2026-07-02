# 本地化审计报告

## 结论

这个测试模组现在使用 `langLibZh` 进行本地化，语言文件放在 `lang/en.json` 与 `lang/zh_hans.json`。运行时可用 `Game:setLanguage("en")` / `Game:setLanguage("zh_hans")` 切换语言，测试项目也在 `mod.lua` 中绑定了 `F6` 快速切换。

汉化不是直接把源码字段改成中文，而是保留英文默认文本，通过稳定 key 查语言表。这样英文和中文可以共存，Tiled 文件和 Lua 脚本里的默认文本也能作为 fallback。

## 实现方式

- 普通文本：使用 `Game:loc(default, id, var)`。
- Cutscene 文本：支持 `cutscene:text(..., {id = "text_id"})`。
- 选项：支持 `cutscene:choicer(..., {ids = {...}})`。
- Tiled NPC / Interactable：在 `text1/text2` 旁添加 `id1/id2`，hook 会按 id 本地化。
- Tiled 地图名：添加 `name_id`，`mod.lua` 会用地图属性里的 `name_id` 本地化 `map.name`。
- 物品、武器、防具、法术、角色名：通过库 hook 转为 `item_*`、`spell_*`、`chara_*` key。
- 中文字体：由 `libraries/langLib_zh_hans` 库内置提供。`main` / `main_mono` / `plain` 的主字体保留 Kristal 原英文字体，中文字符回退到原先使用的 FZBitmap / Unifont 字体，避免中文模式下英文变糊。

## 本次补齐范围

已补齐 `mod.json` 初始背包与装备中引用的内置数据：

- 物品：`glowshard`、`darkburger`、`cell_phone`、`shadowcrystal`
- 武器：`wood_blade`、`mane_ax`、`red_scarf`
- 防具：`amber_card`
- 自定义物品：`ultimate_candy`

已补齐初始队伍菜单会显示的内容：

- 角色：`kris`、`susie`、`ralsei`
- X-Action 名称
- 第 4 章职业标题
- 法术：`rude_buster`、`ultimate_heal`、`pacify`、`heal_prayer`

已补齐 Tiled 文本入口：

- `room1.tmx` 的 NPC、保存点、墙壁守卫文本 ID
- `room1.tmx` / `room2.tmx` 的地图名 `name_id`
- 对应导出的 `room1.lua` / `room2.lua` 属性

## 额外库补丁

少数 Kristal 内置数据覆盖了通用方法，单靠 `Item` / `Spell` 基类 hook 不会命中。本次在库里补了 0.10 专用轻量 hook：

- `glowshard:getBattleText`
- `cell_phone:onWorldUse`
- `shadowcrystal:getDescription/onWorldUse`
- `rude_buster:getCastMessage`
- `pacify:getCastMessage`
- 暗世界物品丢弃确认描述

## 验证

已执行：

```text
jq empty lang/en.json lang/zh_hans.json libraries/langLib_zh_hans/lib.json libraries/langLib_zh_hans/lang/en.json libraries/langLib_zh_hans/lang/zh_hans.json
find scripts libraries -type f -name '*.lua' -print0 | xargs -0 -n1 luac -p
timeout 10s love /home/aik/Projects/LuaProjects/Kristal --mod langlib_chinese_test --auto-mod-start
```

结果：

- JSON 合法。
- Lua 语法通过。
- 主字体 + FZBitmap / Unifont fallback 的新增中文字符缺字数为 0。
- 游戏启动输出 `Loaded langlib_chinese_test!`，没有报错。

## 仓库结构

汉化库已拆成独立 public 仓库，并作为 submodule 引入：

```text
libraries/langLib_zh_hans -> https://github.com/Bli-AIk/kristal-langlib-zh-hans.git
```

## 字体策略

中文模式下的字体配置：

- `main.ttf`: Kristal 原版 `8bitoperator JVE`
- `main_mono.ttf`: Kristal 原版 `Monospaced JVE`
- `plain.ttf`: Kristal 原版 `8bitoperator JVE`
- `zh_main.ttf`: 原先使用的 `FZBitmap_18030_11X12`，作为 `main` / `main_mono` 的中文 fallback
- `zh_plain.ttf`: 原先使用的 `Unifont`，作为 `plain` 的中文 fallback

因此英文和 ASCII 仍由原英文字体绘制，只有中文字符落到中文 fallback 字体。测试项目不再自带字体副本，字体随 `langLibZh` submodule 提供。
