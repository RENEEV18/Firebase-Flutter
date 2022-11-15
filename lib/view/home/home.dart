import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/controller/providers/firebase_login_auth.dart';
import 'package:firebase_project/core/constant/const.dart';
import 'package:firebase_project/view/log_in_screen/login.dart';
import 'package:firebase_project/view/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.watch<AuthenticateProvider>().user(),
        builder: (context, user) {
          if (!user.hasData) {
            return const LoginScreen();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kBlue,
              title: Center(
                child: Text(
                  'welcome'.toUpperCase(),
                  style: kAppbarTitle,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  context.read<AuthenticateProvider>().signOut();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: kWhite,
                  size: 28,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const UserProfileScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person_pin,
                    color: kWhite,
                    size: 35,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
