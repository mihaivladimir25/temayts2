import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:temayts2/src/actions/get_movies.dart';
import 'package:temayts2/src/middleware/middleware.dart';
import 'package:temayts2/src/models/app_state.dart';
import 'package:temayts2/src/presentation/home_page.dart';
import 'package:temayts2/src/reducer/reducer.dart';
import 'package:temayts2/src/epics/app_epics.dart';


import 'src/data/movies_api.dart';

void main() {
  const String apiUrl = 'https://yts.mx/api/v2';
  final Client client = Client();
  final MoviesApi moviesApi = MoviesApi(client: client);
  final AppMiddleware appMiddleware = AppEpics(moviesApi: moviesApi);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: <Middleware<AppState>>[EpicMiddleware<AppState>(AppEpic.epic)],
  );
  store.dispatch(const GetMovies());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
