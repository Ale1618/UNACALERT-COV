import 'dart:convert';

import 'package:covid19/core/consts.dart';
import 'package:covid19/datasource.dart';
import 'package:covid19/paginas/PaginaPaises.dart';
import 'package:covid19/paginas/info_pagina.dart';
import 'package:covid19/panels/infoPanel.dart';
import 'package:covid19/panels/paisesmasafectados.dart';
import 'package:covid19/panels/panelmundial.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map DatosMundo;
  buscarDatosdelMundo() async {
    http.Response response = await http.get('https://disease.sh/v2/all');
    setState(() {
      DatosMundo = json.decode(response.body);
    });
  }

  List DatosPaises;
  buscarDatosPorPaises() async {
    http.Response response =
        await http.get('https://disease.sh/v2/countries?sort=cases');
    setState(() {
      DatosPaises = json.decode(response.body);
    });
  }


  Future buscarDatos() async {
    buscarDatosdelMundo();
    buscarDatosPorPaises();
    print('Actualizacion realizada');
  }

  @override
  void initState() {
    buscarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.highlight
                  : Icons.lightbulb_outline),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              }),

          //icono agregado para la info
          IconButton(icon: Icon(Icons.info_outline), onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => PaginaInfo()),
                );
          })
          //

        ],
        centerTitle: false,
        title: Text('Covid-19'),
      ),
      body: RefreshIndicator(
        onRefresh: buscarDatos,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 115,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25) ,
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              color: Colors.teal,
              ),
              child: Text(
                DataSource.quote,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                textAlign: TextAlign.justify,
              ),
            ),

            //
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  text: "Sintomas del ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blueGrey,
                  ),
                  children: [
                    TextSpan(
                      text: "COVID 19",
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),
            Container(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _buildSintomasItem("images/1.png", "Fiebre"),
                  _buildSintomasItem("images/2.png", "Tos seca"),
                  _buildSintomasItem("images/3.png", "Dolor de cabeza"),
                  _buildSintomasItem("images/4.png", "Agitación"),
                ],
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Prevención",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blueGrey,
                ),
              ),
            ),

            SizedBox(height: 20),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _buildPrevencion(
                      "images/a10.png", "Lavarse", "las manos \na menudo"),
                  _buildPrevencion("images/a4.png", "Cubrise", "al toser"),
                  _buildPrevencion("images/a6.png", "Desinfectar", "frecuente-\nmente"),
                  _buildPrevencion("images/a9.png", "Usar", "mascarilla"),
                ],
              ),
            ),

            //

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'En el Mundo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaginaPaises()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Paises',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            DatosMundo == null
                ? CircularProgressIndicator()
                : PanelMundial(
                    DatosMundo: DatosMundo,
                  ),


            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Text(
                'Paises más afectados',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DatosPaises == null
                ? Container()
                : PanelMasAfectados(
                    DatosPaises: DatosPaises,
                  ),
            InfoPanel(),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Juntos en la lucha',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            Center(
                child: Text(
              'By Ale :)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 50,
            )
          ],
        )),
      ),
    );
  }

  Widget _buildPrevencion(String path, String text1, String text2) {
    return Column(
      children: <Widget>[
        Container(
          width: 170,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Image.asset(path),
              SizedBox(width: 10),
              RichText(
                text: TextSpan(
                    text: "$text1\n",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: text2,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ]),
              )
            ],
          ),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget _buildSintomasItem(String path, String text) {
    return Column(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.backgroundColor,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
          ),
          padding: EdgeInsets.only(top: 15),
          child: Image.asset(path),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
        Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
