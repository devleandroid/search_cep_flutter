

import 'package:flutter/material.dart';
import 'package:search_cep/services/via_cep_service.dart';
import 'package:toast/toast.dart';


class HomePage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String _result;

  String _cepController = "";
  String _logradouroController = "";
  String _complementoController = "";
  String _bairroController = "";
  String _localidadeController = "";
  String _ufController = "";


  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Cep"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildSearchCepTextFild(),
          _buildSearchCepButton(),
          _buildResultFrom()
        ],
      ),),
    );

  }

  Widget _buildSearchCepTextFild() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: "Cep", hintText: 'Digite o cep que deseja pesquisar.', labelStyle: TextStyle(color: Colors.black87),),
      controller: _searchCepController,
      enabled: _enableField,
      maxLength: 8,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: RaisedButton(
        onPressed: _searchCep,
        child: _loading ? _circularLoading() : Text('Consultar', style: new TextStyle(fontWeight: FontWeight.bold),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((10))),
        color: Colors.white60,
      ),
    );
  }

  void _searching(bool enable){
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _buildResultFrom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildText("Resultado " , 20.0),
          ],
        ),
        _buildText("Cep: $_cepController", 15.0),
        _buildText("Logradouro: $_logradouroController", 15.0),
        _buildText("Complemento: $_complementoController", 15.0),
        _buildText("Bairro: $_bairroController", 15.0),
        _buildText("Localidade: $_localidadeController", 15.0),
        _buildText("Uf: $_ufController", 15.0),
      ],
    );
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    final cep = _searchCepController.text;

    if(cep.isNotEmpty){
      _searching(true);
      final resultCep = await ViaCepService.fetchCep(cep: cep);
      //_result = resultCep.toJson();
      if(resultCep.cep != null){
        //print(resultCep.localidade); // Exibe somente a localidade
        _searchCepController.text = '';
        setState(() {
          _cepController = resultCep.cep;
          _logradouroController = resultCep.logradouro;
          _complementoController = resultCep.complemento;
          _bairroController = resultCep.bairro;
          _localidadeController = resultCep.localidade;
          _ufController = resultCep.uf;
        });
      } else {
        _showToast('Erro na Consulta!');
      }
    } else {
      _showToast('Campo Vazio!');
    }
    _searching(false);
  }

  Widget _buildText(String text, double fontSize) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
      child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontSize: fontSize
          )
      ),
    );
  }

  Future _showToast(String msg) {
    Toast.show(msg, context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG, textColor: Colors.lime);
  }

  void _showSnackBar(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text('Resultado: $msg'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          // print('Undo Delete of $message');
          setState(() {

          });
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
