import 'package:e_commerce_app/bloc/app_cubit.dart';
import 'package:e_commerce_app/ui/home_screen.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:e_commerce_app/ui/main_screen.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/ui/register_screen.dart';
import 'package:e_commerce_app/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

   await MyDio.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AppCubit(InitAppState())..search()),
    ], child:
     MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
     // MainScreen(),
      // RegisterScreen(),
     // SettingsScreen()
    ),
   );
  }
}

