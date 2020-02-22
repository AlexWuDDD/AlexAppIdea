import 'package:bin2dec/utils.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:strings/strings.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Bin2Dec",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            "Bin2Dec",
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

  String _errorStr = '';



  String ChangeToBinary(String input){
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
    int ret = 0;
    var runes = input.runes;
    for(int i = 0; i < runes.length; ++i){
      if(runes.elementAt(i)^ 0x30 == 1){
        ret = (ret + 1)*2;
      }
    }
    return ret.toString();
  }

  @override
  void initState(){
    _binaryController.addListener(
        (){
          debugPrint('Binary Input: ${_binaryController.text}');
          if(_binaryController.text.isEmpty){
            setState(() {
              _DecController.text = '';
            });
            return;
          }
          if(isZEROorONE(_binaryController.text)){
            setState(() {
              this._errorStr = '';
            });
            if(_binaryFocus.hasFocus) {
              setState(() {
                _DecController.text = ChangeToDec(_binaryController.text);
              });
            }
          }
          else{
            print('please input 0 or 1');
            setState(() {
              this._errorStr = 'please input 0 or 1';
            });

          }

        }
    );
    _DecController.addListener(
        (){
          debugPrint('Dec Input: ${_DecController.text}');
          setState(() {
            this._errorStr = '';
          });
          if(_DecController.text.isEmpty){
            setState(() {
              _binaryController.text = '';
            });
            return;
          }

          if(StringUtils.isDigit(_DecController.text)){

            if(_DecFoucus.hasFocus) {
              setState(() {
                _binaryController.text = ChangeToBinary(_DecController.text);
              });
            }
          }
          else{
            setState(() {
              this._errorStr = 'please input numbers';
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
      child: TextField(
        focusNode: this._binaryFocus,
        controller: this._binaryController,
        decoration: InputDecoration(
            hintText: "Please input binary",
            border: OutlineInputBorder(),
            labelText: "Binary,"
        ),
      ),
    );
  }

  Widget _DecInput() => Padding(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    child: TextField(
      focusNode: this._DecFoucus,
      controller: this._DecController,
      decoration: InputDecoration(
          hintText: "Please input numbers",
          border: OutlineInputBorder(),
          labelText: "Number",
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        this._BinaryInput(),
        this._DecInput(),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: <Widget>[
              Text(
                this._errorStr.isEmpty?"": "Error: " + this._errorStr,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}





