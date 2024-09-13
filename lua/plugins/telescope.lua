return {
  "nvim-telescope/telescope.nvim",
  keys = function ()
    return {
      { "<leader>fa", "<cmd>Telescope find_files<cr>", desc="Find all files" },
      { "<leader>ff", "<cmd>Telescope git_files<cr>", desc="Find inside git files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc="Live grep" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc="Find in commands" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc="Help" },
    }
  end,
}

