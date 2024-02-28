return {
  "https://codeberg.org/esensar/nvim-dev-container",
  config = function ()
    require("devcontainer").setup({
      attach_mounts = {
        neovim_config = {
          enabled = true,
          options = { "readonly" }
        },
        neovim_data = {
          enabled = true,
          options = {} 
        },
        neovim_state = {
          enabled = true,
          options = {}
        },
      },
    })
  end
}
