import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService{
  final String ?uid;
  DatabaseService({this.uid});

  final CollectionReference usercollection=FirebaseFirestore.instance.collection("users");

  Future savingUserData(String firstName,String lastName,String email,String password)async{
    return await usercollection.doc(uid).set({
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "password":password,
      "uid":uid,
    });
  }
}

class AuthService{
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  

   Future <dynamic> registerUserWithEmailandPassword(String firstName, String lastName, String email,String password)async{
      User user= (await firebaseAuth.createUserWithEmailAndPassword(email:email,password:password)).user!;
      
      await DatabaseService(uid:user.uid).savingUserData(firstName,lastName,email,password);
      return true;
  }
}

class functions{
  static String userNameKey ="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";

  static Future<bool> saveUserNameSF(String firstName)async{
    SharedPreferences sf= await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, firstName);
  }

  static Future<bool> saveUserEmailSF(String email)async{
    SharedPreferences sf= await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, email);
  }
}