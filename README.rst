admincfdi-winsetup
===================

Descripción
-----------

Genera automáticamente y desde GNU/Linux los instaladores de admin-cfdi para sistemas w32.

Dependencias
------------

- Comandos GNU/Linux: sha256sum, uuidgen, sed (vienen incluidos en la mayoría de las distros).
- Inno Setup 5.5.5: Herramienta para generar instaladores de sistemas w32 https://github.com/jrsoftware/issrc
- git: Para clonar la última version de admin-cfdi
- wine: Emula librerías de w32 para ejecutar el compilador de Inno Setup en GNU/Linux
- Xvfb: Ejecuta un servidor X virtual para usar el compilador de Inno Setup desde la consola

Instalación
-----------

1. Usa el gestor de paquetes de tu distro para instalar los paquetes git, wine y Xvfb.
2. Descarga e instala isetup-5.5.5.exe usando wine (para instalar si se requiere entorno gráfico).
3. Clona el repo https://github.com/fipasoft/admincfdi-winsetup en la carpeta ~/.wine/drive_c/admincfdi-winsetup
4. Crea un archivo config basándote en el archivo config.sample y ajústalo a tus necesidades

Uso
---
1. Cambia a la carpeta ~/.wine/drive_c/admincfdi-winsetup y ejecuta el script gensetup-admincfdi.sh
2. En la carpeta output se guardan los archivos generados: .iss (de Inno Setup), el instalador setup.exe y la suma de comprobacion sha256.
