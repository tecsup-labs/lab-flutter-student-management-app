# Gestor de Alumnos - Flutter Cupertino App

Una aplicación móvil moderna, minimalista y de alto rendimiento desarrollada en Flutter (Dart) bajo los lineamientos y directrices de diseño Apple iOS (Cupertino). Creada por Antony Cholan para el desarrollo académico del curso de aplicaciones multiplataforma.

Este proyecto demuestra una transición arquitectónica y visual completa desde Material Design hacia el ecosistema Cupertino, logrando la experiencia nativa que un usuario de iPhone espera, optimizando layouts para dispositivos modernos con Dynamic Island y respetando la paleta cromática personalizada y premium del diseño original.

---

## Credenciales de Acceso (Simuladas)

Para evaluar el flujo de autenticación en la pantalla de inicio de sesión (LoginScreen), utilice los siguientes datos de acceso:

*   **Usuario / Correo:** admin (o admin@ejemplo.com)
*   **Contraseña:** 1234

---

## Características e Implementación de Cupertino (iOS)

Se ha migrado el núcleo completo de la aplicación, incorporando componentes nativos del paquete flutter/cupertino.dart:

1.  **Arquitectura de Temas Nativos (CupertinoApp):**
    *   Sustitución de MaterialApp por CupertinoApp.
    *   Uso de CupertinoThemeData para heredar de forma centralizada la tipografía premium Outfit y la paleta de colores personalizada (fondo crema #FFF9F5 y textos en #2B231E).
2.  **Pantalla de Login con iOS Switch:**
    *   Migración de inputs de texto a CupertinoTextField con enfoque activo de color.
    *   Uso de CupertinoSwitch (interruptor deslizante de iOS) en lugar del checkbox de Android.
    *   Indicador de carga circular nativo CupertinoActivityIndicator integrado en el botón de ingreso para simular latencia de red.
3.  **Selector de Fecha Deslizante (CupertinoDatePicker):**
    *   El formulario de registro (RegisterScreen) y perfil (ProfileScreen) despliegan un CupertinoDatePicker en forma de rodillo 3D dentro de una hoja inferior deslizable (showCupertinoModalPopup), simulando el comportamiento de fecha nativo de Apple.
4.  **Confirmación con Cupertino Action Sheet:**
    *   La confirmación de salida en el cierre de sesión se realiza mediante CupertinoActionSheet, emergiendo desde la base del dispositivo con diseño redondeado y botón de alerta destructivo (rojo) para la salida segura.
5.  **Pestañas Segmentadas (CupertinoSegmentedControl):**
    *   Implementación de pestañas de filtrado superior en el listado de alumnos para ordenar registros instantáneamente: Todos, Nombre (A-Z) y Nuevos (registrados recientes).
6.  **Interacción Avanzada 3D Touch (CupertinoContextMenu):**
    *   Cada tarjeta de alumno de la lista está envuelta en un CupertinoContextMenu. Al mantener presionado un alumno, la celda flota y desenfoca la pantalla de fondo, mostrando opciones flotantes para "Ver Detalles" (mediante CupertinoAlertDialog) o "Eliminar Alumno".
7.  **Header Seguro con SafeArea:**
    *   Se rediseñó el header de la pantalla de perfil (ProfileScreen) integrando controles de navegación personalizados en el cuerpo de la vista con soporte directo de SafeArea. Esto garantiza que los botones de navegación ("Atrás") queden posicionados perfectamente bajo la hora e islas dinámicas sin recortar interacciones.

---

## Estructura del Flujo de Pantallas

1.  **LoginScreen:** Autenticación de usuario con spinner de carga simulado y switch de iOS.
2.  **HomeScreen:** Panel principal que da la bienvenida al usuario y enlaza mediante atenuaciones táctiles nativas a los módulos.
3.  **RegisterScreen:** Formulario de registro con Expresiones Regulares (RegExp) para bloquear números y selector de fecha iOS.
4.  **ListScreen:** Listado reactivo de alumnos con avatares de color dinámicos, pestañas de ordenamiento segmentado, buscador e interacción de presión larga.
5.  **ProfileScreen:** Panel de edición del perfil del administrador con controles adaptados para evitar superposiciones con el notch o Dynamic Island.
6.  **FaqScreen:** Módulo de preguntas frecuentes animado mediante el widget personalizado CupertinoExpansionTile.

---

## Instalación y Uso

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tecsup-labs/lab-flutter-student-management-app.git
   cd lab-flutter-student-management-app
   ```

2. **Obtener las dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar en el simulador de iOS o dispositivo físico**:
   ```bash
   flutter run
   ```
