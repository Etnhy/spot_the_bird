// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/bloc/bird_post_cubit.dart';
import 'package:spot_the_bird/bloc/location_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'add_bird.dart';
import 'package:spot_the_bird/models/bird_model.dart';

class MapScreen extends StatelessWidget {
  final MapController _mapController = MapController();

  Future<void> _pickImageAndCreatePost(
      {required LatLng latLng, required BuildContext context}) async {
    File? image;
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddBirdScreen(latLng: latLng, image: image!)));
    } else {
      print("User didn't pick image.");
    }
  }

  List<Marker> _buildMarkers(BuildContext context, List<BirdModel> birdPost) {
    List<Marker> markers = [];
    birdPost.forEach((post) {
      markers.add(
        Marker(
          width: 55,
          height: 55,
          point: LatLng(post.latitude, post.longitude),
          builder: (context) {
            return Container(
              color: Colors.lightGreenAccent,
            );
          },
        ),
      );
    });

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
        listener: (previousState, currentState) {
          if (currentState is LocationLoaded) {
            _mapController.onReady.then((_) => _mapController.move(
                LatLng(currentState.latitude, currentState.longitude), 15));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Location loaded"),
              duration: Duration(seconds: 2),
              backgroundColor: Color.fromARGB(255, 206, 155, 0),
            ));
          }
          if (currentState is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Error, unable to fetch location."),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.amberAccent,
            ));
          }
        },
        child: BlocBuilder<BirdPostCubit, BirdPostState>(
          buildWhen: (previous, current) => (previous.status != current.status),
          builder: ((context, birdPostState) {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onLongPress: (tapPosition, point) {
                  _pickImageAndCreatePost(latLng: point, context: context);
                },
                center: LatLng(0, 0),
                zoom: 16,
                maxZoom: 18,
                minZoom: 4,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ["a", "b", "c"],
                  retinaMode: true,
                ),
                MarkerLayerOptions(
                  markers: _buildMarkers(context, birdPostState.birdPosts),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
