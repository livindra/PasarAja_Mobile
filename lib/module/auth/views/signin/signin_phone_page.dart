import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasaraja_mobile/config/themes/colors.dart';
import 'package:pasaraja_mobile/config/themes/images.dart';
import 'package:pasaraja_mobile/core/constants/constants.dart';
import 'package:pasaraja_mobile/core/utils/validations.dart';
import 'package:pasaraja_mobile/module/auth/views/verify/verify_pin_page.dart';
import 'package:pasaraja_mobile/module/auth/widgets/widgets.dart';

class SignInPhonePage extends StatefulWidget {
  const SignInPhonePage({super.key});

  @override
  State<SignInPhonePage> createState() => _SignInPhonePageState();
}

class _SignInPhonePageState extends State<SignInPhonePage> {
  final TextEditingController phoneCont = TextEditingController();
  ValidationModel vPhone = PasarAjaValidation.phone(null);
  int state = AuthFilledButton.stateDisabledButton;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PasarAjaColor.white,
      appBar: authAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 19,
              right: 19,
              top: 176 - MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              const AuthInit(
                image: PasarAjaImage.ilLoginPhone,
                title: 'Masuk Akun (Remote)',
                description:
                    'Silakan masukkan nomor HP Anda untuk masuk ke dalam aplikasi.',
              ),
              const SizedBox(height: 19),
              const Align(
                alignment: Alignment.centerLeft,
                child: AuthInputTitle(title: 'Masukan Nomor HP'),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    const Expanded(child: AuthCountries()),
                    const SizedBox(width: 13),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: AuthTextField(
                        controller: phoneCont,
                        hintText: '82-xxxx-xxxx',
                        keyboardType: TextInputType.number,
                        formatters: AuthTextField.numberFormatter(),
                        errorText: vPhone.message,
                        showHelper: false,
                        onChanged: (value) {
                          // valdasi data
                          vPhone = PasarAjaValidation.phone(value);
                          // enable and disable button
                          if (vPhone.status == true) {
                            state = AuthFilledButton.stateEnabledButton;
                          } else {
                            state = AuthFilledButton.stateDisabledButton;
                          }
                          setState(() {});
                        },
                        suffixAction: () {
                          phoneCont.text = '';
                          vPhone = PasarAjaValidation.phone('');
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AuthHelperText(
                  title: _showHelperText(vPhone.message),
                ),
              ),
              const SizedBox(height: 40),
              AuthFilledButton(
                onPressed: () async {
                  setState(
                    () => state = AuthFilledButton.stateLoadingButton,
                  );
                  await Future.delayed(
                    const Duration(seconds: PasarAjaConstant.initLoading),
                  );
                  setState(
                    () => state = AuthFilledButton.stateEnabledButton,
                  );
                  // Navigator.pushNamed(context, RouteName.verifyPin);
                  Get.to(VerifyPinPage(), transition: Transition.leftToRight);
                },
                state: state,
                title: 'Berikutnya',
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

String? _showHelperText(String? message) {
  if (message == null || message != 'Phone null' && message != 'Data valid') {
    return message;
  } else {
    return null;
  }
}