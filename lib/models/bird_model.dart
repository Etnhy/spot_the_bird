import 'dart:io';

class BirdModel {
  final String birdName;
  final String birdDescription;
//
  final double latitude;
  final double longitude;
//
  final File image;

  BirdModel({
    required this.image,
    required this.birdName,
    required this.latitude,
    required this.longitude,
    required this.birdDescription,
  });
}
