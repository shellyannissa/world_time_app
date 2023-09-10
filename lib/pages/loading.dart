import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/pages/home.dart';
import 'package:world_time_app/services/world_time.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String time = 'loading';
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Berlin', flag: 'germany.webp', url: 'Europe/London');
    await instance.getTime();

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const Home(), // Replace with your home screen widget
        settings: RouteSettings(
          arguments: {
            'location': instance.location,
            'flag': instance.flag,
            'time': instance.time,
            'isDaytime': instance.isDaytime
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 150.0,
          ),
        ));
  }
}
