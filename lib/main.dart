import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pasaraja_mobile/config/routes/routes.dart';
import 'package:pasaraja_mobile/config/themes/colors.dart';
import 'package:pasaraja_mobile/firebase_options.dart';
import 'package:pasaraja_mobile/module/auth/providers/providers.dart';
import 'package:pasaraja_mobile/module/auth/views/welcome_page.dart';
import 'package:pasaraja_mobile/core/services/google_signin_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignService()),
        ChangeNotifierProvider(create: (context) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (context) => ChangePinProvider()),
        ChangeNotifierProvider(create: (context) => SignInGoogleProvider()),
        ChangeNotifierProvider(create: (context) => SignInPhoneProvider()),
        ChangeNotifierProvider(create: (context) => SignUpFirstProvider()),
        ChangeNotifierProvider(create: (context) => SignUpSecondProvider()),
        ChangeNotifierProvider(create: (context) => SignUpThirdProvider()),
        ChangeNotifierProvider(create: (context) => SignUpFourthProvider()),
        ChangeNotifierProvider(create: (context) => VerifyOtpProvider()),
        ChangeNotifierProvider(create: (context) => VerifyPinProvider()),
      ],
      child: GetMaterialApp(
        title: 'PasarAja',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: PasarAjaColor.green2,
          ),
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const WelcomePage(),
      ),
    );
  }
}
