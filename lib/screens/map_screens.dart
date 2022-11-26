import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/bloc/location_cubit.dart';

import 'add_bird.dart';

class MapScreen extends StatelessWidget {
  final MapController _mapController = MapController();

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
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          onLongPress: (tapPosition, point) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => AddBirdScreen(latLng: point)));
          },
          center: LatLng(0, 0),
          zoom: 16,
          maxZoom: 18,
          minZoom: 4,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ["a", "b", "c"],
            retinaMode: true,
          ),
        ],
      ),
    ));
  }
}
