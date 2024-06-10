show_pyenv() {
  local index=$1 
  local icon="$(get_tmux_option "@catppuccin_pyenv_icon" "󰌠")"
  local color="$(get_tmux_option "@catppuccin_pyenv_color" "colour76")"
  local text="$(get_tmux_option "@catppuccin_pyenv_text" "#($XDG_CONFIG_HOME/tmux/scripts/get_python_version.sh)" )"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}