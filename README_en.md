# langlib_chinese_test

[![license](https://img.shields.io/badge/license-MIT%2FApache--2.0-blue)](LICENSE-APACHE)
<br>
<img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" />
<img src="https://img.shields.io/badge/Kristal-FF6B35?style=for-the-badge&logo=love2d&logoColor=white" />

> Current Status: ✅ Test Mod

![Screenshot](./screenshot.png)

**langlib_chinese_test** — an integration test and demo mod for [langLib_zh_hans](https://github.com/Bli-AIk/kristal-langlib-zh-hans), used to verify and demonstrate Chinese localization capabilities for Kristal mods.

| English | 简体中文                |
| ------- | ----------------------- |
| English | [简体中文](./README.md) |

## Introduction

`langlib_chinese_test` is a Kristal test mod that fully demonstrates the localization capabilities of the `langLib_zh_hans` library. It covers text, menus, items, spells, character names, Tiled maps/NPCs/Interactables, and more — all with F6 real-time language toggling.

This mod also serves as an integration validation tool during library development — each localization entry point has a corresponding test case here, ensuring library updates don't break existing functionality.

## Features

- 🌐 Bilingual (Chinese/English), toggle anytime with F6
- 📝 Cutscene text localized by `id`
- 🎛️ Cutscene choices localized by `ids`
- 🗺️ Tiled NPC / Interactable localization via `id1`/`id2` properties
- 🏷️ Tiled map name localization via `name_id` property
- ⚔️ Auto-keyed items, weapons, armor, spells
- 🔤 CJK font fallback: English uses original fonts, Chinese falls back to FZBitmap/Unifont

## Dependencies

| Library                                                               | Description                     |
| --------------------------------------------------------------------- | ------------------------------- |
| [Kristal](https://github.com/KristalTeam/Kristal)                     | Game engine, `v0.10.0` or later |
| [langLib_zh_hans](https://github.com/Bli-AIk/kristal-langlib-zh-hans) | Chinese localization library    |

## How to Use

1. Install the [Kristal](https://github.com/KristalTeam/Kristal) engine.
2. Clone this repository into Kristal's `mods/` directory and initialize submodules:

   ```bash
   cd Kristal/mods
   git clone https://github.com/Bli-AIk/langlib_chinese_test.git
   cd langlib_chinese_test
   git submodule update --init
   ```

3. Launch Kristal and select **langlib_chinese_test** from the mod menu.
4. Press F6 to switch between Chinese and English at any time.

## References

The localization approach in this project references the following projects:

| Project                                                       | Author/Organization                                    |
| ------------------------------------------------------------- | ------------------------------------------------------ |
| Chinese localization references from other Kristal projects   | [WasneetPotato](https://space.bilibili.com/1641628190) |
| [DeltaruneChinese](https://github.com/gm3dr/DeltaruneChinese) | dr好人汉化组                                           |

## Contributing

Issues and Pull Requests are welcome.

## License

This project is licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.
