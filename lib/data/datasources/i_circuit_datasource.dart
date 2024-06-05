import '../../../domain/models/circuit.dart';

abstract class ICircuitDataSource {
  bool addCircuit(Circuit circ);
  List<Circuit> getCircuits();
}
