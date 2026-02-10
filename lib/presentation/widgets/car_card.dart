import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/car.dart';
import 'package:flutter_application_1/presentation/pages/car_details_page.dart';
import 'package:flutter_application_1/utils/responsive_utils.dart';

class CarCard extends StatefulWidget {
  final Car car;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  const CarCard({
    super.key,
    required this.car,
    required this.isFavorited,
    required this.onFavoriteToggle,
  });

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardHeight = ResponsiveUtils.getCarCardHeight(context);
    final horizontalMargin = ResponsiveUtils.getHorizontalMargin(context);
    final verticalMargin = ResponsiveUtils.getVerticalMargin(context);
    final fontMultiplier = ResponsiveUtils.getFontSizeMultiplier(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: ResponsiveUtils.animationDuration,
        curve: ResponsiveUtils.animationCurve,
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.02 : 1.0), // Subtle scale on hover
        margin: EdgeInsets.symmetric(
          vertical: verticalMargin,
          horizontal: horizontalMargin,
        ),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context),
          ),
          border: Border.all(
            color: _isHovered
                ? ResponsiveUtils.borderHover
                : ResponsiveUtils.border,
            width: 1.0,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff2A2A2E), Color(0xff1F1F23)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.5 : 0.4),
              spreadRadius: 0,
              blurRadius: _isHovered ? 32 : 20,
              offset: Offset(0, _isHovered ? 16 : 8),
            ),
            BoxShadow(
              color: Color(0xffD1122C).withOpacity(_isHovered ? 0.3 : 0.15),
              spreadRadius: 0,
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailsPage(car: widget.car),
                  ),
                );
              },
              splashColor: Color(0xffD1122C).withOpacity(0.15),
              highlightColor: Color(0xffD1122C).withOpacity(0.08),
              child: Stack(
                children: [
                  // Large Car Image Background
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff1A1A1A), Color(0xff0F0F0F)],
                        ),
                      ),
                      child: widget.car.imageUrl.isNotEmpty
                          ? Image.network(
                              widget.car.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xffD1122C),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                // Debug: Print error for troubleshooting
                                print(
                                  '❌ Image failed to load for ${widget.car.model}',
                                );
                                print('URL: ${widget.car.imageUrl}');
                                print('Error: $error');

                                return Image.asset(
                                  "assets/car_image.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              "assets/car_image.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                  // Dark Gradient Overlay for Text Readability
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button - Top Right
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.isFavorited
                              ? Color(0xffD1122C).withOpacity(0.8)
                              : Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          widget.isFavorited
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorited
                              ? Color(0xffD1122C)
                              : Colors.white,
                          size: 20,
                        ),
                        onPressed: widget.onFavoriteToggle,
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ),

                  // Bottom Info Section
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Model Name
                          Text(
                            widget.car.model,
                            style: TextStyle(
                              fontSize: 22 * fontMultiplier,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 12),

                          // Bottom Row: Icons on Left, Price on Right
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Distance and Fuel Icons
                              Row(
                                children: [
                                  // Distance
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/gps.png',
                                        width: 16,
                                        height: 16,
                                        color: Color(0xffA3ACB3),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${widget.car.distance.toStringAsFixed(0)}km',
                                        style: TextStyle(
                                          fontSize: 13 * fontMultiplier,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffA3ACB3),
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(width: 16),

                                  // Fuel
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/pump.png',
                                        width: 16,
                                        height: 16,
                                        color: Color(0xffA3ACB3),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${widget.car.fuelCapacity.toStringAsFixed(0)}L',
                                        style: TextStyle(
                                          fontSize: 13 * fontMultiplier,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffA3ACB3),
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Price Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffD1122C),
                                      Color(0xffA00F23),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffD1122C).withOpacity(0.5),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '\$${widget.car.price.toStringAsFixed(2)}/h',
                                  style: TextStyle(
                                    fontSize: 16 * fontMultiplier,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
