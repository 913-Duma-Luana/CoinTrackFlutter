import 'package:cointrack2/repository/entityRepo.dart';
import 'package:flutter/material.dart';
import 'package:cointrack2/entities_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EntityRepo repo = EntityRepo();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.deepPurple[200],
        backgroundColor: const Color(0xFFd9dde8),
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[200],
        ),

      //     <color name="purple_200">#FFBB86FC</color>
      //     <color name="purple_500">#FF6200EE</color>
      //     <color name="purple_700">#FF3700B3</color>
      //     <color name="teal_200">#FF03DAC5</color>
      //     <color name="teal_700">#FF018786</color>
      //     <color name="black">#FF000000</color>
      //     <color name="white">#FFFFFFFF</color>
      //
      //     <color name="dark_purple">#80a5ea</color>
      // <color name="medium_purple">#93ace0</color>
      // <color name="medium_light_purple">#9fb8e0</color>
      // #9fb8e0
      // <color name="light_purple">#d9dde8</color>
      //
      // <color name="yellow">#faeece</color>
      // <color name="pink">#f2d0de</color>
      // <color name="brown">#a8796b</color>
      //
      // <color name="dark_yellow">#e8cb81</color>
      ),
      home: EntitiesList(repo),
    );
  }
}
