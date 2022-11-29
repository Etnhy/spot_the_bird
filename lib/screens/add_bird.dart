import 'dart:io';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AddBirdScreen extends StatefulWidget {
  final LatLng latLng;
  final File image;
  AddBirdScreen({required this.latLng, required this.image});

  @override
  State<AddBirdScreen> createState() => _AddBirdScreenState();
}

class _AddBirdScreenState extends State<AddBirdScreen> {
  String? name;
  String? description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add bird"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: FileImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextField(
                onChanged: ((value) {
                  name = value;
                  print("name $name");
                }),
              ),
              TextField(onChanged: (value) {
                description = value;
                print("des $description");
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add bird post to BirdPostCubit
          // Save bird
          // Later show post on the map
          // Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.check,
          size: 30,
        ),
      ),
    );
  }
}
