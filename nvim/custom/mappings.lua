local M = {}

M.abc = {

  n = {
    ["<leader>tr"] = {
      function ()
        require("base46").toggle_transparency()
      end, "toggle transparency"
    },

    ["<leader>tt"] = {
      function ()
       require("base46").toggle_themes()
      end, "toggle theme"
    },

    ["<CR>"] = {":noh<CR><CR>", "remove highlighting"},
   },

  i = {
  },
}

return M
