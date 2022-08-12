import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:test_demo/schoolselection.dart';

class OTPControllerScreen extends StatefulWidget {
  final String phone;

  OTPControllerScreen({required this.phone});

  @override
  State<StatefulWidget> createState() {
    return _OTPControllerScreenState();
  }
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? varificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey));

  @override
  void initState() {
    super.initState();

    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => SchoolSelection()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message.toString()),
          duration: Duration(seconds: 3),
        ));
      },
      codeSent: (String vID, int? resendToken) {
        setState(() {
          varificationCode = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          varificationCode = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Center(
          child: Text('OTP Verification'),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 80.h,
            ),
            Text(
              "OTP Verification!",
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
                color: Colors.blue,
                illustration: UnDrawIllustration.mobile_login,
                placeholder: Text("Illustration is loading..."),
                errorWidget:
                    Icon(Icons.error_outline, color: Colors.blue, size: 50),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Kindly enter the code sent to the phone Number ${widget.phone}",
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
                  // ignore: prefer_const_constructors
                  PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.white),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinOTPCodeFocus,
                    controller: _pinOTPCodeController,
                    submittedFieldDecoration: pinOTPCodeDecoration,
                    selectedFieldDecoration: pinOTPCodeDecoration,
                    followingFieldDecoration: pinOTPCodeDecoration,
                    pinAnimationType: PinAnimationType.rotation,
                    onSubmit: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: varificationCode!,
                                smsCode: pin))
                            .then((value) {
                          if (value.user != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => SchoolSelection()));
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid OTP'),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          verifyPhoneNumber();
                        },
                        child: Text(
                          " Resend",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
