-- See example how to config highlight groups from lua [here](https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua)
-- See how nvim-treesitter highlight works `:h treesitter-highlight`
-- See how lsp highlighting works `:h lsp-semantic-highlight`
-- See article about lsp highlighting [here](https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316)
-- See default vscode dark theme colors [here](https://github.com/microsoft/vscode/blob/main/extensions/theme-defaults/themes/dark_vs.json)

-- nvim-treesitter highlight queries has a priority of 100

local M = {}

function M.enable(args)
  args = args or {}
  if args.background ~= "light" and args.background ~= "dark" then
    args.background = "dark"
  end

  -- Enables 24-bit RGB color. Uses "gui" attributes instead of "cterm" attributes
  -- Enabled by default since 0.10 if compatible terminal detected
  vim.opt.termguicolors = true

  if vim.g.colors_name then
    vim.opt.background = args.background
    -- Uses the current value of 'background' to decide which default colors to use.
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
  end
  vim.g["colors_name"] = "buz_theme"

  local hi = function(name, val)
    -- Make sure that `cterm` attribute is not populated from `gui`
    val.cterm = val.cterm or {}
    -- Define global highlight
    vim.api.nvim_set_hl(0, name, val)
  end

  ------------------------------------------------------------------------------
  -- Default UI items: background, statusline, tabline, winbar, signcolumn, ...
  ------------------------------------------------------------------------------

  hi("Normal", { bg = "#0c0c16", fg = "#DDDDDD" })

  hi("NormalFloat", { link = "Normal" }) -- Floating is used for diagnostic and hovering
  hi("FloatTitle", { bg = "Red" })

  -- Vertical lines
  hi("LineNr", { bg = "", fg = "Gray30" }) -- Line number column
  hi("CursorLineNr", {})
  hi("ColorColumn", { bg = "Gray10" })
  hi("WinSeparator", { fg = "Gray10" })

  -- Horizontal lines
  hi("TabLineSel", { link = "LineNr" })
  hi("TabLine", { link = "LineNr" })
  hi("WinBar", { link = "LineNr" })
  hi("WinBarNC", { link = "LineNr" })
  hi("StatusLine", { link = "LineNr" })

  hi("CursorLine", { bg = "Gray10" })
  hi("Search", { bg = "Orange", fg = "Black" })

  hi("DiagnosticSignError", { fg = "Red", })       --fg = "Black" })
  hi("DiagnosticSignWarn", { fg = "DarkYellow", }) --fg = "Black" })
  hi("DiagnosticSignInfo", { fg = "Grey", })       --fg = "Black" })
  hi("DiagnosticSignHint", { fg = "Grey30", })     --fg = "White" })

  ------------------------------------------------------------------------------
  -- All groups from `:hi`
  ------------------------------------------------------------------------------

  -- Highlights unused header files
  hi("DiagnosticWarn", { fg = "#665700" })
  hi("DiagnosticInfo", { fg = "NvimDarkCyan" })
  hi("DiagnosticHint", { fg = "NvimDarkBlue" })
  hi("DiagnosticError", { fg = "DarkRed" })
  hi("DiagnosticUnnecessary", { fg = "Gray" })

  -- Leave blank to inherit terminal background color
  hi("NonText", { fg = "Gray20" })    -- "eol", "extends", "precedes"
  hi("Whitespace", { fg = "Gray20" }) -- "nbsp", "space", "tab", "multispace", "lead", "trail"
  hi("Comment", { fg = "#6A9955" })   -- any comment
  hi("Visual", { bg = "#ffa759", fg = "#2c2c3d" })

  -- Alternative: NvimDarkGrey4
  hi("Folded", { link = "Comment" })

  hi("Constant", { link = "Keyword" })    -- any constant
  hi("String", { fg = "#ce9178" })        -- a string constant: "this is a string"
  hi("Character", { link = "String" })    -- a character constant: 'c', '\n'
  hi("Number", { link = "Constant" })     -- a number constant: 234, 0xff
  hi("Boolean", { link = "Constant" })    -- a boolean constant: TRUE, false
  hi("Float", { link = "Constant" })      -- a floating point constant: 2.3e10

  hi("Identifier", { fg = "" })           -- any variable name
  hi("Function", { fg = "" })             -- function name (also: methods for classes)

  hi("Statement", { fg = "" })            -- any statement
  hi("Conditional", { link = "Keyword" }) -- if, then, else, endif, switch, etc.
  hi("Repeat", { link = "Keyword" })      -- for, do, while, etc.
  hi("Label", { link = "Keyword" })       -- case, default, etc.
  hi("Operator", { link = "Keyword" })    -- "sizeof", "+", "*", etc.
  hi("Keyword", { fg = "#55899B" })       -- any other keyword
  hi("Exception", { link = "Keyword" })   -- try, catch, throw

  hi("PreProc", { fg = "#850063" })       -- generic Preprocessor
  hi("Include", { link = "PreProc" })     -- preprocessor #include
  hi("Define", { link = "PreProc" })      -- preprocessor #define
  hi("Macro", { link = "PreProc" })       -- same as Define
  hi("PreCondit", { link = "PreProc" })   -- preprocessor #if, #else, #endif, etc.

  -- Problem: Highlights all cpp types
  --hi("Type", { link = "Keyword" })         -- int, long, char, etc.
  hi("StorageClass", { link = "Keyword" }) -- static, register, volatile, etc.
  hi("Structure", { link = "Keyword" })    -- struct, union, enum, etc.
  hi("Typedef", { link = "Keyword" })      -- a typedef

  hi("Special", { fg = "" })               -- any special symbol
  hi("SpecialChar", { fg = "" })           -- special character in a constant
  hi("Tag", { fg = "" })                   -- you can use CTRL-] on this
  hi("Delimiter", { fg = "" })             -- character that needs attention
  hi("SpecialComment", { fg = "" })        -- special things inside a comment
  -- hi("Debug", { fg = "" })                                             -- debugging statements
  -- hi("Underlined", { fg = "" })                                        -- text that stands out, HTML links
  hi("Ignore", { fg = "" })                                            -- left blank, hidden  |hl-Ignore|
  hi("Error", { fg = "" })                                             -- any erroneous construct
  hi("Todo", { fg = "White", bg = "Red", bold = true, italic = true }) -- anything that needs extra attention; mostly the
  -- hi("keywords", { fg = "" })                                          -- TODO FIXME and XXX

  hi("mkdCodeStart", { fg = "Red4" })
  hi("mkdCodeEnd", { fg = "Red4" })

  hi("DiffAdd", { bg = "", fg = "DarkGreen" })
  hi("DiffChange", { bg = "", fg = "DarkYellow" })
  hi("DiffDelete", { bg = "", fg = "DarkRed" })
  hi("Added", { link = "DiffAdd" })      -- added line in a diff
  hi("Changed", { link = "DiffChange" }) -- changed line in a diff
  hi("Removed", { link = "DiffDelete" }) -- removed line in a diff

  ------------------------------------------------------------------------------
  -- Netrw
  ------------------------------------------------------------------------------
  hi("Directory", { fg = "#6A9955" })

  ------------------------------------------------------------------------------
  -- NERDTree - TODO
  ------------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  -- Neogit
  ------------------------------------------------------------------------------

  hi("NeogitDiffContext", {})
  hi("NeogitDiffContextHighlight", { link = "NeogitDiffContext" })
  hi("NeogitDiffAdd", { link = "DiffAdd" })
  hi("NeogitDiffAddHighlight", { link = "NeogitDiffAdd" })
  hi("NeogitDiffDelete", { link = "DiffChange" })
  hi("NeogitDiffDeleteHighlight", { link = "NeogitDiffDelete" })
  hi("NeogitDiffHeader", { bg = "Gold3", fg = "Black" })
  hi("NeogitDiffHeaderHighlight", { link = "NeogitDiffHeader" })

  hi("NeogitHunkHeaderHighlight", { bg = "", fg = "Blue" })
  hi("NeogitHunkHeaderCursor", { bg = "Blue", fg = "White" })

  ------------------------------------------------------------------------------
  -- Treesitter standard captures
  ------------------------------------------------------------------------------

  hi("@comment", { link = "Comment" })
  hi("@module", { fg = "gray51" }) -- namespaces
  -- hi("@variable.member", { fg = "Gold3" }) -- class property
  hi("@variable.builtin", { link = "@keyword" })
  hi("@constant.builtin", { link = "@keyword" })
  hi("@property", { link = "@variable.member" }) -- struct pointer fields?
  hi("@string.escape", { link = "@string" })
  hi("@character", { link = "@string" })

  -- hi("@keyword.return", { fg = "Red" })
  hi("@keyword.return", { link = "@keyword" })
  hi("@keyword.exception", { link = "@keyword.return" })
  hi("@keyword.conditional", { link = "Conditional" })
  hi("@keyword.directive", { link = "PreProc" })
  hi("@include", { link = "PreProc" })
  hi("@preproc", { link = "PreProc" })
  hi("@define", { link = "PreProc" })
  hi("@keyword.directive.define", { link = "@keyword.directive" })
  hi("@keyword.import", { link = "@keyword.directive" })
  hi("@function.macro", { link = "@keyword.directive" })
  hi("@function.builtin", { link = "@keyword" })
  hi("@function.call", { fg = "Orange" })

  hi("@keyword", { link = "Keyword" })
  hi("@operator", { link = "@keyword" })
  hi("@exception", { link = "@keyword" })
  hi("@punctuation.delimiter", { link = "@keyword" })
  hi("@punctuation.bracket", { link = "@keyword" })
  hi("@punctuation.special", { link = "@keyword" })
  hi("@type.builtin", { link = "@keyword" })
  hi("@type.qualifier", { link = "@keyword" })
  hi("@boolean", { link = "@keyword" })
  hi("@number", { link = "@keyword" })
  hi("@storageclass", { link = "@keyword" })
  hi("@repeat", { link = "Repeat" })
  hi("@conditional", { link = "Conditional" })

  hi("@type", { link = "@keyword" })
  hi("@variable", { fg = "Pink" })

  -----------------------
  -- CMake specific
  ----------------------
  hi("@constant.cmake", { link = "@keyword" })
  hi("@variable.cmake", { fg = "Pink" })
  hi("@punctuation.special.cmake", { fg = "Pink" })

  -----------------------
  -- Markdown specific
  ----------------------
  local markdown_slightly_visible = { bg = "", fg = "Gray30" }
  for i = 1, 10 do
    hi("@text.title." .. i .. ".markdown", { bold = true, bg = "", fg = "Purple" })
    hi("@text.title." .. i .. ".marker.markdown", { link = "@text.title." .. i .. ".markdown" })
  end
  -- Multiline code blocks delimiters: e.g. "```"
  hi("@punctuation.delimiter.markdown", markdown_slightly_visible)
  -- Inline code blocks delimiters: e.g. "`"
  hi("@punctuation.delimiter.markdown_inline", markdown_slightly_visible)
  -- Language in code blocks: e.g. "bash" in "```bash"
  hi("@label.markdown", markdown_slightly_visible)
  hi("@text.uri.markdown_inline", markdown_slightly_visible)
  hi("@text.todo.checked.markdown", { fg = "DarkGreen" })
  -- Text inside multiline code block without specified language
  hi("@text.literal.block.markdown", { italic = true, fg = "Gray30" })
  -- `Inline text`
  hi("@text.literal.markdown_inline", { italic = true, fg = "DarkGreen" })
  -- ~Strikethrough~
  hi("@text.strike.markdown_inline", { strikethrough = true, fg = "Gray30" })
  -- *italic*
  hi("@text.emphasis.markdown_inline", { italic = true, })
  -- __bold__
  hi("@text.strong.markdown_inline", { bold = true, fg = "Gold3" })

  ------------------------------------------------------------------------------
  -- LSP semantic highlights. Works only with provided third-party LSP server
  -- Priorities: @lsp.type.*     - lowest
  --             @lsp.mod.*      - middle
  --             @lsp.typemod.*  - highest
  -- Warning: the order of application of modifiers with same priority is random
  ------------------------------------------------------------------------------

  -- Special clangd extmark?
  hi("Type", { fg = "" }) -- treesitter and lsp defaults here (e.g. for GLuint or size_t)

  local lsp_const_color = "SpringGreen4"
  local lsp_non_const_color = "Pink"

  -- hi("@lsp.mod.readonly", { fg = "#AAFFAA" })            -- const vars, methods, enums
  hi("@lsp.mod.deduced", { link = "@keyword" }) -- "auto" keyword

  hi("@lsp.type.method", { fg = lsp_non_const_color })
  hi("@lsp.typemod.method.readonly", { fg = lsp_const_color })
  hi("@lsp.typemod.method.virtual", { underline = true })

  hi("@lsp.type.macro", { link = "PreProc" })
  hi("@lsp.type.class", { fg = "RoyalBlue1" })
  hi("@lsp.type.function", { fg = "Orange" })
  hi("@lsp.type.typeParameter", { fg = "Red" })
  -- Alternative: link to @lsp.mod.readonly
  hi("@lsp.type.enum", { link = "@lsp.type.class" })
  hi("@lsp.type.enumMember", { link = "@keyword" })
  hi("@lsp.type.property", { bg = "Gold3", fg = "Black" })

  hi("@lsp.type.parameter", { fg = lsp_non_const_color, italic = true })
  hi("@lsp.typemod.parameter.readonly", { fg = lsp_const_color })

  hi("@lsp.type.variable", { fg = lsp_non_const_color })
  hi("@lsp.typemod.variable.readonly", { fg = lsp_const_color, bg = "None" })
  hi("@lsp.typemod.variable.globalScope", { fg = "Red" })
  hi("@lsp.typemod.variable.fileScope", { link = "@lsp.typemod.variable.globalScope" })
  hi("@lsp.typemod.variable.classScope", { link = "@lsp.typemod.variable.globalScope" })
  -- All static readonly with higher priority
  hi("@buz.lsp.typemod.variable.readonlyAndGlobal", { link = "@lsp.typemod.variable.readonly" })
  -- Used in lsp semantic highlighting to reset all tokens with lower priority
end

-- Semantic token update event handler
-- Handles property highlighting
--
-- @param[in] args Event arguments table:
--            • id: (number) autocommand id
--            • event: (string) name of the triggered event (See autocmd-events)
--            • group: (number|nil) autocommand group id, if any
--            • match: (string) expanded value of <amatch>
--            • buf: (number) expanded value of <abuf>
--            • file: (string) expanded value of <afile>
--            • data: (any) arbitrary data passed from nvim_exec_autocmds()
local function UpdateProperty(args)
  local token = args.data.token

  -- False only for top-level property (m_prop1) in expression of type "m_prop1.prop2_.prop3"
  local is_nested_property = (function()
    if token.start_col == 0 and token.line_beg == 0 then
      return false
    end
    local context_line_beg = ((token.line > 0) and (token.line - 1) or 0)
    local context_lines = vim.api.nvim_buf_get_text(args.buf, context_line_beg, 0,
      token.line, token.start_col, {})
    local prev_context = table.concat(context_lines, "")
    prev_context = string.gsub(prev_context, "[ \t]+(%f[\r\n%z])", "%1")
    local last_two_chars = string.sub(prev_context, -2, -1)
    return string.sub(last_two_chars, -1) == '.' or last_two_chars == '->'
  end)()

  if is_nested_property then
    local base_priority = vim.highlight.priorities.semantic_tokens + 3
    -- Shadowing semantic tokens with lower priority
    -- Problem: if Normal guibg is empty (i.e. inheriting terminal color),
    -- background color is not shadowed
    vim.lsp.semantic_tokens.highlight_token(
      token, args.buf, args.data.client_id, "Normal", { priority = base_priority })
    vim.lsp.semantic_tokens.highlight_token(
      token, args.buf, args.data.client_id, "@lsp.type.variable", { priority = base_priority + 1 })
    if token.modifiers.readonly then
      vim.lsp.semantic_tokens.highlight_token(
        token, args.buf, args.data.client_id, "@lsp.typemod.variable.readonly", { priority = base_priority + 2 })
    end
  end
end

local function UpdateVariable(args)
  local token = args.data.token
  -- classScope variable is a static property: `static Foo instance_;`
  -- fileScope variable is a static variable inside cpp `static ostream errcode;`
  -- globalScope variable is a extern variable inside header `extern ostream cout;`
  -- static variable is a static variable inside function `static const auto lambda = []{};`
  local is_static = token.modifiers.classScope or
      token.modifiers.fileScope or
      token.modifiers.globalScope or
      token.modifiers.static
  if not is_static or not token.modifiers.readonly then
    return
  end

  local base_priority = vim.highlight.priorities.semantic_tokens + 3
  -- "Normal" shadows lsp.type.property
  vim.lsp.semantic_tokens.highlight_token(
    token, args.buf, args.data.client_id, "Normal", { priority = base_priority })
  vim.lsp.semantic_tokens.highlight_token(
    token, args.buf, args.data.client_id, "@buz.lsp.typemod.variable.readonlyAndGlobal", { priority = base_priority + 1 })
end

local lsp_token_augroup = vim.api.nvim_create_augroup("BuzLspTokenGroup", {
  clear = true
})

vim.api.nvim_create_autocmd(
  "LspTokenUpdate",
  {
    group = lsp_token_augroup,
    callback = function(args)
      if args.data.token.type == "property" then
        UpdateProperty(args)
      elseif args.data.token.type == "variable" then
        UpdateVariable(args)
      end
    end
  }
)

return M
