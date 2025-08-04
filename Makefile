sync-symlinks:
	mkdir -p ~/.config/wezterm
	ln -sf $(PWD)/wezterm.lua ~/.config/wezterm/wezterm.lua
	ln -sf $(PWD)/tmux.conf ~/.tmux.conf
	ln -sf $(PWD)/aliases ~/.aliases
	ln -sf $(PWD)/gitconfig ~/.gitconfig
	mkdir -p ~/.config/fish/functions/
	ln -sf $(PWD)/fish/config.fish ~/.config/fish/config.fish
	ln -sf $(PWD)/fish/fish_variables ~/.config/fish/fish_variables
	ln -sf $(PWD)/fish/functions/fish_promt.fish ~/.config/fish/functions/fish_promt.fish
	ln -sf $(PWD)/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish

nvim-configure:
	rm -rf nvim/plugin || exit 0
	rm -rf ~/.local/share/nvim || exit 0
	rm -rf ~/.config/nvim || exit 0
	mkdir -p ~/.config
	ln -snf $(PWD)/nvim ~/.config/nvim

sync-dotfiles:
	ln -sf $(PWD)/gitconfig ~/.gitconfig
