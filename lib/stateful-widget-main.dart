// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//     final List<String> entries = <String>['lightBlue', 'blue', 'cyan'];
//     final List<Color> colors = <Color>[
// 		Colors.lightBlue, Colors.blue, Colors.cyan
// 	];

//     int _counter = 0;

//     void _incrementCounter() {
//         setState(() {
//             _counter++;
//         });
//     }


//     @override
//     Widget build(BuildContext context) {
//         return Scaffold(
//                 appBar: AppBar(
//                     title: const Text('Flutter'),
//                     backgroundColor: Colors.blue,
//                 ),
//                 body: const Center(
//                     child: Text('Welcome to Flutter'),
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                     child: const Icon(Icons.add),
//                     onPressed: () {},
//                 ),
//             );


//     }
// }

// -----------------------------------------------------------------

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const FavoriteWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  final String msg;

  const FavoriteWidget({super.key, this.msg = 'my favorite'});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  @override
  void initState() {
    print('call initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('call build');
    debugPrint('FavoriteWidget msg: ${widget.msg}');
    return IconButton (
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
        icon: (_isFavorited
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border)),
        color: Colors.red[500],
        onPressed: _toggleFavorite,
    );
  }

  void _toggleFavorite() {
    setState(() {
      print('call setState');
      _isFavorited = !_isFavorited;
    },);
    // toAnotherPage();
  }

  @override
  void dispose() {
    print('call dispose');
    super.dispose();
  }

  // ダミーで画面遷移を行う
  void toAnotherPage() async {
    {
      // ダミー画面へ遷移
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const AnotherPage();
      },),);
    }
  }
}

// import 'package:flutter/material.dart';
class AnotherPage extends StatelessWidget {
  const AnotherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: const Text('another page'),
    );
  }
}
