import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:story_stack/features/primary/presentation/viewmodel/primary_view_model.dart';

class PrimaryView extends ConsumerStatefulWidget {
  const PrimaryView({super.key});

  @override
  ConsumerState<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends ConsumerState<PrimaryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final primaryState = ref.watch(primaryViewModelProvider);
        return Scaffold(
          body: primaryState.lstWidgets[primaryState.index],
          bottomNavigationBar: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.indicator,
            elevation: 10,
            selectedItemColor: const Color(0xFF0B2B3D),
            unselectedItemColor: Colors.grey[900]!,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            currentIndex: primaryState.index,
            onTap: (index) {
              ref.read(primaryViewModelProvider.notifier).changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  size: 25,
                ),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                  size: 25,
                ),
                label: 'Upcoming',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt,
                  size: 25,
                ),
                label: 'Your List',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
