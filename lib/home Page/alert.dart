import 'package:flutter/material.dart';
import 'package:todo/home%20Page/color.dart';

class CustomAlert extends StatelessWidget {
  final String tit;
  final IconData ico;
  final Color col;
  final String des;
  final void Function()? onPressed;
  const CustomAlert(
      {super.key,
      required this.tit,
      required this.ico,
      required this.col,
      this.onPressed,
      required this.des});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ma_col,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: <Widget>[
        Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Icon(
                  ico,
                  color: col,
                  size: 80,
                ),
              ),
              Text(
                tit,
                // 'Login Successfull',
                style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold, color: ma_bal),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  child: Text(des),
                  onPressed: onPressed,
                ),
              ])),
            ])),
      ],
    );
  }
}

// showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return 
              
//           },
//         );