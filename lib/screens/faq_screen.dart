import 'package:flutter/material.dart';

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
          'Preguntas Frecuentes',
          style: TextStyle(
            color: Color(0xFF2B231E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  Positioned(
                    bottom: 12,
                    child: Icon(
                      Icons.emoji_people_rounded,
                      size: 100,
                      color: const Color(0xFFFF7A00).withOpacity(0.95),
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            // Listado de ExpansionTiles personalizados
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
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        iconColor: const Color(0xFFFF7A00),
                        collapsedIconColor: const Color(0xFF91857D),
                        title: Text(
                          faq.question,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B231E),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: 20.0,
                            ),
                            child: Text(
                              faq.answer,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF70655E),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
