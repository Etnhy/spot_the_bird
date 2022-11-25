import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/bloc/location_cubit.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: ((context, state) {
          if (state is LocationLoaded) {
            return FlutterMap(
              options: MapOptions(
                center: LatLng(state.latitude, state.longitude),
                zoom: 15.3,
                maxZoom: 17,
                minZoom: 3.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  retinaMode: true,
                ),
              ],
            );
          }
          if (state is LocationError) {
            return Center(
              child: MaterialButton(
                  child: const Text("try again"),
                  onPressed: () {
                    context.read<LocationCubit>().getLocation();
                  }),
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
