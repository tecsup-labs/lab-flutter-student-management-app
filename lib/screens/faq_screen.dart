import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Alignment, Offset, BoxShadow, BuildContext, Color, EdgeInsets, FontWeight, MainAxisAlignment, Navigator, TextStyle, AnimatedCrossFade, CrossFadeState;

class FaqItemData {
  final String question;
  final String answer;

  FaqItemData({required this.question, required this.answer});
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<FaqItemData> _faqList = [
    FaqItemData(
      question: '¿Cómo registrar un alumno?',
      answer: 'Puedes registrar un nuevo alumno desde la sección "Registrar Alumno" en la pantalla de inicio. Completa los nombres, apellidos y fecha de nacimiento en el formulario, y presiona el botón "Guardar Alumno".',
    ),
    FaqItemData(
      question: '¿Dónde veo la lista de alumnos?',
      answer: 'Puedes ver todos los alumnos registrados desde la sección "Listar Alumnos". Allí encontrarás un buscador interactivo en tiempo real y la lista con las iniciales e información de cada alumno.',
    ),
    FaqItemData(
      question: '¿Cómo puedo cambiar mi contraseña?',
      answer: 'Para cambiar tus datos, ve a la sección de "Mi Perfil" desde la pantalla principal, modifica la información necesaria (Nombres, Apellidos o Fecha de Nacimiento) y guarda los cambios.',
    ),
    FaqItemData(
      question: '¿Cómo cerrar sesión?',
      answer: 'Puedes cerrar sesión de forma segura haciendo clic en la opción "Cerrar Sesión" en la pantalla principal, y luego confirmando la acción en el diálogo emergente.',
    ),
  ];

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
          'Preguntas Frecuentes',
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Ilustración premium auto-contenida (Personaje pensando)
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Círculo de fondo color peach
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2E6),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF7A00).withOpacity(0.06),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                    // Icono central representativo estilizado
                    const Positioned(
                      bottom: 20,
                      child: Icon(
                        CupertinoIcons.person_fill,
                        size: 90,
                        color: Color(0xFFFF7A00),
                      ),
                    ),
                    // Burbuja de diálogo de pregunta "?"
                    Positioned(
                      top: 0,
                      right: -10,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '?',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF7A00),
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              // Listado de Tiles expandibles personalizados de Cupertino
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _faqList.length,
                  itemBuilder: (context, index) {
                    final faq = _faqList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
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
                      child: CupertinoExpansionTile(
                        title: faq.question,
                        content: faq.answer,
                      ),
                    );
                  },
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

// Widget personalizado de expansión compatible con Cupertino
class CupertinoExpansionTile extends StatefulWidget {
  final String title;
  final String content;

  const CupertinoExpansionTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<CupertinoExpansionTile> createState() => _CupertinoExpansionTileState();
}

class _CupertinoExpansionTileState extends State<CupertinoExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B231E),
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
              Icon(
                _isExpanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                color: _isExpanded ? const Color(0xFFFF7A00) : const Color(0xFF91857D),
                size: 16,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
            child: Text(
              widget.content,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF70655E),
                height: 1.5,
                fontFamily: 'Outfit',
              ),
            ),
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
