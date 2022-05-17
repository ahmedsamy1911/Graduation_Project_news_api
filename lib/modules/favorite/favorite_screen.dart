import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapi_01/layout/news_app/news_cubit/cubit.dart';
import 'package:newsapi_01/layout/news_app/news_cubit/states.dart';
import 'package:newsapi_01/shared/components/components.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).favorite;

        if (list.length > 0) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                articleItem_2(list[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () {},
                    child: Card(),
                  ),
                ),
              ),
            ),
            itemCount: list.length,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Icon(
                Icons.list_rounded,
                color: Colors.grey,
                size: 120,
              )),
              Text(
                'لا يوجد أخبار فى المفضلة من فضلك قم بلإضافة',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 6,
                  fontFamily: 'Cairo',
                ),
              )
            ],
          );
        }
      },
    );
  }
}
