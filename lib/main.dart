import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

// Funções
  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";
    setState(() {
      _infoText = "Digite seus dados!";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _controler() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;
      double imc = weigth / (heigth * heigth);
      print(imc);
      if (imc < 18) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)}) kg/m2";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)}) kg/m2";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            "Levemente acima do peso (${imc.toStringAsPrecision(3)}) kg/m2";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(3)}) kg/m2";
      } else if (imc >= 39.9) {
        _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(3)}) kg/m2";
      }
    });
  }

// Variaveis
  String _infoText = "Digite seus dados!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.deepPurple,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (KG)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                    controller: weigthController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (CM)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                    controller: heigthController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed:(){
                          if(_formkey.currentState.validate()){
                            _controler();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25.0,
                    ),
                  )
                ],
              ),
            )));
  }
}
