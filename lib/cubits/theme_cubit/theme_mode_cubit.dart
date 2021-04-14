import 'package:bloc/bloc.dart';
import 'package:mero_note/theme/theme_palatte.dart';

class ThemeModeCubit extends Cubit<ThemePalatte> {
  ThemeModeCubit() : super(ThemePalatte.lightThemePalatte);

  Future switchTheme(bool themeType) async {
    final themePallet = themeType == false
        ? ThemePalatte.lightThemePalatte
        : ThemePalatte.darkThemePalatte;

    return emit(themePallet);
  }
}
