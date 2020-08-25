import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    File userImage,
    bool isLogin,
    BuildContext ctx,
  ) async {
    dynamic authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        print(email);
        print(userName);
        print(userImage.path);
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String fileName = basename(userImage.path);
        StorageReference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(userImage);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        taskSnapshot.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );

        // final FirebaseStorage storage = FirebaseStorage(
        //   app: FirebaseStorage.instance.app,
        //   storageBucket: 'gs://chatapp-1b780.appspot.com',
        // );

        // final StorageReference ref2 = storage
        //     .ref()
        //     .child('userimage')
        //     .child(_auth.currentUser.uid + '.jpg');
        // final StorageUploadTask uploadTask = ref2.putFile(userImage);
        // uploadTask.onComplete
        //     .then((value) => print(value))
        //     .catchError((error) => print(error));
        // print(uploadTask.lastSnapshot.error.toString());

        // ///...
        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('user_image')
        //     .child(authResult.user.id + '.jpg');
        // await ref.putFile(userImage).onComplete;

        ///
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': userName,
          'email': email,
        });
      }
    } on PlatformException catch (error) {
      var message = 'An error occured,Please check your credentials';
      if (error.message != null) {
        setState(() {
          _isLoading = false;
        });
        message = error.message;
      }
      print(message);
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
