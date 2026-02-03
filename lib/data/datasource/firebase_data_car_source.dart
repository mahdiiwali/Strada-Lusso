import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/models/car.dart';

class FirebaseDataCarSource {
  final FirebaseFirestore _firestore;

  FirebaseDataCarSource({required FirebaseFirestore firestore})
    : _firestore = firestore;
  Future<List<Car>> getCars() async {
    var snapshot = await _firestore.collection('cars').get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.data())).toList();
  }
}
