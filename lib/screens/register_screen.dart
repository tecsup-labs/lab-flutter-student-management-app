import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Alignment, Offset, BoxShadow, BoxShape, BuildContext, Color, EdgeInsets, FontWeight, MainAxisAlignment, CrossAxisAlignment, Navigator, TextStyle;
import '../globals.dart';
import '../models/alumno.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();

  final FocusNode _nombresFocus = FocusNode();
  final FocusNode _apellidosFocus = FocusNode();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
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

  Future<void> _selectFecha() async {
    DateTime tempDate = DateTime(2008, 1, 1);
    
    // Si ya hay una fecha ingresada, intentar cargarla en el picker
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
                minimumDate: DateTime(1990),
                maximumDate: DateTime.now(),
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

  void _saveStudent() {
    final nombres = _nombresController.text.trim();
    final apellidos = _apellidosController.text.trim();
    final fecha = _fechaNacimientoController.text.trim();

    if (nombres.isEmpty || apellidos.isEmpty || fecha.isEmpty) {
      _showAlertDialog('Campos incompletos', 'Por favor, completa todos los campos.');
      return;
    }

    // Validación de nombres y apellidos (solo letras y espacios, incluyendo tildes y ñ)
    final RegExp nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    if (!nameRegExp.hasMatch(nombres) || !nameRegExp.hasMatch(apellidos)) {
      _showAlertDialog('Formato inválido', 'Los nombres y apellidos solo deben contener letras.');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    // Simula una petición de red para guardar de 1.2 segundos
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });

      // Agregar el alumno al listado global en memoria
      final nuevoAlumno = Alumno(
        nombres: nombres,
        apellidos: apellidos,
        fechaNacimiento: fecha,
      );
      Globals.alumnos.add(nuevoAlumno);

      // Dialog de éxito de Cupertino
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Registro Exitoso', style: TextStyle(fontFamily: 'Outfit')),
          content: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Alumno registrado correctamente.', style: TextStyle(fontFamily: 'Outfit')),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.back,
            color: Color(0xFF2B231E),
          ),
        ),
        middle: const Text(
          'Registrar Alumno',
          style: TextStyle(
            color: Color(0xFF2B231E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Outfit',
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Icono central decorativo (Usuario con signo +)
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF2E6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF7A00).withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.person,
                          size: 52,
                          color: Color(0xFFFF7A00),
                        ),
                        Positioned(
                          right: 26,
                          top: 26,
                          child: Icon(
                            CupertinoIcons.add,
                            size: 20,
                            color: Color(0xFFFF7A00),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Campo Nombres
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
                // Campo Apellidos
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
                // Campo Fecha de Nacimiento
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
                // Botón Guardar Alumno
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: const Color(0xFFFF7A00),
                    borderRadius: BorderRadius.circular(16),
                    onPressed: _isSaving ? null : _saveStudent,
                    child: _isSaving
                        ? const CupertinoActivityIndicator(color: Colors.white)
                        : const Text(
                            'Guardar Alumno',
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
        ),
      ),
    );
  }
}
