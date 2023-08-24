import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ntp/ntp.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Future<DateTime> _ntpTime;
  late Timer _timer;
  late Connectivity _connectivity;
  bool _isConnected = true; // Initialize with true to assume connected

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();

    _ntpTime = NTP.now();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _ntpTime = NTP.now(); // Update _ntpTime with the current NTP time
      });
    });

    _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = (result != ConnectivityResult.none);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return const Center(
        child: Text(
          'Tidak Ada Jaringan Internet',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return FutureBuilder<DateTime>(
      future: _ntpTime,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final currentTime = snapshot.data!;
          final formattedDay = DateFormat('EEEE')
              .format(currentTime.toLocal()); // Day of the week
          final formattedDate = DateFormat('dd/MM/yyyy')
              .format(currentTime.toLocal()); // Date format
          final formattedTime =
              DateFormat('HH:mm').format(currentTime.toLocal()); // Time format

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   '$formattedDay, $formattedDate', // Displayed day and date
              //   style: const TextStyle(
              //       fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
              // ),
              const SizedBox(height: 5),
              Text(
                '$formattedTime WIB',
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          );
        } else {
          return const Text('No data available.');
        }
      },
    );
  }
}
