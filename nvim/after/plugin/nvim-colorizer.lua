require("colorizer").setup {
  filetypes = { "lua" },
  user_default_options = {
    RGB = true,          -- #RGB hex codes
    RRGGBB = true,       -- #RRGGBB hex codes
    names = true,        -- "Name" codes like Blue or blue
    RRGGBBAA = false,    -- #RRGGBBAA hex codes
    AARRGGBB = false,    -- 0xAARRGGBB hex codes
    mode = "background", -- Display mode: foreground, background, virtualtext
    virtualtext = "■",
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
}
