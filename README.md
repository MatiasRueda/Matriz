# Matriz

## Introducción
Trabajo practico de la materia Organizacion del computador de la Facultad de Ingeniería Universidad de Buenos Aires
La idea detrás de este proyecto es poner en practica los distintos conocimientos sobre Assembler Intel x86.
El programa le servirá como una mini calculadora para realizar operaciones con matrices cuadradas.
( sumar, restar, entre otras cosas ).

## Tipo de proyecto
Proyecto individual.

## Tecnologías usadas
- Intel x86

## Instalación ( para Windows )
1 - Descargar nasm de la siguiente pagina: https://www.nasm.us/pub/nasm/releasebuilds/?C=M;O=D
    - Elegir la versión mas reciente.
    - Elegir Win64 o Win32 ( dependiendo la versión que tenga ).
    - Descargar el .zip.
    - Extraerlo.
    - Agregar a la variable Path la dirección de la carpeta donde se extrajo. Por ejemplo: C:\nasm-2.16-win64\nasm-2.16.
2 - Descargar MinGW de la siguiente pagina: https://sourceforge.net/projects/mingw-w64/files/
    - Dirigirse a la sección  MinGW-W64 GCC-8.1.0.
    - Descargar la versión **x86_64-win32-sjlj**.
    - Extraerlo.
    - Agregar a la variable Path la direccion de la carpeta bin que esta dentro de la carpeta donde se extrajo. Por ejemplo: C:\mingw-w64\bin.

> [!Nota]
> Los directorios que son utilizados como ejemplos son solo referencias, se pueden extraer donde usted mas desee.


## Uso
Después de clonar el repo o descargar el zip ( y extraerlo ), es necesario abrir la terminal en la ruta de la carpeta que se extrajo.
Para que programa empiece a funcionar escriba los siguientes comandos:
```
nasm matriz.asm -f win64
gcc matriz.obj -o matriz
./matriz
```
