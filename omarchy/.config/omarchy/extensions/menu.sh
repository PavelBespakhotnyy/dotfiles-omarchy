show_style_menu() {
  case $(menu "Style" "󰸌  Theme\n  Font\n󱄄  Background\n󱄄  Hyprland\n󱄄  Screensaver\n󱄄  Blueprint\n󱄄  Animations\n󰍜  Waybar Colors\n  About") in
  *Theme*) show_theme_menu ;;
  *Font*) show_font_menu ;;
  *Background*) show_background_menu ;;
  *Hyprland*) open_in_editor ~/.config/hypr/looknfeel.conf ;;
  *Screensaver*) open_in_editor ~/.config/omarchy/branding/screensaver.txt ;;
  *Blueprints*) show_blueprints_menu ;;
  *Animations*) show_animations_menu ;;
  *"Waybar Colors"*) show_waybar_colors_menu ;;
  *About*) open_in_editor ~/.config/omarchy/branding/about.txt ;;
  *) show_main_menu ;;
  esac
}

show_animations_menu() {
  case $(menu "Animations" "  Caelestia\n  SaneAspect") in
  *Caelestia*) ln -sf ~/.config/hypr/animations-caelestia.conf ~/.config/hypr/animations-current.conf && hyprctl reload ;;
  *SaneAspect*) ln -sf ~/.config/hypr/animations-saneaspect.conf ~/.config/hypr/animations-current.conf && hyprctl reload ;;
  *) back_to show_style_menu ;;
  esac
}

show_waybar_colors_menu() {
  case $(menu "Waybar Colors" "  Colorful\n  Ink") in
  *Colorful*) ln -sf ~/.config/waybar/colors-bright.css ~/.config/waybar/colors-current.css && omarchy-restart-waybar ;;
  *Ink*) ln -sf ~/.config/waybar/colors-ink.css ~/.config/waybar/colors-current.css && omarchy-restart-waybar ;;
  *) back_to show_style_menu ;;
  esac
}

show_blueprints_menu() {
  items=$(command ls ~/.config/aether/blueprints/ | sed 's/\.json$//' | paste -sd '\n')
  choice=$(menu "Blueprint" "$items")
  [ -z "$choice" ] && back_to show_style_menu && return
  aether --apply-blueprint "$choice"
}