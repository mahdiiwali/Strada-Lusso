import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/car_list_screen.dart';

/// Onboarding screen showcasing Porsche with premium dark theme
/// Implements responsive layout using OrientationBuilder
/// Compatible with Provider for future state management
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Full-page background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/onboarding2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Semi-transparent overlay for text readability
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
          child: SafeArea(
            child: OrientationBuilder(
              builder: (context, orientation) {
                // Portrait mode: Stack content vertically
                if (orientation == Orientation.portrait) {
                  return _buildPortraitLayout(context);
                }
                // Landscape mode: Place content side-by-side
                else {
                  return _buildLandscapeLayout(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Portrait layout - Vertical stack
  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),

        // Text content
        _buildTextContent(),

        const SizedBox(height: 40),

        // Call-to-action button
        _buildActionButton(context),

        const Spacer(flex: 2),
      ],
    );
  }

  /// Landscape layout - Horizontal arrangement
  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        const Spacer(),

        // Center content
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextContent(),
              const SizedBox(height: 30),
              _buildActionButton(context),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }

  /// Builds the text content (header and subtitle)
  Widget _buildTextContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          // Main heading
          const Text(
            "Premium Cars",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Enjoy the Luxury",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 0.5,
              height: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Subtitle
          Text(
            "Premium and prestige car daily rental.\nExperience the thrill of driving luxury.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey[200],
              height: 1.6,
              letterSpacing: 0.2,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the call-to-action button
  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CarListScreen()),
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xff1A1A2E),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            "Let's Go",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
