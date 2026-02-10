import 'package:flutter/material.dart';

/// Utility class for responsive design breakpoints and sizing
///
/// This class provides helper methods to determine screen size categories
/// and calculate responsive dimensions for the Strada-Lusso app.
///
/// Breakpoints:
/// - Mobile: < 600px
/// - Tablet: 600px - 1024px
/// - Desktop: > 1024px
class ResponsiveUtils {
  // Breakpoint constants
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double maxContentWidth = 1400;

  /// Check if current screen is mobile size (< 600px)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Check if current screen is tablet size (600px - 1024px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if current screen is desktop size (> 1024px)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// Get responsive padding based on screen size
  ///
  /// Returns:
  /// - Mobile: 20px
  /// - Tablet: 32px
  /// - Desktop: 48px
  static double getResponsivePadding(BuildContext context) {
    if (isDesktop(context)) return 48.0;
    if (isTablet(context)) return 32.0;
    return 20.0;
  }

  /// Get maximum content width for centering on large screens
  ///
  /// Returns maxContentWidth (1400px) on desktop, double.infinity otherwise
  static double getMaxContentWidth(BuildContext context) {
    return isDesktop(context) ? maxContentWidth : double.infinity;
  }

  /// Get number of columns for car grid based on screen width
  ///
  /// Returns:
  /// - Mobile: 1 column
  /// - Tablet: 2 columns
  /// - Desktop: 3 columns
  static int getGridCount(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }

  /// Get car card height based on screen size
  ///
  /// Returns:
  /// - Mobile: 200px
  /// - Tablet: 240px
  /// - Desktop: 260px
  static double getCarCardHeight(BuildContext context) {
    if (isDesktop(context)) return 260.0;
    if (isTablet(context)) return 240.0;
    return 200.0;
  }

  /// Get responsive font size multiplier
  ///
  /// Returns:
  /// - Mobile: 1.0x
  /// - Tablet: 1.1x
  /// - Desktop: 1.15x
  static double getFontSizeMultiplier(BuildContext context) {
    if (isDesktop(context)) return 1.15;
    if (isTablet(context)) return 1.1;
    return 1.0;
  }

  /// Get responsive grid spacing
  ///
  /// Returns:
  /// - Mobile: 16px
  /// - Tablet: 20px
  /// - Desktop: 24px
  static double getGridSpacing(BuildContext context) {
    if (isDesktop(context)) return 24.0;
    if (isTablet(context)) return 20.0;
    return 16.0;
  }

  /// Get aspect ratio for car cards in grid
  ///
  /// Returns:
  /// - Mobile: 1.6 (wider cards)
  /// - Tablet/Desktop: 1.4 (more square)
  static double getCardAspectRatio(BuildContext context) {
    return isMobile(context) ? 1.6 : 1.4;
  }

  /// Wrap content with max-width constraint for desktop
  ///
  /// Centers content and constrains width on large screens
  static Widget constrainContentWidth({
    required BuildContext context,
    required Widget child,
    double? maxWidth,
  }) {
    if (!isDesktop(context)) return child;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? maxContentWidth),
        child: child,
      ),
    );
  }

  /// Get responsive horizontal margin for cards
  static double getHorizontalMargin(BuildContext context) {
    if (isDesktop(context)) return 24.0;
    if (isTablet(context)) return 20.0;
    return 20.0;
  }

  /// Get responsive vertical margin for cards
  static double getVerticalMargin(BuildContext context) {
    if (isDesktop(context)) return 12.0;
    if (isTablet(context)) return 10.0;
    return 8.0;
  }

  /// Check if device supports hover (typically desktop)
  static bool supportsHover(BuildContext context) {
    return isDesktop(context);
  }

  // ============================================================
  // PROFESSIONAL TYPOGRAPHY SYSTEM
  // ============================================================

  /// Get professional heading size based on screen size
  ///
  /// Returns:
  /// - Mobile: 28px
  /// - Tablet: 32px
  /// - Desktop: 36px
  static double getHeadingSize(BuildContext context) {
    if (isDesktop(context)) return 36.0;
    if (isTablet(context)) return 32.0;
    return 28.0;
  }

  /// Get subheading size
  ///
  /// Returns:
  /// - Mobile: 20px
  /// - Tablet: 22px
  /// - Desktop: 24px
  static double getSubheadingSize(BuildContext context) {
    if (isDesktop(context)) return 24.0;
    if (isTablet(context)) return 22.0;
    return 20.0;
  }

  /// Get professional body text size
  ///
  /// Returns:
  /// - Mobile: 14px
  /// - Tablet: 15px
  /// - Desktop: 16px
  static double getBodyFontSize(BuildContext context) {
    if (isDesktop(context)) return 16.0;
    if (isTablet(context)) return 15.0;
    return 14.0;
  }

  /// Get caption/small text size
  ///
  /// Returns:
  /// - Mobile: 12px
  /// - Tablet: 13px
  /// - Desktop: 13px
  static double getCaptionSize(BuildContext context) {
    if (isDesktop(context)) return 13.0;
    if (isTablet(context)) return 13.0;
    return 12.0;
  }

  /// Get professional letter spacing for headings
  static double getHeadingLetterSpacing(BuildContext context) {
    return isDesktop(context) ? 0.5 : 0.3;
  }

  /// Get letter spacing for body text
  static double getBodyLetterSpacing() {
    return 0.2;
  }

  // ============================================================
  // PROFESSIONAL SPACING SYSTEM
  // ============================================================

  /// Get section spacing (vertical gap between major sections)
  ///
  /// Returns:
  /// - Mobile: 32px
  /// - Tablet: 40px
  /// - Desktop: 48px
  static double getSectionSpacing(BuildContext context) {
    if (isDesktop(context)) return 48.0;
    if (isTablet(context)) return 40.0;
    return 32.0;
  }

  /// Get item spacing (vertical gap between items in a list)
  ///
  /// Returns:
  /// - Mobile: 16px
  /// - Tablet: 20px
  /// - Desktop: 24px
  static double getItemSpacing(BuildContext context) {
    if (isDesktop(context)) return 24.0;
    if (isTablet(context)) return 20.0;
    return 16.0;
  }

  /// Get compact spacing (small gaps)
  ///
  /// Returns:
  /// - Mobile: 8px
  /// - Tablet: 10px
  /// - Desktop: 12px
  static double getCompactSpacing(BuildContext context) {
    if (isDesktop(context)) return 12.0;
    if (isTablet(context)) return 10.0;
    return 8.0;
  }

  // ============================================================
  // PROFESSIONAL BUTTON & INTERACTIVE ELEMENTS
  // ============================================================

  /// Get button height
  ///
  /// Returns:
  /// - Mobile: 48px
  /// - Tablet: 52px
  /// - Desktop: 56px
  static double getButtonHeight(BuildContext context) {
    if (isDesktop(context)) return 56.0;
    if (isTablet(context)) return 52.0;
    return 48.0;
  }

  /// Get button font size
  ///
  /// Returns:
  /// - Mobile: 15px
  /// - Tablet: 16px
  /// - Desktop: 17px
  static double getButtonFontSize(BuildContext context) {
    if (isDesktop(context)) return 17.0;
    if (isTablet(context)) return 16.0;
    return 15.0;
  }

  /// Get border radius for cards and containers
  ///
  /// Returns:
  /// - Mobile: 16px
  /// - Tablet: 18px
  /// - Desktop: 20px
  static double getBorderRadius(BuildContext context) {
    if (isDesktop(context)) return 20.0;
    if (isTablet(context)) return 18.0;
    return 16.0;
  }

  // ============================================================
  // PROFESSIONAL COLOR SYSTEM
  // ============================================================

  /// Professional dark theme colors
  static const Color backgroundDeep = Color(0xff0A0A0A);
  static const Color surface = Color(0xff1A1A1A);
  static const Color surfaceElevated = Color(0xff2A2A2A);
  static const Color border = Color(0x1AFFFFFF);
  static const Color borderHover = Color(0x33FFFFFF);
  static const Color accent = Color(0xffD1122C);
  static const Color textPrimary = Color(0xffFFFFFF);
  static const Color textSecondary = Color(0xffA3ACB3);

  // ============================================================
  // ANIMATION CONSTANTS
  // ============================================================

  /// Standard animation duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Fast animation duration
  static const Duration fastAnimation = Duration(milliseconds: 200);

  /// Slow animation duration
  static const Duration slowAnimation = Duration(milliseconds: 500);

  /// Professional easing curve
  static const Curve animationCurve = Curves.easeOutCubic;
}
