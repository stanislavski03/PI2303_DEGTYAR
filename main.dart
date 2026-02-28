import 'models/Resources.dart';
import 'views/ConsoleView.dart';
import 'controllers/MachineController.dart';

void main() {
  Resources resources = Resources(100, 200, 300, 500);
  ConsoleView view = ConsoleView();
  MachineController controller = MachineController(resources, view);

  controller.run();
}
