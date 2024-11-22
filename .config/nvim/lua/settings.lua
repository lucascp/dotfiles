-- indent options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true

-- search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- cursor and window options
vim.opt.number = true
vim.opt.scrollback = 20000
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.diffopt:append({ "vertical" })
vim.opt.showbreak = "↪"
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- completion options
vim.o.shortmess = vim.o.shortmess .. "c"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full", "list" }


--misc options
vim.opt.mouse = "a"
vim.opt.matchpairs:append({ "<:>" })
vim.opt.undofile = true
vim.opt.clipboard:append({ "unnamed" })
