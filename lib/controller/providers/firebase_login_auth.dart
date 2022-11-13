
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticateProvider extends ChangeNotifier{

  FirebaseAuth auth;
  AuthenticateProvider(this.auth);
  bool isLoading = false;
  Stream<User?> user() {
    
    return auth.authStateChanges();
    
  }

  bool get loading => isLoading;

    Future<void>signOut()async{
      await auth.signOut();
    }

    Future<String>signIn(String email , String password) async{
    try{
   /// checking the loading ///////   
      isLoading = true;
      notifyListeners();
  ////////////////////////////////

     await  auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
     isLoading = false;
      notifyListeners();
     return Future.value('');
     
    }
    on FirebaseAuthException catch(e){
       isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

      Future<String>signUp(String email , String password) async{
    try{
   /// checking the loading ///////   
      isLoading = true;
      notifyListeners();
  ////////////////////////////////

     await  auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
     isLoading = false;
      notifyListeners();
     return Future.value('');
     
    }
    on FirebaseAuthException catch(e){
       isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }
}