import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/controller/providers/api_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiProvider>(context, listen: false).listofUsers();
    });
    return StreamBuilder<User?>(
        stream: context.watch<AuthenticateProvider>().user(),
        builder: (context, user) {
          if (!user.hasData) {
            return const LoginScreen();
          }
          return Scaffold(
            appBar: AppBar(
              leading: const Icon(
                Icons.menu_rounded,
                color: kWhite,
              ),
              backgroundColor: kBlue,
              title: Center(
                child: Text(
                  'welcome'.toUpperCase(),
                  style: kAppbarTitle,
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
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Consumer<ApiProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                            ),
                            Text(
                              value.userList[index].name,
                              style: const TextStyle(
                                  color: kBlack, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const SizedBox(
                              width: 24,
                            ),
                            Text(
                              value.userList[index].email,
                              style: const TextStyle(
                                  color: kBlack, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(imageUrl[index]),
                        ),
                        trailing: const Icon(
                          Icons.business_center_outlined,
                          color: kBlack,
                        ),
                      );
                    },
                    itemCount: 10,
                  );
                },
              ),
            ),
          );
        });
  }
}
