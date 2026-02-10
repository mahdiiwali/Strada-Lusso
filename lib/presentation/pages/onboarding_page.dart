import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/car_list_screen.dart';
import 'package:flutter_application_1/utils/responsive_utils.dart';

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
      child: Builder(
        builder: (context) => Column(
          children: [
            // Main heading
            Text(
              "Premium Cars",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:
                    ResponsiveUtils.getHeadingSize(context) +
                    6, // Extra large for hero
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: ResponsiveUtils.getHeadingLetterSpacing(context),
                height: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveUtils.getCompactSpacing(context)),

            Text(
              "Enjoy the Luxury",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getSubheadingSize(context),
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 0.8,
                height: 1.3,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveUtils.getItemSpacing(context)),

            // Subtitle
            Text(
              "Premium and prestige car daily rental.\nExperience the thrill of driving luxury.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getBodyFontSize(context),
                fontWeight: FontWeight.w400,
                color: ResponsiveUtils.textSecondary.withOpacity(0.9),
                height: 1.6,
                letterSpacing: ResponsiveUtils.getBodyLetterSpacing(),
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the call-to-action button
  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveUtils.getButtonHeight(context),
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
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getBorderRadius(context),
              ),
            ),
          ),
          child: Text(
            "Let's Go",
            style: TextStyle(
              fontSize: ResponsiveUtils.getButtonFontSize(context),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
