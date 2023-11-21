import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:introduction_screen/introduction_screen.dart';
// import 'package:todo/color.dart';
import 'package:todo/auth%20Page/loginscreen.dart';
import 'package:todo/auth%20Page/regscreen.dart';

class IntroPage extends StatelessWidget {
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  IntroPage({super.key});
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkInternetConnection(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError || !snapshot.data!) {
            // No internet connection, show alert
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("No Internet Connection"),
                    icon: const Icon(
                      Icons.network_check,
                      size: 50,
                      color: Colors.red,
                    ),
                    content: const Text(
                      "Please check your internet connection",
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Okay"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // You can exit the app or perform any other action here
                        },
                      ),
                    ],
                  );
                },
              );
            });
          }
          const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.white);

          const pageDecoration = PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 216, 203, 79)),
            bodyTextStyle: bodyStyle,
            bodyPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            pageColor: Colors.black,
            imagePadding: EdgeInsets.only(top: 50),
          );

          return IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.black,
            allowImplicitScrolling: true,
            autoScrollDuration: 3000,
            infiniteAutoScroll: true,
            globalHeader: Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16),
                  child: Image.asset(
                    'assets/JKr.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),

            pages: [
              PageViewModel(
                title: "Welcome To My App",
                body: "Organize your tasks and boost your productivity",
                image: Image.asset(
                  'assets/JKr.png',
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Create Tasks",
                body:
                    "Easily create and manage your tasks with just a few taps",
                image: Image.asset(
                  'assets/ta.png',
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Create Notes",
                body:
                    "Easily create and manage your Notes with just a few taps",
                image: Image.asset(
                  'assets/na.png',
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Delete Notes & Tasks",
                body: "LongPress The Tasks or Notes",
                image: Image.asset(
                  'assets/da.png',
                ),
                decoration: pageDecoration,
              ),
            ],
            onDone: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegScreen(),
                ),
              );
            },
            onSkip: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }, // You can override onSkip callback
            showSkipButton: true,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showBackButton: false,
            //rtl: true, // Display as right-to-left
            back: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 216, 203, 79),
            ),
            skip: const Text('Skip',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 216, 203, 79))),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 216, 203, 79))),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color.fromARGB(255, 216, 203, 79),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            dotsContainerDecorator: const ShapeDecoration(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          );
        }
      },
    );
  }
}



//  Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const LoginScreen(),
//                               ),
//                             );