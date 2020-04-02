import 'package:flutter/material.dart';
import 'package:testnorthapp/travelerinfo.dart';

import 'local.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var _pageController;
  var _tabBarController;
  var _heightBlackContainer;

  List<Local> locais = [
    Local("assets/images/godfoss.jpg", "Goðafoss", "Godafoss é uma queda de água da Islândia, situada na região de Nordurland Eystra, no nordeste do país. Tem uma altura de 12 m e uma largura de 30m, e transporta a água do rio Skjálfandafljót proveniente do glaciar Vatnajökull.", "5°C"),
    Local("assets/images/faxi.jpg", "Faxi", "A cachoeira Faxi está localizada no Círculo Dourado, uma popular trilha turística a leste de Reykjavik. A cachoeira está localizada no rio Tungufljót.", "16°C"),
    Local("assets/images/pingvellir.png", "Þingvellir", "Þingvellir ou Thingvellir é um vale situado no sudeste da Islândia, considerado um dos lugares históricos mais importantes do país.", "11°C"),
    Local("assets/images/jokulsarlon.png", "Jökulsárlón", "O Jökulsárlón é um lago glacial da Islândia, localizado a sul do glaciar Vatnajökull, junto a uma praia de areia negra, que dá para o Oceano Atlântico. Tem uma área de 18 km² e uma profundidade máxima de 284 m. O lago recebe blocos de gelo – icebergs – provenientes do glaciar Vatnajökull.", "23°C"),
  ];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.6);
    _tabBarController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Stack(
          children: <Widget>[_blackContainer(), _containerPageView()],
        ),
      ),
    );
  }

  _containerPageView() {
    return Positioned.fill(
        top: MediaQuery.of(context).size.height / 3.1,
        child: Container(
            margin: EdgeInsets.only(left: 32),
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _tabBarLocais(),
                _pageViewContainer(),
                _categoryContainer()
              ],
            )));
  }

  _blackContainer() {
    return Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32))),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            _heightBlackContainer = constraints.maxHeight;
            return Column(
              children: <Widget>[_toolBar(), _title()],
            );
          },
        ));
  }

  _toolBar() {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 35,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  _title() {
    return Container(
      width: double.maxFinite,
      height: _heightBlackContainer / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Explore north",
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            "secret places",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
    );
  }

  _tabBarLocais() {
    return TabBar(
      tabs: [
        Tab(
          child: Text("Iceland"),
        ),
        Tab(
          child: Text("Greenland"),
        ),
        Tab(
          child: Text("Norway"),
        )
      ],
      isScrollable: true,
      controller: _tabBarController,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
        width: 4,
        color: Colors.cyan,
      )),
      indicatorWeight: 4,
      labelStyle: TextStyle(fontSize: 18),
    );
  }

  _pageViewContainer() {
    return Expanded(
      flex: 7,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: double.maxFinite,
        child: PageView.builder(
            controller: _pageController,
            itemCount: locais.length,
            itemBuilder: (c, i) {
              return _pageViewCell(locais[i]);
            }),
      ),
    );
  }

  _categoryContainer() {
    return Expanded(
        flex: 4,
        child: Container(
          padding: EdgeInsets.only(top: 20, right: 20),
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Category",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 30,
                    color: Colors.grey,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    _categoryCell(Icon(Icons.terrain)),
                    _categoryCell(Icon(Icons.details)),
                    _categoryCell(Icon(Icons.filter_vintage)),
                    _categoryCell(Icon(Icons.fastfood))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _pageViewCell(Local local) {
    return Hero(
      tag: local.nome,
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => TravelerInfo(local))),
          child: Container(
            padding: EdgeInsets.only(right: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                  child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    local.image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 15, left: 20),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        local.nome,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  _categoryCell(Icon icon) {
    return Container(
      color: Color(0xffE8E8E8),
      width: 65,
      height: 65,
      child: Center(
        child: icon,
      ),
    );
  }
}
