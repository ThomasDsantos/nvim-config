return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
      },
    })
  end
}
