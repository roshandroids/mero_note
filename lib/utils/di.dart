import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mero_note/cubits/theme_cubit/theme_mode_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  _themeRegister();
}

void _themeRegister() {
  getIt.registerLazySingleton(() => ThemeModeCubit());
}
