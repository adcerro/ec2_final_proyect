import 'package:get/get.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/use_case/circuit_usecase.dart';

class CircuitController extends GetxController {
  final CircuitUseCase circuitUseCase = Get.find();

  /// This function is responsible for displaying the file picker.
  /// Once a file is chosen it gets the text and parses it to the
  /// XmlDocument type of the xml library
  Future<bool> openFile() => circuitUseCase.openFile();

  /// This function looks for the specific circuit in the controller's
  /// storage, if it's not there, then it creates a circuit extracting the
  /// information from the .circ file and stores it in the circuitStorage Array
  /// Finally (being in the storage or not) it returns the circuit
  Circuit loadCircuitData({required String name}) => circuitUseCase.loadCircuitData(name: name);

  ///This function gets all the circuit tags from the file and extracts their name
  ///then the names are stored locally for performance reasons
  List<String> listCircuitsNames() => circuitUseCase.listCircuitsNames();
}
