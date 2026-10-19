# Cuaderno Barcelona 2027

App web para la preparación de la Marató de Barcelona (14 de marzo de 2027): plan 3+3 de 26 semanas, registro de sesiones, ritmos E/T/M, avisos de carga, series por grupo muscular y control físico. Funciona en el ordenador y en el móvil con la misma cuenta.

- **Web:** GitHub Pages (archivos estáticos, sin compilación).
- **Datos:** Supabase (Postgres + Auth). Cada fila lleva `user_id` y las reglas RLS solo dejan leer y escribir las tuyas.

## Puesta en marcha

1. **Supabase → SQL Editor:** pega `schema.sql` y pulsa *Run*.
2. **Supabase → Authentication → URL Configuration:** pon como *Site URL* la dirección de GitHub Pages (`https://jaumesalom10.github.io/cuaderno-barcelona-2027/`) y añádela también en *Redirect URLs*.
3. **`config.js`:** rellena `supabaseUrl` y `supabaseAnonKey` (Project Settings → API).
4. **GitHub → Settings → Pages:** *Deploy from a branch*, rama `main`, carpeta `/ (root)`.
5. Abre la web, pulsa **Crear cuenta**, confirma el email y entra.
6. **Ajustes → Importar JSON** para cargar tus registros anteriores.

## En el móvil

Abre la web y añádela a la pantalla de inicio (Safari: Compartir → *Añadir a pantalla de inicio*; Chrome: menú → *Instalar app*). Se abre a pantalla completa y mantiene la sesión.

## Archivos

| Archivo | Qué es |
|---|---|
| `index.html` | La app completa: plan, vistas y lógica |
| `config.js` | URL y clave pública de tu proyecto de Supabase |
| `schema.sql` | Tablas `logs`, `settings` y `body`, reglas RLS y tiempo real |
| `vendor/` | Cliente de Supabase (supabase-js 2.45.4) servido desde el propio repositorio |
| `manifest.webmanifest`, `icons/` | Instalación como app en el móvil |

## Cambiar el plan

Las sesiones están en `index.html`: carrera en `RUNS` (una fila por semana: martes, jueves, domingo) y fuerza en `LIB_NEW` y las plantillas `NEW_A`, `NEW_B`, `NEW_C`. Las claves de los registros son `fecha-índice` (`2026-10-14-30`), así que puedes cambiar el contenido de una sesión sin perder lo que ya registraste.
