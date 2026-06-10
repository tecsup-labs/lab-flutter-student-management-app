import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Alignment, Offset, BoxShadow, BoxShape, BuildContext, Color, EdgeInsets, FontWeight, MainAxisAlignment, CrossAxisAlignment, MainAxisSize, Navigator, Radius, TextStyle, Stack, Positioned;
import '../globals.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();

  final FocusNode _nombresFocus = FocusNode();
  final FocusNode _apellidosFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Carga de datos iniciales desde Globals
    _nombresController.text = Globals.nombresPerfil;
    _apellidosController.text = Globals.apellidosPerfil;
    _fechaNacimientoController.text = Globals.fechaNacimientoPerfil;

    _nombresFocus.addListener(() => setState(() {}));
    _apellidosFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nombresFocus.dispose();
    _apellidosFocus.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }

  void _showAlertDialog(String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title, style: const TextStyle(fontFamily: 'Outfit')),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(message, style: const TextStyle(fontFamily: 'Outfit')),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK', style: TextStyle(fontFamily: 'Outfit', color: Color(0xFFFF7A00))),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // Método para seleccionar fecha
  Future<void> _selectFecha() async {
    DateTime tempDate = DateTime(2000, 5, 15);
    
    if (_fechaNacimientoController.text.isNotEmpty) {
      try {
        final parts = _fechaNacimientoController.text.split('/');
        if (parts.length == 3) {
          tempDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        }
      } catch (_) {}
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: const Color(0xFFFFF9F5),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancelar', style: TextStyle(color: Color(0xFF70655E), fontFamily: 'Outfit')),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('Aceptar', style: TextStyle(color: Color(0xFFFF7A00), fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                    onPressed: () {
                      setState(() {
                        final dia = tempDate.day.toString().padLeft(2, '0');
                        final mes = tempDate.month.toString().padLeft(2, '0');
                        _fechaNacimientoController.text = '$dia/$mes/${tempDate.year}';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                minimumDate: DateTime(1900),
                maximumDate: DateTime(2100),
                onDateTimeChanged: (DateTime newDate) {
                  tempDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    final nombres = _nombresController.text.trim();
    final apellidos = _apellidosController.text.trim();

    if (nombres.isEmpty || apellidos.isEmpty) {
      _showAlertDialog('Campos obligatorios', 'Por favor, completa los campos obligatorios.');
      return;
    }

    // Validación de nombres y apellidos (solo letras y espacios, incluyendo tildes y ñ)
    final RegExp nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    if (!nameRegExp.hasMatch(nombres) || !nameRegExp.hasMatch(apellidos)) {
      _showAlertDialog('Formato inválido', 'Los nombres y apellidos solo deben contener letras.');
      return;
    }

    // Guardar en memoria temporal
    Globals.nombresPerfil = _nombresController.text.trim();
    Globals.apellidosPerfil = _apellidosController.text.trim();
    Globals.fechaNacimientoPerfil = _fechaNacimientoController.text.trim();

    // Dialog de éxito de Cupertino
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Perfil Actualizado', style: TextStyle(fontFamily: 'Outfit')),
        content: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text('Perfil actualizado correctamente.', style: TextStyle(fontFamily: 'Outfit')),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK', style: TextStyle(fontFamily: 'Outfit', color: Color(0xFFFF7A00))),
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      child: Column(
        children: [
          // Header de Navegación Naranja Seguro
          Container(
            color: const Color(0xFFFF7A00),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                              size: 26,
                            ),
                            Text(
                              'Atrás',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Outfit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      'Mi Perfil',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Cuerpo Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Onda decorativa en el header simulando la curva naranja del perfil
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF7A00),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -20,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Avatar circular con icono
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFFFF2E6),
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                CupertinoIcons.person_fill,
                                size: 56,
                                color: Color(0xFFFF7A00),
                              ),
                            ),
                            // Botón flotante de la cámara
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF7A00),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                CupertinoIcons.camera_fill,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  // Formulario
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombres
                        const Text(
                          'Nombres',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B231E),
                            fontFamily: 'Outfit',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF7A00).withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CupertinoTextField(
                            controller: _nombresController,
                            focusNode: _nombresFocus,
                            placeholder: 'Ingresa nombres',
                            placeholderStyle: const TextStyle(color: Color(0xFF8C847E), fontSize: 14, fontFamily: 'Outfit'),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _nombresFocus.hasFocus
                                    ? const Color(0xFFFF7A00)
                                    : const Color(0xFFFF7A00).withOpacity(0.12),
                                width: _nombresFocus.hasFocus ? 1.5 : 1.0,
                              ),
                            ),
                            style: const TextStyle(fontSize: 15, color: Color(0xFF2B231E), fontFamily: 'Outfit'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Apellidos
                        const Text(
                          'Apellidos',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B231E),
                            fontFamily: 'Outfit',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF7A00).withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CupertinoTextField(
                            controller: _apellidosController,
                            focusNode: _apellidosFocus,
                            placeholder: 'Ingresa apellidos',
                            placeholderStyle: const TextStyle(color: Color(0xFF8C847E), fontSize: 14, fontFamily: 'Outfit'),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _apellidosFocus.hasFocus
                                    ? const Color(0xFFFF7A00)
                                    : const Color(0xFFFF7A00).withOpacity(0.12),
                                width: _apellidosFocus.hasFocus ? 1.5 : 1.0,
                              ),
                            ),
                            style: const TextStyle(fontSize: 15, color: Color(0xFF2B231E), fontFamily: 'Outfit'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Fecha de Nacimiento
                        const Text(
                          'Fecha de Nacimiento',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B231E),
                            fontFamily: 'Outfit',
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _selectFecha,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF7A00).withOpacity(0.02),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CupertinoTextField(
                              controller: _fechaNacimientoController,
                              enabled: false,
                              placeholder: 'Selecciona una fecha',
                              placeholderStyle: const TextStyle(color: Color(0xFF8C847E), fontSize: 14, fontFamily: 'Outfit'),
                              suffix: const Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  CupertinoIcons.calendar,
                                  color: Color(0xFFFF7A00),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFFF7A00).withOpacity(0.12),
                                  width: 1.0,
                                ),
                              ),
                              style: const TextStyle(fontSize: 15, color: Color(0xFF2B231E), fontFamily: 'Outfit'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        // Botón Guardar
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: const Color(0xFFFF7A00),
                            borderRadius: BorderRadius.circular(16),
                            onPressed: _saveChanges,
                            child: const Text(
                              'Guardar Cambios',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
