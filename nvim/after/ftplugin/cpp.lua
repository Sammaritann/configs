local map_tools = require("buzreps.remap")

vim.o.commentstring = "//%s"

local opts = {
  noremap = true
}

-- Wrap selection with cast
vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>sc', '<Esc>`>a)<Esc>`<istatic_cast<>(<Esc>hi', opts)
vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>rc', '<Esc>`>a)<Esc>`<ireinterpret_cast<>(<Esc>hi', opts)
vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>dc', '<Esc>`>a)<Esc>`<idynamic_cast<>(<Esc>hi', opts)
vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>cc', '<Esc>`>a)<Esc>`<iconst_cast<>(<Esc>hi', opts)

-- Insert cast operator and put cursor inside angle brackets
vim.api.nvim_buf_set_keymap(0, 'i', ',sc', 'static_cast<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',rc', 'reinterpret_cast<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',dc', 'dynamic_cast<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',cc', 'const_cast<><Left>', opts)

-- Wrap in selection mode
local visual_wrap_type = function(key, wrapper)
  -- 1. Go to right part of selection, append ">"
  -- 2. Go to left part of selection, insert "std::optional<"
  -- 3. Jump to next ">" (does not work as expected if selection contains angle brackets)
  vim.api.nvim_buf_set_keymap(0, 'v', key, [[<Esc>`>a><Esc>`<i]] .. wrapper .. [[<<Esc>f>]], opts)
end
visual_wrap_type('<Leader>op', 'std::optional')
visual_wrap_type('<Leader>up', 'std::unique_ptr')
visual_wrap_type('<Leader>sp', 'std::shared_ptr')
visual_wrap_type('<Leader>wp', 'std::weak_ptr')
visual_wrap_type('<Leader>va', 'std::variant')
visual_wrap_type('<Leader>ex', 'std::expected')

-- Insert smart pointer and put cursor inside angle blackets
vim.api.nvim_buf_set_keymap(0, 'i', ',up', 'std::unique_ptr<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',mup', 'std::make_unique<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',sp', 'std::shared_ptr<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',msp', 'std::make_shared<><Left>', opts)
vim.api.nvim_buf_set_keymap(0, 'i', ',wp', 'std::weak_ptr<><Left>', opts)

vim.api.nvim_buf_set_keymap(0, 'i', [[']], [[''<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [["]], [[""<Left>]], opts)

vim.api.nvim_buf_set_keymap(0, 'i', [[,(]], [[()<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,<]], [[<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,co]], [[std::cout << ;<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,fmt]], [[std::cout << std::format("\n");<Esc>4hi]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,mv]], [[std::move()<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,less]], [[bool operator<() const {}<Left><CR>]], opts)

-- Insert standard type
vim.api.nvim_buf_set_keymap(0, 'i', [[,um]], [[std::unordered_map<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,umm]], [[std::unordered_multimap<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,mm]], [[std::multimap<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,us]], [[std::unordered_set<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,ums]], [[std::unordered_multiset<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,ms]], [[std::multiset<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,vec]], [[std::vector<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,op]], [[std::optional<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,no]], [[std::nullopt]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,mop]], [[std::make_optional()<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,pq]], [[std::priority_queue<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,pa]], [[std::pair<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,mpa]], [[std::make_pair()<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,tu]], [[std::tuple<><Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,mtu]], [[std::make_tuple()<Left>]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,st]], [[std::string]], opts)
vim.api.nvim_buf_set_keymap(0, 'i', [[,sv]], [[std::string_view]], opts)

-- Insert empty lambda
vim.api.nvim_buf_set_keymap(0, 'i', [[,la]], [[[&](){}<Esc>i<CR><Esc>O]], opts)

-- Insert Qt type
vim.api.nvim_buf_set_keymap(0, 'i', ',sl', [[QStringLiteral("")<Left><Left>]], opts)
