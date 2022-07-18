
import 'package:e_commerce_app/bloc/app_cubit.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/response_files/favorite_data_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatelessWidget {


//   String url = "https://www.afdal.best/wp-content/uploads/2021/09/Samsung-Chromebook-3.jpg";

 late AppCubit cubit;
   @override
   Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
       cubit = AppCubit.get(context);
       print(cubit.favoriteList2[0].product!.image);
       return Scaffold(
         body:
         ListView.builder(itemBuilder: (context, index) {
           return Container(
             height: 200,
             padding: EdgeInsets.all(10),
             child: Column(
               children: [
                 Row(
                   children: [
                     Container(
                       margin: EdgeInsets.only(left: 20),
                       height: 180,
                       width: 90,
                       child: Image.network(
                         cubit.favoriteList2[index].product!.image ?? cubit.url,
                         fit: BoxFit.fill,),),
                     SizedBox(width: 20,),
                     Column(
                       children: [
                         Container(
                           height: 100,
                           width: 180,
                           child: Text(cubit.favoriteList2[index].product!.name ??
                               "favorites", style:
                           TextStyle(fontWeight: FontWeight.w500,
                               overflow: TextOverflow.ellipsis,
                               fontSize:
                               15),
                             maxLines: 2,),
                         ),

                         SizedBox(height: 15,),
                         Container(
                           width: 200,
                           child: Row(
                             children: [
                               Text(cubit.favoriteList2[index].product!.price.toString(),
                                 style:
                                 TextStyle(
                                   fontWeight: FontWeight.bold,
                                   color: Colors.blue,
                                   fontSize: 15,
                                 ),),
                               Spacer(),
                               CircleAvatar(
                                 radius: 18,
                                 backgroundColor: Colors.blue,
                                 child: IconButton(onPressed: () {

                                 }, icon: Icon(Icons.favorite_border,
                                   color: Colors.white,
                                   size: 17,)),
                               ),

                             ],
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ],
             ),

           );
         },
             itemCount: cubit.favoriteList2.length),
       );

     }, listener: (context, state) {

     },);
        }




 }