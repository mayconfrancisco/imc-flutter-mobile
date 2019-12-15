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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>(); //para resetar tb as msgs de erros
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / (height * height);
    String imcStr = imc.toStringAsPrecision(3);

    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (IMC $imcStr)";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal ($imcStr)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (IMC $imcStr)";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (IMC $imcStr)";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (IMC $imcStr)";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (IMC $imcStr)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: (InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.green))),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.green,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o Peso!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: (InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                  )),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: Colors.green),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe e Altura!';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                        child: Text(
                          'Calcular',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25.0),
                        ),
                        color: Colors.green,
                        onPressed: (){
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        }),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }
}
