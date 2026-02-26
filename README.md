# Funki Menu Scaffold

A minimal reusable World of Warcraft addon menu scaffold.

## Scope

This version intentionally contains only:

- A generic menu frame scaffold.
- A simple tab/subtab renderer.
- Placeholder structured data in one table.

No Clickable Raid Buffs logic is included.

## Data structure

Edit `addon.MenuTemplate` in `MenuTemplate.lua`:

- `title`, `width`, `height`
- `tabs[]`
  - `id`, `label`
  - `subtabs[]`
    - `id`, `label`, `content`

## Usage

- Run `/funkimenu` in-game to toggle the scaffold.
- Replace placeholder tabs/subtabs/content with project-specific values.
