import 'package:firebase_project/controller/providers/firebase_login_auth.dart';
import 'package:firebase_project/core/constant/const.dart';
import 'package:firebase_project/view/register_screen/register.dart';
import 'package:firebase_project/widgets/bottom_button.dart';
import 'package:firebase_project/widgets/clippath_top.dart';
import 'package:firebase_project/widgets/signin_button.dart';
import 'package:firebase_project/widgets/row_divider.dart';
import 'package:firebase_project/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticateProvider>();
    // final authProvider = Provider.of<AuthenticateProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: TopWaveClipper(),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: kBlue,
                ),
              ),
              Image.asset(
                'assets/images/firebase-1-282796.png',
                height: 60,
              ),
              const Text(
                'Firebase',
                style: kFirebaseStyle,
              ),
              const Text(
                'Authentication',
                style: kAuthStyle,
              ),
              kSize,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Field(
                  text: const Text('Email'),
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  obscuretext: false,
                ),
              ),
              kSize,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Field(
                  text: const Text('Password'),
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscuretext: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
              ),
              if (authProvider.loading)
                const CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              if (!authProvider.loading)
                SigninButton(
                  onPressed: () {
                    signIn(authProvider, context);
                  },
                  text: 'Sign in',
                ),
              kSize,
              const RowDivider(),
              kSize,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  BottomButton(
                    image: 'assets/images/google_PNG19635.png',
                    text: Text(
                      'Sign in with Google',
                    ),
                    color: kGoogle,
                  ),
                  BottomButton(
                    image:
                        'assets/images/PNGPIX-COM-Apple-Grey-Logo-PNG-Transparent.png',
                    text: Text(
                      'Sign in with Apple',
                      style: TextStyle(color: kWhite),
                    ),
                    color: kBlack,
                  ),
                ],
              ),
              kSize,
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Terms and consitons apply @Copyfirebase. ',
                    style: TextStyle(
                      color: kGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(AuthenticateProvider provider, context) async {
    final message = await provider.signIn(email.text, password.text);
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: kRed),
          ),
          backgroundColor: kBlack,
        ),
      );
    }
  }
}
