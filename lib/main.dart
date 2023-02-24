import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/app/theme/app_theme.dart';
import 'src/features/authentication/presentation/login/login_screen.dart';
import 'src/features/home/home.dart';
import 'src/features/home/usert.dart';
import 'src/providers/provider_observer.dart';
import 'src/providers/shared_prefs_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      key: const Key('RiverpodProviderScope'),
      overrides: <Override>[
        prefsProvider.overrideWithValue(sharedPreferences),
      ],
      observers: <ProviderObserver>[ProviderLogger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme themeData = ref.watch(themeDataProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      //Light theme is made as default as of now but later on
      //need to make it dynamic based on user's preference
      themeMode: ThemeMode.light,
      home: const KeyboardVisibilityProvider(child: AuthCheck()),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  AuthCheckState createState() => AuthCheckState();
}

class AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences.getString('employeeId') != null) {
        setState(() {
          User.employeeId = sharedPreferences.getString('employeeId')!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? const HomeScreen() : const LoginScreen();
  }
}
