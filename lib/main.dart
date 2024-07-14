import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/app.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPrefs().init();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
