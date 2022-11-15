import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
     
      notifyListeners();
      uploadPick();
      log('image picked');
    }
  }

  Future<void> uploadPick() async {
    Reference reference = FirebaseStorage.instance.ref().child('test');
    await reference.putFile(image!);
    notifyListeners();
  }

  // Future<void> uploadPick() async {

  //   if(image == null){
  //     return;
  //   }
  //   final fileName = DateTime.now().microsecondsSinceEpoch.toString();

  //     Reference reference = FirebaseStorage.instance.ref();
  //      Reference referenceImagedir = reference.child('test');
  //      Reference referenceImagetoUplad = referenceImagedir.child(fileName);
  //      try{
  //        await referenceImagetoUplad.putFile(image!);
  //       downloadUrl = await referenceImagetoUplad.getDownloadURL();
  //       notifyListeners();
  //      } on FirebaseException catch(e){
  //       log(e.message.toString());
  //      }

  // }

  void getProfileImage() async {
    try {
      isImageLoading = true;
      notifyListeners();
      Reference reference =
          FirebaseStorage.instance.ref().child('test');
      downloadUrl = await reference.getDownloadURL();
      isImageLoading = false;
      notifyListeners();
      log(downloadUrl);
    } catch (e) {
      isImageLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  // Future<void> editBut(String user,)async{
  //    if (image != null) {
  //       isImageLoading = true;
  //       notifyListeners();
  //       await uploadPick();
  //     } else {
  //       log('not called');
  //     }
  // }
}
