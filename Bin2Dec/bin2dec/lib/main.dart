import 'package:bin2dec/utils.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:strings/strings.dart';

void main() => runApp(MyApp());

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: "Bin<=>Dec",
//      home: Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          backgroundColor: Colors.red,
//          title: Text(
//            "Bin <-> Dec",
//            style: TextStyle(
//              fontSize: 30,
//              fontWeight: FontWeight.bold,
//            ),
//          ),
//
//        ),
//        body: Bin2Dec(),
//      ),
//    );
//  }
//}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Bin<=>Dec",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            "Bin <-> Dec",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),
        body: Bin2Dec(),
      ),
    );
  }
}

class Bin2Dec extends StatefulWidget {
  @override
  _Bin2DecState createState() => _Bin2DecState();
}


class _Bin2DecState extends State<Bin2Dec> {

  final TextEditingController _binaryController = TextEditingController();
  final TextEditingController _DecController = TextEditingController();
  final FocusNode _binaryFocus = FocusNode();
  final FocusNode _DecFoucus = FocusNode();

  String ChangeToBinary(String input){
    if(input.isEmpty){
      return "0";
    }
    int nums = int.parse(input);
    if(nums == 0){
      return "0";
    }
    String ret = "";
    while(nums != 0){
      ret = ret + (nums%2).toString();
      nums = nums ~/ 2;
    }
    return reverse(ret);
  }

  String ChangeToDec(String input){
    print("ChangeToDec: ${input}");
    int ret = 0;
    var runes = input.runes;
    for(int i = 0; i < runes.length; ++i){
      if(runes.elementAt(i)^ 0x30 == 1){
        print("It's one");
        ret = ret*2 + 1;
      }
      if(runes.elementAt(i) ^ 0x30 == 0){
        print("It's zero");
        ret = ret*2 + 0;
      }
    }
    return ret.toString();
  }

  @override
  void initState(){
    _binaryController.addListener(
        (){
          if(_binaryController.text.isEmpty){
            setState(() {
              _DecController.text = '';
            });
            return;
          }

          if(_binaryFocus.hasFocus) {
            setState(() {
              _DecController.text = ChangeToDec(_binaryController.text);
            });
          }
        }
    );
    _DecController.addListener(
        (){
          if(_DecController.text.isEmpty){
            setState(() {
              _binaryController.text = '';
            });
            return;
          }

          if(_DecFoucus.hasFocus) {
            setState(() {
              _binaryController.text = ChangeToBinary(_DecController.text);
            });
          }
        }
    );
  }

  @override
  void dispose(){
    _binaryController.dispose();
    _DecController.dispose();
    _binaryFocus.dispose();
    _DecFoucus.dispose();
    super.dispose();
  }


  Widget _BinaryInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: TextFormField(
        focusNode: this._binaryFocus,
        controller: this._binaryController,
        decoration: InputDecoration(
            hintText: "Please input binary",
            border: OutlineInputBorder(),
            labelText: "Binary,"
        ),
        autovalidate: true,
        validator: (String val){
          if(val.isEmpty) return null;
          if(!isZEROorONE(val)) {
            return "please input 0 or 1";
          }
          return null;

        },
      ),
    );
  }

  get _DecInput => Padding(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    child: TextFormField(
      focusNode: this._DecFoucus,
      controller: this._DecController,
      decoration: InputDecoration(
          hintText: "Please input numbers",
          border: OutlineInputBorder(),
          labelText: "Number",
      ),
      autovalidate: true,
      validator: (String val){
        if(val.isEmpty) return null;
        
        try {
          if(!StringUtils.isDigit(val)){
            return "please input numbers";
          }
          return null;
        } on Exception catch (e) {
          return null;
        }
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        this._BinaryInput(),
        this._DecInput,
        Divider(),
      ],
    );
  }
}





