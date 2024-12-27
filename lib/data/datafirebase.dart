import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DataFirebase extends ChangeNotifier {
  DataFirebase() : super() {
    readDataMq135();
    readSoilMoisture();
    readDataHp();
    readDataSoil();
  }
  final refData = FirebaseDatabase.instance.ref(); // call firebase
  int mq135Data = 1;
  int humidity_indoor = 1;
  int soil_misture = 20;
  int ph = 1;
  readDataMq135() {
    refData.child("temp").onValue.listen((event) {
      mq135Data = event.snapshot.value as int;
      notifyListeners();
    });
  }

  readDataSoil() {
    refData.child("temp").onValue.listen((event) {
      soil_misture = event.snapshot.value as int;
      notifyListeners();
    });
  }

  readDataHp() {
    refData.child("temp").onValue.listen((event) {
      ph = event.snapshot.value as int;
      notifyListeners();
    });
  }

  readSoilMoisture() {
    refData.child("humi").onValue.listen((event) {
      humidity_indoor = event.snapshot.value as int;
      notifyListeners();
    });
  }
}
