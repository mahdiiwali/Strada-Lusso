import 'package:cloud_firestore/cloud_firestore.dart';

/// Helper function to add sample luxury cars to Firebase Firestore
/// Call this once to populate your database with test data
Future<void> addSampleCars() async {
  final firestore = FirebaseFirestore.instance;

  // List of luxury cars with realistic specifications
  final sampleCars = [
    {
      'model': 'Mercedes-Benz S-Class',
      'distance': 1250.5,
      'fuelCapacity': 80.0,
      'price': 25.99,
      'maxSpeed': '250 km/h',
      'acceleration': '0-100 in 4.5s',
      'transmission': '9-Speed Automatic',
      'seats': 5,
      'category': 'Luxury Sedan',
      'imageUrl':
          'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
      'ownerName': 'Michael Schmidt',
      'ownerPhone': '+49 30 12345678',
      'ownerRating': 4.8,
      'ownerReviews': 156,
    },
    {
      'model': 'BMW M5',
      'distance': 890.3,
      'fuelCapacity': 68.0,
      'price': 22.50,
      'maxSpeed': '305 km/h',
      'acceleration': '0-100 in 3.4s',
      'transmission': '8-Speed M Steptronic',
      'seats': 5,
      'category': 'Sports Sedan',
      'imageUrl':
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800',
      'ownerName': 'Andreas Mueller',
      'ownerPhone': '+49 89 98765432',
      'ownerRating': 4.9,
      'ownerReviews': 203,
    },
    {
      'model': 'Mercedes-AMG C63 S',
      'distance': 725.4,
      'fuelCapacity': 66.0,
      'price': 24.99,
      'maxSpeed': '290 km/h',
      'acceleration': '0-100 in 3.9s',
      'transmission': 'AMG SPEEDSHIFT MCT 9-Speed',
      'seats': 5,
      'category': 'Sports Sedan',
      'imageUrl':
          'https://images.unsplash.com/photo-1563720360172-67b8f3dce741?w=800',
      'ownerName': 'Stefan Bauer',
      'ownerPhone': '+49 711 44455566',
      'ownerRating': 4.8,
      'ownerReviews': 167,
    },
    {
      'model': 'Porsche 911 Turbo S',
      'distance': 567.8,
      'fuelCapacity': 64.0,
      'price': 35.00,
      'maxSpeed': '330 km/h',
      'acceleration': '0-100 in 2.7s',
      'transmission': '8-Speed PDK',
      'seats': 4,
      'category': 'Sports Car',
      'imageUrl':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
      'ownerName': 'Thomas Weber',
      'ownerPhone': '+49 711 55566677',
      'ownerRating': 5.0,
      'ownerReviews': 89,
    },
    {
      'model': 'Ferrari F8 Tributo',
      'distance': 342.1,
      'fuelCapacity': 78.0,
      'price': 50.00,
      'maxSpeed': '340 km/h',
      'acceleration': '0-100 in 2.9s',
      'transmission': '7-Speed F1 DCT',
      'seats': 2,
      'category': 'Supercar',
      'imageUrl':
          'https://images.unsplash.com/photo-1592198084033-aade902d1aae?w=800',
      'ownerName': 'Lorenzo Rossi',
      'ownerPhone': '+39 055 1234567',
      'ownerRating': 4.7,
      'ownerReviews': 45,
    },
    {
      'model': 'Range Rover Autobiography',
      'distance': 1580.2,
      'fuelCapacity': 104.5,
      'price': 28.75,
      'maxSpeed': '225 km/h',
      'acceleration': '0-100 in 5.4s',
      'transmission': '8-Speed Automatic',
      'seats': 7,
      'category': 'Luxury SUV',
      'imageUrl':
          'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=800',
      'ownerName': 'James Baldwin',
      'ownerPhone': '+44 20 87654321',
      'ownerRating': 4.6,
      'ownerReviews': 178,
    },
  ];

  // Add each car to Firestore
  for (var car in sampleCars) {
    await firestore.collection('cars').add(car);
    print('Added: ${car['model']}');
  }

  print('✅ Successfully added ${sampleCars.length} luxury cars to Firebase!');
}

/// Helper function to clear existing cars and add updated ones
/// Use this when you want to replace all cars with new data
Future<void> clearAndAddCars() async {
  final firestore = FirebaseFirestore.instance;

  print('🗑️ Clearing old car data...');

  // Delete all existing cars
  final snapshot = await firestore.collection('cars').get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }

  print('✅ Deleted ${snapshot.docs.length} old cars');
  print('➕ Adding updated cars...');

  // Add new cars with updated data
  await addSampleCars();
}
