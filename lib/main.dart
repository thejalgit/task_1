import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/user_controller.dart';
import 'package:task_1/view_page/user_listview.dart';
import 'package:tasks/controller/usercontroller.dart';
import 'package:tasks/view/userlistview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>UserController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: UserViewClass(),
      ),
    );
  }
}
