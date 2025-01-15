return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    require('telescope').setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      },
    })
    require('telescope').load_extension("ui-select")
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>fgw', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>fga', function()
      builtin.live_grep({ additional_args = { "--hidden" }, glob_pattern = "!.git/" })
    end)
    vim.keymap.set('n', '<leader>fgA', function()
      builtin.live_grep({ additional_args = { "--hidden", "--no-ignore-vcs" }, glob_pattern = "!.git/" })
    end)
  end,
  lazy = false,
  keys = function()
    return {
      { "<leader>fa",  "<cmd>Telescope find_files<cr>", desc = "Find all files" },
      { "<leader>ff",  "<cmd>Telescope git_files<cr>",  desc = "Find git files" },
      { "<leader>fgf", "<cmd>Telescope live_grep<cr>",  desc = "Git grep" },
      { "<leader>fc",  "<cmd>Telescope commands<cr>",   desc = "Find in commands" },
      { "<leader>fh",  "<cmd>Telescope help_tags<cr>",  desc = "Help" },
    }
  end,
}
