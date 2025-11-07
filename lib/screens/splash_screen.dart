import 'dart:async';
import 'package:flutter/material.dart';
import 'package:natural_africa/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}): super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(milliseconds: 900), (){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Natural Africa', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white)),
          const SizedBox(height:12),
          Text('Discover Africa\'s natural wealth', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70)),
        ]),
      ),
    );
  }
}
