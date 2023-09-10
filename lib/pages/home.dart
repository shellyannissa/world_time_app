import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? data = {};

  @override
  Widget build(BuildContext context) {
    data = data!.isEmpty
        ? ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?
        : data;

    Color? bgColor = data!['isDaytime']
        ? const Color.fromARGB(255, 30, 98, 154)
        : const Color.fromARGB(255, 31, 32, 36);

    String bgImage = data!['isDaytime'] ? 'day1.webp' : 'night3.webp';
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          height: double.maxFinite,
          child: Column(
            children: [
              const SizedBox(height: 150.0),
              FloatingActionButton(
                tooltip: 'Edit location',
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                      'flag': result['flag']
                    };
                  });
                },
                child: const Icon(Icons.edit_location),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data!['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: !data!['isDaytime']
                              ? Colors.white
                              : Colors.black))
                ],
              ),
              const SizedBox(height: 20.0),
              Text(data!['time'],
                  style: TextStyle(
                      fontSize: 66.0,
                      color: !data!['isDaytime'] ? Colors.white : Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
