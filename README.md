# FunkiMenu

A minimal reusable World of Warcraft addon menu scaffold.

## Scope

This package contains only:

- Generic menu scaffold logic.
- Modular option element builders under `Options/Elements`.
- Data-driven tabs/subtabs in `MenuTemplate.lua`.

No legacy addon logic is included.

## Modular element files

`OptionElements.lua` is not used. Element builders are split into:

- `Options/Elements/TabButton.lua`
- `Options/Elements/SubtabButton.lua`
- `Options/Elements/ContentText.lua`

## Data structure

Edit `addon.MenuTemplate` in `MenuTemplate.lua`:

- `title`, `width`, `height`
- `tabs[]`
  - `id`, `label`
  - `subtabs[]`
    - `id`, `label`, `content`

## Usage

- Run `/funkimenu` in-game to toggle the scaffold.
- Replace placeholder tabs/subtabs/content with your project data.
