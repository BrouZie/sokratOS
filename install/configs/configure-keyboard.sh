#!/bin/bash

# Script to detect and configure keyboard layout in Hyprland

# Detect current keyboard layout
detect_kb_layout() {
	local kb_layout=""

	# Try to get from localectl (systemd)
	if command -v localectl &> /dev/null; then
		kb_layout=$(localectl status 2>/dev/null | grep "X11 Layout" | awk '{print $3}')
	fi

	# Fallback: check /etc/X11/xorg.conf.d/ or vconsole.conf
	if [ -z "$kb_layout" ]; then
		if [ -f /etc/vconsole.conf ]; then
			kb_layout=$(grep "^KEYMAP=" /etc/vconsole.conf | cut -d'=' -f2)
			# Convert console keymap to X11 layout (approximate)
			case "$kb_layout" in
				no*) kb_layout="no" ;;
				us*) kb_layout="us" ;;
				uk*) kb_layout="gb" ;;
				de*) kb_layout="de" ;;
				fr*) kb_layout="fr" ;;
				es*) kb_layout="es" ;;
				sv*) kb_layout="se" ;;
				dk*) kb_layout="dk" ;;
			esac
		fi
	fi

	# Final fallback: default to 'us'
	if [ -z "$kb_layout" ]; then
		kb_layout="us"
	fi

	echo "$kb_layout"
}

# Detect keyboard variant
detect_kb_variant() {
	local kb_variant=""

	if command -v localectl &> /dev/null; then
		kb_variant=$(localectl status 2>/dev/null | grep "X11 Variant" | awk '{print $3}')
	fi

	# Default to nodeadkeys if nothing found
	if [ -z "$kb_variant" ]; then
		kb_variant="nodeadkeys"
	fi

	echo "$kb_variant"
}

# Main configuration
INPUT_CONF="$HOME/.config/hypr/configs/input.conf"

# Detect keyboard settings
KB_LAYOUT=$(detect_kb_layout)
KB_VARIANT=$(detect_kb_variant)

echo "Detected keyboard layout: $KB_LAYOUT"
echo "Detected keyboard variant: $KB_VARIANT"

# Update the input.conf file if it exists
if [ -f "$INPUT_CONF" ]; then
	# Use sed to replace the kb_layout line
	sed -i "s/kb_layout = .*/kb_layout = $KB_LAYOUT/" "$INPUT_CONF"
	sed -i "s/kb_variant = .*/kb_variant = $KB_VARIANT/" "$INPUT_CONF"
	echo "Updated $INPUT_CONF with detected keyboard settings"
else
	echo "Warning: $INPUT_CONF not found"
fi
