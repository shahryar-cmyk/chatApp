import 'package:flutter/material.dart';
import 'dart:io';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email, String password, String userName,
      File userImage, bool isLogin, BuildContext ctx) submitFn;
  AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trysubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick an Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userPassword);
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _userImageFile, _isLogin, context);
      print(_userEmail);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_isLogin)
                      UserImagePicker(
                        imagePickFn: _pickedImage,
                      ),
                    TextFormField(
                      key: ValueKey('emailAdress'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please return a valid email address';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('userName'),
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please Enter at least 4 characters';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userName = newValue;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Please Enter at least 7 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        onPressed: _trysubmit,
                        child: Text((_isLogin) ? 'Login' : 'SignUp'),
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
