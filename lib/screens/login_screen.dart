import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors; // Usamos Colors para el blanco/transparente si es necesario, o podemos usar CupertinoColors
import '../widgets/header_wave.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    // Simulamos carga de 1.5 segundos típica de iOS
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      if ((email == 'admin' || email == 'admin@ejemplo.com') && password == '1234') {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        _showAlertDialog('Error de inicio de sesión', 'Usuario o contraseña incorrectos');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            // Onda superior naranja
            const HeaderWaveWidget(height: 280),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),
                  // Contenedor del Logo
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2E6),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF7A00).withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        CupertinoIcons.book,
                        size: 56,
                        color: Color(0xFFFF7A00),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Títulos
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B231E),
                      letterSpacing: -0.5,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Inicia sesión para continuar',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF70655E),
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Input Correo
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF7A00).withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CupertinoTextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      placeholder: 'Correo electrónico',
                      placeholderStyle: const TextStyle(
                        color: Color(0xFF8C847E),
                        fontSize: 14,
                        fontFamily: 'Outfit',
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Icon(
                          CupertinoIcons.person,
                          color: Color(0xFFFF7A00),
                          size: 22,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _emailFocus.hasFocus
                              ? const Color(0xFFFF7A00)
                              : const Color(0xFFFF7A00).withOpacity(0.12),
                          width: _emailFocus.hasFocus ? 1.5 : 1.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15,
                        color: Color(0xFF2B231E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Input Contraseña
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF7A00).withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CupertinoTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      obscureText: _obscureText,
                      placeholder: 'Contraseña',
                      placeholderStyle: const TextStyle(
                        color: Color(0xFF8C847E),
                        fontSize: 14,
                        fontFamily: 'Outfit',
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Icon(
                          CupertinoIcons.lock,
                          color: Color(0xFFFF7A00),
                          size: 22,
                        ),
                      ),
                      suffix: CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: const Color(0xFFFF7A00),
                          size: 22,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _passwordFocus.hasFocus
                              ? const Color(0xFFFF7A00)
                              : const Color(0xFFFF7A00).withOpacity(0.12),
                          width: _passwordFocus.hasFocus ? 1.5 : 1.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15,
                        color: Color(0xFF2B231E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Fila Recordarme / Olvidaste contraseña
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                        child: Row(
                          children: [
                            CupertinoSwitch(
                              value: _rememberMe,
                              activeColor: const Color(0xFFFF7A00),
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Recordarme',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF70655E),
                                fontFamily: 'Outfit',
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Simulado
                        },
                        child: const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFFF7A00),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Botón Iniciar Sesión
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      color: const Color(0xFFFF7A00),
                      borderRadius: BorderRadius.circular(16),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const CupertinoActivityIndicator(color: Colors.white)
                          : const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Texto inferior
                  const Text(
                    '¿No tienes cuenta? Contacta al administrador',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF91857D),
                      fontFamily: 'Outfit',
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
