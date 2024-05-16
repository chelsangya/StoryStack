import 'package:flutter/widgets.dart';
import 'package:story_stack/features/primary/presentation/view/discover_view.dart';
import 'package:story_stack/view/select_view.dart';

class PrimaryState {
  final int index;
  final bool isLoading;
  // final List<NannyEntity> nannies;
  final List<Widget> lstWidgets;

  PrimaryState({
    required this.index,
    required this.lstWidgets,
    required this.isLoading,
    // required this.nannies
  });

  PrimaryState.initialState()
      : index = 0,
        isLoading = false,
        // nannies = [],
        lstWidgets = [
          const DiscoverView(),
          const SelectView(),
          const SelectView(),
          const SelectView(),

          // const FavouritesView(),
          // const BookingsView(),
          // const SettingsView(),
        ];

  // CopyWith function to change the index no
  PrimaryState copyWith({
    int? index,
    bool? isLoading,
    // List<NannyEntity>? nannies,
  }) {
    return PrimaryState(
      index: index ?? this.index,
      isLoading: isLoading ?? this.isLoading,
      lstWidgets: lstWidgets,
      // nannies: nannies ?? this.nannies,
    );
  }
}
