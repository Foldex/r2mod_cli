set -l subcommands check delete disable edit enable export hold import install load list refresh remove run save search setup uninstall update version
set -l subcommands_short ch del dis ed en exp hol imp ins li ls loa ref rem sav sea set un upd ver

function __fish_r2mod_nth
	test (count (commandline -poc)) = $argv[1]
end

function __fish_bepin_dir
	if set -q R2MOD_INSTALL_DIR
		echo $R2MOD_INSTALL_DIR/BepInEx
	else if test -d "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2"
		echo "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2/BepInEx"
	else
		echo "$HOME/.local/share/Steam/steamapps/common/Risk of Rain 2/BepInEx"
	end
end

function __fish_r2mod_configs
	path basename (__fish_bepin_dir)/config/**
end
function __fish_r2mod_disabled
	path basename (__fish_bepin_dir)/plugins_disabled/* \
		| string match --invert -r "^(.*R2API.*|MMHOOK|RoR2BepInExPack|bbepis-BepInExPack-.*|RiskofThunder-HookGenPatcher-.*)"
end
function __fish_r2mod_enabled
	path basename (__fish_bepin_dir)/plugins/* \
		| string match --invert -r "^(.*R2API.*|MMHOOK|RoR2BepInExPack|bbepis-BepInExPack-.*|RiskofThunder-HookGenPatcher-.*)"
end
function __fish_r2mod_remote_plugins
	set -l cc /tmp/r2mod/comp_cache
	test -f $cc && cat $cc
end
function __fish_r2mod_profiles
	path basename (
		if set -q XDG_CONFIG_HOME
			echo "$XDG_CONFIG_HOME"
		else
			echo "$HOME/.config"
		end)/r2mod_cli/profiles/* | string replace -f ".zip" ""
end
function __fish_r2mod_imports
	path basename /tmp/r2mod/profile/* | string match --invert -r '(\.|_|^config$|^new$)'
end

complete -c r2mod -c io.github.Foldex.r2mod -f
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a check -d "Check for Script Updates"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a delete -d "Delete a Profile"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a disable -d "Disable Mods"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a edit -d "Edit Mod Configs"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a enable -d "Enable Mods"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a export -d "Export r2modman mod profile"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a hold -d "Toggle Mod Updates"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a import -d "Import r2modman mod profile"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a install -d "Install New Mod"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a load -d "Load a Profile"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a list -d "List Installed Mods"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a refresh -d "Force Refresh Package Cache"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a remove -d "Uninstall a mod"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a run -d "Launch Risk of Rain"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a save -d "Save a Profile"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a search -d "Search for Mods"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a setup -d "Install a Fresh BepInEx Setup"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a uninstall -d "Uninstall a mod"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a update -d "Update All Existing Mods"
complete -c r2mod -c io.github.Foldex.r2mod -n "not __fish_seen_subcommand_from $subcommands $subcommands_short" -a version -d "Print Version"

complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from ed edit && __fish_r2mod_nth 2" -a "(__fish_r2mod_configs)"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from en enable && __fish_r2mod_nth 2" -a "(__fish_r2mod_disabled)"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from dis disable un uninstall hol hold rem remove && __fish_r2mod_nth 2" -a "(__fish_r2mod_enabled)"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from ins install && __fish_r2mod_nth 2" -a "(__fish_r2mod_remote_plugins)"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from loa load del delete sav save && __fish_r2mod_nth 2" -a "(__fish_r2mod_profiles)"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from imp import && __fish_r2mod_nth 2" -a "(__fish_r2mod_imports)"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from imp import && __fish_r2mod_nth 3" -a preview

complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from li list ls && not __fish_seen_subcommand_from count names" -a "count names"
complete -c r2mod -c io.github.Foldex.r2mod -n "__fish_seen_subcommand_from li list ls && not __fish_seen_subcommand_from all" -a "all"
