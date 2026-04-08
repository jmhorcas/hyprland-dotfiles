Crea una lista de los paquetes:

`paru -Qqe > my_programs.txt`

Restaurar:
`paru -S --needed - < my_programs.txt`


Restaurar configuración:
`git clone https://github.com/jmhorcas/hyprland-dotfiles.git ~/my-dotfiles`
`cp -r ~/my-dotfiles/* ~/.config/`


