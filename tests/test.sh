#!/bin/bash
# Testing Script to ensure proper functionality

###########
# Globals #
###########

[[ "$1" == 1 ]] && ENABLE_EXTRA_TESTS=1

# Dirs
if [[ -d "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2" ]]; then
    # Flatpak install
	R2_DIR="$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Risk of Rain 2"
else
	R2_DIR="$HOME/.local/share/Steam/steamapps/common/Risk of Rain 2"
fi

BEPIN_DIR="$R2_DIR/BepInEx"
CONFIG_DIR="$BEPIN_DIR/config"
PLUGINS_DIR="$BEPIN_DIR/plugins"
TMP_DIR="/tmp/../r2mod"

#########
# Funcs #
#########

function cecho {

	# COLORS
	local BLUE="\e[34m"
	local GREEN="\e[32m"
	local PURPLE="\e[35m"
	local RED="\e[31m"
	local CEND="\e[0m"

	# UNICODE
	local ARROW="→"
	local CHECK="✓"
	local CROSS="✖"
	local INFO="✦"

	# INDENT
	[[ "$3" == 1 ]] && local INDENT="  "

	case "$1" in
		b) echo -e "${INDENT}${BLUE}${ARROW} ${2}${CEND}";;
		g) echo -e "${INDENT}${GREEN}${CHECK} ${2}${CEND}";;
		p) echo -e "${INDENT}${PURPLE}${INFO} ${2}${CEND}";;
		r) echo -e "${INDENT}${RED}${CROSS} ${2}${CEND}";;
	esac
}

#####################
###### TESTING ######
#####################

#########
# Setup #
#########
cecho b "Testing Setting up BepInEx"

OLD_TIME=0
NEW_TIME=0
[[ -d "$BEPIN_DIR" ]] && OLD_TIME=$(date -r "$BEPIN_DIR" +%s)
yes | ../r2mod setup > /dev/null
[[ -d "$BEPIN_DIR" ]] && NEW_TIME=$(date -r "$BEPIN_DIR" +%s)

if [[ ! -d "$BEPIN_DIR" || ! -d "$PLUGINS_DIR/R2API" || "$OLD_TIME" -ge "$NEW_TIME" ]]; then
	cecho r "Setup Failed!" 1
	exit
fi

##############
# Installing #
##############
cecho b "Testing Installing Mods"

cecho b "Bad Mod Names" 1
declare names=( "TestName" "TestName-" "TestName-Test-" "TestName-Test-1." "TestName-Test-1.0" "TestName-Test-1.0.d" "---" "--" )
for i in "${names[@]}"; do
	../r2mod install "$i" | grep -q "is not a Valid Mod Name" || cecho r "$i Failed!" 1
done


cecho b "Valid Names, Invalid Mods" 1
declare names=( "R2Test-Test" "R2Test-Test-1.0.0" )
for i in "${names[@]}"; do
	../r2mod install "$i" | grep -q "Failed to Parse JSON for" || cecho r "$i Failed!" 1
done

cecho b "Valid Mod, Check Install" 1
declare names=( "ontrigger-ItemStatsMod-2.0.0" )
for i in "${names[@]}"; do
	[[ -d "$PLUGINS_DIR/$i" ]] && rm -r "$PLUGINS_DIR/$i"
	../r2mod install "$i" > /dev/null
	[[ -d "$PLUGINS_DIR/$i" ]] || cecho r "$i Install Failed!" 1
done

################
# Uninstalling #
################
cecho b "Testing Uninstalling Mods"

cecho b "Invalid Mod Name" 1
declare names=( "TestName" "TestName-" "TestName-Test-" "TestName-Test-1." "TestName-Test-1.0" "TestName-Test-1.0.d" "---" "--" )
for i in "${names[@]}"; do
	yes n | ../r2mod uninstall "$i" | grep -q "is not a Valid Mod Name" || cecho r "$i Failed!" 1
done

cecho b "Valid Mod Name, but Not Installed" 1
declare names=( "TestName-TestNameTest-2.0.0" )
for i in "${names[@]}"; do
	yes n | ../r2mod uninstall "$i" | grep -q "not found" || cecho r "$i Failed!" 1
done

cecho b "Valid Mod Name, but Core Mod" 1
declare names=( "bbepis-BepInExPack" "tristanmcpherson-R2API")
for i in "${names[@]}"; do
	yes n | ../r2mod uninstall "$i" | grep -q "core mod" || cecho r "$i Failed!" 1
done

cecho b "Valid Mod" 1
declare names=( "ontrigger-ItemStatsMod-2.0.0" )
for i in "${names[@]}"; do
	[[ -d "$PLUGINS_DIR/$i" ]] && yes | ../r2mod uninstall "$i" > /dev/null
	[[ -d "$PLUGINS_DIR/$i" ]] && "$i Uninstall Failed!" 1
done

###########
# Profile #
###########
cecho b "Testing Importing Profiles"

cecho b "Invalid Profile Name" 1
declare names=( "" "a" "000000" "ontrigger-ItemStatsMod-2.0.0" )
for i in "${names[@]}"; do
	yes n | ../r2mod import "$i" | grep -q "is not a Valid Profile Code" || cecho r "$i Failed!" 1
done

if [[ "$ENABLE_EXTRA_TESTS" == 1 ]]; then
	cecho b "Valid Profile Name, but NonExistent Profile" 1
	declare names=( "aaaaaaaaaaa" )
	for i in "${names[@]}"; do
		yes n | ../r2mod import "$i" | grep -q "Failed to Download Profile from" || cecho r "$i Failed!" 1
	done
fi
