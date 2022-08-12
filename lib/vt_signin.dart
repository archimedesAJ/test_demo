import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:test_demo/OTPControllerScreen.dart';
import 'package:test_demo/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_demo/schoolselection.dart';

class VTSignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VTSignInState();
  }
}

class VTSignInState extends State<VTSignIn> {
  late String _email;
  late String _password;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loader = false;

  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Email is Required';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
          return 'Enter valid email!';
        }
        return null;
      },
      onSaved: (String? value) {
        _email = value!;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordStatus,
          color: Color(0xFFFF9800),
        ),
      ),
      obscureText: _obscureText,
      onChanged: (val) {
        setState(() {
          _password = val.trim();
        });
      },
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Password Number is Required';
        }
      },
      onSaved: (String? value) {
        _password = value!;
      },
    );
  }

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return loader
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xFFFF9800),
              title: Center(
                child: Text('Login'),
              ),
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      Text(
                        "Welcome, VT Member!",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: UnDraw(
                          height: 120,
                          width: 120,
                          color: Color(0xF9A826),
                          illustration: UnDrawIllustration.access_account,
                          placeholder: Text("Illustration is loading..."),
                          errorWidget: Icon(Icons.error_outline,
                              color: Colors.blue, size: 50),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Kindly enter your username and password below.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildEmail(),
                            SizedBox(
                              height: 13.h,
                            ),
                            _buildPassword(),
                            SizedBox(
                              height: 13.h,
                            ),
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();
                                    setState(() => loader = true);

                                    signIn(_emailcontroller.text,
                                        _emailcontroller.text);
                                  }
                                  setState(() => loader = false);
                                  return;
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  primary: Color(0xFFFF9800),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          );
  }

  void signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((uid) => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SchoolSelection())),
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: 'Login successfully!',
                  autoCloseDuration: Duration(seconds: 2),
                ),
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: errorMessage,
        autoCloseDuration: Duration(seconds: 2),
      );
      setState(() => loader = false);
    }
  }
}
