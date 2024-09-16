return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pylsp",
        "ruff_lsp",
        "ansiblels",
        "rust_analyzer",
        "bashls",
        "volar",
        "eslint",
        "yamlls",
        "jsonls",
        "helm_ls",
        "dockerls"
      },
      handlers = {
        function(server_name) -- default handler
          lspconfig[server_name].setup {
            capabilities = capabilities
          }
        end,
        ["lua_ls"] = function() -- override server setup
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      })
    })
  end,
  keys = {
    { '<leader>gd', vim.lsp.buf.definition },
    { '<leader>gD', vim.lsp.buf.declaration },
    { '<leader>gi', vim.lsp.buf.implementation },
    { '<leader>go', vim.lsp.buf.type_definition },
    { '<leader>gr', vim.lsp.buf.references },
    { '<leader>gh', vim.lsp.buf.signature_help },
    { '<F2>',       vim.lsp.buf.rename },
    { '<F3>',       "<cmd>lua vim.lsp.buf.format({ async = true })<cr>" },
    { '<F4>',       vim.lsp.buf.code_action },
  },
  lazy = false,
}
