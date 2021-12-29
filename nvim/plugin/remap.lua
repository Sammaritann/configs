local map = require("buzreps.remap")
local builtin = require("telescope.builtin")

-- Tab switching
map.normal { "<A-1>", "1gt" }
map.normal { "<A-2>", "2gt" }
map.normal { "<A-3>", "3gt" }
map.normal { "<A-4>", "4gt" }
map.normal { "<A-5>", "5gt" }
map.normal { "<A-6>", "6gt" }
map.normal { "<A-7>", "7gt" }
map.normal { "<A-8>", "8gt" }
map.normal { "<A-9>", "9gt" }

-- Create [n]ew tab next to current
map.normal { "<A-n>", "<cmd>tabnew<CR>" }

-- Move current tab left/right
map.normal { "<A-j>", "<cmd>call MoveCurrentTab(-1)<CR>" }
map.normal { "<A-k>", "<cmd>call MoveCurrentTab(1)<CR>" }

-- Goto prev/next tab
map.normal { "<A-h>", "gT" }
map.normal { "<A-l>", "gt" }

-- [R]ename current tab
-- TODO: insert current tab label after command
map.normal { "<A-r>", ":SetCurrentTabPageLabel ", descr = "Rename current tab" }

-- Window switching
map.normal { "<Leader>1", "1<C-w>w" }
map.normal { "<Leader>2", "2<C-w>w" }
map.normal { "<Leader>3", "3<C-w>w" }
map.normal { "<Leader>4", "4<C-w>w" }
map.normal { "<Leader>5", "5<C-w>w" }
map.normal { "<Leader>6", "6<C-w>w" }
map.normal { "<Leader>7", "7<C-w>w" }
map.normal { "<Leader>8", "8<C-w>w" }
map.normal { "<Leader>9", "9<C-w>w" }

map.insert { "jk", "<Esc>" }
map.terminal { "<Esc>", [[<C-\><C-n>]] }
map.terminal { "jk", [[<C-\><C-n>]] }

-- Toggle word [w]rap
map.normal { "<Leader>w", "<cmd>set wrap!<CR>", descr = "Toggle wrap mode" }

-- [S]earch: yank current selection into search buffer
-- warning: Overwrites 's' register
-- requires appropriate selection mode
map.visual { "<Leader>s", '"sy :let @/=@s<CR>', descr = "Yank selection into search buffer" }

-- Turn off search highlight
map.normal { "<Leader>S", "<cmd>nohl<CR>" }

-- Clipboard [y]ank: copy unnamed register contents to OS clipboard
map.normal { "<Leader>y", ':let @+=@"<CR>', descr = "Yank into system clipboard" }
-- Clipboard [y]ank: copy selection to OS clipboard
map.visual { "<Leader>y", '"+y', descr = "Yank into system clipboard" }

-- [P]aste: paste last yanked text
-- or `xnoremap <Leader>p pgvy` - paste{p), select pasted(gv), yank(y}
map.normal { "<Leader>p", '"0p', descr = "Paste last yanked text" }
map.normal { "<Leader>P", '"0P', descr = "Paste last yanked text" }

-- centering window at search result
map.normal { "n", "nzzzv" }
map.normal { "N", "Nzzzv" }

-- centering window at undo/redo
map.normal { "u", "uzz" }
map.normal { "<C-r>", "<C-r>zz" }

-- fg - grep in lua/init.lua
map.normal { "<Leader>ff", builtin.find_files }
map.normal { "<Leader>fof", builtin.oldfiles }
map.normal { "<leader>fb", builtin.buffers }

map.normal { "<leader>fref", builtin.lsp_references }
map.normal { "<leader>fic", builtin.lsp_incoming_calls }
map.normal { "<leader>foc", builtin.lsp_outgoing_calls }
map.normal { "<leader>fws", builtin.lsp_workspace_symbols }
map.normal { "<leader>fds", builtin.lsp_document_symbols }

-- [f]ind [a]ll [d]iagnostics
map.normal { "<leader>fad", builtin.diagnostics }
-- [f]ind [c]urrent [d]iagnostics
-- map.normal { "<leader>fcd", "<cmd>Telescope diagnostics bufnr=0<cr>" }
map.normal { "<leader>fcd", function()
  builtin.diagnostics({
    bufnr = 0
  })
end }

map.normal { "<leader>frp", builtin.resume }
-- normal{"<leader>flp", "<cmd>Telescope pickers<cr>"}
-- [f]ind [t]elescope [d]efaults
-- normal{"<leader>ftd", "<cmd>Telescope builtin<cr>"}
-- normal{"<leader>freg", "<cmd>Telescope registers<cr>"}

local file_manager = "NERDTree" -- or "netrw"
if file_manager == "NERDTree" then
  map.normal { '<leader>n', '<cmd>NERDTreeToggle<cr>' }
  map.normal { '<leader>N', '<cmd>NERDTreeFind<cr>' }
elseif file_manager == "netrw" then
  map.normal { '<leader>n', '<cmd>Lex<cr>' }
end

-- [s]ymbols [o]utline
map.normal { '<Leader>so', '<cmd>SymbolsOutline<cr>' }

-- Window resizing
map.normal { '<F9>', ':resize -2<CR>' }
map.normal { '<F10>', ':resize +2<CR>' }
map.normal { '<F11>', ':vertical resize -10<CR>' }
map.normal { '<F12>', ':vertical resize +10<CR>' }

-- Wrap selection with brackets or quotes
-- Requires 'old' or 'inclusive' selection
map.visual { "<Leader>'", "<Esc>`>a'<Esc>`<i'<Esc>" }
map.visual { '<Leader>"', '<Esc>`>a"<Esc>`<i"<Esc>' }
map.visual { '<Leader>(', '<Esc>`>a)<Esc>`<i(<Esc>' }
map.visual { '<Leader>{', '<Esc>`>a}<Esc>`<i{<Esc>' }
map.visual { '<Leader><', '<Esc>`>a><Esc>`<i<<Esc>' }
map.visual { '<Leader>[', '<Esc>`>a]<Esc>`<i[<Esc>' }
map.visual { '<Leader>*', '<Esc>`>a*<Esc>`<i*<Esc>' }
map.visual { '<Leader>`', '<Esc>`>a`<Esc>`<i`<Esc>' }

map.normal { "<Leader>'", "a''<Esc>i" }
map.normal { '<Leader>"', 'a""<Esc>i' }
map.normal { '<Leader>(', 'a()<Esc>i' }
map.normal { '<Leader>{', 'a{}<Esc>i' }
map.normal { '<Leader><', 'a<><Esc>i' }
map.normal { '<Leader>[', 'a[]<Esc>i' }
map.normal { '<Leader>*', 'a**<Esc>i' }
map.normal { '<Leader>`', 'a``<Esc>i' }

-- Paste tabs on <Tab>; Set tab virtual size to arg
map.normal { '<Leader>ut', ':UseTabs ' }
-- Paste spaces in <Tab>; Set amount of spaces per <Tab>
map.normal { '<Leader>us', ':UseSpaces ' }

-- TODO: compact mode for all windows {on current tab?}
map.normal { '<Leader>cm', ':execute ":call ToggleCompactMode()"<CR>' }

-- CamelCase
local function switch_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand('<cword>')
  local word_start = vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

  -- Detect camelCase
  if word:find('[a-z][A-Z]') then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
    -- Detect snake_case
  elseif word:find('_[a-z]') then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    print("Not a snake_case or camelCase word")
  end
end

map.normal { [[<Leader>sc]], switch_case }

map.normal { [[<Leader>git]], ':Neogit<CR>' }

