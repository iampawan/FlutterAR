import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter ARKit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ARKitController _arKitController;

  _onARKitViewCreated(ARKitController controller) {
    _arKitController = controller;

    _addSphere(_arKitController);
    _addText(_arKitController);
    _addPlane(_arKitController);
  }

  _addSphere(ARKitController controller) {
    final material = ARKitMaterial(
        lightingModelName: ARKitLightingModel.physicallyBased,
        diffuse: ARKitMaterialProperty(
          color: Colors.red,
        ));

    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.2,
    );

    final node =
        ARKitNode(geometry: sphere, position: vector.Vector3(0, -1.0, -1.5));

    controller.add(node);
  }

  _addText(ARKitController controller) {
    final material = ARKitMaterial(
        diffuse: ARKitMaterialProperty(
      color: Colors.blue,
    ));
    final text =
        ARKitText(text: "Flutter", extrusionDepth: 1, materials: [material]);

    final node = ARKitNode(
        geometry: text,
        position: vector.Vector3(-1.0, -2.0, -1.5),
        scale: vector.Vector3(0.05, 0.05, 0.05));

    controller.add(node);
  }

  _addPlane(ARKitController controller) {
    final material = ARKitMaterial(
        transparency: 0.5,
        diffuse: ARKitMaterialProperty(
          color: Colors.white,
        ));

    final plane = ARKitPlane(
      materials: [material],
      width: 1,
      height: 1,
    );

    final node =
        ARKitNode(geometry: plane, position: vector.Vector3(0, -1.0, -1.5));

    controller.add(node);
  }

  @override
  void dispose() {
    _arKitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ARKitSceneView(
          onARKitViewCreated: _onARKitViewCreated,
          showStatistics: true,
        ));
  }
}
