return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    event_handlers = {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.opt_local.relativenumber = true
      end,
    },
  },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git"
          },
        },
        window = {
          mappings = {
            ["B"] = "noop"
          },
        },
        follow_current_file = {
          enabled = true
        },
        -- hijack_netrw_behavior = "disabled",
      }
    })
    vim.keymap.set('n', '<leader>b', '<Cmd>Neotree toggle<CR>')
  end,
}
