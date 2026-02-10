class Car {
  final String model;
  final double distance;
  final double fuelCapacity;
  final double price;
  final String maxSpeed;
  final String acceleration;
  final String transmission;
  final int seats;
  final String category;
  final String imageUrl;

  // Owner information
  final String ownerName;
  final String ownerPhone;
  final double ownerRating;
  final int ownerReviews;

  Car({
    required this.model,
    required this.distance,
    required this.fuelCapacity,
    required this.price,
    required this.maxSpeed,
    required this.acceleration,
    required this.transmission,
    required this.seats,
    required this.category,
    required this.imageUrl,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerRating,
    required this.ownerReviews,
  });

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['model'],
      distance: map['distance'],
      fuelCapacity: map['fuelCapacity'],
      price: map['price'],
      maxSpeed: map['maxSpeed'],
      acceleration: map['acceleration'],
      transmission: map['transmission'],
      seats: map['seats'],
      category: map['category'],
      imageUrl:
          map['imageUrl'] ??
          '', // Removed cache-busting for better mobile performance
      ownerName: map['ownerName'],
      ownerPhone: map['ownerPhone'],
      ownerRating: map['ownerRating'],
      ownerReviews: map['ownerReviews'],
    );
  }
}
