import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapi_01/layout/news_app/news_cubit/states.dart';
import 'package:newsapi_01/layout/news_app/theme_cubit/theme_cubit.dart';
import 'package:newsapi_01/modules/serarch/search_screen.dart';
import 'package:newsapi_01/shared/components/components.dart';
import 'package:newsapi_01/shared/components/onboarding/onboarding.dart';
import 'news_cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/image/logo_a_01.png'),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'تطبيق الاخبار *  كينج مريوط ',
                    style: TextStyle(
                      fontSize: 8,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    ThemeCubit.get(context).changeThemeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined))
            ],
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    navigateTo(context, OnBoarding());
                  },
                  icon: Icon(Icons.info_outline));
            }),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
