abstract class NewsStates {}

class NewsInitialStates extends NewsStates {}

class ChangeNewsBottomNavState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}

// ============ ============================

class NewsGetPoliticLoadingState extends NewsStates {}

class NewsGetPoliticSuccessState extends NewsStates {}

class NewsGetPoliticErrorState extends NewsStates {
  final String error;

  NewsGetPoliticErrorState(this.error);
}

// ============ ==========================

class NewsGetFavoriteLoadingState extends NewsStates {}

class NewsGetFavoriteSuccessState extends NewsStates {}

class NewsGetFavoriteErrorState extends NewsStates {
  final String error;

  NewsGetFavoriteErrorState(this.error);
}

// ============ DB ============================

class AppCreateDatabaseState extends NewsStates {}

class AppInsertDatabaseState extends NewsStates {}

class AppInsertDatabaseStateManual extends NewsStates {}

class AppGetDatabaseState extends NewsStates {}

//  -----------------------

class AppUpdateDatabaseState extends NewsStates {}

class AppDeleteDatabaseState extends NewsStates {}

//  -------------   fabIcon  ----------

class ThemeModeChangedState extends NewsStates {}

// class ThemeMode2ChangedState extends NewsStates{}

class ToggleSwitchState extends NewsStates {}
