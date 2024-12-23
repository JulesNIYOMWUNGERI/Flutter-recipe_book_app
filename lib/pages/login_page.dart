import 'package:flutter/material.dart';
import 'package:recepies_app/services/auth_service.dart';
import 'package:recepies_app/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width, // 100% of the screen
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text("Recip Book",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w300,
        ));
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90, // 90% of the screen
      height: MediaQuery.sizeOf(context).height * 0.30, // 30% of the screen
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'emilys',
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a username";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
              obscureText: true,
              initialValue: 'emilyspass',
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Please enter a valid password";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.60, // 60% of the screen
        child: ElevatedButton(
          onPressed: () async {
            if (_loginFormKey.currentState?.validate() ?? false) {
              _loginFormKey.currentState?.save();

              bool result = await AuthService().login(username!, password!);

              if (result) {
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                showCustomSnackBar(context, "Invalid username or password",
                    isSuccess: false);
              }
            }
          },
          child: const Text("Login"),
        ));
  }
}
