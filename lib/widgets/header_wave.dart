import 'package:flutter/material.dart';

class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.75);

    final firstControlPoint = Offset(size.width * 0.25, size.height * 0.95);
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.85);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.75);
    final secondEndPoint = Offset(size.width, size.height * 0.9);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HeaderWaveWidget extends StatelessWidget {
  final double height;
  const HeaderWaveWidget({super.key, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderWaveClipper(),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF7A00),
              Color(0xFFFF9E43),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
