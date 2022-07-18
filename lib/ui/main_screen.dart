

 import 'package:e_commerce_app/bloc/app_cubit.dart';
 import 'package:e_commerce_app/ui/search_screen.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {

  late AppCubit cubit;

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
       cubit = AppCubit.get(context);
       return Scaffold(
         appBar: AppBar(title: Text("Salla"),
           actions: [
             IconButton(onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen(),));
             }, icon: Icon(Icons.search)),
           ],),

         bottomNavigationBar: BottomNavigationBar(
           items:
           [
             BottomNavigationBarItem(icon:Icon( Icons.home),label: "Home"),
             BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: "Categories"),
             BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
             BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
           ],
           currentIndex: cubit.index,
           onTap: (value) {
             cubit.changeBottomNavigationState(value);
           },
           type: BottomNavigationBarType.fixed,
           selectedItemColor: Colors.blue,
           unselectedItemColor:Colors.grey,
           backgroundColor: Colors.grey[400],
         ),
         body: cubit.screens[cubit.index],
       );
     }, listener: (context, state) {

     },

     );

   }
 }
