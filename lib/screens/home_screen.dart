import 'package:flutter/material.dart';
import '../globals.dart';
import 'profile_screen.dart';
import 'register_screen.dart';
import 'list_screen.dart';
import 'faq_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Función para mostrar el modal de Cerrar Sesión inspirado en el diseño final
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono de candado moderno con estrellas alrededor
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2E6),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF7A00).withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.lock_open_rounded,
                      size: 48,
                      color: Color(0xFFFF7A00),
                    ),
                    // Decoraciones simulando las estrellas
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Icon(Icons.star, size: 12, color: const Color(0xFFFF7A00).withOpacity(0.6)),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 8,
                      child: Icon(Icons.star, size: 14, color: const Color(0xFFFF9E43).withOpacity(0.8)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B231E),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '¿Estás seguro que deseas\ncerrar sesión?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF70655E),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),
                // Botón Cerrar Sesión
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7A00),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Botón Cancelar
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: const Color(0xFFFF7A00).withOpacity(0.18),
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Color(0xFFFF7A00),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Cabecera: Saludo (Izquierda) e Icono de Perfil (Derecha)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Globals.nombresPerfil.isEmpty
                            ? '¡Hola! 👋'
                            : 'Hola, ${Globals.nombresPerfil} 👋',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B231E),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '¿Qué deseas hacer hoy?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF70655E),
                        ),
                      ),
                    ],
                  ),
                  // Icono de perfil circular a la derecha
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFF2E6),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF7A00).withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFFFF7A00),
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Lista de Cards de Menú
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildMenuCard(
                      icon: Icons.person_outline,
                      iconColor: const Color(0xFFFF7A00),
                      iconBgColor: const Color(0xFFFFF2E6),
                      title: 'Mi Perfil',
                      subtitle: 'Ver y editar tu información',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        ).then((_) {
                          // Actualizar el saludo al volver
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.person_add_alt_1_outlined,
                      iconColor: const Color(0xFF34C759),
                      iconBgColor: const Color(0xFFE8F9ED),
                      title: 'Registrar Alumno',
                      subtitle: 'Agrega un nuevo alumno',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        ).then((_) => setState(() {}));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.format_list_bulleted_rounded,
                      iconColor: const Color(0xFF007AFF),
                      iconBgColor: const Color(0xFFE5F1FF),
                      title: 'Listar Alumnos',
                      subtitle: 'Ver todos los alumnos',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ListScreen()),
                        ).then((_) => setState(() {}));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.help_outline_rounded,
                      iconColor: const Color(0xFFFFB900),
                      iconBgColor: const Color(0xFFFFF9E6),
                      title: 'Preguntas Frecuentes',
                      subtitle: 'Resuelve tus dudas',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FaqScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Tarjeta de Cerrar Sesión
                    _buildMenuCard(
                      icon: Icons.logout_rounded,
                      iconColor: const Color(0xFFFF4A4A),
                      iconBgColor: const Color(0xFFFFECEC),
                      title: 'Cerrar Sesión',
                      subtitle: 'Salir de la aplicación',
                      onTap: _showLogoutDialog,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7A00).withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Contenedor del Icono
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B231E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF70655E),
                        ),
                      ),
                    ],
                  ),
                ),
                // Flecha derecha
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF91857D),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
