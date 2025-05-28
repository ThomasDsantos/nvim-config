return {
  'saghen/blink.cmp',
  build = 'cargo build --release',
  opts = {
    completion = {
      documentation = {
        auto_show = true,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { 'snippets', 'dadbod', 'buffer' },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    keymap = {
      ['<Up>'] = { 'fallback' },
      ['<Down>'] = { 'fallback' },
      ['<C-p>'] = { function(cmp) cmp.select_prev({ auto_insert = false }) end },
      ['<C-n>'] = { function(cmp) cmp.select_next({ auto_insert = false }) end },
      ["<CR>"] = { 'accept', 'fallback' },
      ["<C-Space>"] = { function(cmp) cmp.show() end },
    },
    signature = { enabled = true },
  }
}
