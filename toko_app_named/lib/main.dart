import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'models/cart.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/product_list_page.dart';
import 'pages/splash_screen.dart';
import 'routes/app_routes.dart';

void main() => runApp(const TokoApp());

class TokoApp extends StatefulWidget {
  const TokoApp({super.key});

  @override
  State<TokoApp> createState() => _TokoAppState();
}

class _TokoAppState extends State<TokoApp> {
  final CartController _cart = CartController();

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      builder: (context, child) => CartScope(
        controller: _cart,
        child: Stack(
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
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.products: (context) => const ProductListPage(),
        AppRoutes.productDetail: (context) => const ProductDetailPage(),
        AppRoutes.cart: (context) => const CartPage(),
      },
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
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-math.pi / 6);
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
