import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/models/car.dart';
import 'package:flutter_application_1/presentation/widgets/car_card.dart';
import 'package:flutter_application_1/presentation/pages/car_search_page.dart';
import 'package:flutter_application_1/presentation/pages/favorite_cars_page.dart';
import 'package:flutter_application_1/utils/responsive_utils.dart';
import 'package:flutter_application_1/presentation/bloc/car_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/car_event.dart';
import 'package:flutter_application_1/presentation/bloc/car_state.dart';
import 'package:flutter_application_1/injection_container.dart';
import 'package:flutter_application_1/data/datasource/favorites_storage_service.dart';

class CarListScreen extends StatefulWidget {
  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  int _selectedNavIndex = 0;
  String _selectedCategory = "All";
  final List<String> _categories = [
    "All",
    "Luxury Sedan",
    "Sports Sedan",
    "Sports Car",
    "Supercar",
    "Luxury SUV",
  ];
  final Set<String> _favoriteCars = {}; // Track favorite car models

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesStorageService.loadFavorites();
    setState(() {
      _favoriteCars.addAll(favorites);
    });
  }

  Future<void> _saveFavorites() async {
    await FavoritesStorageService.saveFavorites(_favoriteCars);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CarBloc>()..add(LoadCarsEvent()),
      child: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarLoadingState) {
            return Scaffold(
              backgroundColor: Color(0xff1A1A1A),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xffD1122C)),
                    SizedBox(height: 20),
                    Text(
                      'Loading cars...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CarErrorState) {
            return Scaffold(
              backgroundColor: Color(0xff1A1A1A),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Color(0xffD1122C),
                      size: 60,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Error loading cars',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      state.message,
                      style: TextStyle(color: Color(0xffA3ACB3), fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CarBloc>().add(LoadCarsEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffD1122C),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CarLoadedState) {
            final cars = state.cars;

            if (cars.isEmpty) {
              return Scaffold(
                backgroundColor: Color(0xff1A1A1A),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car_outlined,
                        color: Color(0xffD1122C),
                        size: 60,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No cars available',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Check back later for new listings!',
                        style: TextStyle(
                          color: Color(0xffA3ACB3),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return _buildCarList(cars);
          }

          return Container(); // Fallback
        },
      ),
    );
  }

  Widget _buildCarList(List<Car> cars) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A), // Deep Charcoal background
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Top spacing for back button
                SliverToBoxAdapter(child: SizedBox(height: 60)),

                // Category Filter Chips
                SliverToBoxAdapter(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category;
                        return Container(
                          margin: EdgeInsets.only(right: 12),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            selectedColor: Color(
                              0xffD1122C,
                            ), // Brake Caliper Red
                            backgroundColor: Color(0xff2A2A2E), // Charcoal
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Color(0xffA3ACB3),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? Color(0xffD1122C)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Car Grid - Responsive
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.getResponsivePadding(context),
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.getGridCount(context),
                      childAspectRatio: ResponsiveUtils.getCardAspectRatio(
                        context,
                      ),
                      crossAxisSpacing: ResponsiveUtils.getGridSpacing(context),
                      mainAxisSpacing: ResponsiveUtils.getGridSpacing(context),
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Filter cars based on selected category
                        final filteredCars = _selectedCategory == 'All'
                            ? cars
                            : cars
                                  .where(
                                    (car) => car.category == _selectedCategory,
                                  )
                                  .toList();

                        if (index >= filteredCars.length) return null;

                        final car = filteredCars[index];
                        return CarCard(
                          car: car,
                          isFavorited: _favoriteCars.contains(car.model),
                          onFavoriteToggle: () {
                            setState(() {
                              if (_favoriteCars.contains(car.model)) {
                                _favoriteCars.remove(car.model);
                              } else {
                                _favoriteCars.add(car.model);
                              }
                            });
                            _saveFavorites(); // Save to local storage
                          },
                        );
                      },
                      childCount: (_selectedCategory == 'All'
                          ? cars.length
                          : cars
                                .where(
                                  (car) => car.category == _selectedCategory,
                                )
                                .length),
                    ),
                  ),
                ),

                // Bottom padding for navigation bar
                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),

            // Professional Header with Back Button
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff1A1A1A),
                      Color(0xff1A1A1A).withOpacity(0.95),
                      Color(0xff1A1A1A).withOpacity(0.0),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Back Button
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff2A2A2E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xffD1122C).withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    // Title
                    Text(
                      'Browse Cars',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xff2A2A2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          backgroundColor: Color(0xff2A2A2E),
          indicatorColor: Color(0xffD1122C).withOpacity(0.3),
          selectedIndex: _selectedNavIndex,
          onDestinationSelected: (index) {
            if (index == 1) {
              // Navigate to search page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CarSearchPage(allCars: cars, favoriteCars: _favoriteCars),
                ),
              ).then((_) {
                // Refresh the screen when returning from search
                setState(() {});
              });
            } else if (index == 2) {
              // Show Coming Soon dialog for My Rentals
              _showComingSoonDialog(context);
            } else if (index == 3) {
              // Navigate to favorites page
              final favoriteCars = cars
                  .where((car) => _favoriteCars.contains(car.model))
                  .toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteCarsPage(
                    favoriteCars: favoriteCars,
                    favoriteCarsSet: _favoriteCars,
                  ),
                ),
              ).then((_) {
                // Refresh the screen when returning from favorites
                setState(() {});
              });
            } else {
              setState(() {
                _selectedNavIndex = index;
              });
            }
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: _selectedNavIndex == 0
                    ? Color(0xffD1122C)
                    : Color(0xffA3ACB3),
              ),
              selectedIcon: Icon(Icons.home, color: Color(0xffD1122C)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.search_outlined,
                color: _selectedNavIndex == 1
                    ? Color(0xffD1122C)
                    : Color(0xffA3ACB3),
              ),
              selectedIcon: Icon(Icons.search, color: Color(0xffD1122C)),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.car_rental_outlined,
                color: _selectedNavIndex == 2
                    ? Color(0xffD1122C)
                    : Color(0xffA3ACB3),
              ),
              selectedIcon: Icon(Icons.car_rental, color: Color(0xffD1122C)),
              label: 'My Rentals',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_border,
                color: _selectedNavIndex == 3
                    ? Color(0xffD1122C)
                    : Color(0xffA3ACB3),
              ),
              selectedIcon: Icon(Icons.favorite, color: Color(0xffD1122C)),
              label: 'My Favorite',
            ),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff2A2A2E), Color(0xff1F1F23)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 30,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Color(0xffD1122C).withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffD1122C), Color(0xffA00F23)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffD1122C).withOpacity(0.4),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.car_rental, color: Colors.white, size: 40),
                ),
                SizedBox(height: 24),

                // Title
                Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 12),

                // Message
                Text(
                  'My Rentals feature is under development and will be available soon!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffA3ACB3),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 28),

                // Close Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffD1122C), Color(0xffA00F23)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffD1122C).withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Got it!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
