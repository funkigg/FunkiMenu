# Funki Menu Scaffold

This repository contains a stripped-down, reusable WoW addon menu scaffold.

## What this template does

- Creates a movable framed menu.
- Renders menu entries from a simple data table.
- Supports placeholder item types:
  - `label`
  - `separator`
  - `button`
  - `toggle`

## How to reuse

1. Copy `FunkiMenu.lua` and `MenuTemplate.lua` into your addon.
2. Rename addon metadata in `.toc`.
3. Replace the `addon.MenuTemplate.items` table with your own entries.
4. Trigger with `/funkimenu` (or change slash command name).

## Notes

All Clickable Raid Buffs-specific behavior has been removed. Only generic scaffold behavior remains.
