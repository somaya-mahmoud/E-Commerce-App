import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  late AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        cubit = AppCubit.get(context);
        //print('home test');
        // print(cubit.responseList.length);
        //print(cubit.bannersList.length);
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
              cubit.bannersList.isEmpty ? SizedBox() :    CarouselSlider.builder(
                    itemCount: cubit.bannersResponse.data!.length,
                    itemBuilder: (context, index, realIndex) {
                      //   var imageUrl = urlImages[index];
                      // return buildImage(imageUrl, index);
                      return Image.network(
                        cubit.bannersResponse.data![index].image!,
                      );
                    },
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      reverse: true,
                      autoPlayInterval: Duration(seconds: 1),
                      viewportFraction: 1,
                    )),
                SizedBox(
                  height: 5,
                ),
                Container(
                    margin: EdgeInsets.only(right: 190),
                    child: Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 4,
                ),
                // (cubit.responseList.isEmpty) ? Center(
                //   child: CircularProgressIndicator.adaptive(),
                // )
                // :
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.network(
                              cubit.responseList[index].image ?? cubit.url,
                              width: 100,
                              height: 75,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              cubit.responseList[index].name ??
                                  "electronic devices",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: cubit.responseList.length,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                    margin: EdgeInsets.only(right: 170),
                    child: Text(
                      "New Products ",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 5,
                ),
                // (cubit.productsList.isEmpty)? Center(
                //   child: CircularProgressIndicator.adaptive(),
                // ) :
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.6),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Image.network(
                                  cubit.homeResponse.data!.products![index]
                                          .image ??
                                      cubit.url,
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              cubit.homeResponse.data!.products![index].name ??
                                  "new products",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text(
                                  cubit
                                      .homeResponse.data!.products![index].price
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  cubit.homeResponse.data!.products![index]
                                      .oldPrice
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[500],
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.addToFavorite(id: cubit.homeResponse.data!.products![index].id);
                                       // cubit.favoriteResponse =null;
                                    },
                                    icon: Icon(Icons.favorite_border),
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: cubit.productsList.length,
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is ShowFavorites){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${cubit.favoriteResponse!.message}")));
        }
      },
    );
  }
}
