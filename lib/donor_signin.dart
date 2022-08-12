import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:test_demo/OTPControllerScreen.dart';

class DonorSignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DonorSignInState();
  }
}

class DonorSignInState extends State<DonorSignIn> {
  late String _phoneNumber;
  TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      maxLength: 15,
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Phone Number00 is Required';
        }
      },
      onSaved: (String? value) {
        _phoneNumber = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 80.h,
            ),
            Text(
              "Welcome Back!",
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
                illustration: UnDrawIllustration.online_ad,
                placeholder: Text("Illustration is loading..."),
                errorWidget:
                    Icon(Icons.error_outline, color: Colors.blue, size: 50),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Kindly enter your phone number to generate the OTP code.",
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
                  _buildPhoneNumber(),
                  SizedBox(
                    height: 13.h,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      child: const Text(
                        'Generate Code',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) =>
                                  OTPControllerScreen(phone: _phoneNumber)));
                        }
                        return;
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        primary: Color(0xFF0D47A1),
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
}
