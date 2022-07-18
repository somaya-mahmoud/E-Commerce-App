

  import 'package:e_commerce_app/bloc/app_cubit.dart';
  import 'package:e_commerce_app/reusable_component.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  late AppCubit cubit;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      cubit = AppCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                myTextFormField(controller: searchController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        print('Write Search Key');
                        return null;
                      }
                    },
                    prefixIcon: Icons.search,
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Write Search Key")));
                      }
                      cubit.search(searchKey: searchController.text);
                    },
                    label: "Search",
                    textInputAction: TextInputAction.search),
                Visibility(
                  visible: isSearching,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                Expanded(child: searchBody()),


              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {

    },);
  }


  Widget searchBody() {
  //   return ListView.builder(
  //     itemBuilder: (context, index) =>
  //         Container(
  //           height: 200,
  //           padding: EdgeInsets.all(10),
  //           color: Colors.grey[300],
  //           child: Column(
  //             children: [
  //               Container(
  //                   margin: EdgeInsets.only(left: 20),
  //                 width: 90,
  //                   height: 180
  //                   ,child: Image.network(cubit.searchList[index].image ?? cubit.url,fit: BoxFit.fill,)
  //               ,),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               Container(
  //                 height: 180,
  //                 width: 100,
  //                 child: Text(cubit.searchList[index].name ??
  //                     "search products", style:
  //                 TextStyle(fontWeight: FontWeight.w500,
  //                     overflow: TextOverflow.ellipsis,
  //                     fontSize:
  //                     15),
  //                   maxLines: 2,),
  //               ),
  //               SizedBox(height: 15,),
  //               Container(
  //                 width: 200,
  //                 child: Row(
  //                   children: [
  //                     Text(cubit.searchList[index].price.toString(),
  //                       style:
  //                       TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.blue,
  //                         fontSize: 15,
  //                       ),),
  //                     Spacer(),
  //                     CircleAvatar(
  //                       radius: 18,
  //                       backgroundColor: Colors.blue,
  //                       child: IconButton(onPressed: () {
  //
  //                       }, icon: Icon(Icons.favorite_border,
  //                         color: Colors.white,
  //                         size: 17,)),
  //                     ),
  //
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //
  //         ),
  //
  // itemCount: cubit.searchList.length);

   return ListView.builder(itemBuilder: (context, index) {
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
                    cubit.searchList[index].image ?? cubit.url,
                    fit: BoxFit.fill,),),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 180,
                      child: Text(cubit.searchList[index].name ??
                          "searchProducts", style:
                      TextStyle(fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          fontSize:
                          15),
                        maxLines: 2,),
                    ),

                    SizedBox(height: 15,),
                    Container(
                      width: 180,
                      child: Row(
                        children: [
                          Text(cubit.searchList[index].price.toString(),
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
        itemCount: cubit.searchList.length);


  }



}
  