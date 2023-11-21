import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/alert.dart';
import 'package:todo/color.dart';

class ForgetPas extends StatefulWidget {
  const ForgetPas({super.key});

  @override
  State<ForgetPas> createState() => _ForgetPasState();
}

class _ForgetPasState extends State<ForgetPas> {
  late String email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 120,
              height: 140,
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
                  Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _emailController,
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
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlert(
                              tit: 'Check Your Mail',
                              ico: Icons.send_to_mobile_sharp,
                              col: Colors.blue,
                              des: 'Okay',
                              onPressed: () async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email);
                              },
                            );
                          },
                        ); // Handle the case where sign-in with Google failed
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
                          'Send Code',
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(80),
                  ),
                  color: ma_col),
            ),
          ],
        ),
      ],
    ));
  }
}
