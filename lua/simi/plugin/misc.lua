return {
  {
    'jbyuki/venn.nvim',
    config = function()
      local function toggle_venn()
        if vim.b.venn_enabled == nil then
          local normal_maps = vim.api.nvim_buf_get_keymap(0, 'n')
          local visual_maps = vim.api.nvim_buf_get_keymap(0, 'v')
          local old_maps = {
            ['H'] = nil,
            ['J'] = nil,
            ['K'] = nil,
            ['L'] = nil,
            ['f'] = nil,
          }
          for _, value in ipairs(normal_maps) do
            if value['lhs'] == 'H' or value['lhs'] == 'J' or value['lhs'] == 'K' or value['lhs'] == 'L' then
              old_maps[value['lhs']] = value
            end
          end
          for _, value in ipairs(visual_maps) do
            if value['lhs'] == 'f' then
              old_maps[value['lhs']] = value
            end
          end
          vim.b.venn_old_maps = old_maps
          vim.b.venn_enabled = true
          vim.opt_local.ve = 'all'
          vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<C-v>j:VBox<CR>', { noremap = true })
          vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<C-v>k:VBox<CR>', { noremap = true })
          vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<C-v>l:VBox<CR>', { noremap = true })
          vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<C-v>h:VBox<CR>', { noremap = true })
          vim.api.nvim_buf_set_keymap(0, 'v', 'f', ':VBox<CR>', { noremap = true })
        else
          vim.opt_local.ve = ''
          local function reset(mode, map)
            vim.api.nvim_buf_del_keymap(0, mode, map)
            local mapping = vim.b.venn_old_maps[map]
            if mapping ~= nil then
              if mapping['callback'] ~= nil then
                vim.api.nvim_buf_set_keymap(0, mode, map, '', {
                  noremap = mapping['normap'],
                  silent = mapping['silent'],
                  expr = mapping['expr'],
                  callback = mapping['callback'],
                })
              else
                vim.api.nvim_buf_set_keymap(0, mode, map, vim.inspect(mapping['rhs']), {
                  noremap = mapping['normap'],
                  silent = mapping['silent'],
                  expr = mapping['expr'],
                })
              end
            end
          end
          reset('n', 'J')
          reset('n', 'K')
          reset('n', 'L')
          reset('n', 'H')
          reset('v', 'f')
          vim.b.venn_enabled = nil
          vim.b.venn_old_maps = nil
        end
      end
      vim.keymap.set('n', '<leader>v', toggle_venn)
    end,
  },
}
