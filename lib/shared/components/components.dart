import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapi_01/layout/news_app/news_cubit/cubit.dart';
import 'package:newsapi_01/layout/news_app/theme_cubit/theme_cubit.dart';
import 'package:newsapi_01/modules/web_view/web_view_screen.dart';
import 'package:sqflite/sqflite.dart';

var datetest;

Database? dataBase;

IconData fabIcon = Icons.favorite_outline;
IconData fabIcon3 = Icons.favorite_sharp;
bool fabIcon2 = true;

double numbera = 60;

Future<Widget> defaultButton({
  bool isUpperCase = true,
  double width = double.infinity,
  double radius = 0,
  Color background = Colors.blue,
  required VoidCallback onPressed, // voidCallback = void Function()
  required String text,
}) async =>
    Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget imageTest(itemMap) {
  return FadeInImage.assetNetwork(
    height: 150,
    width: 150,
    fit: BoxFit.cover,
    fadeInDuration: Duration(milliseconds: 800),
    fadeInCurve: Curves.fastLinearToSlowEaseIn,
    placeholder: 'assets/image/Default_Image.png',
    image: itemMap['urlToImage'] ?? 'assets/image/Default_Image.png',
    imageErrorBuilder: (context, error, stackTrace) {
      return Container(
        height: 150,
        width: 150,
        child: Image.asset(
          'assets/image/Default_Image.png',
          fit: BoxFit.cover,
        ),
      );
    },
  );
}

Widget articleItem(Map itemMap, context) => Dismissible(
      key: Key(itemMap['id'].toString()),
      onDismissed: (direction) {
        NewsCubit.get(context).deleteData(id: itemMap['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            navigateTo(context, WebViewScreen(itemMap['url']));
          },
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    '${itemMap['source']['name']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 35,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 55,
                height: 25,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageTest(itemMap),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                '${itemMap['title']}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat.MMMMEEEEd()
                                          .format(DateTime.now()) +
                                      "   " +
                                      DateFormat.Hms().format(DateTime.now()),
                                  // ******************
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                        // ],
                        ),
                  ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

Widget buttonViewSeparator() {
  return RawMaterialButton(
    focusColor: Colors.purple,
    onPressed: () {},
    elevation: 3.0,
    fillColor: Colors.white,
    child: Icon(
      Icons.announcement,
      size: 15.0,
    ),
    padding: EdgeInsets.all(7.0),
    shape: CircleBorder(),
  );
}

Widget articleItem_2(itemMap, context) => Dismissible(
      key: Key(itemMap['id'].toString()),
      onDismissed: (direction) {
        NewsCubit.get(context).deleteData(id: itemMap['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            navigateTo(context, WebViewScreen(itemMap['url']));
          },
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageTest(itemMap),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              '${itemMap['title']}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                // DateFormat.MMMMEEEEd().format(DateTime.now()) + "   " +
                                //     DateFormat.Hms().format(DateTime.now()),

                                '${itemMap['date']}',
                                // ******************
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

Widget listViewSeparator(Map itemMap, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RawMaterialButton(
              focusColor: Colors.amber,
              onPressed: () {
                NewsCubit.get(context).insertToDatabase(
                    title: '${itemMap['title']}',
                    date: DateFormat.MMMMEEEEd().format(DateTime.now()) +
                        "   " +
                        DateFormat.Hms().format(DateTime.now()),
                    url: '${itemMap['url']}',
                    img: '${itemMap['urlToImage']}');

                NewsCubit.get(context).toggleSwitchState();
              },
              elevation: 3.0,
              fillColor: Colors.white,
              child: NewsCubit.get(context).toggleswitch == false
                  ? Icon(
                      Icons.favorite_outline,
                    )
                  : Icon(
                      Icons.favorite_sharp,
                      size: 27.0,
                      color: Colors.blueGrey,
                    ),
              padding: EdgeInsets.all(7.0),
              shape: CircleBorder(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: 1,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget articleBuilder(List<dynamic> list, {isSearch = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return articleItem(list[index], context);
          },
          separatorBuilder: (context, index) =>
              listViewSeparator(list[index], context),
          itemCount: 10);
    },
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()),
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Widget defaultFormField(
        {required BuildContext context,
        TextEditingController? controller,
        required String labelText,
        required TextInputType keyboardType,
        required IconData prefixIcon,
        required String? Function(String?)? validator,
        void Function()? onEditingComplete,
        void Function(String)? onChanged,
        VoidCallback? suffixIconOnPressed,
        IconData? suffixIcon,
        bool obscureText = false,
        VoidCallback? onTap,
        Function? onFieldSubmitted // mohem
        }) =>
    TextFormField(
      style: TextStyle(
          color:
              ThemeCubit.get(context).darkMode ? Colors.white : Colors.black),
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      obscureText: obscureText,
      controller: controller!,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ThemeCubit.get(context).darkMode
                    ? Colors.white
                    : Colors.deepOrange)),
        labelStyle: TextStyle(
            color:
                ThemeCubit.get(context).darkMode ? Colors.white : Colors.grey),
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
          color: ThemeCubit.get(context).darkMode
              ? Colors.white
              : Colors.deepOrange,
        ),
        suffixIcon: IconButton(
          onPressed: suffixIconOnPressed,
          icon: Icon(suffixIcon),
        ),
      ),
      keyboardType: keyboardType,
      // or like this
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: (value) {},
    );
