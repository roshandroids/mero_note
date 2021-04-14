import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_note/Ui/home.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mero_note/utils/di.dart';
import 'package:mero_note/theme/theme_palatte.dart';

import 'cubits/theme_cubit/theme_mode_cubit.dart';

void main() async {
  initDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeModeCubit>(),
      child: BlocBuilder<ThemeModeCubit, ThemePalatte>(
        builder: (context, themePalatte) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
            theme: ThemeData(
                scaffoldBackgroundColor: themePalatte.background,
                primaryColor: themePalatte.corePalatte.primaryColor,
                accentColor: themePalatte.corePalatte.secondaryColor,
                canvasColor: themePalatte.background,
                brightness: themePalatte.brightness,
                textTheme: TextTheme(
                  headline1: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                  headline2: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                  headline3: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                  headline4: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  headline5: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                  headline6: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                  subtitle1: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  subtitle2: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  bodyText1: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  bodyText2: GoogleFonts.openSans(
                      color: themePalatte.onBackground,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  button: GoogleFonts.openSans(
                      color: themePalatte.onBackgroundDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                  caption: GoogleFonts.openSans(
                      color: themePalatte.onBackgroundLight),
                  overline: GoogleFonts.openSans(
                      color: themePalatte.onBackgroundLight),
                ),
                appBarTheme: AppBarTheme(
                  brightness: themePalatte.brightness,
                  color: themePalatte.surface,
                  iconTheme: IconThemeData(
                    color: themePalatte.onSurface,
                  ),
                )),
          );
        },
      ),
    );
  }
}
