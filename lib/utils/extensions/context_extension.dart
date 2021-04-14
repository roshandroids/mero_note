import 'package:flutter/material.dart';
import 'package:mero_note/cubits/theme_cubit/theme_mode_cubit.dart';
import 'package:mero_note/theme/theme_palatte.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext {
  ThemePalatte get theme => watch<ThemeModeCubit>().state;
}
