return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "folke/noice.nvim",
  },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          }
        },
      },
      options = {
        theme = 'dracula'
      }
    })
  end
}
