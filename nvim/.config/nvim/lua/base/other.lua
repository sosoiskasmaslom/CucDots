
-- ~/.config/nvim/lua/base/other.lua
-- Автокоманды и прочее

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Убирать подсветку поиска при нажатии Escape
autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    vim.cmd('nohlsearch')
  end,
})

-- Подсвечивать текст при копировании (yank)
autocmd('TextYankPost', {
  group = augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})

-- Восстанавливать позицию курсора при открытии файла
autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Убирать trailing пробелы при сохранении
autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})
