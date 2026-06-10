import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Offset, BoxShadow, BoxShape, BuildContext, Color, EdgeInsets, FontWeight, MainAxisAlignment, CrossAxisAlignment, Navigator, TextStyle, VoidCallback; // Conservamos algunos objetos de estructura y estilo que no tienen equivalente en Cupertino o que son estándar
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
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text(
            'Cerrar Sesión',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          message: const Text(
            '¿Estás seguro que deseas cerrar sesión?',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 14,
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el ActionSheet
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Cerrar Sesión', style: TextStyle(fontFamily: 'Outfit')),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Color(0xFFFF7A00),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      child: SafeArea(
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
                          fontFamily: 'Outfit',
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '¿Qué deseas hacer hoy?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF70655E),
                          fontFamily: 'Outfit',
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
                      CupertinoIcons.person_fill,
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
                      icon: CupertinoIcons.person,
                      iconColor: const Color(0xFFFF7A00),
                      iconBgColor: const Color(0xFFFFF2E6),
                      title: 'Mi Perfil',
                      subtitle: 'Ver y editar tu información',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const ProfileScreen()),
                        ).then((_) {
                          // Actualizar el saludo al volver
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: CupertinoIcons.person_badge_plus,
                      iconColor: const Color(0xFF34C759),
                      iconBgColor: const Color(0xFFE8F9ED),
                      title: 'Registrar Alumno',
                      subtitle: 'Agrega un nuevo alumno',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const RegisterScreen()),
                        ).then((_) => setState(() {}));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: CupertinoIcons.list_bullet,
                      iconColor: const Color(0xFF007AFF),
                      iconBgColor: const Color(0xFFE5F1FF),
                      title: 'Listar Alumnos',
                      subtitle: 'Ver todos los alumnos',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const ListScreen()),
                        ).then((_) => setState(() {}));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: CupertinoIcons.question_circle,
                      iconColor: const Color(0xFFFFB900),
                      iconBgColor: const Color(0xFFFFF9E6),
                      title: 'Preguntas Frecuentes',
                      subtitle: 'Resuelve tus dudas',
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const FaqScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Tarjeta de Cerrar Sesión
                    _buildMenuCard(
                      icon: CupertinoIcons.square_arrow_right,
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
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(20),
        onPressed: onTap,
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
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF70655E),
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),
              // Flecha derecha
              const Icon(
                CupertinoIcons.chevron_forward,
                color: Color(0xFF91857D),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
