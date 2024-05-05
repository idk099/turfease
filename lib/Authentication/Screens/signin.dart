import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Turfease/Authentication/Screens/forgotpassword.dart';
import 'package:Turfease/Authentication/Screens/signup.dart';
import 'package:Turfease/Authentication/Services/authenticationservice.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool _loading = false;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final Authenticate _auth = Authenticate();
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsivePadding1 = screenWidth * 0.1;

    return Scaffold(
      backgroundColor:Colors.blue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/turf.png',
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: responsivePadding1),
              child: Column(
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20),
                            child: TextFormField(
                                controller: _emailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  final emailRegx =
                                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegx.hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:Colors.white ,
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Email',
                                  focusedErrorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                                  
                                  errorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20),
                            child: TextFormField(
                                controller: _passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.length < 4) {
                                    return 'Password must contain more than 4 characters';
                                  }
                                  return null;
                                },
                                obscureText: _isObscured,
                                decoration: InputDecoration(
                                  filled:true ,
                                  fillColor: Colors.white,
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObscured = !_isObscured;
                                        });
                                      },
                                      icon: Icon(
                                        _isObscured
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      )),
                                  errorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),

                                          focusedErrorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                )),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Forgot(),
                                      ));
                                },
                                child: const Text(
                                  "forgot password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.red),
                                elevation: MaterialStateProperty.all<double>(
                                    8.0), // Adjust the elevation as needed
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                              ),
                              onPressed: _submit,
                              child: _loading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : Text(
                                      "SUBMIT",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
        
        const SizedBox(height: 30),
                          Text(
                                      "New User?",
                                      style: TextStyle(color: Colors.white,fontSize: 20),
                                    ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              elevation: MaterialStateProperty.all<double>(
                                  8.0), // Adjust the elevation as needed
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ));
                            },
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        await _auth.signinwithEmail(
          context: context,
          email: _emailcontroller.text.toLowerCase(),
          password: _passwordcontroller.text,
        );
        _emailcontroller.clear();
        _passwordcontroller.clear();
      } on FirebaseAuthException catch (e) {
        setState(() {
          _loading = false;
        });
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User not found!'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wrong password'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong!'),
            ),
          );
        }
      }
    }
  }
}
