
import 'package:e_commerce_app/bloc/app_cubit.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/response_files/data_response.dart';
import 'package:e_commerce_app/reusable_component.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsScreen extends StatelessWidget {

  var formKeysss = GlobalKey<FormState>();
  // var nameController = TextEditingController();
  // var emailController = TextEditingController();
  // var phoneController = TextEditingController();
   late AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
      cubit = AppCubit.get(context);
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50,left: 15,right: 15),
          child:
          ListView(
            children:[
              Column(
                children: [
                  myTextFormField(controller: cubit.nameController, validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                  }
                      , prefixIcon: Icons.email, label: "Name",keyboardType: TextInputType.name),
                  SizedBox(height: 15,),
                  myTextFormField(controller: cubit.emailController, validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                  }
                      , prefixIcon: Icons.person, label: "Email Address",keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 15,),
                  myTextFormField(controller: cubit.phoneController, validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                  }
                      , prefixIcon: Icons.phone, label: "Phone",keyboardType: TextInputType.phone),
                  SizedBox(height: 15,),
                  myButtonWidget(onPressed: () {
                   cubit. updateProfile(name:cubit.nameController.text,email: cubit.emailController.text,phone: cubit.phoneController.text);
                  }, texts: "UPDATE"),

                  SizedBox(height: 15,),
                  myButtonWidget(onPressed: () {

                          cubit.logOut();
                  }, texts: "LOGOUT"),

                ],

              ),
            ],
          ),
        ),

      );

    }, listener: (context, state) {

        if( state is Logout ){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logout Successfully")));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));

   }else if(state is Update){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Successfully")));
        }

    },);
  }

}
