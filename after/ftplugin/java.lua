local ok, jdtls = pcall(require, 'jdtls')
if ok then
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      require('simi.lspAttach').on_attach(event)
      require('which-key').register {
        ['<leader>ce'] = { name = '[E]xtract', _ = 'which_key_ignore' },
      }
      local function map(opts)
        vim.keymap.set(opts.mode, '<leader>ce' .. opts.lhs, opts.rhs, { buffer = event.buf, desc = opts.desc or '' })
      end
      map {
        mode = 'n',
        lhs = 'v',
        rhs = function()
          jdtls.extract_variable()
        end,
        desc = '[E]xtract [V]ariable',
      }
      map {
        mode = 'v',
        lhs = 'v',
        rhs = function()
          jdtls.extract_variable { visual = true }
        end,
        desc = '[E]xtract [V]ariable',
      }
      map {
        mode = 'n',
        lhs = 'c',
        rhs = function()
          jdtls.extract_constant()
        end,
        desc = '[E]xtract [C]onstant',
      }
      map {
        mode = 'v',
        lhs = 'c',
        rhs = function()
          jdtls.extract_constant { visual = true }
        end,
        desc = '[E]xtract [C]onstant',
      }
      map {
        mode = 'v',
        lhs = 'm',
        rhs = function()
          jdtls.extract_method { visual = true }
        end,
        desc = '[E]xtract [M]ethod',
      }
    end,
  })
  jdtls.start_or_attach {
    cmd = { require('mason-core.path').bin_prefix() .. '/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  }
end
