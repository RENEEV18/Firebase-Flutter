import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/controller/providers/firebase_login_auth.dart';
import 'package:firebase_project/core/constant/const.dart';
import 'package:firebase_project/view/home/home.dart';
import 'package:firebase_project/view/log_in_screen/login.dart';
import 'package:firebase_project/widgets/bottom_button.dart';
import 'package:firebase_project/widgets/signin_button.dart';
import 'package:firebase_project/widgets/row_divider.dart';
import 'package:firebase_project/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticateProvider>();
    // final authProvider = Provider.of<AuthenticateProvider>(context,listen: false);
    return StreamBuilder<User?>(
      stream: authProvider.user(),
      builder: (context, user) {
        if (user.hasData) {
          return const HomeScreen();
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kSize,
                  Image.asset(
                    'assets/images/task-registration-2081679-1756042.png',
                    width: 230,
                  ),
                  Image.asset(
                    'assets/images/firebase-1-282796.png',
                    height: 50,
                  ),
                  const Text(
                    'Register',
                    style: kFirebaseStyle,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ),
                          );
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                  if (authProvider.loading)
                    const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  if (!authProvider.loading)
                    SigninButton(
                      onPressed: () {
                        signUp(authProvider, context);
                      },
                      text: 'Sign up',
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
                          'Sign up with Google',
                        ),
                        color: kGoogle,
                      ),
                      BottomButton(
                        image:
                            'assets/images/PNGPIX-COM-Apple-Grey-Logo-PNG-Transparent.png',
                        text: Text(
                          'Sign up with Apple',
                          style: TextStyle(color: kWhite),
                        ),
                        color: kBlack,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void signUp(AuthenticateProvider provider, context) async {
    final message = await provider.signUp(email.text, password.text);
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

    void googleSignup(AuthenticateProvider provider, context) async {
    final message = await provider.googleSignup();
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

   void appleSignup(AuthenticateProvider provider, context) async {
    final message = await provider.appleSignup();
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
