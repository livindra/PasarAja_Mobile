import 'package:flutter/material.dart';
import 'package:pasaraja_mobile/config/themes/Typography.dart';
import 'package:pasaraja_mobile/config/themes/colors.dart';
import 'package:pasaraja_mobile/config/themes/images.dart';
import 'package:pasaraja_mobile/core/utils/validations.dart';
import 'package:pasaraja_mobile/feature/auth/presentation/pages/verify_otp_page.dart';
import 'package:pasaraja_mobile/feature/auth/presentation/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:pasaraja_mobile/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInGooglePage extends StatefulWidget {
  const SignInGooglePage({super.key});

  @override
  State<SignInGooglePage> createState() => _SignInGooglePageState();
}

class _SignInGooglePageState extends State<SignInGooglePage> {
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController pwCont = TextEditingController();
  ValidationModel vEmail = PasarAjaValidation.email(null);
  ValidationModel vPass = PasarAjaValidation.password(null);
  String email = '';
  //
  int state = AuthFilledButton.stateDisabledButton;
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PasarAjaColor.white,
      appBar: authAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 70 - MediaQuery.of(context).padding.top,
            left: 19,
            right: 19,
          ),
          child: Column(
            children: [
              const AuthInit(
                image: PasarAjaImage.ilLoginEmail,
                title: 'Masuk Akun',
                haveImage: true,
                description:
                    'Silakan masukkan email dan kata sandi Anda untuk masuk ke dalam aplikasi.',
              ),
              const SizedBox(height: 19),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: [
                    AuthInputText(
                      title: 'Masukan Email',
                      textField: AuthTextField(
                        controller: emailCont,
                        hintText: 'pasaraja@email.com',
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        fontSize: 18,
                        errorText: vEmail.message,
                        onChanged: (value) {
                          vEmail = PasarAjaValidation.email(value);
                          state = _buttonState(vEmail.status, vPass.status);
                          emailCont.text = value;
                          setState(() {});
                        },
                        suffixAction: () {
                          setState(() {
                            emailCont.text = '';
                            vEmail = PasarAjaValidation.email('');
                            state = _buttonState(vEmail.status, vPass.status);
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    AuthInputText(
                      title: 'Masukan Password',
                      textField: AuthTextField(
                        controller: pwCont,
                        hintText: 'xxxxxxxx',
                        errorText: vPass.message,
                        obscureText: obscure,
                        fontSize: 18,
                        suffixIcon: obscure
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              ),
                        onChanged: (value) {
                          vPass = PasarAjaValidation.password(value);
                          state = _buttonState(vEmail.status, vPass.status);
                          setState(() {});
                        },
                        suffixAction: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              AuthFilledButton(
                state: state,
                title: 'Masuk',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Goto Main'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  if (PasarAjaValidation.email(emailCont.text).status == true) {
                    Get.to(
                      VerifyOtpPage(
                        from: VerifyOtpPage.fromLoginGoogle,
                        recipient: emailCont.text,
                      ),
                      transition: Transition.downToUp,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email tidak valid'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Lupa Kata Sandi',
                  style: PasarAjaTypography.sfpdSemibold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  final provider =
                      Provider.of<GoogleSignProvider>(context, listen: false);
                  provider.googleLogin();

                  setState(() => email = provider.user.email);

                  // provider.logout();
                },
                child: Image.asset(
                  PasarAjaImage.icGoogle,
                  width: 38,
                  height: 38,
                ),
              ),
              InkWell(
                onTap: () {
                  final provider =
                      Provider.of<GoogleSignProvider>(context, listen: false);
                  provider.logout();
                  setState(() => email = '');
                },
                child: Text(
                  email,
                  style:
                      PasarAjaTypography.sfpdBold.copyWith(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

int _buttonState(bool? v1, bool? v2) {
  if (v1 == null || v2 == null) {
    return AuthFilledButton.stateDisabledButton;
  }
  if (!v1 || !v2) {
    return AuthFilledButton.stateDisabledButton;
  } else {
    return AuthFilledButton.stateEnabledButton;
  }
}
