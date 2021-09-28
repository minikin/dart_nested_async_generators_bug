import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unexpected Behavior with Nested Async Generators in Dart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var correct = <int>[];
  var wrong = <int>[];

  final blocCorrect = Counter();
  final blocWrong = Counter();

  @override
  void initState() {
    super.initState();
    blocCorrect.listen((i) {
      correct.add(i);
      setState(() {});
    });

    blocWrong.listen((i) {
      wrong.add(i);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              correct.toString(),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 50),
            TextButton(
              child: Text('Correct'),
              onPressed: () => blocCorrect.add(CounterEvent.correct),
            ),
            SizedBox(height: 50),
            Container(
              color: Colors.black,
              width: 200,
              height: 2,
            ),
            SizedBox(height: 50),
            Text(
              wrong.toString(),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 50),
            TextButton(
              child: Text('Wrong'),
              onPressed: () => blocWrong.add(CounterEvent.wrong),
            ),
          ],
        ),
      ),
    );
  }
}

enum CounterEvent { correct, wrong }

class Counter extends Bloc<CounterEvent, int> {
  Counter() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event == CounterEvent.correct) {
      // Works
      yield state + 1;
      yield state + 1;
    } else {
      /// Does not work
      yield* _increment();
    }
  }

  Stream<int> _increment() async* {
    yield state + 1;
    yield state + 1;
  }
}

abstract class Bloc<E, S> {
  Bloc(this._state) {
    _eventController.stream.asyncExpand(mapEventToState).listen((s) {
      _state = s;
      _stateController.add(_state);
    });
  }

  final _eventController = StreamController<E>();
  final _stateController = StreamController<S>.broadcast();

  S _state;
  S get state => _state;

  StreamSubscription<S> listen(void Function(S) onData) {
    return _stateController.stream.listen(onData);
  }

  Stream<S> mapEventToState(E event);

  void add(E event) => _eventController.add(event);
}
