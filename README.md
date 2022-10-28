# telescope-lines.nvim

A simple [Telescope](https://github.com/nvim-telescope/telescope.nvim) extension to search through
the lines in the current buffer.

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use({
  "neanias/telescope-lines.nvim",
  requires = "nvim-telescope/telescope.nvim",
})
```

## Setup

To enable the extension, add this to your config:

```lua
require("telescope").load_extension("lines")
```

To configure the plugin, you can add to the telescope setup:

```lua
local telescope = require("telescope")
telescope.setup({
  -- ...
  extensions = {
    -- These are the default values.
    lines = {
      hide_empty_lines = true,
      trim_lines = true,
    },
  },
})

-- `load_extension` must be called after `telescope.setup`
telescope.load_extension("lines")
```

The two configuration fields are `hide_empty_lines` and `trim_lines` as noted above.
`hide_empty_lines` will hide any lines that are just whitespace from being in the picker, whilst
`trim_lines` will trim leading & trailing whitespace from the lines before sending them to the
picker.

## Usage

This can be run as a Telescope command

```viml
:Telescope lines
```

or called directly in lua

```viml
:lua require("telescope").extensions.lines.lines()
```
