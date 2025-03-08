import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker_pkg;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isFrozen = true; // State to track freeze mode
  int _selectedIndex = 1; // Default selected index
  final faker = faker_pkg.Faker();

  // Card Details
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";

  @override
  void initState() {
    super.initState();
    _generateCardDetails(); // Generate initial card details
  }

  void _generateCardDetails() {
    setState(() {  // Ensure UI updates when generating new details
      cardNumber =
      "${faker.randomGenerator.integer(9999, min: 1000)} "
          "${faker.randomGenerator.integer(9999, min: 1000)} "
          "${faker.randomGenerator.integer(9999, min: 1000)} "
          "${faker.randomGenerator.integer(9999, min: 1000)}";

      expiryDate =
      "${faker_pkg.faker.randomGenerator.integer(12, min: 1).toString().padLeft(2, '0')}/"
          "${faker_pkg.faker.randomGenerator.integer(30, min: 25)}";

      cvv = faker_pkg.faker.randomGenerator.integer(999, min: 100).toString();
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "select payment mode",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "choose your preferred payment method to make payment.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        _buildGradientBorderButton(
                            "pay",
                            [
                              Colors.white,
                              Colors.white.withOpacity(0),
                            ],
                            Colors.white),
                        const SizedBox(width: 10),
                        _buildGradientBorderButton(
                            "card",
                            [
                              const Color(0xFFA90808),
                              const Color(0xFFA90808).withOpacity(0),
                            ],
                            const Color(0xFFA90808)),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "your digital debit card".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.2),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Container(
                            key: ValueKey<bool>(_isFrozen),
                            height: 296,
                            width: 186,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(
                                  _isFrozen
                                      ? "assets/freeze.png"
                                      : "assets/card.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  color: Colors.grey,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: !_isFrozen
                                ? Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Card Number in a vertical layout
                                  Container(
                                    margin: EdgeInsets.only(bottom: 50),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        for (var block in cardNumber.split(" "))
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 2),
                                            child: Text(
                                              block,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 3,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Expiry and CVV aligned to the right
                                  Container(
                                    margin: EdgeInsets.only(bottom: 50),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "expiry",
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.5),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                expiryDate,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30), // Space between expiry and CVV

                                        Container(
                                          margin: EdgeInsets.only(right: 55,bottom: 20),
                                          child: Text(
                                            "cvv",
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )

                                : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isFrozen = !_isFrozen;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.3)),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black, Color(0xFF0D0D0D)],
                                  ),
                                ),
                                child: Image.asset(
                                  _isFrozen
                                      ? "assets/ice_red.png"
                                      : "assets/ice_white.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _isFrozen ? "unfreeze" : "freeze",
                              style: TextStyle(
                                  color:
                                  _isFrozen ? Colors.red : Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildCustomBottomNavigationBar(),
          ],
        ),
      ),
    );
  }


  Widget _buildGradientBorderButton(
      String text, List<Color> colors, Color textColor) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFF0D0D0D),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -80, // Adjust position for visibility
          left: 0,
          right: 0,
          child: CustomPaint(
            size: Size(double.infinity, 100), // Ensures full width
            painter: CurvedLinePainter(),
          ),
        ),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -20, // Floating effect
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      child: _buildNavItem(Icons.qr_code_scanner, "yolo pay", 1)
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home, "home", 0),
                  SizedBox(width: 60,),
                  _buildNavItem(Icons.settings, "ginie", 2),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
              border: Border.all(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
                  width: 2),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
              size: isSelected ? 40 : 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2 // Slightly thicker for visibility
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(-10, size.height) // Extend slightly past the left edge
      ..quadraticBezierTo(
          size.width / 2, -10, size.width + 10, size.height) // Extend past right edge

      ..lineTo(size.width + 10, size.height) // Ensure it reaches the right edge
      ..lineTo(-10, size.height) // Ensure it reaches the left edge
      ..close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}