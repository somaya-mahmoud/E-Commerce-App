
import 'package:e_commerce_app/bloc/app_cubit.dart';
import 'package:e_commerce_app/response_files/login_response.dart';
import 'package:e_commerce_app/ui/main_screen.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/ui/register_screen.dart';
import 'package:e_commerce_app/reusable_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    late AppCubit cubit;
    @override
    Widget build(BuildContext context) {
      emailController.text="somaya14@gmail.com";
      passwordController.text="12345678";
      return BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        cubit = AppCubit.get(context);
        return Scaffold(
          body: Form(
              key: formKey,
              child:
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 22),
                //margin: EdgeInsets.only(bottom: 60),
                child: ListView(
                  shrinkWrap: true,
                  //crossAxisAlignment:CrossAxisAlignment.start,
                  //mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text("Login",
                      style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                    SizedBox(height: 15),
                    Text("Login now to browse our hot offers",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                    SizedBox(height: 30),

                    myTextFormField(controller: emailController, validator: (value) {
                      if(value!.isEmpty){
                        return "Required";
                      }
                    },
                        prefixIcon: Icons.email,
                        keyboardType:TextInputType.emailAddress,
                        label: "Email Address"),


                    SizedBox(height: 16,),
                    myTextFormField(controller: passwordController, validator: (value) {
                      if(value!.isEmpty){
                        return "Required";
                      }
                    },
                        obsecureText:cubit.isPasswordVisible,
                        prefixIcon: Icons.lock,
                        suffixIcon: myIconWidget(),
                        label: "Password"),
                    SizedBox(height: 26,),
                    myButtonWidget(onPressed: () {
                          if(formKey.currentState!.validate()) {
                        cubit.login(email:emailController.text,password: passwordController.text);
                      }
                    }, texts: "Login"),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?? ",style:
                        TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        TextButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen(),));
                        }, child: Text(
                          "REGISTER",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        )),
                      ],
                    ),

                  ],
                ),
              )),
        );

      }, listener: (context, state) {

           if(state is Login){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen(),));
           } else if(state is InvalidLogin) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Invalid Email or password",style:
             TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.pink),) ));

           }
      },);

    }

    Widget myIconWidget(){
      return InkWell(
        onTap: () {
          cubit.changeIconWidget(cubit.value);
        } ,

        child: cubit.isPasswordVisible ? Icon(Icons.visibility_off
          ,size: 22):Icon(Icons.visibility,size: 22),
      );

    }



}
