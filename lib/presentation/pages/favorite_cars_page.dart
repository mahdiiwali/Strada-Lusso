import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/car.dart';
import 'package:flutter_application_1/presentation/widgets/car_card.dart';

class FavoriteCarsPage extends StatefulWidget {
  final List<Car> favoriteCars;
  final Set<String> favoriteCarsSet;
  const FavoriteCarsPage({
    super.key,
    required this.favoriteCars,
    required this.favoriteCarsSet,
  });

  @override
  State<FavoriteCarsPage> createState() => _FavoriteCarsPageState();
}

class _FavoriteCarsPageState extends State<FavoriteCarsPage> {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: Color(0xffD1122C)),
            SizedBox(width: 8),
            Text(
              'My Favorites',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 32), // Balance the leading icon
          ],
        ),
      ),
      body: widget.favoriteCars.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff2A2A2E), Color(0xff1F1F23)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Color(0xffD1122C),
                      size: 72,
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    'No Favorites Yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'Start adding cars to your favorites by tapping the heart icon on any car',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffA3ACB3),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              itemCount: widget.favoriteCars.length,
              itemBuilder: (context, index) {
                final car = widget.favoriteCars[index];
                return CarCard(
                  car: car,
                  isFavorited: widget.favoriteCarsSet.contains(car.model),
                  onFavoriteToggle: () {
                    setState(() {
                      widget.favoriteCarsSet.remove(car.model);
                    });
                  },
                );
              },
            ),
    );
  }
}
