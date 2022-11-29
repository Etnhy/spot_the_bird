import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/bird_model.dart';
part 'bird_post_state.dart';

class BirdPostCubit extends Cubit<BirdPostState> {
  BirdPostCubit()
      : super(BirdPostState(birdPosts: [], status: BirdPostStatus.initial));
}
