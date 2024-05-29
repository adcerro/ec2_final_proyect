import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:logisim_n/ui/widgets/circuit_drawer.dart';

class CircuitsPage extends StatefulWidget {
  const CircuitsPage({super.key});
  @override
  State<CircuitsPage> createState() => _CircuitsPageState();
}

class _CircuitsPageState extends State<CircuitsPage> {
  Offset offset = Offset(0, 0);
  String _circuitName = "main";
  CircuitController controller = Get.find();
  List<Widget> displayList() {
    List<Widget> circList = [];
    controller.listCircuitsNames().forEach((element) {
      circList.add(TextButton(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () {
            setState(() {
              _circuitName = element;
            });
          },
          child: Text(element)));
    });
    return circList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: DrawerButton(),
        title: Text('Current circuit: $_circuitName'),
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.sizeOf(context).width / 4,
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) {
            setState(() {
              offset = offset + details.delta;
            });
          },
          child: CustomPaint(
            size: Size(MediaQuery.sizeOf(context).width,
                MediaQuery.sizeOf(context).height),
            willChange: true,
            painter: WhiteBoard(circuitName: _circuitName, offset: offset),
          )),
    );
  }
}
