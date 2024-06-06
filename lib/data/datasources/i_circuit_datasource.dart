import '../../../domain/models/circuit.dart';

abstract class ICircuitDataSource {
  Circuit loadCircuitData({required String name});
  Future<bool> openFile();
  List<String> listCircuitsNames();
  Future<bool> clear();
}
