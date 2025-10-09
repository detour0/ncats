local colorschemeName = nixCats('colorscheme')
if not require('nixCatsUtils').isNixCats then
  colorschemeName = 'onedark'
end


return {
  "bufferline.nvim",
  for_cat = 'general.always',
  -- cmd = { "" },
  event = "DeferredUIEnter",
  -- ft = "",
  keys = {
    { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  },
  -- colorscheme = "",
  after = function(plugin)
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        -- mode = "tabs",
        separator_style = "slant",
        -- style_preset = bufferline.style_preset.minimal,
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = false,
      },
    })
  end
}
