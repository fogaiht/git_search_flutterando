import 'package:level1/Home/GithubService.dart';
import 'package:level1/models/SearchResult.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final GithubService _githubApi = GithubService();

  final _searchController = BehaviorSubject<String>();

  Observable<String> get searchFlux => _searchController.stream;

  Sink<String> get searchEvent => _searchController.sink;

  Observable<SearchResult> listItems;

  HomeBloc() {
    listItems = searchFlux
        .distinct()
        .debounce(Duration(milliseconds: 300))
        .asyncMap(_githubApi.search)
        .switchMap((dados) => Observable.just(dados));
  }

  void dispose(){
    _searchController?.close();
  }


}
