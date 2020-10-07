import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

final List<String> bookList = [
  'ressources/images/lile-du-roi-lezard.jpg',
  'ressources/images/le-labyrinthe-de-la-mort.jpg',
  'ressources/images/les-maitres-des-tenebres.jpg'
];

Future<String> loadAsset() async {
  var file = await rootBundle.loadString('ressources/books/books.json');
  print(file); //Possible de lire ici ! Assets !
  // https://toastguyz.com/flutter/read-and-write-files-in-flutter
  return file;
}

void main() {
  runApp(MyApp());
  loadAsset();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heroes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'L\'application dont vous êtes le héros'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _no() {
    setState(() {});
  }

  void _something() {
    print("I was clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEAECEE),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Image.asset('ressources/images/lile-du-roi-lezard.jpg'),
              CarouselSlider(
                options: CarouselOptions(height: 530.0, aspectRatio: 2.0),
                items: bookList
                    .map((item) => Container(
                        margin: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () => _something(),
                          child: Center(
                              child: Image.asset(item,
                                  fit: BoxFit.cover, width: 1000)),
                        )))
                    .toList(),
              )
            ],
          ),
        ));
  }
}
