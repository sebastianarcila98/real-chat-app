import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_chat_app/widgets/img/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function submitForm;
  final bool isLoading;

  const AuthForm(this.submitForm, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail;
  String _userName;
  String _userPassword;
  File _userImg;

  void _setImg(File img) {
    _userImg = img;
  }

  void _submitForm() {
    if (!_form.currentState.validate()) return;
    FocusScope.of(context).unfocus();
    _form.currentState.save();
    if (!_isLogin && _userImg == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    widget.submitForm(_userEmail.trim(), _userName, _userPassword, _isLogin,
        _userImg, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_setImg),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Adress'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _userEmail = newValue,
                ),
                if (!_isLogin)
                  TextFormField(
                    key: UniqueKey(),
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username must be longer than 4 characters';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _userName = newValue,
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be 8 characters atleast';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _userPassword = newValue,
                ),
                SizedBox(height: 10),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _submitForm,
                    child: Text(_isLogin ? 'Login' : 'Create Account'),
                  ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create an account'
                      : 'Already have an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
