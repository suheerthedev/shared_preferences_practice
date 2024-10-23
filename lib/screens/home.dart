import 'package:flutter/material.dart';
import 'package:shared_preferences_practice/base_class.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  LocalStorage.initialize().then((_){
    setState(() {
      counter = LocalStorage.getInt('counter') ?? 0;
    });
  });
  }

  int counter = 0;

  void _incrementCounter(){
    setState(() {
      counter++;
      LocalStorage.setInt('counter', counter);
    });
  }

  void _decrementCounter(){
    setState(() {
      counter--;
      LocalStorage.setInt('counter',counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Center(
        child: Text('$counter',style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton(onPressed: _decrementCounter,child: const Icon(Icons.remove),),
          ),
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton(onPressed: _incrementCounter,child: const Icon(Icons.add),),
          )
        ],
      ),
    );
  }
}