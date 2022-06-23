// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<CounterBloc, CounterState>(
            listener: (context, state) {
              if (state is IncrementState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Increased"),
                  duration: Duration(microseconds: 300),
                ));
              } else if (state is DecrementState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Decreased"),
                  duration: Duration(microseconds: 300),
                ));
              }
            },
            builder: (context, state) {
              return Container(
                child: Text('Counter value: ${state.counterValue}'),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Increment'),
                onPressed: () {
                  context.read<CounterBloc>().add(CounterIncrementEvent());
                },
              ),
              ElevatedButton(
                child: Text('Decrement'),
                onPressed: () {
                  context.read<CounterBloc>().add(CounterDecrementEvent());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
