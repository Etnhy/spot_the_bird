import 'dart:io';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/models/bird_model.dart';

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
  late final FocusNode _descriptionsFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _descriptionsFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionsFocusNode.dispose();
    super.dispose();
  }

  void _submit(BirdModel birdModel, BuildContext context) {
    // save to cubit
    if (!_formKey.currentState!.validate()) {
      //invalid
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add bird"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    // move focus to next tf
                    FocusScope.of(context).requestFocus(_descriptionsFocusNode);
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter a Bird Name"),
                  onChanged: (newValue) {
                    name = newValue.trim();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    }
                    if (value.length < 2) {
                      return "Please enter a longer name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  focusNode: _descriptionsFocusNode,
                  decoration: const InputDecoration(
                      hintText: "Enter a Bird description"),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    final BirdModel birdModel = BirdModel(
                        image: widget.image,
                        birdName: name!,
                        latitude: widget.latLng.latitude,
                        longitude: widget.latLng.longitude,
                        birdDescription: description!);
                    _submit(birdModel, context);
                  },
                  onChanged: ((newValue) {
                    description = newValue!.trim();
                  }),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a description";
                    }
                    if (value.length < 2) {
                      return "Please enter a longer description";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add bird post to BirdPostCubit
          // Save bird

          final BirdModel birdModel = BirdModel(
              image: widget.image,
              birdName: name!,
              latitude: widget.latLng.latitude,
              longitude: widget.latLng.longitude,
              birdDescription: description!);

          _submit(birdModel, context);
          //context.read<BirdPostCubit>().addpost(birdModel);
          // Navigator.of(context).pop();
          // Later show post on the map
        },
        child: const Icon(
          Icons.check,
          size: 30,
        ),
      ),
    );
  }
}
