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
  List<ListTile> displayList() {
    List<ListTile> circList = [];
    controller.listCircuitsNames().forEach((element) {
      circList.add(ListTile(
          onTap: () {
            setState(() {
              offset = Offset.zero;
              _circuitName = element;
            });
          },
          title: Text(element)));
    });
    return circList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: const DrawerButton(),
        title: Text('Current circuit: $_circuitName'),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.logout),
            tooltip: "Close file",
          )
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.sizeOf(context).width / 4,
        child: ListView(
          children: displayList(),
          //children: displayList(),
        ),
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
