return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,
      filesystem = {
        window = {
          mappings = {
            ["B"] = "noop"
          },
        },
        follow_current_file = {
          enabled = true
        },
        hijack_netrw_behavior = "disabled",
      }
    })
    vim.keymap.set('n', '<leader>b', '<Cmd>Neotree toggle<CR>')
  end,
}
