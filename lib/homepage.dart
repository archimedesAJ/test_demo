import 'package:flutter/material.dart';
import 'package:test_demo/donor_signup.dart';
import 'package:test_demo/sign_up.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:test_demo/vt_signin.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D47A1),
          title: Center(
            child: Text("Home"),
          ),
          leading: Icon(Icons.home),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print("Page  is refreshed!");
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 80, 20, 2),
                child: Center(
                  child: UnDraw(
                    height: 120,
                    width: 120,
                    color: Colors.blue,
                    illustration: UnDrawIllustration.welcome_cats,
                    placeholder: Text("Illustration is loading..."),
                    errorWidget:
                        Icon(Icons.error_outline, color: Colors.blue, size: 50),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Text(
                    'MLH Cherishes your effort to making learning happen. Kindly select your identity below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.00,
                      height: 1.4,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 20, 20),
                child: Text(
                  'Are you a?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.00,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 20, 15),
                child: SizedBox(
                  height: 50,
                  width: 220,
                  child: ElevatedButton(
                    child: const Text(
                      'Nominator',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new SignUp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 20, 15),
                child: SizedBox(
                  height: 50,
                  width: 220,
                  child: ElevatedButton(
                    child: const Text(
                      'Donor',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new DonorSignUp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 20, 15),
                child: SizedBox(
                  height: 50,
                  width: 220,
                  child: ElevatedButton(
                    child: const Text('VT Member'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new VTSignIn()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
