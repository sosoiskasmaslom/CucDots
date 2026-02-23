# Загружаем autoconfig.yml (если он есть, иначе эта строка не нужна)
config.load_autoconfig(False)

# ───── Aliases ─────
c.aliases = {
    'only': 'tab-only',
    'q':    'tab-close',
    'qa':   'quit',
    'w':    'session-save',
    'wq':   'quit --save',
    'wqa':  'quit --save',
}

# ───── Backend ─────
c.backend = 'webengine'

# ───── Key mappings ─────
c.bindings.key_mappings = {
    '<Alt+A>':      '<Shift+H>',
    '<Alt+D>':      '<Shift+L>',
    '<Ctrl+6>':     '<Ctrl+^>',
    '<Ctrl+Enter>': '<Ctrl+Return>',
    '<Ctrl+[>':     '<Escape>',
    '<Ctrl+i>':     '<Tab>',
    '<Ctrl+j>':     '<Return>',
    '<Ctrl+m>':     '<Return>',
    '<Enter>':      '<Return>',
    '<Shift+Enter>':'<Return>',
    '<Shift+Return>':'<Return>',
}

# ───── Changelog ─────
c.changelog_after_upgrade = 'minor'

# ───── Colors ─────
c.colors.completion.category.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #888888, stop:1 #505050)'
c.colors.completion.category.border.bottom = 'black'
c.colors.completion.category.fg = 'white'

c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.policy.images = 'always'

# ───── Content ─────
config.set('content.geolocation', True, 'https://www.ozon.ru')

config.set('content.javascript.clipboard', 'access-paste', 'https://chatgpt.com')
config.set('content.javascript.clipboard', 'access-paste', 'https://claude.ai')
config.set('content.javascript.clipboard', 'access-paste', 'https://github.com')
config.set('content.javascript.clipboard', 'access-paste', 'https://miro.com')

# ───── URLs ─────
c.url.default_page = 'https://google.com/'
c.url.start_pages   = ['https://google.com']
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}',
}

# ───── Bindings: swap H ↔ J ─────
# Дефолт: H = back, J = tab-prev
config.bind('H', 'tab-prev')
config.bind('J', 'back')

# ───── Bindings: swap L ↔ K ─────
# Дефолт: L = forward, K = tab-next
config.bind('L', 'tab-next')
config.bind('K', 'forward')

