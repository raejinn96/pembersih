import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'clock_widget.dart';
import 'raindrop.dart';
import 'sunny.dart'; // Import the SunnyAnimation widget
import 'package:cloud_firestore/cloud_firestore.dart';

// widget untuk appbar:
import 'appbar_widget.dart';
// widget exit:
import 'exit_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isRaining = false;
  bool isCleaning = false; // Set this value based on the raining condition

  void _exitApp() {
    // Close the app
    SystemNavigator.pop();
  }

  Future<void> _showExitDialog(BuildContext context) async {
    await showExitDialog(context, _exitApp);
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pembersihan?"),
          actions: <Widget>[
            TextButton(
              child: Text("Ya"),
              onPressed: () async {
                // Update Firestore with the value true
                await FirebaseFirestore
                    .instance // Use the actual instance of FirebaseFirestore
                    .collection('weather')
                    .doc('current_condition')
                    .update({'cleaning': true});

                Navigator.of(context).pop(); // Close the dialog

                // Start a timer to switch the value back to false after 10 seconds
                Timer(Duration(seconds: 10), () async {
                  await FirebaseFirestore.instance
                      .collection('weather')
                      .doc('current_condition')
                      .update({'cleaning': false});
                });
              },
            ),
            TextButton(
              child: Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleCleaningValue() async {
    // Switch the value only when the toggle button is clicked
    setState(() {
      isCleaning = !isCleaning;
    });

    if (isCleaning) {
      // Update Firestore with the new value when toggled to true
      await FirebaseFirestore.instance
          .collection('weather')
          .doc('current_condition')
          .update({'cleaning': true});
    }
  }

  @override
  void initState() {
    super.initState();
    _subscribeToRainStatus();
  }

  void _subscribeToRainStatus() {
    FirebaseFirestore.instance // Use the actual instance of FirebaseFirestore
        .collection('weather')
        .doc('current_condition')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        isRaining = snapshot.data()?['itsraining'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          onLogoutPressed: () => _showExitDialog(context),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color.fromARGB(255, 152, 135, 248),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        Text(
                          "Halo, Adek!",
                          style: TextStyle(
                            fontSize: 28,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color =
                                  const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const Text(
                          "Halo, Adek!",
                          style: TextStyle(
                              fontSize: 28,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            onPressed: _showConfirmationDialog,
                            child: Text("Bersih"),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          SizedBox(height: 10),
                          FloatingActionButton(
                            onPressed: _toggleCleaningValue,
                            child: Text("Toggle"),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10), // Adjust the spacing
                              Text(
                                "Hari ini",
                                style: TextStyle(
                                  height: 1.1,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  if (isRaining)
                                    RaindropAnimation()
                                  else
                                    SunnyAnimation(), // Display SunnyAnimation when not raining
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 152, 135, 248),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ClockWidget(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
