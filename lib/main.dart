import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Define a ChangeNotifier class
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class Counter2 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// Mock future data
Future<String> fetchFutureData() async {
  await Future.delayed(Duration(seconds: 120));
  return "Future Data Loaded";
}

// Mock stream data
Stream<int> fetchStreamData() async* {
  for (int i = 1; i <= 1000; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Counter2()),
        FutureProvider<String>(create: (_) => fetchFutureData(), initialData: "Loading..."),
        StreamProvider<int>(create: (_) => fetchStreamData(), initialData: 0),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Provider Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



            // Using ChangeNotifierProvider
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text('Counter: ${counter.count}', style: TextStyle(fontSize: 24));
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<Counter>().increment();
              },
              child: Text('Increment Counter  Using Consumer Widget'),
            ),





            Text(
              'Counter: ${Provider.of<Counter2>(context).count}',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Counter2>(context, listen: false).increment();
              },
              child: Text('Increment Counter using Provider Widget'),
            ),



            SizedBox(height: 20),
            // Using FutureProvider
            Consumer<String>(
              builder: (context, futureData, child) {
                return Text(futureData, style: TextStyle(fontSize: 24));
              },
            ),





            SizedBox(height: 20),
            // Using StreamProvider
            Consumer<int>(
              builder: (context, streamData, child) {
                return Text('Stream Data: $streamData', style: TextStyle(fontSize: 24));
              },
            ),
          ],
        ),
      ),
    );
  }
}
