

import 'package:e_commerce_app/bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class CategoriesScreen extends StatelessWidget {

  //String url = "https://www.afdal.best/wp-content/uploads/2021/09/Samsung-Chromebook-3.jpg";
   late AppCubit cubit;

  @override
    Widget build(BuildContext context) {

    return
      BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
       cubit = AppCubit.get(context);
       print(cubit.categoriesResponse.data!.data!.length);
       return Scaffold(
       body:
       // (cubit.responseList.isEmpty) ?
       // Center(
       //   child: CircularProgressIndicator.adaptive(),
       // )
       //     :
       ListView.builder(itemBuilder: (context, index) {
       return Container(
       padding: EdgeInsets.all(10),
       child: Column(
       children: [
       Row(
       children: [
       Image.network(cubit.responseList[index].image?? cubit.url,width: 120,height: 90,),
       SizedBox(width: 15),
       Text(cubit.responseList[index].name ?? "electronic devices",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
       SizedBox(width: 10),
       Spacer(),
       IconButton(onPressed: () {

       }, icon: Icon(Icons.arrow_forward_ios_outlined,size: 20,)),
       ],
       ),
       ],
       ),
       );
       },
       itemCount: cubit.responseList.length,),
       );

       }, listener: (context, state) {

       },
       );

          }

  }



