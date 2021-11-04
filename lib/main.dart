import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StreamBuilderExample(title: 'Flutter Demo Home Page'),
    );
  }
}

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  int _timerVal = 0;
  bool _paused = true;
  final Stream<int> _periodicStream =
      Stream.periodic(const Duration(milliseconds: 1000), (i) => i);
  int _previousStreamValue = 0;

  Widget _buildTimerUI() {
    return Column(
      children: [
        Text('$_timerVal'),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _paused = !_paused;
                  });
                },
                icon: Icon(_paused ? Icons.play_arrow : Icons.pause)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _timerVal = 0;
                    _paused = true;
                  });
                },
                icon: const Icon(Icons.stop))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      child: StreamBuilder(
        stream: _periodicStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != _previousStreamValue) {
              debugPrint('Latest snapshot from stream: ${snapshot.data}');
              _previousStreamValue = snapshot.data!;
              if (!_paused) {
                _timerVal++;
              }
            }
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('data'),
              Card(
                child: _buildTimerUI(),
              )
            ],
          );
        },
      ),
    );
  }
}
