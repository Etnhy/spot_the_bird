import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spot_the_bird/services/sqflite.dart';
import '../models/bird_model.dart';
part 'bird_post_state.dart';

class BirdPostCubit extends Cubit<BirdPostState> {
  final dbHelper = DatabaseHelper.instance;

  BirdPostCubit()
      : super(BirdPostState(birdPosts: [], status: BirdPostStatus.initial));

  Future<void> loadPosts() async {
    emit(state.copyWith(status: BirdPostStatus.loading));
    List<BirdModel> birdPosts = [];

    emit(state.copyWith(birdPosts: birdPosts, status: BirdPostStatus.loaded));
  }

  Future<void> addBirdPost(BirdModel birdModel) async {
    emit(state.copyWith(status: BirdPostStatus.loading));
    List<BirdModel> birdPost = state.birdPosts;
    birdPost.add(birdModel);
    emit(state.copyWith(birdPosts: birdPost, status: BirdPostStatus.loaded));
  }

  void removeBirdPost(BirdModel birdModel) {
    emit(state.copyWith(status: BirdPostStatus.loading));
    List<BirdModel> birdPost = state.birdPosts;
    birdPost.removeWhere((element) => element == birdModel);
    emit(state.copyWith(birdPosts: birdPost, status: BirdPostStatus.loaded));
  }
}
