import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/car.dart';
import 'package:flutter_application_1/presentation/widgets/car_card.dart';
import 'package:flutter_application_1/utils/responsive_utils.dart';

class CarSearchPage extends StatefulWidget {
  final List<Car> allCars;
  final Set<String> favoriteCars;
  const CarSearchPage({
    super.key,
    required this.allCars,
    required this.favoriteCars,
  });

  @override
  State<CarSearchPage> createState() => _CarSearchPageState();
}

class _CarSearchPageState extends State<CarSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Car> _filteredCars = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredCars = widget.allCars;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCars(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredCars = widget.allCars;
      } else {
        _filteredCars = widget.allCars
            .where(
              (car) => car.model.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        backgroundColor: Color(0xff1F1F23),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Cars',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xff1F1F23),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff2A2A2E), Color(0xff1F1F23)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xffD1122C).withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Color(0xffD1122C), size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search for a car model...',
                        hintStyle: TextStyle(
                          color: Color(0xffA3ACB3),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: _filterCars,
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear, color: Color(0xffA3ACB3)),
                      onPressed: () {
                        _searchController.clear();
                        _filterCars('');
                      },
                    ),
                ],
              ),
            ),
          ),

          // Search Results
          Expanded(
            child: _filteredCars.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Color(0xff2A2A2E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isSearching
                                ? Icons.search_off
                                : Icons.directions_car,
                            color: Color(0xffD1122C),
                            size: 64,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          _isSearching ? 'No cars found' : 'Start searching',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _isSearching
                              ? 'Try searching with a different name'
                              : 'Enter a car model name above',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffA3ACB3),
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.getResponsivePadding(context),
                      vertical: 20,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.getGridCount(context),
                      childAspectRatio: ResponsiveUtils.getCardAspectRatio(
                        context,
                      ),
                      crossAxisSpacing: ResponsiveUtils.getGridSpacing(context),
                      mainAxisSpacing: ResponsiveUtils.getGridSpacing(context),
                    ),
                    itemCount: _filteredCars.length,
                    itemBuilder: (context, index) {
                      final car = _filteredCars[index];
                      return CarCard(
                        car: car,
                        isFavorited: widget.favoriteCars.contains(car.model),
                        onFavoriteToggle: () {
                          setState(() {
                            if (widget.favoriteCars.contains(car.model)) {
                              widget.favoriteCars.remove(car.model);
                            } else {
                              widget.favoriteCars.add(car.model);
                            }
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
