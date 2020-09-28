# r2mod completion                                        -*- shell-script -*-

_r2mod()
{
	shopt -s extglob
	local cur prev commands R2_DIR CONFIG_DIR PLUGINS_DIR TMP_DIR
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	commands="check disable edit enable export import install list refresh setup uninstall update version"

	if [[ -d "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2" ]]; then
		# Flatpak install
		R2_DIR="$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2"
	else
		R2_DIR="$HOME/.local/share/Steam/steamapps/common/Risk of Rain 2"
	fi

	BEPIN_DIR="$R2_DIR/BepInEx"
	CONFIG_DIR="$BEPIN_DIR/config"
	PLUGINS_DIR="$BEPIN_DIR/plugins"
	TMP_DIR="/tmp/r2mod"

	if [ $COMP_CWORD == 1 ]
	then
		COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
		return 0
	fi

	if [ $COMP_CWORD == 2 ]
	then
		case "$prev" in
			ed | edit)
				[[ ! -d "$CONFIG_DIR" ]] && return 1
				COMPREPLY=( $(cd "$CONFIG_DIR" && compgen -f -- "$cur") )
				return 0
				;;
			ins | install)
				[[ ! -d "$TMP_DIR/mods" ]] && return 1
				COMPREPLY=( $(cd "$TMP_DIR/mods" && compgen -d -- "$cur") )
				return 0
				;;
			imp | import)
				[[ ! -d "$TMP_DIR/profile" ]] && return 1
				COMPREPLY=( $(cd "$TMP_DIR/profile" && compgen -f -X "@(*[._]*|config|new)" -- "$cur") )
				return 0
				;;
			un | uninstall)
				[[ ! -d "$PLUGINS_DIR" ]] && return 1
				COMPREPLY=( $(cd "$PLUGINS_DIR" && compgen -d -X "@(R2API|bbepis-BepInExPack-*)" -- "$cur") )
				return 0
				;;
			*)
				;;
		esac
	fi

}

complete -F _r2mod r2mod
