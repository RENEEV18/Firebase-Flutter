import 'package:firebase_project/controller/services/services.dart';
import 'package:firebase_project/model/api/api_service.dart';
import 'package:flutter/cupertino.dart';

class ApiProvider extends ChangeNotifier {

   List<Welcome> userList = [];
  void listofUsers() async {
    final Stream<Welcome> stream = await ApiServices.getUserList();
    stream.listen((Welcome user) {
      userList.add(user);
      notifyListeners();
    });
  }
}
