import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidad1/screens/page_screen.dart';

final List<String> catNames = [
  'Maraguay', 'Murphy', 'Cloe', 'Frida', 'Luna', 'Simba', 'Milo', 'Nala',
  'Oliver', 'Leo', 'Chloe', 'Bella', 'Charlie', 'Max', 'Lucy', 'Kitty',
  'Oscar', 'Loki', 'Jasper', 'Shadow', 'Tiger', 'Tigger', 'Smokey', 'Angel',
  'Lily', 'Misty', 'Coco', 'Mittens', 'Pepper', 'Rocky', 'Sammy', 'Sasha',
  'Gizmo', 'Ginger', 'Ruby', 'Rosie', 'Muffin', 'Ziggy', 'Maggie', 'Thor',
  'Zeus', 'Bandit', 'Zoe', 'Boo', 'Rusty', 'Moose', 'Shadow', 'Jax', 'Izzy'
];

final List<String> _cats = List<String>.generate(51, (index) => catNames[Random().nextInt(catNames.length)]);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: const AppBarExample(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            const Text('A random idea:'),
            Text(appState.current.asLowerCase),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[500],
                shadowColor: Colors.purple[800],
                overlayColor: Colors.purple[100],
              ),
              child: const Text(
                'Boton',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ElevatedButton(onPressed: null, child: Text('Disable'))
          ],
        ),
      ),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({super.key});

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 249),
      appBar: AppBar(  
        backgroundColor: Colors.purple[50],       
        leading: const Icon(Icons.pets, color: Color.fromARGB(255, 108, 33, 141),),
        title: const Text('AppBar Elevation Equipo 2', style: TextStyle(color: Color.fromARGB(255, 92, 0, 131), fontWeight: FontWeight.bold),),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      body: GridView.builder(
        itemCount: _cats.length,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Center(
              child: Text(
                'Hola! Haz scroll para ver el efecto :)',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            );
          }
         return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration( // Modificación 2
              borderRadius: BorderRadius.circular(20.0),
              color: index.isOdd ? oddItemColor : evenItemColor,
            ),
            child: Text(_cats[index]),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple[50],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    shadowColor = !shadowColor;
                  });
                },
                icon: Icon(
                  shadowColor ? Icons.visibility_off : Icons.visibility,
                ),
                label: const Text('Aplicar sombra'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  if (scrolledUnderElevation == null) {
                    setState(() {
                      scrolledUnderElevation = 4.0;
                    });
                  } else {
                    setState(() {
                      scrolledUnderElevation = scrolledUnderElevation! + 1.0;
                    });
                  }
                },
                child: Text(
                  'Elige tu eleveción: ${scrolledUnderElevation ?? 'default'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
