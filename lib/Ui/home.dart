import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_note/cubits/theme_cubit/theme_mode_cubit.dart';
import 'package:mero_note/utils/di.dart';
import 'package:mero_note/theme/theme_palatte.dart';
import 'package:mero_note/utils/extensions/context_extension.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid;
  String userEmail;
  Future<User> signInWithEmailPassword({String email, String password}) async {
    await Firebase.initializeApp();
    User user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => getIt<ThemeModeCubit>(),
      child: BlocBuilder<ThemeModeCubit, ThemePalatte>(
        builder: (context, themePalatte) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              body: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: size.height / 2,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    color: context.theme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter email address !";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Enter valid email address !";
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: context.theme.background,
                                filled: true,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: context.theme.corePalatte.iconColor,
                                ),
                                focusColor:
                                    context.theme.corePalatte.primaryColor,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                    color: context.theme.corePalatte.iconColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                labelText: "E-mail",
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        color: context.theme.textColor
                                            .withOpacity(0.6))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter password";
                              }

                              return null;
                            },
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              fillColor: context.theme.background,
                              filled: true,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: context.theme.corePalatte.iconColor,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                child: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: context.theme.corePalatte.iconColor,
                                ),
                              ),
                              focusColor:
                                  context.theme.corePalatte.primaryColor,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: "xxxxxxx",
                              hintStyle: TextStyle(
                                  color: context.theme.corePalatte.iconColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              labelText: "Password",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: context.theme.textColor
                                          .withOpacity(0.6)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              print("ok");
                              signInWithEmailPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            } else {
                              print("not ok");
                            }
                          },
                          child: Text("Login"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: DayNightSwitcher(
                isDarkModeEnabled: themePalatte.isDarkMode,
                onStateChanged: (status) {
                  getIt<ThemeModeCubit>().switchTheme(
                    status,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
