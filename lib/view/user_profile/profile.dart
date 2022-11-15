import 'dart:io';

import 'package:firebase_project/controller/providers/firebase_login_auth.dart';
import 'package:firebase_project/controller/providers/profile.dart';
import 'package:firebase_project/core/constant/const.dart';
import 'package:firebase_project/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthenticateProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getProfileImage();
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProfileProvider>().signOut(context);
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: kBlack,
              size: 28,
            ),
          ),
          kWidth,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          value.image == null
                              ? value.downloadUrl.isEmpty
                                  ? const CircleAvatar(
                                      radius: 60,
                                      backgroundColor: kBlack,
                                      child: Icon(Icons.photo),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        value.downloadUrl,
                                      ),
                                      radius: 60,
                                    )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(value.image!.path),
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: -2,
                            child: RawMaterialButton(
                              constraints: const BoxConstraints(
                                  maxHeight: 40, maxWidth: 40),
                              fillColor: kWhite,
                              shape: const CircleBorder(),
                              onPressed: () {},
                              child: IconButton(
                                  onPressed: () async {
                                    value.getImage(ImageSource.gallery);

                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.edit)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          '26',
                          style: profileStyle,
                        ),
                        Text('posts'),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          '10.3K',
                          style: profileStyle,
                        ),
                        Text('Followers'),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          '400',
                          style: profileStyle,
                        ),
                        Text('Following'),
                      ],
                    ),
                  ),
                ],
              ),
              kSize,
              Column(
                children: [
                  Text(
                    data.auth.currentUser!.email.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
