import 'package:flutter/material.dart';
import 'package:project1/Provider/Provider.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TransactionProvider();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 132, 177, 255),
        ),
        home: const MyHomePage(title: 'TODO'),
      ),
    );
  }
}
