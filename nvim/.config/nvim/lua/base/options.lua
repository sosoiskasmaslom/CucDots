
-- ~/.config/nvim/lua/base/options.lua

local opt = vim.opt

-- Внешний вид
opt.number         = true       -- Номера строк
opt.relativenumber = true       -- Относительные номера
opt.cursorline     = true       -- Подсветка текущей строки
opt.signcolumn     = 'yes'      -- Всегда показывать колонку знаков (для LSP/git)
opt.termguicolors  = true       -- 24-bit цвета
opt.scrolloff      = 8          -- Отступ при скролле (строк до края)
opt.wrap           = false      -- Не переносить длинные строки

-- Отступы и табы
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.expandtab      = true       -- Пробелы вместо табов
opt.smartindent    = true       -- Умные отступы

-- Поиск
opt.ignorecase     = true
opt.smartcase      = true       -- Учитывать регистр если есть заглавные
opt.hlsearch       = false      -- Не оставлять подсветку после поиска
opt.incsearch      = true       -- Подсветка в реальном времени

-- Буфер обмена и мышь
opt.clipboard      = 'unnamedplus'  -- Системный буфер обмена
opt.mouse          = 'a'

-- Разное
opt.splitbelow     = true       -- Новый сплит снизу
opt.splitright     = true       -- Новый сплит справа
opt.undofile       = true       -- Сохранять историю отмен между сессиями
opt.updatetime     = 250        -- Быстрее обновление (для LSP)
opt.swapfile       = false      -- Отключить swap файлы
