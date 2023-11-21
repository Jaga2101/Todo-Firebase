import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/alert.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/authan.dart';
import 'package:todo/color.dart';
import 'package:todo/forget.dart';
import 'package:todo/regscreen.dart';
import 'package:todo/taskpage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                    ),
                    color: ma_col),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/JK1r.png',
                              width: 80,
                              height: 80,
                            ),
                            Text(
                              '𝕃𝕠𝕘𝕚𝕟 ℙ𝕒𝕘𝕖',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: ma_bal,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autocorrect: true,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(20))),
                        labelText: 'Email ID',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please Enter Email ID";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passController,
                      obscureText: _obscureText,
                      maxLength: 8,
                      // obscureText: true,
                      // keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(20))),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please Enter Password ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => ForgetPas()),
                          );
                        },
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user =
                              await signInWithEmailPassword(email, password);
                          if (user != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlert(
                                  tit: 'Login Success',
                                  ico: Icons.verified,
                                  col: Colors.green,
                                  des: 'Okay',
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TaskPage(uid: user.uid)),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            // Handle the case where sign-in with Google failed
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                    tit: 'Login Falied',
                                    ico: Icons.error,
                                    col: Colors.red,
                                    des: "Retry",
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                });

                            print("Sign-in failed.");
                          }
                        }
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              ma_bal,
                              ma_bal,
                              ma_bal,
                              ma_bal,
                              ma_bal,
                              // ma_col
                            ])),
                        child: const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Don't have account ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ma_bal,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           height: 55,
                  //           width: 300,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(30),
                  //               gradient: LinearGradient(colors: [
                  //                 ma_bal,
                  //                 ma_bal,
                  //                 ma_bal,
                  //                 ma_bal,
                  //                 ma_bal,
                  //                 // ma_col
                  //               ])),
                  //           child: TextButton.icon(
                  //               onPressed: () async {
                  //                 User? user = await signInWithGoogle();

                  //                 if (user != null) {
                  //                   Navigator.of(context).pushReplacement(
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             TaskPage(uid: user.uid)),
                  //                   );
                  //                 } else {
                  //                   // Handle the case where sign-in with Google failed
                  //                   print("Sign-in with Google failed.");
                  //                 }
                  //               },
                  //               icon: Icon(Icons.g_mobiledata),
                  //               label: Text('Sign in with Google')),
                  //         ),
                  //         SizedBox(
                  //           height: 30,
                  //         )
                  //       ]),
                  // ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(80),
                    ),
                    color: ma_col),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
