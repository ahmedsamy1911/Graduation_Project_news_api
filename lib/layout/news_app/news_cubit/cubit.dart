import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapi_01/layout/news_app/news_cubit/states.dart';
import 'package:newsapi_01/modules/business/business_screen.dart';
import 'package:newsapi_01/modules/favorite/favorite_screen.dart';
import 'package:newsapi_01/modules/politic/politic_screen.dart';
import 'package:newsapi_01/modules/science/science_screen.dart';

import 'package:newsapi_01/modules/sports/sports_screen.dart';

import 'package:newsapi_01/shared/network/remote/dio_helper.dart';

import 'package:sqflite/sqflite.dart';

var apikey = '2d7bd60ce37647f5ae5692879614e453';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 4;
  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      label: 'المفضلة',
      tooltip: 'الاخبار المفضلة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet_membership_outlined),
      label: 'السياسة',
      tooltip: 'الاخبار الحصرية',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'الرياضة',
      tooltip: 'الاخبار الحصرية',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'العلوم',
      tooltip: 'الاخبار الحصرية',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: 'الاعمال',
      tooltip: 'الاخبار الحصرية',
    ),
  ];

  List<Widget> screens = [
    FavoriteScreen(),
    PoliticScreen(),
    SportsScreen(),
    ScienceScreen(),
    BusinessScreen(),
  ];

  void changeBottomNavBarIndex(index) {
    currentIndex = index;
    emit(ChangeNewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': apikey,
      },
    ).then((value) {
      business = value.data['articles'];
      print(value.data['articles'][0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': apikey,
    }).then((value) {
      sports = value.data['articles'];
      print(value.data['articles'][0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsErrorState(error));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': apikey,
    }).then((value) {
      science = value.data['articles'];
      print(value.data['articles'][0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  List<dynamic> search = [];

  void getSearch(String? searchValue) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$searchValue',
      'apiKey': apikey,
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  // ================== =================================

  List<dynamic> politic = [];

  void getPolitic() {
    emit(NewsGetPoliticLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'politics',
        'apiKey': apikey,
      },
    ).then((value) {
      politic = value.data['articles'];
      print(value.data['articles'][0]['title']);
      emit(NewsGetPoliticSuccessState());
    }).catchError((error) {
      emit(NewsGetPoliticErrorState(error.toString()));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  // ============= favorite ============

  Database? dataBase;

  List<Map<String, dynamic>> favorite = [];

  void getFavorite() {
    emit(NewsGetFavoriteLoadingState());
    emit(AppGetDatabaseState());
    print('inserted successfully getFavorite');
  }

  // =========================================
  void createDatabase() {
    openDatabase(
      'newstest.db',
      version: 8,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE news (id INTEGER PRIMARY KEY, title TEXT, date TEXT , url Text , img Text )')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error while creating table ${error.toString()}');
        });
      },
      onOpen: (dataBase) {
        getNewsFromDatabase(dataBase);
        print('table opened');
      },
    ).then((value) {
      dataBase = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getNewsFromDatabase(database) {
    favorite = [];
    database.rawQuery('SELECT * FROM news ORDER BY id DESC').then((value) {
      value.forEach((element) {
        favorite.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  Future insertToDatabase({
    required String title,
    required String date,
    required String url,
    required String img,

    // required String image,
  }) async {
    return dataBase?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO news(title, date, url, img ) VALUES("$title", "$date", "$url", "$img")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getNewsFromDatabase(dataBase);
      }).catchError((error) {
        print(' error when inserting new record ${error.toString()}');
      });
    });
  }

  // ********

  Future insertToDatabaseManual({
    required String title,
    required String date,
    required String url,
    required String img,

    // required String image,
  }) async {
    return await dataBase?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO news(title, date, url, img) VALUES("$title", "$date", "$url", "$img" )')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getNewsFromDatabase(dataBase);
      }).catchError((error) {
        print(' error when inserting new record ${error.toString()}');
      });
    });
  }

  // *********

  void deleteData({required int id}) {
    dataBase?.rawDelete('DELETE FROM news where id = ?', [id]).then((value) {
      getNewsFromDatabase(dataBase);
      emit(AppDeleteDatabaseState());
    });
  }

// *********
// *********

  void deleteData_2({required String id}) {
    dataBase?.rawDelete('DELETE FROM news where id = ?', [id]).then((value) {
      getNewsFromDatabase(dataBase);
      emit(AppDeleteDatabaseState());
    });
  }

  bool fabIcon6 = true;
  IconData fabIcon5 = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    fabIcon6 = isShow;
    fabIcon5 = icon;

    emit(ThemeModeChangedState());
  }

  // ==============    toggle  switch ==========
  bool toggleswitch = true;

  void toggleSwitchState() {
    toggleswitch = !toggleswitch;
    emit(ToggleSwitchState());
  }
}
