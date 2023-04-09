local M = {}

M.ui = {

  theme = 'onenord',

  nvdash = {
    load_on_startup = true
  },

  theme_toggle = { "onedark", "onenord" },

  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
  },

}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M

