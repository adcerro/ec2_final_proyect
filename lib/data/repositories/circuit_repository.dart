import 'package:logisim_n/data/datasources/i_circuit_datasource.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/repositories/i_circuit_repository.dart';

class CircuitRepository extends ICircuitRepository {
  final ICircuitDataSource _circuitDataSource;
  CircuitRepository(this._circuitDataSource);
  @override
  Future<bool> openFile() => _circuitDataSource.openFile();
  @override
  Future<bool> clear() => _circuitDataSource.clear();
  @override
  List<String> listCircuitsNames() => _circuitDataSource.listCircuitsNames();

  @override
  Circuit loadCircuitData({required String name}) =>
      _circuitDataSource.loadCircuitData(name: name);
}
