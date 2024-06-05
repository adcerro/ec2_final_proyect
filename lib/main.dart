import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logisim_n/data/datasources/circuit_datasource.dart';
import 'package:logisim_n/data/datasources/i_circuit_datasource.dart';
import 'package:logisim_n/data/repositories/circuit_repository.dart';
import 'package:logisim_n/domain/repositories/i_circuit_repository.dart';
import 'package:logisim_n/domain/use_case/circuit_usecase.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:logisim_n/ui/views/circuits_view.dart';
import 'package:logisim_n/ui/views/home_page.dart';

void main() {
  Get.put<ICircuitDataSource>(CircuitDataSource());
  Get.put<ICircuitRepository>(CircuitRepository(Get.find()));
  Get.put(CircuitUseCase(Get.find()));
  Get.put(CircuitController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Logisim N',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Logisim N'),
      routes: {'/circuits': (context) => CircuitsPage()},
    );
  }
}
