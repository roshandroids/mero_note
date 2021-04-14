package com.roshandroids.mero_note
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen


class MainActivity: FlutterActivity() {
     override fun provideSplashScreen(): SplashScreen? = SplashView()
}
