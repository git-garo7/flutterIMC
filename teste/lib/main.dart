import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(
      home:Home() ,
    ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _FormKey  = GlobalKey<FormState>();

  String _infoText = "informe seu peso e altura! ";//tell your weight and height!

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
       _infoText = "Inform your height and weight";//informe seu peso e altura
    });
    
  } //dei nulo pra peso  e altura,(botão de reset)

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) /100;
    double imcbmi = weight / (height * height);
    print(imcbmi);
    if (imcbmi < 18.6){
      _infoText = "Under weight(${imcbmi.toStringAsPrecision(3)})";//abaixo do peso
    }else if (imcbmi >= 18.6 && imcbmi < 24.9){
      _infoText = " Ideal weight(${imcbmi.toStringAsPrecision(3)})";//Peso ideal
    }else if(imcbmi >= 24.9 && imcbmi < 29.9){
      _infoText = "Slightly overweight(${imcbmi.toStringAsPrecision(3)})";//Levemente acima do peso
    }else if(imcbmi >= 29.9 && imcbmi < 34.9){
      _infoText = "Grade I obesity(${imcbmi.toStringAsPrecision(3)})";//Obesidade grauI
    }else if(imcbmi >= 34.9 && imcbmi < 39.9){
      _infoText = "Grade II obesity(${imcbmi.toStringAsPrecision(3)})";//Obesidade grauII
    }else if(imcbmi >= 40 ){
      _infoText = "Grade III obesity(${imcbmi.toStringAsPrecision(3)})";}//Obesidade grauIII
      
      
      
      
    });
    
  }//peguei o peso e dividi pela altura ao quadrado.I took the weight and divided it by the height squared
 // divide-se por /100,pra passar de metros(m)pra centímetros(cm)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("calculo de IMC"),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        actions:<Widget> [
          IconButton(icon: Icon(Icons.refresh),
        onPressed: _resetFields, )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
        child: Form(
          key: _FormKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Icon(Icons.person_outline,size: 120.0,color: Colors.yellow),
          TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Weight(kg)",
            labelStyle: TextStyle(color:Colors.yellow)
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color:Colors.yellow,fontSize: 25.0),//can change text color and size over here
          controller: weightController,
          validator: (value){
            if(value.isEmpty){
              return "enter your weight!!!";//insira seu peso!!!
            }
          },
          ),
            TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "height(cm)",
            labelStyle: TextStyle(color:Colors.yellow)
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color:Colors.yellow,fontSize: 25.0),//pode alterar cor aqui e tamanho de texto*can change text color and size over here
          controller: heightController,
          validator: (value){
            if(value.isEmpty){
              return "enter your height!!!";//insira sua altura!!!
            }
          },
          ),
         Padding(
           padding:EdgeInsets.only(top:10.0,bottom:10.0),
           child: Container(//container pra definir altura*container to set height
           height: 50.0,
           child: RaisedButton(
            onPressed:(){
              if(_FormKey.currentState.validate()){
                _calculate();
              }
            },
            child: Text("Calculate",
            style: TextStyle(color:Colors.white,fontSize: 27.0),),//botão de calcular*calculate button
            color: Colors.yellow,
          ) ,
         ) ,
         ),
         Text(
           _infoText,
         textAlign:TextAlign.center,
         style: TextStyle(color: Colors.red,fontSize: 25.0),)
        ],
      ),
        ),
      ),
         
    );
  }//scaffold para barras,facilita bastante
}