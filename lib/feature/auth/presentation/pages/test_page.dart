import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:pasaraja_mobile/config/themes/colors.dart';
import 'package:pasaraja_mobile/feature/auth/presentation/widgets/appbar.dart';
import 'package:pasaraja_mobile/feature/auth/presentation/widgets/item_otp_view.dart';
import 'package:pasaraja_mobile/feature/auth/presentation/widgets/otp_view.dart';

class MyTestPage extends StatefulWidget {
  const MyTestPage({super.key});

  @override
  State<MyTestPage> createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  @override
  Widget build(BuildContext context) {
    OtpFieldController otpCont = OtpFieldController();
    const double space = 5;
    const double length = 6;
    const bool error = true;
    return Scaffold(
      backgroundColor: PasarAjaColor.white,
      appBar: authAppbar(),
      body: const SingleChildScrollView(
        child: AuthOtpView(
          length: 6,
        ),
      ),
    );
  }

  Row _manually(bool error, double space) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ItemOtpView(
          error: error,
        ),
        SizedBox(width: space),
        ItemOtpView(
          error: error,
        ),
        SizedBox(width: space),
        ItemOtpView(
          error: error,
        ),
        SizedBox(width: space),
        ItemOtpView(
          error: error,
        ),
        SizedBox(width: space),
        ItemOtpView(
          error: error,
        ),
        SizedBox(width: space),
        ItemOtpView(
          error: error,
        ),
      ],
    );
  }
}
