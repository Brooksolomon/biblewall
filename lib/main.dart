import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math';
import 'models/verse.dart';



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(VerseAdapter());
  runApp(const MyApp());
}



List<Verse> createVerses() {
  return [
    Verse(book: "Isaiah", chapter: 41, verse: 10, text: "So do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand."),
    Verse(book: "Joshua", chapter: 1, verse: 9, text: "Be strong and courageous; do not be frightened and do not be dismayed, for the Lord your God is with you wherever you go."),
    Verse(book: "Isaiah", chapter: 40, verse: 31, text: "But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint."),
    Verse(book: "Deuteronomy", chapter: 31, verse: 6, text: "Be strong and courageous. Do not be afraid or terrified because of them, for the Lord your God goes with you; he will never leave you nor forsake you."),
    Verse(book: "Romans", chapter: 15, verse: 13, text: "May the God of hope fill you with all joy and peace as you trust in him, so that you may overflow with hope by the power of the Holy Spirit."),
    Verse(book: "2 Timothy", chapter: 1, verse: 7, text: "For the Spirit God gave us does not make us timid, but gives us power, love and self-discipline."),
    Verse(book: "Isaiah", chapter: 40, verse: 29, text: "He gives strength to the weary and increases the power of the weak"),
  ];
}

class GenerateVerse  extends StatefulWidget{
  const GenerateVerse({super.key});

  @override
  State <GenerateVerse> createState() => _myGeneateVerseState();
}

class _myGeneateVerseState extends State<GenerateVerse>{
  final List<Verse> _verses = createVerses();
  List<Verse> _shuffledVerses = createVerses();
  Verse _dailyVerse =Verse(book: "start", chapter: 1, verse: 1, text: "and it starts");

  // Future<void> _loadShuffledVerses() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? storedOrder = prefs.getStringList('verseOrder');

  //   if (storedOrder != null && storedOrder.isNotEmpty) {
  //     // Load previously stored order
  //     _shuffledVerses = _verses.toList();
  //     _shuffledVerses.shuffle(Random());
  //     prefs.setStringList('verseOrder', _shuffledVerses.map((v) => v.text).toList());
  //   } else {
  //     // If no stored order, shuffle and save
  //     _shuffledVerses = _verses.toList();
  //     _shuffledVerses.shuffle(Random());
  //     prefs.setStringList('verseOrder', _shuffledVerses.map((v) => v.text).toList());
  //   }
  // }

  Verse _getDailyVerse() {
    if (_shuffledVerses.isEmpty) {
      // If all verses have been displayed, re-shuffle
      _shuffledVerses = _verses.toList();
      _shuffledVerses.shuffle(Random());
    }
    if (_shuffledVerses.isNotEmpty) {
      Verse verse = _shuffledVerses.last; 
      _shuffledVerses.removeLast(); 
      return verse;
    } else {
      return Verse(book: "none", chapter: 0, verse: 0, text: "none"); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("myapp"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
           Text(
  _getDailyVerse().text,
  textAlign: TextAlign.center,
),
FloatingActionButton(
  onPressed: () {
    setState(() {
      // Call getDailyVerse() here to fetch a new verse
      _dailyVerse = _getDailyVerse(); // Update the state variable
    });
  },
  child: Icon(Icons.refresh), // Optional: Add a refresh icon
),]
        ),
      ),
    );
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenerateVerse(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
