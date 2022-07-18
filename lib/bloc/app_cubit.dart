

import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/response_files/banners_response.dart';
import 'package:e_commerce_app/response_files/categories_response.dart';
import 'package:e_commerce_app/response_files/data_response.dart';
import 'package:e_commerce_app/response_files/favorite_data_response.dart';
import 'package:e_commerce_app/response_files/favorite_response.dart';
import 'package:e_commerce_app/response_files/home_response.dart';
import 'package:e_commerce_app/response_files/login_response.dart';
import 'package:e_commerce_app/response_files/logout_response.dart';
import 'package:e_commerce_app/response_files/search_products_response.dart';
import 'package:e_commerce_app/response_files/update_response.dart';
import 'package:e_commerce_app/ui/categories_screen.dart';
import 'package:e_commerce_app/ui/favorites_screen.dart';
import 'package:e_commerce_app/ui/home_screen.dart';
import 'package:e_commerce_app/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStates {}

 class InitAppState extends AppStates {}
 class ShowCategories extends AppStates{}
 class ShowBanners extends AppStates{}
 class ShowProducts extends AppStates{}
 class ShowFavorites extends AppStates{}
 class ShowFavoritesData extends AppStates{}
 class Login extends AppStates{}
 class BottomNavigationChangeState extends AppStates {}
 class Update extends AppStates{}
 class GetData extends AppStates{}
 class Logout extends AppStates{}
 class InvalidLogin extends AppStates{}
 class Search extends AppStates{}
 class ChangePasswordVisible extends AppStates{}
 class AppCubit extends Cubit<AppStates>{

  AppCubit(AppStates initialState) : super(initialState);

  static AppCubit get(context) =>BlocProvider.of(context);
   String message = "";
  String url = "https://www.afdal.best/wp-content/uploads/2021/09/Samsung-Chromebook-3.jpg";
  var urlImages = [
   'https://img.freepik.com/free-psd/american-food-banner-template-design_23-2148473300.jpg?size=626&ext=jpg&ga=GA1.2.1377667626.1638748800',
   'https://image.freepik.com/free-vector/american-food-banner-design-template_23-2148947451.jpg',
   'https://image.freepik.com/free-psd/banner-design-american-food_23-2148479829.jpg',
   'https://thumbs.dreamstime.com/z/vector-illustration-national-french-fries-day-food-banner-poster-card-design-usa-american-traditional-holiday-background-145441247.jpg'
  ];

  List<Widget> screens = [
   HomeScreen(),
   CategoriesScreen(),
   FavoritesScreen(),
   SettingsScreen()];
  int index = 0;
  String token = "";
  bool value = true;
  Widget buildImage(String imageUrl, int index) {
   return Container(
    margin: EdgeInsets.all(1),
    color: Colors.grey,
    child: Image.network(imageUrl,
     width: double.infinity,
    ),
   );
  }
  //..............
  var bannersList =  [];
  late BannersResponse bannersResponse;
  void getBanners(){
   MyDio.getData(
    endPoint: "banners",
   ).then((value) {
    bannersResponse = BannersResponse.fromJson(value.data);
    bannersList = bannersResponse.data!;
    if(bannersResponse.status!){
     print('HomeScreen');
     print('bannersStatus: ${bannersResponse.status}');
     print(bannersResponse.data!.length);
     print(bannersResponse.data![0].image);
     emit(ShowBanners());

    }
   });
  }
  //...................
  late CategoriesResponse categoriesResponse;
  List<Category> responseList = [];
  void getCategories() {
   MyDio.getData(endPoint: "categories"
   ).then((value) {
    categoriesResponse = CategoriesResponse.fromJson(value.data);
    if (categoriesResponse.status!) {
     responseList = categoriesResponse.data!.data!;
     print(categoriesResponse.data!.data![0].image);
     print(categoriesResponse.data!.data![0].name);
     print('status is : ${categoriesResponse.status}');
     emit(ShowCategories());
    }
   }).catchError((e){
    print(e);
   });
  }
  //.....................
  late HomeResponse homeResponse;
  List<Products> productsList = [];
  void getProducts(){
   MyDio.getData(
    endPoint: "home",
   ).then((value) {
    homeResponse  = HomeResponse.fromJson(value.data);
    if(homeResponse.status!){
     productsList = homeResponse.data!.products!;
     print('status of home response is : ${homeResponse.status}');
     print('length of data is : ${homeResponse.data!.products!.length}');
     print(homeResponse.data!.products![0].image);
     print(homeResponse.data!.products![0].images);
     emit(ShowProducts());
    }
   });
  }
  //........................
  var favoriteList  = [];
  late FavoriteResponse? favoriteResponse;
  void addToFavorite({int? id}) async{
   SharedPreferences preferences =  await SharedPreferences.getInstance();
   token = preferences.getString("token")?? "";
   MyDio.postData(
       endPoint: "favorites",
       token:token,
       data: {
        "product_id": id,
       }
   ).then((value){
    favoriteResponse = FavoriteResponse.fromJson(value.data);
    if(favoriteResponse!.status!){
     message = favoriteResponse!.message!;
     print('favorite');
     print(' favorite data is : ${favoriteResponse!.data!.id} ');
     emit(ShowFavorites());
     getFavorites();
    }else{
     print(favoriteResponse!.message);
    }
   });
  }
  //......................
  void changeBottomNavigationState(int value) {
   index = value;
   emit(BottomNavigationChangeState());
  }
  //.....................
  late FavoriteDataResponse favoriteDataResponse;
  List<Data2> favoriteList2 = [];
  void getFavorites() async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   token = preferences.getString("token") ?? "";
   MyDio.getData(
    endPoint: "favorites",
    token: token,
   ).then((value) {
    favoriteDataResponse = FavoriteDataResponse.fromJson(value.data);
    if (favoriteDataResponse.status!) {
     favoriteList2 = favoriteDataResponse.data!.data!.cast<Data2>();
     print(favoriteDataResponse.data!.data!.length);
     print('image is: ${favoriteList2[0].product!.image}');
     print('name is: ${favoriteList2[0].product!.name}');
     emit(ShowFavoritesData());
    } else {
     print(favoriteDataResponse.message);
    }
   });
  }
  //..................
 void initialization(){
   //login();
  getBanners();
  getCategories();
  getProducts();
  addToFavorite();
  getProfileData();
  getFavorites();

 }
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  //..................
 late DataResponse dataResponse;
  void getProfileData({String? name,String? email,String? phone}) async{
   SharedPreferences preferences =  await SharedPreferences.getInstance();
   token = preferences.getString("token")?? "";
   print('token is: ${token}');
   MyDio.getData(
    endPoint: "profile",
    token: token,
   ).then((value) {
    dataResponse = DataResponse.fromJson(value.data);
    if(dataResponse.status!){
     print('settings_screen');
     print('status is : ${dataResponse.status}');
     print('name is : ${dataResponse.data!.name}');
     print('email is : ${dataResponse.data!.email}');
     print('phone is : ${dataResponse.data!.phone}');
     nameController.text =dataResponse.data!.name! ;
     emailController.text = dataResponse.data!.email!;
     phoneController.text =dataResponse.data!. phone!;
     emit(GetData());
    }else{
     print('message is : ${dataResponse.message}');
    }
   });
  }
  //..........................
  late  LogoutResponse logoutResponse;
  void logOut() async{
   SharedPreferences preferences =  await SharedPreferences.getInstance();
   token = preferences.getString("token")?? "";
   MyDio.postData(
    endPoint: "logout",
    token: token,
    data: {
     "fcm_token": "SomeFcmToken"
    },
   ).then((value) {
    logoutResponse = LogoutResponse.fromJson(value.data);
    if(logoutResponse.status!)
    emit(Logout());
   });
  }
  //....................
  late UpdateResponse updateResponse;
  void updateProfile({String? name,String? phone,String? email})async{
   SharedPreferences preferences =  await SharedPreferences.getInstance();
   token = preferences.getString("token")?? "";
   MyDio.putData(
       endPoint: "update-profile",
       token: token,
       queryParameters: {
        "name" : name,
        "email": email,
        "phone": phone,
       }
   ).then((value) {
    updateResponse = UpdateResponse.fromJson(value.data);
    if(updateResponse.status!){
     print('token is : ${updateResponse.data!.token}');
     emit(Update());
    }
   });
  }
  //....................
  late LoginResponse loginResponse;
  void login({String? email,String? password}){
   MyDio.postData(endPoint:"login",
    queryParameters: {
     "email": email,
     "password" :password
    },
   ).then((value) async {
    loginResponse = LoginResponse.fromJson(value.data);
    if(loginResponse.status!){
     SharedPreferences preferences =  await SharedPreferences.getInstance();
     preferences.setString("token", loginResponse.data!.token!);
     print('status is : ${loginResponse.status}');
     print('token is: ${loginResponse.data!.token}');
     print('email is: ${loginResponse.data!.email}');
     print('phone is: ${loginResponse.data!.phone}');
     initialization();
     emit(Login());
    }
    else{
     print(loginResponse.message);
     emit(InvalidLogin());
         }
   });
  }
  //....................
  bool isPasswordVisible = false;
  void changeIconWidget(bool value){
  isPasswordVisible = value ;
  emit(ChangePasswordVisible());
 }

 // .......................
  List<Data3> searchList = [];
 late  SearchProductsResponse searchProductsResponse;
 void search({String? searchKey}){
   MyDio.postData(endPoint: "products/search",
    data: {
     "text": searchKey,
    },

   ).then((value) {
    searchProductsResponse = SearchProductsResponse.fromJson(value.data);
    searchList = searchProductsResponse.data!.data!;
    if(searchProductsResponse.status!){
        print('status is :${searchProductsResponse.status} ');
        print("length is : ${searchProductsResponse.data!.data!.length}");
        print('message is: ${searchProductsResponse.message} ');
        print('id is :${searchProductsResponse.data!.data![0].id}');
        print(searchProductsResponse.data!.data![0].image);
        emit(Search());
    }
   });
 }
 


 }



