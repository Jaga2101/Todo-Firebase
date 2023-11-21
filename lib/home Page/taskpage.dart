import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todo/home%20Page/alert.dart';
import 'package:todo/auth%20Page/authan.dart';
import 'package:todo/home%20Page/color.dart';
import 'package:todo/intro%20Page/intropage.dart';
// import 'package:todo/loginscreen.dart';
// import 'package:todo/loginscreen.dart';

// import 'main.dart';

class TaskPage extends StatefulWidget {
  final String uid;

  const TaskPage({super.key, required this.uid});

  @override
  State<TaskPage> createState() => _TaskPageState(uid);
}

class _TaskPageState extends State<TaskPage> {
  // final db =  Firestore.instance;
  final String uid;
  _TaskPageState(this.uid);
  // final db = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var taskcollection = FirebaseFirestore.instance.collection('tasks');
  var listcollection = FirebaseFirestore.instance.collection('lists');
  bool isDone = false;
  late String nam;
  late String dat;
  late bool stus;
  late String list;

  void _showdialogList() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ma_col,
            title: Text('Add Notes'),
            content: Container(
              width: 220,
              height: 200,
              child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't Be Empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          nam = value;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        autofocus: true,
                        maxLength: 250,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Notes',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't Be Empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          dat = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ma_bal,
                            padding: const EdgeInsets.all(16.0),
                          ),
                          onPressed: () {
                            listcollection
                                .doc(uid)
                                .collection('list')
                                .add({'nam': nam, 'dat': dat});

                            Navigator.pop(context);
                          },
                          child: Text(
                            'ADD',
                            style: TextStyle(color: ma_col),
                          )),
                    ],
                  )),
            ),
          );
        });
  }

  // bool isLoading = true;
  late String task;
  void _showdialog() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ma_col,
            title: Text('Add Task'),
            content: Form(
                key: formkey,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Can't Be Empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    task = value;
                  },
                )),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ma_bal,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  onPressed: () {
                    taskcollection
                        .doc(uid)
                        .collection('task')
                        .add({'task': task});

                    Navigator.pop(context);
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(color: ma_col),
                  ))
            ],
          );
        });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: ma_col,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: _showdialog,
                    icon: Icon(Icons.add_task),
                    label: Text('Add Tasks'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _showdialogList,
                    icon: Icon(Icons.list_alt),
                    label: Text(' Add Notes'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    String? email = _auth.currentUser!.email;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // onPressed: _showdialog,

        onPressed: () {
          _showBottomSheet(context);
        },
        backgroundColor: Color.fromRGBO(255, 249, 196, 1),
        child: Icon(
          Icons.add_card,
          size: 30,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'JK-ToDo',
          style: TextStyle(
            fontSize: 23.0,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              showDialog(
                //barrierColor: Colors.black,
                context: context,
                builder: (context) => AlertDialog(
                  shadowColor: ma_col,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  contentPadding: const EdgeInsets.all(16.0),
                  actions: [
                    Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ma_col),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Center(
                                  child: Text(
                                'Welcome\nMy Firends\nThis app Very Useful\nfor you',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('Close'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 15, 50, 15),
                                  textStyle: const TextStyle(fontSize: 15),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                signOutUser().whenComplete(() => Navigator.of(context)
                    .pushReplacement(
                        MaterialPageRoute(builder: (context) => IntroPage())));
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: <Widget>[
        StreamBuilder<QuerySnapshot>(
          // stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          stream: taskcollection.doc(uid).collection('task').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot db = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ma_col),
                        child: ListTile(
                          title: Text(db['task']),
                          leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  isDone = !isDone;
                                });
                              },
                              icon: Icon(
                                isDone
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: Colors.black,
                              )),
                          trailing: IconButton(
                              onPressed: () {
                                GlobalKey<FormState> formkey =
                                    GlobalKey<FormState>();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: ma_col,
                                        title: Text('Edit Todo'),
                                        content: Form(
                                            key: formkey,
                                            child: TextFormField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Task',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Can't Be Empty";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                task = value;
                                              },
                                            )),
                                        actions: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: ma_bal,
                                                padding: EdgeInsets.all(8.0),
                                              ),
                                              onPressed: () {
                                                taskcollection
                                                    .doc(uid)
                                                    .collection('task')
                                                    .doc(db.id)
                                                    .update({'task': task});
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Save',
                                                style: TextStyle(color: ma_col),
                                              ))
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.edit_calendar_outlined,
                                color: Colors.black,
                              )),
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                    tit: 'Are You Sure',
                                    ico: Icons.delete,
                                    col: Colors.red,
                                    des: "Okay",
                                    onPressed: () {
                                      taskcollection
                                          .doc(uid)
                                          .collection('task')
                                          .doc(db.id)
                                          .delete();
                                      Navigator.pop(context);
                                    },
                                  );
                                });

                            //  Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/lot.gif',
                              width: 300,
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                          ],
                        )),
                  ],
                ),
              );
              // return Center(
              //   child: CircularProgressIndicator(
              //     color: Colors.white,
              //   ),
              // );
            }
          },
        ),
        StreamBuilder<QuerySnapshot>(
          // stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          stream: listcollection.doc(uid).collection('list').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return GridView.builder(
                  itemCount: snapshot.data?.size,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 150),
                  itemBuilder: (context, index) {
                    DocumentSnapshot db = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ma_col),
                        child: ListTile(
                          title: Text(
                            db['nam'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(db['dat']),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: ma_col,
                                    title: Text(
                                      db['nam'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Container(
                                      width: 250,
                                      height: 250,
                                      child: SingleChildScrollView(
                                        child: Form(
                                            child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(db['dat']),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: ma_bal,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: ma_col),
                                                  )),
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                  );
                                });
                          },
                          trailing: IconButton(
                              onPressed: () {
                                GlobalKey<FormState> formkey =
                                    GlobalKey<FormState>();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: ma_col,
                                        title: Text('Edit Notes'),
                                        content: Container(
                                          width: 220,
                                          height: 200,
                                          child: Form(
                                              key: formkey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Title',
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Can't Be Empty";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    onChanged: (value) {
                                                      nam = value;
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  TextFormField(
                                                    autofocus: true,
                                                    maxLength: 250,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Notes',
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Can't Be Empty";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    onChanged: (value) {
                                                      dat = value;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor: ma_bal,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                      ),
                                                      onPressed: () {
                                                        listcollection
                                                            .doc(uid)
                                                            .collection('list')
                                                            .doc(db.id)
                                                            .update({
                                                          'nam': nam,
                                                          'dat': dat
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                            color: ma_col),
                                                      )),
                                                ],
                                              )),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.edit_document,
                                color: Colors.black,
                              )),
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                    tit: 'Are You Sure',
                                    ico: Icons.delete,
                                    col: Colors.red,
                                    des: "Okay",
                                    onPressed: () {
                                      listcollection
                                          .doc(uid)
                                          .collection('list')
                                          .doc(db.id)
                                          .delete();
                                      Navigator.pop(context);
                                    },
                                  );
                                });

                            //  Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/lot.gif',
                              width: 300,
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                          ],
                        )),
                  ],
                ),
              );
              // return Center(
              //   child: CircularProgressIndicator(
              //     color: Colors.white,
              //   ),
              // );
            }
          },
        ),
        Center(
          child: Container(
            width: 250,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ma_col,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.verified_user_sharp,
                    size: 80,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$email',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                  onPressed: () {
                    signOutUser().whenComplete(() => Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => IntroPage())));
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('LogOut'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ][currentPageIndex],
      // bottomNavigationBar: CurvedNavigationBar(
      //   // key: _bottomNavigationKey,
      //   index: 0,
      //   height: 60.0,
      //   items: const <Widget>[
      //     Icon(Icons.home, size: 30),
      //     Icon(Icons.people, size: 30),
      //     // Icon(Icons.list, size: 30),
      //     // Icon(Icons.call_split, size: 30),
      //   ],
      //   color: const Color.fromRGBO(255, 249, 196, 1),
      //   buttonBackgroundColor: const Color.fromRGBO(255, 249, 196, 1),
      //   backgroundColor: Colors.black,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: const Duration(milliseconds: 600),
      //   onTap: (index) {
      //     if (index.isOdd) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const Person(),
      //         ),
      //       );
      //     }
      //     if (index.isEven) {
      //       // Navigator.pop(context);
      //     }
      //   },
      //   letIndexChange: (index) => true,
      // ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: ma_col,
        backgroundColor: Colors.black,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: ma_bal,
            ),
            icon: Icon(
              Icons.home,
              color: ma_col,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.import_contacts_rounded),
            icon: Icon(
              Icons.import_contacts,
              color: ma_col,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(
              Icons.people,
              color: ma_col,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
