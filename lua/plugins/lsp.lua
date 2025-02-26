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
    "pmizio/typescript-tools.nvim",
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
    vim.filetype.add {
      extension = {
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'jinja',
      },
    }

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ansiblels",
        "bashls",
        "dockerls",
        "eslint",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "ts_ls",
        "volar",
        "yamlls",
        -- "pylsp"
      },
      handlers = {
        function(server_name) -- default handler
          lspconfig[server_name].setup {
            capabilities = capabilities
          }
        end,
        ["ansiblels"] = function()
          if vim.filetype then
            vim.filetype.add({
              pattern = {
                [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
                [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
                [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
                [".*/playbook.*%.ya?ml"] = "yaml.ansible",
                [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
                [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
                [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
                [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
              },
            })
          else
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
              pattern = {
                "*/host_vars/*.yml",
                "*/host_vars/*.yaml",
                "*/group_vars/*.yml",
                "*/group_vars/*.yaml",
                "*/group_vars/*/*.yml",
                "*/group_vars/*/*.yaml",
                "*/playbook*.yml",
                "*/playbook*.yaml",
                "*/playbooks/*.yml",
                "*/playbooks/*.yaml",
                "*/roles/*/tasks/*.yml",
                "*/roles/*/tasks/*.yaml",
                "*/roles/*/handlers/*.yml",
                "*/roles/*/handlers/*.yaml",
                "*/tasks/*.yml",
                "*/tasks/*.yaml",
              },
              callback = function()
                vim.bo.filetype = "yaml.ansible"
              end,
            })
            lspconfig.ansiblels.setup({
              capabilities = capabilities
            })
          end
          lspconfig.ansiblels.setup({
            filetypes = {
              "yaml.ansible",
            },
            settings = {
              ansible = {
                ansible = {
                  path = "ansible",
                  useFullyQualifiedCollectionNames = true
                },
                ansibleLint = {
                  enabled = true,
                  path = "ansible-lint"
                },
                executionEnvironment = {
                  enabled = false
                },
                python = {
                  interpreterPath = "python"
                },
                completion = {
                  provideRedirectModules = true,
                  provideModuleOptionAliases = true
                }
              },
            },
            capabilities = capabilities
          })
        end,
        ["pylsp"] = function()
          lspconfig.pylsp.setup {
            -- cmd = { "pylsp", "-vvv", "--log-file", "/tmp/lsp.log" },
            settings = {
              pylsp = {
                plugins = {
                  pycodestyle = {
                    enabled = false
                  },
                  rope_autoimport = {
                    enabled = true,
                    memory = false,
                  },
                  pydocstyle = {
                    enabled = false,
                  },
                  mypy = {
                    enabled = false,
                  },
                  ruff = {
                    enabled = true,
                    formatEnabled = true,
                  },
                  jedi_completion = { fuzzy = true },
                },
              },
            },
            flags = {
              debounce_text_changes = 200,
            },
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
            },
          }
        end,
        ["volar"] = function()
          lspconfig.volar.setup({
            capabilities = capabilities,
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "/home/thdo/.nvm/versions/node/v22.14.0/lib/node_modules/@vue/typescript-plugin",
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            },
            filetypes = {
              "javascript",
              "typescript",
              "vue",
            },
          })
        end
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      enabled = true,
      preselect = cmp.PreselectMode.Item,
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
      }, {
        { name = 'buffer' }
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
