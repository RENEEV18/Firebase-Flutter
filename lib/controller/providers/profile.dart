import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/view/log_in_screen/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  File? image;
  bool isImageLoading = false;
  bool get isLoading => isImageLoading;
  String downloadUrl = '';

  Future<void> getImage(ImageSource source) async {
    final imgPicker = await ImagePicker().pickImage(source: source);
    if (imgPicker == null) {
      return;
    } else {
      final imageTemp = File(imgPicker.path);
      image = imageTemp;
      if (image != null) {
        uploadPick();
      }
      notifyListeners();

      log('image picked');
    }
  }

  Future<void> signOut(context) async {
    await auth.signOut();
    downloadUrl = '';
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }

  Future<void> uploadPick() async {
    try {
      Reference reference =
          storage.ref().child('${auth.currentUser!.email}/images');
      reference.putFile(image!);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void getProfileImage() async {
    try {
      Reference reference =
          storage.ref().child('${auth.currentUser!.email}/images');
      downloadUrl = await reference.getDownloadURL();
      notifyListeners();
      log(downloadUrl);
    } catch (e) {
      log('getImageException${e.toString()}');
    }
  }
}
