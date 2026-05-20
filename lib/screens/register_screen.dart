import 'package:flutter/material.dart';
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

  Future<void> _selectFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2008, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF7A00),
              onPrimary: Colors.white,
              onSurface: Color(0xFF2D2D2D),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final dia = picked.day.toString().padLeft(2, '0');
        final mes = picked.month.toString().padLeft(2, '0');
        _fechaNacimientoController.text = '$dia/$mes/${picked.year}';
      });
    }
  }

  void _saveStudent() {
    final nombres = _nombresController.text.trim();
    final apellidos = _apellidosController.text.trim();
    final fecha = _fechaNacimientoController.text.trim();

    if (nombres.isEmpty || apellidos.isEmpty || fecha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Completa todos los campos'),
            ],
          ),
          backgroundColor: const Color(0xFFFF9533),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    // Validación de nombres y apellidos (solo letras y espacios, incluyendo tildes y ñ)
    final RegExp nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    if (!nameRegExp.hasMatch(nombres) || !nameRegExp.hasMatch(apellidos)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Los nombres y apellidos solo deben contener letras',
                  style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFF4A4A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    // Agregar el alumno al listado global en memoria
    final nuevoAlumno = Alumno(
      nombres: nombres,
      apellidos: apellidos,
      fechaNacimiento: fecha,
    );
    Globals.alumnos.add(nuevoAlumno);

    // Feedback visual premium
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Alumno registrado correctamente',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF34C759),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF2B231E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Registrar Alumno',
          style: TextStyle(
            color: Color(0xFF2B231E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                        Icons.person_outline_rounded,
                        size: 52,
                        color: Color(0xFFFF7A00),
                      ),
                      Positioned(
                        right: 26,
                        top: 26,
                        child: Icon(
                          Icons.add,
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
                child: TextField(
                  controller: _nombresController,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF2B231E)),
                  decoration: InputDecoration(
                    hintText: 'Ingresa nombres',
                    hintStyle: const TextStyle(color: Color(0xFF8C847E), fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xFFFF7A00).withOpacity(0.18),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xFFFF7A00).withOpacity(0.12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF7A00),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
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
                child: TextField(
                  controller: _apellidosController,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF2B231E)),
                  decoration: InputDecoration(
                    hintText: 'Ingresa apellidos',
                    hintStyle: const TextStyle(color: Color(0xFF8C847E), fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xFFFF7A00).withOpacity(0.18),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xFFFF7A00).withOpacity(0.12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF7A00),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
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
                child: TextField(
                  controller: _fechaNacimientoController,
                  readOnly: true,
                  onTap: _selectFecha,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF2B231E)),
                  decoration: InputDecoration(
                    hintText: 'Selecciona una fecha',
                    hintStyle: const TextStyle(color: Color(0xFF8C847E), fontSize: 14),
                    suffixIcon: const Icon(
                      Icons.calendar_today_rounded,
                      color: Color(0xFFFF7A00),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xFFFF7A00).withOpacity(0.18),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xFFFF7A00).withOpacity(0.12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF7A00),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Botón Guardar Alumno
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Guardar Alumno',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
