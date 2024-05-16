import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/features/primary/presentation/state/primary_state.dart';


final primaryViewModelProvider =
    StateNotifierProvider.autoDispose<PrimaryViewModel, PrimaryState>(
        (ref) => PrimaryViewModel());

class PrimaryViewModel extends StateNotifier<PrimaryState> {
  PrimaryViewModel() : super(PrimaryState.initialState()) {
    getAllData();
  }

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }

  void getAllData() {
    state = state.copyWith(isLoading: true);
  }

}
