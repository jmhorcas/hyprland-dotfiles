Crea una lista de los paquetes:

`pacman -Qe | awk '{print $1}' > my_programs.txt`

Restaurar:
`sudo pacman -S --needed - < my_programs.txt`


Restaurar configuración:
`git clone https://github.com/jmhorcas/hyprland-dotfiles.git ~/my-dotfiles`
`cp -r ~/my-dotfiles/* ~/.config/`


