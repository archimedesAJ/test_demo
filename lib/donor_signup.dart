import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_demo/donor_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:test_demo/paystack_payment_page.dart';
import 'package:test_demo/schoolselection.dart';

class DonorSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DonorSignUpState();
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

enum Decision { no, yes }

class DonorSignUpState extends State<DonorSignUp> {
  late String _name;
  late String _email;
  late String _phoneNumber;
  late String _hometown;
  late String _homeregion;
  late String _currentLocation;
  late String _region;
  late String _school_name;
  late String _amount;

// Default Radio Button Selected Item When App Starts
  //String radioButtonItem = "No";

// Group Value for Radio Button
  Decision? _dec;

  String selectedValue = "Greater Accra";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String amount;

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

  Widget _buildHomeTown() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Hometown*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Hometown Number is Required';
        }
      },
      onSaved: (String? value) {
        _hometown = value!;
      },
    );
  }

  Widget _buildRegion() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Current Region',
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
          _homeregion = value;
        });
      },
      items: dropdownItems,
    );
  }

  Widget _buildCurrentLocation() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: 'CurrentLocation*'),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Location is Required';
        }
      },
      onSaved: (String? value) {
        _currentLocation = value!;
      },
    );
  }

  Widget _buildHomeRegion() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Home Region',
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

  Widget _buildAmount() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: 'Amount to Pay (GHS,USD)'),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Amount is Required';
        }
      },
      onSaved: (String? value) {
        _amount = value!;
      },
    );
  }

  bool _homeFieldVisible = false;

  void handleSelection(value) {
    setState(() {
      _dec = value;

      _homeFieldVisible = value == Decision.yes;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Donors =
        FirebaseFirestore.instance.collection("Donors");
    return Scaffold(
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
                  "Welcome, Donor!",
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
                      _buildHomeTown(),
                      SizedBox(
                        height: 13.h,
                      ),
                      _buildHomeRegion(),
                      SizedBox(
                        height: 13.h,
                      ),
                      _buildCurrentLocation(),
                      SizedBox(
                        height: 13.h,
                      ),
                      _buildRegion(),
                      SizedBox(
                        height: 13.h,
                      ),
                      Text(
                        'Would you want to donate to a specific school?',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.normal),
                      ),
                      RadioListTile(
                          title: Text(
                            'No',
                            style: new TextStyle(fontSize: 13.sp),
                          ),
                          value: Decision.no,
                          groupValue: _dec,
                          onChanged: handleSelection),
                      RadioListTile(
                        title: Text(
                          'Yes',
                          style: new TextStyle(fontSize: 13.sp),
                        ),
                        value: Decision.yes,
                        groupValue: _dec,
                        onChanged: handleSelection,
                      ),
                      if (_homeFieldVisible)
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'School Name*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          //maxLength: 20,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'School Name is Required';
                            }
                          },
                          onSaved: (String? value) {
                            _school_name = value!;
                          },
                        ),
                      SizedBox(
                        height: 13.h,
                      ),
                      _buildAmount(),
                      SizedBox(
                        height: 13.h,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          child: const Text(
                            'Register and Pay',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              await Donors.add({
                                "full_name": _name,
                                "email": _email,
                                "phone_number": _phoneNumber,
                                "hometown": _hometown,
                                "home_region": _homeregion,
                                "current_location": _currentLocation,
                                "current_region": _region,
                                "amount": _amount,
                                "schoolname": _school_name
                              }).then((value) {
                                setState(() {
                                  email = _email;
                                  amount = _amount;
                                });
                                /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (c) => MakePayment(
                                        ctx: context,
                                        price: _amount,
                                        email: _email)))*/
                                MakePayment(
                                        ctx: context,
                                        price: int.parse(amount),
                                        email: email)
                                    .chargeCardAndMakePayment();
                                /*CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: 'Registered successfully!',
                                  autoCloseDuration: Duration(seconds: 3),
                                );*/
                              }).catchError((error) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: 'Registered unsuccessful!',
                                  autoCloseDuration: Duration(seconds: 3),
                                );
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
                        height: 11.h,
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
                                    builder: (context) => DonorSignIn())),
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
