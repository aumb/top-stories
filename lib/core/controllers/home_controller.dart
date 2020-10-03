import 'package:rxdart/rxdart.dart';

class HomeController {
  ///Keeps track of the current bottom tab item selected
  BehaviorSubject<int> _currentIndex;

  HomeController() {
    _currentIndex = BehaviorSubject<int>.seeded(0);
  }

  //Stream getters
  Observable<int> get currentIndexStream => _currentIndex.stream;

  //Value getters
  int get currentIndex => _currentIndex.value;

  //Value setters
  set currentIndex(int value) {
    if (!_currentIndex.isClosed) _currentIndex.add(value);
  }

  //Functions
  void dispose() {
    if (!_currentIndex.isClosed) _currentIndex.close();
  }
}
