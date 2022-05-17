import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapi_01/layout/news_app/news_cubit/cubit.dart';
import 'package:newsapi_01/layout/news_app/news_cubit/states.dart';
import 'package:newsapi_01/shared/components/components.dart';

class PoliticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic>? list = NewsCubit.get(context).politic;
        return articleBuilder(list);
      },
    );
  }
}
