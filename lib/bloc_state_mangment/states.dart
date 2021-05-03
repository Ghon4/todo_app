abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeNavBottomState extends AppInitialState {}

class AppCreateDBState extends AppInitialState {}

class AppInsertDBState extends AppInitialState {}

class AppUpdateDBState extends AppInitialState {}

class AppLoadingState extends AppInitialState {}

class AppOpenAndReadDBState extends AppInitialState {}
