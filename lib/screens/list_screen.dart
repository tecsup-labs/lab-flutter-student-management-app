import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Alignment, Offset, BoxShadow, BuildContext, Color, EdgeInsets, FontWeight, MainAxisAlignment, CrossAxisAlignment, Navigator, TextStyle;
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
  final FocusNode _searchFocus = FocusNode();
  int _selectedSegment = 0; // 0: Todos, 1: A-Z, 2: Nuevos

  @override
  void initState() {
    super.initState();
    _filterAlumnos('');
    _searchFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterAlumnos(String query) {
    setState(() {
      List<Alumno> tempList = [];
      if (query.trim().isEmpty) {
        tempList = List.from(Globals.alumnos);
      } else {
        tempList = Globals.alumnos.where((alumno) {
          final nombreCompleto = '${alumno.nombres} ${alumno.apellidos}'.toLowerCase();
          return nombreCompleto.contains(query.toLowerCase());
        }).toList();
      }

      // Aplicar filtros/ordenación del SegmentedControl
      if (_selectedSegment == 1) {
        // Ordenar alfabéticamente por nombres
        tempList.sort((a, b) => '${a.nombres} ${a.apellidos}'.toLowerCase().compareTo('${b.nombres} ${b.apellidos}'.toLowerCase()));
      } else if (_selectedSegment == 2) {
        // Nuevos primero (revertir la lista)
        tempList = tempList.reversed.toList();
      }

      _filteredAlumnos = tempList;
    });
  }

  void _showStudentDetails(Alumno alumno) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('${alumno.nombres} ${alumno.apellidos}', style: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombres: ${alumno.nombres}', style: const TextStyle(fontFamily: 'Outfit')),
              const SizedBox(height: 6),
              Text('Apellidos: ${alumno.apellidos}', style: const TextStyle(fontFamily: 'Outfit')),
              const SizedBox(height: 6),
              Text('Fecha de Nacimiento: ${alumno.fechaNacimiento}', style: const TextStyle(fontFamily: 'Outfit')),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cerrar', style: TextStyle(fontFamily: 'Outfit', color: Color(0xFFFF7A00))),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(Alumno alumno) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Eliminar Alumno', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('¿Estás seguro que deseas eliminar a ${alumno.nombres} de la lista?', style: const TextStyle(fontFamily: 'Outfit')),
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              setState(() {
                Globals.alumnos.remove(alumno);
                _filterAlumnos(_searchController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Eliminar', style: TextStyle(fontFamily: 'Outfit')),
          ),
          CupertinoDialogAction(
            child: const Text('Cancelar', style: TextStyle(fontFamily: 'Outfit', color: Color(0xFFFF7A00))),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
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
          'Listar Alumnos',
          style: TextStyle(
            color: Color(0xFF2B231E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Outfit',
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Barra de búsqueda premium
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 8.0),
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
                      controller: _searchController,
                      focusNode: _searchFocus,
                      onChanged: _filterAlumnos,
                      placeholder: 'Buscar alumno...',
                      placeholderStyle: const TextStyle(
                        color: Color(0xFF8C847E),
                        fontSize: 14,
                        fontFamily: 'Outfit',
                      ),
                      suffix: const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Color(0xFFFF7A00),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _searchFocus.hasFocus
                              ? const Color(0xFFFF7A00)
                              : const Color(0xFFFF7A00).withOpacity(0.12),
                          width: _searchFocus.hasFocus ? 1.5 : 1.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF2B231E),
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                ),
                // CupertinoSegmentedControl para ordenar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoSegmentedControl<int>(
                      groupValue: _selectedSegment,
                      selectedColor: const Color(0xFFFF7A00),
                      unselectedColor: Colors.white,
                      borderColor: const Color(0xFFFF7A00).withOpacity(0.2),
                      children: const {
                        0: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('Todos', style: TextStyle(fontFamily: 'Outfit', fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                        1: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('A-Z', style: TextStyle(fontFamily: 'Outfit', fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                        2: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('Nuevos', style: TextStyle(fontFamily: 'Outfit', fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      },
                      onValueChanged: (int val) {
                        setState(() {
                          _selectedSegment = val;
                          _filterAlumnos(_searchController.text);
                        });
                      },
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
                                CupertinoIcons.group,
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
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 80.0),
                          itemCount: _filteredAlumnos.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final alumno = _filteredAlumnos[index];
                            final initials = _getInitials(alumno.nombres, alumno.apellidos);
                            final fullName = '${alumno.nombres} ${alumno.apellidos}';
                            final colors = _getAvatarColors(fullName);

                            // Envolvemos el item en CupertinoContextMenu para dar soporte 3D Touch/Long Press
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: CupertinoContextMenu(
                                enableHapticFeedback: true,
                                actions: [
                                  CupertinoContextMenuAction(
                                    trailingIcon: CupertinoIcons.eye,
                                    child: const Text('Ver Detalles', style: TextStyle(fontFamily: 'Outfit')),
                                    onPressed: () {
                                      Navigator.pop(context); // Cierra el menú context
                                      _showStudentDetails(alumno);
                                    },
                                  ),
                                  CupertinoContextMenuAction(
                                    isDestructiveAction: true,
                                    trailingIcon: CupertinoIcons.trash,
                                    child: const Text('Eliminar Alumno', style: TextStyle(fontFamily: 'Outfit')),
                                    onPressed: () {
                                      Navigator.pop(context); // Cierra el menú context
                                      _deleteStudent(alumno);
                                    },
                                  ),
                                ],
                                child: Container(
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
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
                                              fontFamily: 'Outfit',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fullName,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2B231E),
                                                  fontFamily: 'Outfit',
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                alumno.fechaNacimiento,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF70655E),
                                                  fontFamily: 'Outfit',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          CupertinoIcons.chevron_forward,
                                          color: Color(0xFF91857D),
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            // Botón flotante para registrar un nuevo alumno
            Positioned(
              bottom: 24,
              right: 24,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF7A00).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: const Color(0xFFFF7A00),
                  borderRadius: BorderRadius.circular(16),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const RegisterScreen()),
                    ).then((_) {
                      // Actualizar la lista al regresar del registro
                      setState(() {
                        _filterAlumnos(_searchController.text);
                      });
                    });
                  },
                  child: const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(CupertinoIcons.add, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
