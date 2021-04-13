# r2mod completion                                        -*- shell-script -*-

_r2mod()
{
	shopt -s extglob
	local cur prev first commands R2_DIR CONFIG_DIR PLUGINS_DIR TMP_DIR
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	first="${COMP_WORDS[1]}"
	commands="check delete disable edit enable export hold import install list load refresh remove run save search setup uninstall update version"

	if [[ -n "$R2MOD_INSTALL_DIR" ]]; then
		# Custom install location
		R2_DIR="$R2MOD_INSTALL_DIR"
	elif [[ -d "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2" ]]; then
		# Flatpak install
		R2_DIR="$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2"
	else
		# Default
		R2_DIR="$HOME/.local/share/Steam/steamapps/common/Risk of Rain 2"
	fi

	BEPIN_DIR="$R2_DIR/BepInEx"
	CONFIG_DIR="$BEPIN_DIR/config"
	PLUGINS_DIR="$BEPIN_DIR/plugins"
	PLUGINS_DISABLED_DIR="$BEPIN_DIR/plugins_disabled"
	PROFILES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/r2mod_cli/profiles"
	TMP_DIR="/tmp/r2mod"

	case "$COMP_CWORD" in
		1)
			COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
			return 0
			;;

		2)
			case "$prev" in
				ed | edit)
					[[ ! -d "$CONFIG_DIR" ]] && return 1
					COMPREPLY=( $(cd "$CONFIG_DIR" && compgen -f -- "$cur") )
					return 0
					;;
				en | enable)
					[[ ! -d "$PLUGINS_DISABLED_DIR" ]] && return 1
					COMPREPLY=( $(cd "$PLUGINS_DISABLED_DIR" && compgen -d -- "$cur") )
					return 0
					;;
				ins | install)
					[[ ! -f "$TMP_DIR/comp_cache" ]] && return 1
					local mods=$(cat "$TMP_DIR/comp_cache" | tr '\n' ' ')
					COMPREPLY=( $(compgen -W "$mods" -- "$cur" ) )
					return 0
					;;
				imp | import)
					[[ ! -d "$TMP_DIR/profile" ]] && return 1
					COMPREPLY=( $(cd "$TMP_DIR/profile" && compgen -f -X "@(*[._]*|config|new)" -- "$cur") )
					return 0
					;;
				li | list | ls)
					local args="all count"
					COMPREPLY=( $(compgen -W "$args" -- "$cur" ) )
					return 0
					;;
				loa | load | del | delete | sav | save)
					[[ ! -d "$PROFILES_DIR" ]] && return 1
					COMPREPLY=( $(cd "$PROFILES_DIR" && compgen -f -- "$cur") )
					COMPREPLY=( "${COMPREPLY[@]/.zip/}" )
					return 0
					;;
				un | uninstall | hol | hold | rem | remove | dis | disable)
					[[ ! -d "$PLUGINS_DIR" ]] && return 1
					COMPREPLY=( $(cd "$PLUGINS_DIR" && compgen -d -X "@(*R2API*|MMHOOK|bbepis-BepInExPack-*|RiskofThunder-HookGenPatcher-*)" -- "$cur") )
					return 0
					;;
				*)
					;;
			esac
			;;

		3)
			case "$first" in
				imp | import)
					COMPREPLY=( "preview" )
					return 0
					;;
				li | list | ls)
					[[ "$prev" != "all" ]] && COMPREPLY=( "all" )
					return 0
					;;
				*)
					;;
			esac
			;;

		*)
			return 1
			;;
	esac
}

complete -F _r2mod r2mod
