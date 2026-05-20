import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    // Carga de datos iniciales desde Globals
    _nombresController.text = Globals.nombresPerfil;
    _apellidosController.text = Globals.apellidosPerfil;
    _fechaNacimientoController.text = Globals.fechaNacimientoPerfil;
  }

  // Método para seleccionar fecha
  Future<void> _selectFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 5, 15),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
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
        // Formatear fecha simple: DD/MM/AAAA
        final dia = picked.day.toString().padLeft(2, '0');
        final mes = picked.month.toString().padLeft(2, '0');
        _fechaNacimientoController.text = '$dia/$mes/${picked.year}';
      });
    }
  }

  void _saveChanges() {
    final nombres = _nombresController.text.trim();
    final apellidos = _apellidosController.text.trim();

    if (nombres.isEmpty || apellidos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor, completa los campos obligatorios'),
          backgroundColor: const Color(0xFFFF4A4A),
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

    // Guardar en memoria temporal
    Globals.nombresPerfil = _nombresController.text.trim();
    Globals.apellidosPerfil = _apellidosController.text.trim();
    Globals.fechaNacimientoPerfil = _fechaNacimientoController.text.trim();

    // Mostrar feedback visual
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Perfil actualizado correctamente',
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
      // AppBar personalizado con fondo curvo
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7A00),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mi Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      // Avatar circular con icono (reemplaza foto)
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
                          Icons.person_rounded,
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
                          Icons.camera_alt_rounded,
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
                  // Apellidos
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
                  // Fecha de Nacimiento
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
                  // Botón Guardar
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A00),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Guardar Cambios',
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
          ],
        ),
      ),
    );
  }
}
