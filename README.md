# Gestor de Alumnos - Flutter Premium App 🎓

Una aplicación móvil moderna, minimalista y elegante desarrollada en Flutter (Dart) para la gestión académica simulada de alumnos, creada como parte del **Laboratorio S10** por **Antony Cholan**.

---

## 🎨 Características Destacadas
*   **Visuales Premium e Interfaz Coherente**: Paleta de colores cálida de alto contraste (`Color(0xFFFFF9F5)` de fondo y textos en `Color(0xFF2B231E)`), logrando una legibilidad perfecta.
*   **Diseño Abstracto Limpio**: Sustitución de imágenes por iconos vectoriales estilizados para una estética minimalista.
*   **Navegación Fluida**: Flujo completo de 5 pantallas dinámicas implementado mediante rutas nativas (`Navigator.push` y `Navigator.pop`).
*   **Cabecera de Login Curva (CustomWaveClipper)**: Onda con degradado fluido naranja y curvas de Bézier cuadráticas para una primera impresión premium.
*   **Persistencia Simulada en Memoria**: Gestión dinámica de la información en memoria temporal reactiva (`Globals.alumnos`) compartida a través de las pantallas.
*   **Validaciones en Formularios (RegExp)**: Control robusto mediante expresiones regulares que bloquea números y caracteres especiales en los nombres y apellidos.
*   **Empty States Inteligentes**: Pantalla informativa ilustrada que responde reactivamente cuando el listado de alumnos está vacío.
*   **Diálogo de Cerrar Sesión Personalizado**: Cuadro interactivo moderno con diseño redondeado e iconos decorativos.
*   **Selector de Fecha Tematizado**: Integración del widget de calendario nativo tematizado en armonía con los colores de la aplicación.

---

## 📸 Estructura del Flujo de Pantallas
1.  **LoginScreen**: Autenticación segura con credenciales simuladas (`admin` / `1234`).
2.  **HomeScreen**: Panel principal interactivo con el saludo personalizado al usuario e icono del perfil a la cabecera.
3.  **RegisterScreen**: Registro completo de nuevos alumnos con validación de letras y selector de fecha.
4.  **ListScreen**: Listado reactivo de alumnos con avatares autogenerados de colores, buscador dinámico en tiempo real y vista de estado vacío.
5.  **ProfileScreen**: Edición de datos del perfil del usuario administrador.
6.  **FaqScreen**: Sección interactiva de preguntas y respuestas frecuentes implementada con `ExpansionTile`.

---

## 🚀 Requisitos para la Ejecución
*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (versión estable más reciente).
*   [Dart SDK](https://dart.dev/get-dart).
*   Simulador iOS (Xcode) o Android Emulator.

---

## 📦 Instalación y Uso

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tecsup-labs/lab-flutter-student-management-app.git
   cd lab-flutter-student-management-app
   ```

2. **Obtener dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```
