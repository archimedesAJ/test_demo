import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_demo/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:test_demo/loader.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Eastern"), value: "Eastern"),
    DropdownMenuItem(child: Text("Central"), value: "Central"),
    DropdownMenuItem(child: Text("Greater Accra"), value: "Greater Accra"),
    DropdownMenuItem(child: Text("Northern"), value: "Northern"),
    DropdownMenuItem(child: Text("Oti"), value: "Oti"),
    DropdownMenuItem(child: Text("Volta"), value: "Volta"),
    DropdownMenuItem(child: Text("Bono East"), value: "Bono East"),
    DropdownMenuItem(child: Text("Brong Ahafo"), value: "Brong Ahafo"),
    DropdownMenuItem(child: Text("Savannah"), value: "Savannah"),
    DropdownMenuItem(child: Text("Upper East"), value: "Upper East"),
    DropdownMenuItem(child: Text("Western"), value: "Western"),
    DropdownMenuItem(child: Text("Western North"), value: "Western North"),
    DropdownMenuItem(child: Text("Western"), value: "Western"),
    DropdownMenuItem(child: Text("Ahafo"), value: "Ahafo"),
    DropdownMenuItem(child: Text("North East"), value: "North East"),
  ];
  return menuItems;
}

class SignUpState extends State<SignUp> {
  late String _name;
  late String _email;
  late String _phoneNumber;
  late String _region;
  String selectedValue = "Greater Accra";
  late String _city;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loader = false;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Full Name*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      //maxLength: 20,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Name is Required';
        }
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
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

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Phone Number is Required';
        }
      },
      onSaved: (String? value) {
        _phoneNumber = value!;
      },
    );
  }

  Widget _buildRegion() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Region',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelStyle: TextStyle(
            fontSize: 16,
          )),
      //value: selectedValue,
      style: TextStyle(color: Colors.blue, fontSize: 13),
      onChanged: (String? value) {
        setState(() {
          selectedValue = value!;
          _region = value;
        });
      },
      items: dropdownItems,
    );
  }

  Widget _buildCity() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: 'City*'),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'City is Required';
        }
      },
      onSaved: (String? value) {
        _city = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Nominators =
        FirebaseFirestore.instance.collection("Nominators");
    return loader
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xFF0D47A1),
              title: Center(
                child: Text('Register Form'),
              ),
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Welcome OnBoard!",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Kindly provide your details. All fields are required.",
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
                            _buildName(),
                            SizedBox(
                              height: 13.h,
                            ),
                            _buildEmail(),
                            SizedBox(
                              height: 13.h,
                            ),
                            _buildPhoneNumber(),
                            SizedBox(
                              height: 13.h,
                            ),
                            _buildRegion(),
                            SizedBox(
                              height: 13.h,
                            ),
                            _buildCity(),
                            SizedBox(
                              height: 13.h,
                            ),
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();
                                    setState(() => loader = true);
                                    await Nominators.add({
                                      "fullname": _name,
                                      "email": _email,
                                      "phone_number": _phoneNumber,
                                      "region": _region,
                                      "city": _city
                                    }).then((value) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (c) => SignIn()));
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        text: 'Registered successfully!',
                                        autoCloseDuration: Duration(seconds: 3),
                                      );
                                    }).catchError((error) {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: 'Registered unsuccessful!',
                                        autoCloseDuration: Duration(seconds: 3),
                                      );
                                      setState(() => loader = false);
                                    });
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
                            SizedBox(
                              height: 13.h,
                            ),
                            Wrap(
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn())),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF0D47A1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
