import 'package:flutter/material.dart';
import 'package:testnorthapp/local.dart';

class TravelerInfo extends StatefulWidget {
  Local localSelecionado;
  TravelerInfo(this.localSelecionado);

  @override
  _TravelerInfoState createState() => _TravelerInfoState();
}

class _TravelerInfoState extends State<TravelerInfo>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> moveDown;
  Animation<double> moveUp;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _initilized());

    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    moveDown = Tween<double>(begin: -50, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    moveUp = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _initilized() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
            tag: widget.localSelecionado.nome,
            child: SizedBox.expand(
              child: Image.asset(
                widget.localSelecionado.image,
                fit: BoxFit.cover,
              ),
            )),
        Positioned.fill(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _toolBar(),
            Spacer(),
            AnimatedBuilder(
                child: _nameAndDescription(),
                animation: moveDown,
                builder: (c, ch) {
                  return Transform.translate(
                    offset: Offset(0.0, moveDown.value),
                    child: Opacity(opacity: opacityAnimation.value, child: ch),
                  );
                }),
            AnimatedBuilder(
                child: _moreDetailsContainer(),
                animation: moveUp,
                builder: (c, ch) {
                  return Transform.translate(
                    offset: Offset(0, moveUp.value),
                    child: Opacity(opacity: opacityAnimation.value ,child: ch),
                  );
                })
          ],
        ))
      ],
    ));
  }

  _toolBar() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      height: 60,
      child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context)),
    );
  }

  _nameAndDescription() {
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_temperatureContainer(), _nameAndDescContainer()],
      ),
    );
  }

  _temperatureContainer() {
    return Container(
      width: 100,
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.ac_unit,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            widget.localSelecionado.temperature,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }

  _nameAndDescContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.localSelecionado.nome,
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.localSelecionado.description,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }

  _moreDetailsContainer() {
    var containerHeight = MediaQuery.of(context).size.height / 11.5;

    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
      height: containerHeight,
      child: Row(
        children: <Widget>[
          _terrainButton(containerHeight),
          _showMoreButton(containerHeight)
        ],
      ),
    );
  }

  _terrainButton(var containerHeight) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white38),
      width: containerHeight,
      height: containerHeight,
      child: Icon(
        Icons.terrain,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  _showMoreButton(var containerHeight) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        height: containerHeight,
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: <Widget>[
            Text(
              "Show more...",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              size: 30,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
