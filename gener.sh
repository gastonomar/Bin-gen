#!/bin/bash

echo -e "\e[35m
╭━━━┳━━━┳━╮╱╭╮
┃╭━╮┃╭━━┫┃╰╮┃┃
┃┃╱╰┫╰━━┫╭╮╰╯┃
┃┃╭━┫╭━━┫┃╰╮┃┃
┃╰┻━┃╰━━┫┃╱┃┃┃
╰━━━┻━━━┻╯╱╰━╯
╭━━━┳━━━┳━╮╱╭╮
┃╭━╮┃╭━╮┃┃╰╮┃┃
┃┃╱╰┫┃╱┃┃╭╮╰╯┃
┃┃╱╭┫┃╱┃┃┃╰╮┃┃
┃╰━╯┃╰━╯┃┃╱┃┃┃
╰━━━┻━━━┻╯╱╰━╯\e[0m"

echo -e "\e[1;31mGENERADOR DE CONTRASEÑAS\e[0m"


echo "1. Nombres"
echo "2. Números"
read -p "Elige una opción (1/2): " option

read -p "¿Cuántas contraseñas quieres generar? " num_passwords

# Función para generar contraseñas con nombres latinos
function generate_name_password() {
    local first_names=("Alejandro" "Beatriz" "Carlos" "Daniela" "Enrique" "Fernanda" "Guillermo" "Isabela" "Javier" "Mariana" "Nicolás" "Paulina" "Raúl" "Sofía" "Tomás" "Valentina")
    local last_names=("Acevedo" "Bermúdez" "Cortés" "Domínguez" "Escobar" "Fernández" "García" "Herrera" "Jiménez" "López" "Martínez" "Núñez" "Ortiz" "Pérez" "Rodríguez" "Sánchez")
    local password="${first_names[$RANDOM % ${#first_names[@]}]}${last_names[$RANDOM % ${#last_names[@]}]}"
    echo "$password"
}

# Función para generar contraseñas con números
function generate_number_password() {
    local password=$(tr -dc '0-9' </dev/urandom | head -c 10)
    echo "$password"
}

# Generar y mostrar las contraseñas
for i in $(seq 1 $num_passwords); do
    if [[ $option -eq 1 ]]; then
        password=$(generate_name_password)
    else
        password=$(generate_number_password)
    fi
    echo "$password"
done

# Preguntar si se quiere guardar las contraseñas en la tarjeta SD
read -p "¿Quieres guardar las contraseñas en la tarjeta SD? (s/n) " save_to_sd
if [[ $save_to_sd == "s" ]]; then
    mkdir -p /sdcard/passwords
    if [[ $option -eq 1 ]]; then
        for i in $(seq 1 $num_passwords); do
            password=$(generate_name_password)
            echo "$password" >> /sdcard/passwords/name_passwords.txt
        done
    else
        for i in $(seq 1 $num_passwords); do
            password=$(generate_number_password)
            echo "$password" >> /sdcard/passwords/number_passwords.txt
        done
    fi
    echo "Las contraseñas se han guardado en /sdcard/passwords"
else
    echo "No se han guardado las contraseñas."
fi