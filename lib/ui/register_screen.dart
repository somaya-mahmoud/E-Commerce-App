

import 'package:e_commerce_app/ui/main_screen.dart';
  import 'package:e_commerce_app/my_dio.dart';
  import 'package:e_commerce_app/response_files/register_response.dart';
  import 'package:e_commerce_app/reusable_component.dart';
  import 'package:flutter/material.dart';

 class RegisterScreen extends StatefulWidget {


    @override
    _RegisterScreenState createState() => _RegisterScreenState();
  }

  class _RegisterScreenState extends State<RegisterScreen> {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    bool isPasswordVisible = false;
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    @override
  void initState() {
   //register(name: "Somaya Mahmoud Elsaid",email: "somaya13@gmail.com",password: "12345678",phone: "01060692267");
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children:[
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 80,right: 110),
                        child: Text("REGISTER",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 45,color: Colors.black),)),
                    SizedBox(height: 20,),
                    Text("Register now to browse our hot offers",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.grey),),
                    SizedBox(height: 20,),
                    myTextFormField(controller: nameController, validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                    }
                        , prefixIcon: Icons.email, label: "Name",keyboardType: TextInputType.name),
                    SizedBox(height: 15,),
                    myTextFormField(controller: emailController, validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                    }
                        , prefixIcon: Icons.person, label: "Email Address",keyboardType: TextInputType.emailAddress),
                    SizedBox(height: 15,),
                    myTextFormField(controller: passwordController, validator: (value) {
                      if(value!.isEmpty){
                        return "Required";
                      }
                    },
                        obsecureText:isPasswordVisible,
                        prefixIcon: Icons.lock,
                        suffixIcon: myIconWidget(),
                        label: "Password"),
                    SizedBox(height: 15,),
                    myTextFormField(controller: phoneController, validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                    }
                        , prefixIcon: Icons.phone, label: "Phone",keyboardType: TextInputType.phone),
                    SizedBox(height: 15,),
                    myButtonWidget(onPressed: () {
                      if(formKey.currentState!.validate()){
                              register(name: nameController.text,email: emailController.text,password: passwordController.text,phone: phoneController.text);
                          }


                    }, texts: "REGISTER"),

                  ],
                ),
            ],
              ),


            ),
          ),
        ),

      );
    }

    Widget myIconWidget(){
      return InkWell(
        onTap: () {
          isPasswordVisible = !isPasswordVisible;
          setState(() {

          });
        },
        child: isPasswordVisible ? Icon(Icons.visibility_off
            ,size: 22):Icon(Icons.visibility,size: 22),
      );


    }
    late RegisterResponse response;

    void register({String? name,String? email,String? password,String? phone}){
     MyDio.postData(
       endPoint: "register",
       data: {
         "name":name,
         "email":email,
         "password":password,
         "phone":phone,
       },
     ).then((value) {
        response = RegisterResponse.fromJson(value.data);
        if(response.status!){
                 print('status is: ${response.status}');
                 print('data is: ${response.data}');
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen(),));
               }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid")));

                  print('message is : ${response.message}');
       }
     });
    }
  }
