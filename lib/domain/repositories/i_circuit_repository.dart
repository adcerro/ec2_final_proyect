import 'package:logisim_n/domain/models/circuit.dart';

abstract class ICircuitRepository {
  Circuit loadCircuitData({required String name});
  Future<bool> openFile();
  Future<bool> clear();
  List<String> listCircuitsNames();
}
