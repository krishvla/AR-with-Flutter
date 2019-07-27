import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internship FLutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AR Internship'),
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
  ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _arCoreController) {
    arCoreController = _arCoreController;
    _addSphere(arCoreController);
    _addMoon(arCoreController);

  }

  _addSphere(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(color: Colors.purple,
                                  texture: "earth.jpg",
                                  metallic: 1.0,
                                  roughness: 0.0,
                                  reflectance: 1.0,
                                                );
    final sphere = ArCoreSphere(materials: [material], radius: 0.3);
    final node = ArCoreNode(shape: sphere, position: vector.Vector3(0, 0, -1.5),);

    _arCoreController.addArCoreNode(node);
  }
 _addMoon(ArCoreController _arCoreController) {
    final moonmaterial  = ArCoreMaterial(
        color: Colors.grey
    );
    final moonShape = ArCoreSphere(materials: [moonmaterial], radius: 0.1);
    final moon = ArCoreNode(shape: moonShape, position: vector.Vector3(0, 1.0, -1.5),);
    _arCoreController.addArCoreNode(moon);

 }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
