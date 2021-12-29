local map = require("buzreps.remap")

-- There are too many nested lists, and spaces are too ugly
vim.opt.listchars:append('lead: ')

map.visual { '<Leader>_', '<Esc>`>a__<Esc>`<i__<Esc>' }
map.visual { '<Leader>~', '<Esc>`>a~<Esc>`<i~<Esc>' }

