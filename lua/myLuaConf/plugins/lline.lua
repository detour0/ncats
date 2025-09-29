local colorschemeName = nixCats('colorscheme')
if not require('nixCatsUtils').isNixCats then
  colorschemeName = 'onedark'
end


return {
  "lualine.nvim",
  for_cat = 'general.always',
  -- cmd = { "" },
  event = "DeferredUIEnter",
  -- ft = "",
  -- keys = "",
  -- colorscheme = "",
  after = function(plugin)
    require('lualine').setup({

