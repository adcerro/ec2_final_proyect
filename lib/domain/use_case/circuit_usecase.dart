import 'package:logisim_n/domain/repositories/i_circuit_repository.dart';

import '../models/circuit.dart';

class CircuitUseCase {
  final ICircuitRepository _repository;
  CircuitUseCase(this._repository);
  Circuit loadCircuitData({required String name}) =>
      _repository.loadCircuitData(name: name);
  Future<bool> openFile() => _repository.openFile();
  List<String> listCircuitsNames() => _repository.listCircuitsNames();
}
