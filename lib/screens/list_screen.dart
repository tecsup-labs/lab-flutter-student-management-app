import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/alumno.dart';
import 'register_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Alumno> _filteredAlumnos = [];

  @override
  void initState() {
    super.initState();
    _filteredAlumnos = List.from(Globals.alumnos);
  }

  void _filterAlumnos(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredAlumnos = List.from(Globals.alumnos);
      } else {
        _filteredAlumnos = Globals.alumnos.where((alumno) {
          final nombreCompleto = '${alumno.nombres} ${alumno.apellidos}'.toLowerCase();
          return nombreCompleto.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  String _getInitials(String nombres, String apellidos) {
    final firstLetter = nombres.isNotEmpty ? nombres[0].toUpperCase() : '';
    final secondLetter = apellidos.isNotEmpty ? apellidos[0].toUpperCase() : '';
    return '$firstLetter$secondLetter';
  }

  Map<String, Color> _getAvatarColors(String name) {
    final index = name.length % 4;
    switch (index) {
      case 0: // Blue
        return {
          'bg': const Color(0xFFE5F1FF),
          'text': const Color(0xFF007AFF),
        };
      case 1: // Teal/Green
        return {
          'bg': const Color(0xFFE8F9ED),
          'text': const Color(0xFF34C759),
        };
      case 2: // Cyan/Teal
        return {
          'bg': const Color(0xFFE6F9FC),
          'text': const Color(0xFF30B0C7),
        };
      default: // Purple
        return {
          'bg': const Color(0xFFF3E8FF),
          'text': const Color(0xFF985EFF),
        };
    }
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
          'Listar Alumnos',
          style: TextStyle(
            color: Color(0xFF2B231E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra de búsqueda premium
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
              child: TextField(
                controller: _searchController,
                onChanged: _filterAlumnos,
                decoration: InputDecoration(
                  hintText: 'Buscar alumno...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF8C847E),
                    fontSize: 14,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.search_rounded,
                      color: Color(0xFFFF7A00),
                    ),
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
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          // Listado de alumnos
          Expanded(
            child: _filteredAlumnos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline_rounded,
                          size: 72,
                          color: const Color(0xFFFF7A00).withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No se encontraron alumnos',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF70655E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    itemCount: _filteredAlumnos.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final alumno = _filteredAlumnos[index];
                      final initials = _getInitials(alumno.nombres, alumno.apellidos);
                      final fullName = '${alumno.nombres} ${alumno.apellidos}';
                      final colors = _getAvatarColors(fullName);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF7A00).withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: colors['bg'],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              initials,
                              style: TextStyle(
                                color: colors['text'],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          title: Text(
                            fullName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B231E),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              alumno.fechaNacimiento,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF70655E),
                              ),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFF91857D),
                            size: 14,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // Botón flotante para registrar un nuevo alumno
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterScreen()),
          ).then((_) {
            // Actualizar la lista al regresar del registro
            setState(() {
              _filterAlumnos(_searchController.text);
            });
          });
        },
        backgroundColor: const Color(0xFFFF7A00),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
