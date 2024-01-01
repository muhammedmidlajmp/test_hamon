import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_hamon/data/api_serviece/api_service.dart';
import 'package:test_hamon/data/repository/repository.dart';
import 'package:test_hamon/presentation/bottom_nav/bottom_nav.dart';
import 'package:test_hamon/presentation/provider/bottom_naprovider/bottom_nav_pro.dart';
import 'package:test_hamon/presentation/provider/classroom_provider/classroom_provider.dart';
import 'package:test_hamon/presentation/provider/student_list_provider/student_list_provider.dart';
import 'package:test_hamon/presentation/provider/subject_provider/subject_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Repository repository = Repository(ApiService(
        'https://nibrahim.pythonanywhere.com/students/?api_key=fcd06'));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(
            create: (context) => StudentsProvider(repository)),
        ChangeNotifierProvider(
            create: (context) => SubjectsProvider(repository)),
        ChangeNotifierProvider(
            create: (context) => ClassroomProvider(repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNavScreen(),
      ),
    );
  }
}
