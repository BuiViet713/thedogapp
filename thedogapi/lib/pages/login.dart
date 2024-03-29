import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:thedogapi/Cofig/Messages.dart';
import 'package:thedogapi/Cofig/PrimaryButton.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/controller/AuthController.dart';
import 'package:thedogapi/core/navigation/routes.dart';
import 'package:thedogapi/pages/home/presenter/home_screen.dart';
import 'package:thedogapi/pages/signUp.dart';
import 'package:thedogapi/pages/splash/presentater/splash_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Welcome",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF8541DC)),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Dog App",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF8541DC)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 40),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromRGBO(67, 104, 80, 0.1),
            filled: true,
            prefixIcon: Icon(Icons.person, color: Color(0xFF8541DC)),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromRGBO(67, 104, 80, 0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock, color: Color(0xFF8541DC)),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFF8541DC),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _loginWithEmailPassword();
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  void _loginWithEmailPassword() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter both email and password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: "Password should be at least 6 characters long",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    AuthController authController = Get.put(AuthController());
    authController.loginWithEmailPassword(email, password);
  }

  Widget _forgotPassword(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                _showForgotPasswordDialog(context);
              },
              child: Text("Forgot password?", style: TextStyle(fontSize: 14, color: Color(0xFF8541DC))),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryButton(
              btnName: "LOGIN WITH GOOGLE",
              ontap: () {
                authController.loginWithEmail();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    TextEditingController forgetPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Forgot Password",
            style: TextStyle(color: Color(0xFF8541DC)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: forgetPasswordController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
                style: TextStyle(color: Color(0xFF8541DC)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var forgotEmail = forgetPasswordController.text.trim();
                  try {
                    if (forgotEmail.isEmpty) {
                      errorMessage("Please enter your email");
                      return;
                    }
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail);
                    successMessage('Email Sent');
                    Get.offAll(LoginPage());
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                  Navigator.pop(context);
                },
                child: Text("Reset Password"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Don't have an account? ", style: TextStyle(color: Color(0xFF8541DC))),
    TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpForm()),
    );
    },
    child: Text("Sign Up", style:
    TextStyle(color: Color(0xFF8541DC))),
    )
        ],
    );
  }
}
