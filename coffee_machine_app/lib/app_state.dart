import './models/Resources.dart';
import './services/CoffeeMaker.dart';
import './controllers/MachineController.dart';

class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  late Resources resources;
  late CoffeeMaker coffeeMaker;
  late MachineController controller;

  void initialize() {
    resources = Resources(100, 200, 300, 500);
    coffeeMaker = CoffeeMaker();
    controller = MachineController(resources, coffeeMaker);
  }
}
