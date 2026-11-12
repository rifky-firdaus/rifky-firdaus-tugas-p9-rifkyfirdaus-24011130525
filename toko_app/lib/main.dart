import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'state/auth_state.dart';
import 'state/cart_state.dart';

void main() {
  final authState = AuthState();
  final cartState = CartState();
  final router = createRouter(authState, cartState);
  runApp(TokoApp(router: router));
}

class TokoApp extends StatelessWidget {
  const TokoApp({super.key, required this.router});
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Toko App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      routerConfig: router,
      builder: (context, child) => Stack(
        fit: StackFit.expand,
        children: [
          child ?? const SizedBox.shrink(),
          const Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                key: ValueKey('app-watermark'),
                painter: _WatermarkPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WatermarkPainter extends CustomPainter {
  const _WatermarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Rifky Firdaus',
        style: TextStyle(
          color: Colors.black.withValues(alpha: 0.08),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final extent = size.width + size.height;
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..rotate(-math.pi / 6);
    for (var y = -extent; y < extent; y += 130) {
      for (var x = -extent; x < extent; x += 230) {
        textPainter.paint(canvas, Offset(x, y));
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WatermarkPainter oldDelegate) => false;
}
