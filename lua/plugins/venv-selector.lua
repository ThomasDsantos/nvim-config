return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig", 
  },
  branch = "regexp",
  keys = function ()
    return {
      { "<leader>vs", "<cmd>:VenvSelect<cr>" },
      {"<leader>vc", "<cmd>:VenvSelectCached<cr>"}
    }
  end,
  config = function()
    require("venv-selector").setup()
  end,
}
