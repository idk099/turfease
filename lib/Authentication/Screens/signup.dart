import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Turfease/Authentication/Services/authenticationservice.dart';



class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final Authenticate _auth = Authenticate();
final TextEditingController _emailcontroller = TextEditingController();
final TextEditingController _passwordcontroller = TextEditingController();

String? val;

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool _isObscured2 = true;
  bool _loading = false;
  Image? background;


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      body: 
      
          SafeArea(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/turf.png',
                  width: 200,
                  height: 100,
            
                ),
             
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                           
                            const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                            const SizedBox(height: 30),
                           
                          
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                  controller: _emailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    final emailRegx = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegx.hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    fillColor:Colors.white ,
                                    filled:true  ,
                                      suffixIcon: Icon(Icons.email ,color:Colors.black),
                                      hintText: 'Email',
                                                                                   errorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),

                                          focusedErrorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                  controller: _passwordcontroller,
                                  validator: (value) {
                                    val = value;
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
                                     fillColor:Colors.white ,
                                    filled:true ,
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isObscured = !_isObscured;
                                            });
                                          },
                                          icon: Icon(_isObscured
                                              ? Icons.visibility
                                              : Icons.visibility_off),color:  Colors.black),
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
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                  validator: (value) {
                                    if (val!.isNotEmpty && value!.isEmpty) {
                                      return 'Please confirm password';
                                    }
                                    if (val != value) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  obscureText: _isObscured2,
                                  decoration: InputDecoration(
                                    fillColor:Colors.white ,
                                    filled:true ,
                                      hintText: 'Confirm Password',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isObscured2 = !_isObscured2;
                                            });
                                          },
                                          icon: Icon(_isObscured2
                                              ? Icons.visibility
                                              : Icons.visibility_off),color: Colors.black,),
                                              errorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),

                                          focusedErrorBorder: OutlineInputBorder(borderSide:
                                          BorderSide(color: Colors.white)),
                               
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),)),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 250,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 235, 16, 1),
                                ),
                                onPressed: _submit,
                                child: _loading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        "SUBMIT",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ),
                          ],
                        )),
                  
                
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
        await _auth.signupwithEmail(
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
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email already in use !'),
      ),
    );
          
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid email!'),
      ),
    );
        }  else {
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
