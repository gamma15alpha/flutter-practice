import 'package:flatter_templates_study/pages/ScreeenThree.dart';
import 'package:flatter_templates_study/pages/ScreenFour.dart';
import 'package:flatter_templates_study/pages/ScreenOne.dart';
import 'package:flatter_templates_study/pages/ScreenTwo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenOne())
                    );
                  },
                  child: const Text("Первый макет")
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenTwo())
                    );
                  },
                  child: const Text("Второй макет")
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreeenThree())
                    );
                  },
                  child: const Text("Третий макет")
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenFour())
                    );
                  },
                  child: const Text("Четвертый макет")
              ),
            )
          ],
        ),
      ),
    );
  }
}
