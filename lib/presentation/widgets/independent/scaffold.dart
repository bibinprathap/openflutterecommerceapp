//Scaffold for Open Flutter E-commerce App
//Author: openflutterproject@gmail.com
//Date: 2020-02-06
import 'dart:convert';
import 'dart:typed_data';
import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:openflutterecommerce/config/AlgoliaApplication.dart';
import 'package:openflutterecommerce/config/routes.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/presentation/features/product_details/product_screen.dart';

import '../widgets.dart';
import 'base_product_tile.dart';

class OpenFlutterScaffold extends StatelessWidget {
  final Color background;
  final String title;
  final Widget body;
  final int bottomMenuIndex;
  final List<String> tabBarList;
  final TabController tabController;

  const OpenFlutterScaffold(
      {Key key,
      this.background,
      @required this.title,
      @required this.body,
      @required this.bottomMenuIndex,
      this.tabBarList,
      this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tabBars = <Tab>[];
    var _theme = Theme.of(context);
    if (tabBarList != null) {
      for (var i = 0; i < tabBarList.length; i++) {
        tabBars.add(Tab(key: UniqueKey(), text: tabBarList[i]));
      }
    }
    Widget tabWidget = tabBars.isNotEmpty
        ? TabBar(
            unselectedLabelColor: _theme.primaryColor,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            labelColor: _theme.primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: tabBars,
            controller: tabController,
            indicatorColor: _theme.accentColor,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab)
        : null;
    return Scaffold(
      backgroundColor: background,
      appBar: title != null
          ? AppBar(title: Text(title), bottom: tabWidget, actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  })
            ])
          : null,
      body: body,
      drawer: Drawer(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
        //     child: new ListView(children: <Widget>[
        //   InkWell(
        //     onTap: () {},
        //     child: ListTile(
        //       title: Text('Home Page'),
        //       leading: Icon(
        //         Icons.home,
        //         color: Colors.blueGrey,
        //       ),
        //     ),
        //   ),

        // ])
      ),
      bottomNavigationBar: OpenFlutterBottomMenu(bottomMenuIndex),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry({this.title, this.url, this.submenu, this.image});

  final String title;
  final String url;
  final String image;
  final List<Entry> submenu;
}

class CategoryDef {
  CategoryDef({this.name, this.slug, this.children, this.image, this.items});

  final String name;
  final String slug;
  final String image;
  final int items;
  final List<CategoryDef> children;
}

final List<CategoryDef> shopCategoriesDef = <CategoryDef>[
  CategoryDef(
      name: 'IDLER',
      slug: 'IDLER',
      image: 'assets/categories/IDLER.jpg',
      items: 106,
      children: [
        CategoryDef(name: "IDLER", slug: "IDLER"),
        CategoryDef(name: "IGNITION", slug: "IGNITION"),
        CategoryDef(name: "INDICATOR", slug: "INDICATOR"),
        CategoryDef(name: "INJECTOR", slug: "INJECTOR"),
        CategoryDef(name: "INSERT", slug: "INSERT"),
        CategoryDef(name: "INSTRUMENT", slug: "INSTRUMENT"),
        CategoryDef(name: "INSULATOR", slug: "INSULATOR"),
        CategoryDef(name: "INTAKE", slug: "INTAKE"),
        CategoryDef(name: "INTERIOR", slug: "INTERIOR")
      ]),
  CategoryDef(
    name: 'ELECTRICAL',
    slug: 'ELECTRICAL',
    image: 'assets/categories/Electrical.jpg',
    items: 508,
    children: [
      CategoryDef(name: "ELECTRICAL", slug: "ELECTRICAL"),
      CategoryDef(name: "ELEMENT", slug: "ELEMENT"),
      CategoryDef(name: "EMBLEM", slug: "EMBLEM"),
      CategoryDef(name: "END", slug: "END"),
      CategoryDef(name: "ENGINE", slug: "ENGINE"),
      CategoryDef(name: "EVAPORATOR", slug: "EVAPORATOR"),
      CategoryDef(name: "EXHAUST", slug: "EXHAUST"),
      CategoryDef(name: "EXPANSION", slug: "EXPANSION"),
      CategoryDef(name: "EXTENSION", slug: "EXTENSION"),
    ],
  ),
  CategoryDef(
      name: 'MIRROR',
      slug: 'MIRROR',
      image: 'assets/categories/MIRROR.jpg',
      items: 106,
      children: [
        CategoryDef(name: "MIRROR", slug: "MIRROR"),
        CategoryDef(name: "MODULE", slug: "MODULE"),
        CategoryDef(name: "MOLDING", slug: "MOLDING"),
        CategoryDef(name: "MOTOR", slug: "MOTOR"),
        CategoryDef(name: "MOUDLING", slug: "MOUDLING"),
        CategoryDef(name: "MOULDING", slug: "MOULDING"),
        CategoryDef(name: "MOUNT", slug: "MOUNT"),
        CategoryDef(name: "MOUNTING", slug: "MOUNTING"),
        CategoryDef(name: "MUD", slug: "MUD"),
        CategoryDef(name: "MULTIRIB", slug: "MULTIRIB")
      ]),
  CategoryDef(
      name: 'THERMOSTAT AND HOUSING ',
      slug: 'THERMOSTAT-AND-HOUSING',
      image: 'assets/categories/THERMOSTAT-AND-HOUSING.png',
      items: 106,
      children: [
        CategoryDef(name: "TANK", slug: "TANK"),
        CategoryDef(name: "TENSIONER", slug: "TENSIONER"),
        CategoryDef(name: "THERMOSTAT", slug: "THERMOSTAT"),
        CategoryDef(
            name: "THERMOSTAT AND HOUSING", slug: "THERMOSTAT-AND-HOUSING"),
        CategoryDef(name: "THROTTLE", slug: "THROTTLE"),
        CategoryDef(name: "THRUST", slug: "THRUST"),
        CategoryDef(name: "TIE ROD", slug: "TIE-ROD"),
        CategoryDef(name: "TIMING", slug: "TIMING"),
        CategoryDef(name: "TIMING CHAIN", slug: "TIMING-CHAIN"),
        CategoryDef(name: "TIRROD", slug: "TIRROD"),
        CategoryDef(name: "TRACK ROD", slug: "TRACK-ROD"),
        CategoryDef(name: "TRANSMISSION", slug: "TRANSMISSION"),
        CategoryDef(name: "TRIM", slug: "TRIM"),
        CategoryDef(name: "TRUNK", slug: "TRUNK"),
        CategoryDef(name: "TUBE", slug: "TUBE"),
        CategoryDef(name: "TURBO", slug: "TURBO"),
        CategoryDef(name: "TURN", slug: "TURN"),
        CategoryDef(name: "TYPE", slug: "TYPE"),
        CategoryDef(name: "TYRE", slug: "TYRE"),
        CategoryDef(name: "TYRE LINER", slug: "TYRE-LINER")
      ]),
  CategoryDef(
    name: 'A/C',
    slug: 'AC',
    image: 'assets/categories/FAN.jpg',
    items: 131,
    children: [
      CategoryDef(slug: "ABSORBER", name: "ABSORBER"),
      CategoryDef(slug: "AC-ASSY", name: "ACASSY"),
      CategoryDef(slug: "AC-BELT", name: "AC BELT"),
      CategoryDef(slug: "AC-BLOWER", name: "AC BLOWER"),
      CategoryDef(slug: "AC-BLOWER-MOTOR", name: "AC BLOWER MOTOR"),
      CategoryDef(slug: "AC-COMPRESSOR", name: "AC COMPRESSOR"),
      CategoryDef(slug: "AC-CONDENSER", name: "AC CONDENSER"),
      CategoryDef(slug: "AC-DRIER", name: "AC DRIER"),
      CategoryDef(slug: "AC-FAN", name: "AC FAN"),
      CategoryDef(slug: "ACCELERATOR", name: "ACCELERATOR"),
      CategoryDef(slug: "ACCUMUALTOR", name: "ACCUMUALTOR"),
      CategoryDef(slug: "ACTUATOR", name: "ACTUATOR"),
      CategoryDef(slug: "ADAPTER", name: "ADAPTER"),
      CategoryDef(slug: "ADDITIONAL", name: "ADDITIONAL"),
      CategoryDef(slug: "ADJUSTER", name: "ADJUSTER"),
      CategoryDef(slug: "AIR", name: "AIR"),
      CategoryDef(slug: "ALTERNATOR", name: "ALTERNATOR"),
      CategoryDef(slug: "ALTERNATOR ", name: "ALTERNATOR "),
      CategoryDef(slug: "AMPLIFIER", name: "AMPLIFIER"),
      CategoryDef(slug: "ANTENNA", name: "ANTENNA"),
      CategoryDef(slug: "ANTI-FREEZE", name: "ANTIFREEZE"),
      CategoryDef(slug: "ARM", name: "ARM"),
      CategoryDef(slug: "ASA-BOLT", name: "ASA BOLT"),
      CategoryDef(slug: "ASA-SCREW", name: "ASA SCREW"),
      CategoryDef(slug: "ASA-BOLT", name: "ASA-BOLT"),
      CategoryDef(slug: "ASHTRAY", name: "ASHTRAY"),
      CategoryDef(slug: "ATF", name: "ATF"),
      CategoryDef(slug: "AUDIO", name: "AUDIO"),
      CategoryDef(slug: "AUXILARY", name: "AUXILARY"),
      CategoryDef(slug: "AXLE", name: "AXLE")
    ],
  ),
  CategoryDef(
    name: 'BADGE',
    slug: 'BADGE',
    image: 'assets/categories/BADGE.jpg',
    items: 356,
    children: [
      CategoryDef(name: "BADGE", slug: "BADGE"),
      CategoryDef(name: "BAFFLE", slug: "BAFFLE"),
      CategoryDef(name: "BALL", slug: "BALL"),
      CategoryDef(name: "BALL JOINT", slug: "BALL-JOINT"),
      CategoryDef(name: "BAR", slug: "BAR"),
      CategoryDef(name: "BASE", slug: "BASE"),
      CategoryDef(name: "BASIC", slug: "BASIC"),
      CategoryDef(name: "BATTERY", slug: "BATTERY"),
      CategoryDef(name: "BAZEL", slug: "BAZEL"),
      CategoryDef(name: "BEAM", slug: "BEAM"),
      CategoryDef(name: "BEARING", slug: "BEARING"),
      CategoryDef(name: "BELLOWS", slug: "BELLOWS"),
      CategoryDef(name: "BELT", slug: "BELT"),
      CategoryDef(name: "BLADE", slug: "BLADE"),
      CategoryDef(name: "BLINKER", slug: "BLINKER"),
      CategoryDef(name: "BLOWER", slug: "BLOWER"),
      CategoryDef(name: "BODY", slug: "BODY"),
      CategoryDef(name: "BOLT", slug: "BOLT"),
      CategoryDef(name: "BONET", slug: "BONET"),
      CategoryDef(name: "BOOT", slug: "BOOT"),
      CategoryDef(name: "BOWDEN CABLE", slug: "BOWDEN-CABLE"),
      CategoryDef(name: "BRACKET", slug: "BRACKET"),
      CategoryDef(name: "BRAKE", slug: "BRAKE"),
      CategoryDef(name: "BRAKE PAD", slug: "BRAKE-PAD"),
      CategoryDef(name: "BREATHER", slug: "BREATHER"),
      CategoryDef(name: "BRG", slug: "BRG"),
      CategoryDef(name: "BUFFER", slug: "BUFFER"),
      CategoryDef(name: "BULB", slug: "BULB"),
      CategoryDef(name: "BUMPER", slug: "BUMPER"),
      CategoryDef(name: "BUSH", slug: "BUSH")
    ],
  ),
  CategoryDef(
    name: 'CABLE',
    slug: 'CABLE',
    image: 'assets/categories/cable.jpg',
    items: 54,
    children: [
      CategoryDef(name: "CABLE", slug: "CABLE"),
      CategoryDef(name: "CALIPER", slug: "CALIPER"),
      CategoryDef(name: "CAMERA", slug: "CAMERA"),
      CategoryDef(name: "CAP", slug: "CAP"),
      CategoryDef(name: "CARRIER", slug: "CARRIER"),
      CategoryDef(name: "CASE", slug: "CASE"),
      CategoryDef(name: "CATALYST CONVERTER", slug: "CATALYST-CONVERTER"),
      CategoryDef(name: "CATCH", slug: "CATCH"),
      CategoryDef(name: "CENTER", slug: "CENTER"),
      CategoryDef(name: "CHAIN", slug: "CHAIN"),
      CategoryDef(name: "CHANNEL", slug: "CHANNEL"),
      CategoryDef(name: "CHARGE", slug: "CHARGE"),
      CategoryDef(name: "CHASSIS", slug: "CHASSIS"),
      CategoryDef(name: "CHECK ASSY", slug: "CHECK-ASSY"),
      CategoryDef(name: "CHROME", slug: "CHROME"),
      CategoryDef(name: "CLAMP ", slug: "CLAMP"),
      CategoryDef(name: "CLIP", slug: "CLIP"),
      CategoryDef(name: "CLUTCH", slug: "CLUTCH"),
      CategoryDef(name: "CLY ASSY", slug: "CLY-ASSY"),
      CategoryDef(name: "COIL", slug: "COIL"),
      CategoryDef(name: "COMBI SWITCH", slug: "COMBI-SWITCH"),
      CategoryDef(name: "COMBINATION", slug: "COMBINATION"),
      CategoryDef(name: "COMPRESSION", slug: "COMPRESSION"),
      CategoryDef(name: "COMPRESSOR", slug: "COMPRESSOR"),
      CategoryDef(name: "COMPUTER", slug: "COMPUTER"),
      CategoryDef(name: "CONDENSER ", slug: "CONDENSER "),
      CategoryDef(name: "CONNECTING", slug: "CONNECTING"),
      CategoryDef(name: "CONNECTOR", slug: "CONNECTOR"),
      CategoryDef(name: "CONSOLE", slug: "CONSOLE"),
      CategoryDef(name: "CONTACT", slug: "CONTACT"),
      CategoryDef(name: "CONTROL", slug: "CONTROL"),
      CategoryDef(name: "CONVERTER", slug: "CONVERTER"),
      CategoryDef(name: "COOLANT", slug: "COOLANT"),
      CategoryDef(name: "COOLENT", slug: "COOLENT"),
      CategoryDef(name: "COOLER", slug: "COOLER"),
      CategoryDef(name: "COOLING", slug: "COOLING"),
      CategoryDef(name: "COUPLING", slug: "COUPLING"),
      CategoryDef(name: "COVER", slug: "COVER"),
      CategoryDef(name: "CRANK", slug: "CRANK"),
      CategoryDef(name: "CROSS", slug: "CROSS"),
      CategoryDef(name: "CUP", slug: "CUP"),
      CategoryDef(name: "CUSHION", slug: "CUSHION"),
      CategoryDef(name: "CUT BUSH", slug: "CUT-BUSH"),
      CategoryDef(name: "CV JOINT", slug: "CV-JOINT"),
      CategoryDef(name: "CYLENDER", slug: "CYLENDER"),
      CategoryDef(name: "CYLINDER", slug: "CYLINDER"),
    ],
  ),
  CategoryDef(
    name: 'DAMPER',
    slug: 'DAMPER',
    image: 'assets/categories/DAMPER.jpg',
    items: 274,
    children: [
      CategoryDef(name: "DAMPER", slug: "DAMPER"),
      CategoryDef(name: "DASHBOARD", slug: "DASHBOARD"),
      CategoryDef(name: "DEFLECTION", slug: "DEFLECTION"),
      CategoryDef(name: "DEFLECTOR", slug: "DEFLECTOR"),
      CategoryDef(name: "DELIVERY UNIT", slug: "DELIVERY-UNIT"),
      CategoryDef(name: "DICKY", slug: "DICKY"),
      CategoryDef(name: "DISC", slug: "DISC"),
      CategoryDef(name: "DISTRIBUTION", slug: "DISTRIBUTION"),
      CategoryDef(name: "DME", slug: "DME"),
      CategoryDef(name: "DOOR", slug: "DOOR"),
      CategoryDef(name: "DOWEL", slug: "DOWEL"),
      CategoryDef(name: "DRIER", slug: "DRIER"),
      CategoryDef(name: "DRIVE", slug: "DRIVE"),
      CategoryDef(name: "DRUM", slug: "DRUM"),
    ],
  ),
  CategoryDef(
    name: 'FAN',
    slug: 'FAN',
    image: 'assets/categories/FAN.jpg',
    items: 95,
    children: [
      CategoryDef(name: "FAN", slug: "FAN"),
      CategoryDef(name: "FASTENER", slug: "FASTENER"),
      CategoryDef(name: "FENDER", slug: "FENDER"),
      CategoryDef(name: "FIILTER", slug: "FIILTER"),
      CategoryDef(name: "FILLER CAP", slug: "FILLER-CAP"),
      CategoryDef(name: "FILLER FLAP", slug: "FILLER-FLAP"),
      CategoryDef(name: "FILLER NECK", slug: "FILLER-NECK"),
      CategoryDef(name: "FILLER PIPE", slug: "FILLER-PIPE"),
      CategoryDef(
          name: "FILLER PIPE WASH CONTAINER",
          slug: "FILLER-PIPE-WASH-CONTAINER"),
      CategoryDef(name: "FILLER SUB ASSY", slug: "FILLER-SUB-ASSY"),
      CategoryDef(name: "FILL-IN FLAP", slug: "FILL-IN-FLAP"),
      CategoryDef(name: "FILLISTER", slug: "FILLISTER"),
      CategoryDef(name: "FILM", slug: "FILM"),
      CategoryDef(name: "FILTER", slug: "FILTER"),
      CategoryDef(name: "FINISHER", slug: "FINISHER"),
      CategoryDef(name: "FITTING", slug: "FITTING"),
      CategoryDef(name: "FLANGE", slug: "FLANGE"),
      CategoryDef(name: "FLAP", slug: "FLAP"),
      CategoryDef(name: "FLOOR", slug: "FLOOR"),
      CategoryDef(name: "FOG", slug: "FOG"),
      CategoryDef(name: "FRAME", slug: "FRAME"),
      CategoryDef(name: "FRONR", slug: "FRONR"),
      CategoryDef(name: "FRONT", slug: "FRONT"),
      CategoryDef(name: "FUEL", slug: "FUEL"),
      CategoryDef(name: "FUNNEL", slug: "FUNNEL"),
      CategoryDef(name: "FUSE", slug: "FUSE")
    ],
  ),
  CategoryDef(
      name: 'Oils & Lubricants',
      slug: 'oils-lubricants',
      image: 'assets/categories/Oils-Lubricants.jpeg',
      items: 179,
      children: [
        CategoryDef(name: "GASKET", slug: "GASKET"),
        CategoryDef(name: "GASKET", slug: "GASKET"),
        CategoryDef(name: "GEAR", slug: "GEAR"),
        CategoryDef(name: "GLASS", slug: "GLASS"),
        CategoryDef(name: "GLOW", slug: "GLOW"),
        CategoryDef(name: "GRID", slug: "GRID"),
        CategoryDef(name: "GRILL", slug: "GRILL"),
        CategoryDef(name: "GROMMET", slug: "GROMMET"),
        CategoryDef(name: "GUIDE", slug: "GUIDE"),
        CategoryDef(name: "HAND", slug: "HAND"),
        CategoryDef(name: "HARNESS", slug: "HARNESS"),
        CategoryDef(name: "HEAD", slug: "HEAD"),
        CategoryDef(name: "HEAT", slug: "HEAT"),
        CategoryDef(name: "HIGH PRESSURE", slug: "HIGH-PRESSURE"),
        CategoryDef(name: "HINGE", slug: "HINGE"),
        CategoryDef(name: "HOLDER", slug: "HOLDER"),
        CategoryDef(name: "HOOD", slug: "HOOD"),
        CategoryDef(name: "HOOK", slug: "HOOK"),
        CategoryDef(name: "HORN", slug: "HORN"),
        CategoryDef(name: "HOSE", slug: "HOSE"),
        CategoryDef(name: "HOUSING", slug: "HOUSING"),
        CategoryDef(name: "HUB", slug: "HUB"),
        CategoryDef(name: "HYDRAULIC", slug: "HYDRAULIC"),
      ]),
  CategoryDef(
      name: 'JOINT & KEY & LAMP',
      slug: 'JOINT-KEY-LAMP',
      image: 'assets/categories/JOINT-KEY-LAMP.jpg',
      items: 106,
      children: [
        CategoryDef(name: "JOINT", slug: "JOINT"),
        CategoryDef(name: "KEY", slug: "KEY"),
        CategoryDef(name: "KIT", slug: "KIT"),
        CategoryDef(name: "KNOB", slug: "KNOB"),
        CategoryDef(name: "KNUCKLE", slug: "KNUCKLE"),
        CategoryDef(name: "LAMP", slug: "LAMP"),
        CategoryDef(name: "LATCH", slug: "LATCH"),
        CategoryDef(name: "LATERAL", slug: "LATERAL"),
        CategoryDef(name: "LENS & BODY", slug: "LENS-&-BODY"),
        CategoryDef(name: "LEVER", slug: "LEVER"),
        CategoryDef(name: "LIGHT", slug: "LIGHT"),
        CategoryDef(name: "LINE", slug: "LINE"),
        CategoryDef(name: "LINK", slug: "LINK"),
        CategoryDef(name: "LOCK", slug: "LOCK"),
        CategoryDef(name: "LOGO", slug: "LOGO"),
        CategoryDef(name: "LOWER", slug: "LOWER")
      ]),
  CategoryDef(
      name: 'NOZZLE & OIL',
      slug: 'NOZZLE-OIL',
      image: 'assets/categories/NOZZLE-OIL.jpg',
      items: 106,
      children: [
        CategoryDef(name: "NAME PLATE", slug: "NAME-PLATE"),
        CategoryDef(name: "NOZZLE", slug: "NOZZLE"),
        CategoryDef(name: "NUMBER PLATE", slug: "NUMBER-PLATE"),
        CategoryDef(name: "NUT", slug: "NUT"),
        CategoryDef(name: "O - RING", slug: "O---RING"),
        CategoryDef(name: "OIL", slug: "OIL"),
        CategoryDef(name: "OIL ASSY", slug: "OIL-ASSY"),
        CategoryDef(name: "OIL CAP", slug: "OIL-CAP"),
        CategoryDef(name: "OIL COOLER", slug: "OIL-COOLER"),
        CategoryDef(name: "ORNAMENTAL", slug: "ORNAMENTAL"),
        CategoryDef(name: "OTHERS", slug: "OTHERS"),
      ]),
  CategoryDef(
      name: 'PANEL & RADIATOR ',
      slug: 'IDLER',
      image: 'assets/categories/PANEL-RADIATOR.jpg',
      items: 106,
      children: [
        CategoryDef(name: "PANEL", slug: "PANEL"),
        CategoryDef(name: "PIECE", slug: "PIECE"),
        CategoryDef(name: "PIN", slug: "PIN"),
        CategoryDef(name: "PIPE", slug: "PIPE"),
        CategoryDef(name: "PISTON", slug: "PISTON"),
        CategoryDef(name: "PLATE", slug: "PLATE"),
        CategoryDef(name: "PLUG", slug: "PLUG"),
        CategoryDef(name: "POWER", slug: "POWER"),
        CategoryDef(name: "PRESSURE", slug: "PRESSURE"),
        CategoryDef(name: "PROTECTOR", slug: "PROTECTOR"),
        CategoryDef(name: "PULLEY", slug: "PULLEY"),
        CategoryDef(name: "PULLY", slug: "PULLY"),
        CategoryDef(name: "PUMP", slug: "PUMP"),
        CategoryDef(name: "RACK", slug: "RACK"),
        CategoryDef(name: "RADIATOR", slug: "RADIATOR"),
        CategoryDef(name: "RAIL", slug: "RAIL"),
        CategoryDef(name: "REAR", slug: "REAR"),
        CategoryDef(name: "REFLECTOR", slug: "REFLECTOR"),
        CategoryDef(name: "REGISTER", slug: "REGISTER"),
        CategoryDef(name: "REGULATOR", slug: "REGULATOR"),
        CategoryDef(name: "REINFORCEMENT", slug: "REINFORCEMENT"),
        CategoryDef(name: "RELAY", slug: "RELAY"),
        CategoryDef(name: "RELEY", slug: "RELEY"),
        CategoryDef(name: "REPAIR KIT", slug: "REPAIR-KIT"),
        CategoryDef(name: "RESERVOIR", slug: "RESERVOIR"),
        CategoryDef(name: "RESISTOR", slug: "RESISTOR"),
        CategoryDef(name: "RETAINER", slug: "RETAINER"),
        CategoryDef(name: "RING", slug: "RING"),
        CategoryDef(name: "RIVET", slug: "RIVET"),
        CategoryDef(name: "ROD", slug: "ROD"),
        CategoryDef(name: "ROLLER", slug: "ROLLER"),
        CategoryDef(name: "ROOF", slug: "ROOF"),
        CategoryDef(name: "ROTOR", slug: "ROTOR"),
        CategoryDef(name: "RUBBER", slug: "RUBBER"),
      ]),
  CategoryDef(
      name: 'SPARK PLUG ',
      slug: 'SPARK-PLUG',
      image: 'assets/categories/SPARK-PLUG.jpg',
      items: 106,
      children: [
        CategoryDef(name: "SEAL", slug: "SEAL"),
        CategoryDef(name: "SEALING", slug: "SEALING"),
        CategoryDef(name: "SEAT", slug: "SEAT"),
        CategoryDef(name: "SENDER", slug: "SENDER"),
        CategoryDef(name: "SENSOR", slug: "SENSOR"),
        CategoryDef(name: "SHAFT", slug: "SHAFT"),
        CategoryDef(name: "SHIELD", slug: "SHIELD"),
        CategoryDef(name: "SHOCK", slug: "SHOCK"),
        CategoryDef(name: "SIDE", slug: "SIDE"),
        CategoryDef(name: "SILICON", slug: "SILICON"),
        CategoryDef(name: "SLEEVE", slug: "SLEEVE"),
        CategoryDef(name: "SLIDE", slug: "SLIDE"),
        CategoryDef(name: "SOCKET", slug: "SOCKET"),
        CategoryDef(name: "SOLENOID", slug: "SOLENOID"),
        CategoryDef(name: "SPACER", slug: "SPACER"),
        CategoryDef(name: "SPARK PLUG", slug: "SPARK-PLUG"),
        CategoryDef(name: "SPEAKER", slug: "SPEAKER"),
        CategoryDef(name: "SPINDLE", slug: "SPINDLE"),
        CategoryDef(name: "SPOILER", slug: "SPOILER"),
        CategoryDef(name: "SPRAY NOZZLE", slug: "SPRAY-NOZZLE"),
        CategoryDef(name: "SPRING", slug: "SPRING"),
        CategoryDef(name: "SPROCKET", slug: "SPROCKET"),
        CategoryDef(name: "SPROCKET", slug: "SPROCKET"),
        CategoryDef(name: "ST.LINK", slug: "ST.LINK"),
        CategoryDef(name: "STAB LINK", slug: "STAB-LINK"),
        CategoryDef(name: "STABILIZER", slug: "STABILIZER"),
        CategoryDef(name: "STARTER", slug: "STARTER"),
        CategoryDef(name: "STB LINK", slug: "STB-LINK"),
        CategoryDef(name: "STEARING", slug: "STEARING"),
        CategoryDef(name: "STEERING", slug: "STEERING"),
        CategoryDef(name: "STICKER", slug: "STICKER"),
        CategoryDef(name: "STOP", slug: "STOP"),
        CategoryDef(name: "STRIP", slug: "STRIP"),
        CategoryDef(name: "STRUT", slug: "STRUT"),
        CategoryDef(name: "STUD", slug: "STUD"),
        CategoryDef(name: "SUCTION", slug: "SUCTION"),
        CategoryDef(name: "SUN", slug: "SUN"),
        CategoryDef(name: "SUPPORT", slug: "SUPPORT"),
        CategoryDef(name: "SUSPENSION", slug: "SUSPENSION"),
        CategoryDef(name: "SWITCH", slug: "SWITCH")
      ]),
  CategoryDef(
      name: 'UPPER ARM && VACCUM && WASHER',
      slug: 'UPPER-ARM-&&-VACCUM-&&-WASHER',
      image: 'assets/categories/UPPER-ARM-VACCUM-WASHER.png',
      items: 106,
      children: [
        CategoryDef(name: "UPPER ARM", slug: "UPPER-ARM"),
        CategoryDef(name: "VACCUM", slug: "VACCUM"),
        CategoryDef(name: "VALVE", slug: "VALVE"),
        CategoryDef(name: "V-BELT", slug: "V-BELT"),
        CategoryDef(name: "VENT", slug: "VENT"),
        CategoryDef(name: "VIBRATION", slug: "VIBRATION"),
        CategoryDef(name: "VOLTAGE", slug: "VOLTAGE"),
        CategoryDef(name: "WASHER", slug: "WASHER"),
        CategoryDef(name: "WATER PUMP", slug: "WATER-PUMP"),
        CategoryDef(name: "WEATER STRIPE", slug: "WEATER-STRIPE"),
        CategoryDef(name: "WHEEL", slug: "WHEEL"),
        CategoryDef(name: "WIND", slug: "WIND"),
        CategoryDef(name: "WINDOW", slug: "WINDOW"),
        CategoryDef(name: "WINDSHIELD", slug: "WINDSHIELD"),
        CategoryDef(name: "WIPER", slug: "WIPER"),
        CategoryDef(name: "WIRE", slug: "WIRE"),
        CategoryDef(name: "WIRING", slug: "WIRING"),
        CategoryDef(name: "WISH BONE", slug: "WISH-BONE")
      ])
];

final List<Entry> data = <Entry>[
  Entry(
    title: 'Home',
    image: 'assets/brands/home.png',
    url: '/',
    submenu: <Entry>[
      Entry(title: 'Offers', url: '/View-All-Available-Offers'),
      Entry(title: 'Latest News', url: '/New-Arrivals-Latest-News'),
      Entry(title: 'Category', url: '/auto-spare-parts-category'),
      Entry(title: 'Brands', url: '/Brands'),
    ],
  ),
  Entry(
    title: 'AUDI',
    image: 'assets/brands/audi.png',
    url: '/catalog/products?make=AUDI&makeCode=AUDI',
    submenu: <Entry>[
      Entry(
        title: 'AUTOSTAR && BOSCH',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=AUTOSTAR&origincode=AST",
        submenu: <Entry>[
          Entry(
              title: "AUTOSTAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=AUTOSTAR&origincode=AST"),
          Entry(
              title: "BEHR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BEHR&origincode=BHR"),
          Entry(
              title: "BILSTIEN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BILSTIEN&origincode=BLN"),
          Entry(
              title: "BOGE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BOGE&origincode=BOG"),
          Entry(
              title: "BOSCH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BOSCH&origincode=BSH"),
          Entry(
              title: "BREMI",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BREMI&origincode=BMI"),
          Entry(
              title: "A/C",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=A/C&partsCategoryCode=AC"),
          Entry(
              title: "AC CONDENSER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC CONDENSER&partsCategoryCode=AC CONDENSER"),
          Entry(
              title: "AC ASSY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC ASSY&partsCategoryCode=ACAS"),
          Entry(
              title: "AC BLOWER MOTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC BLOWER MOTOR&partsCategoryCode=ACBLM"),
          Entry(
              title: "ACCELERATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ACCELERATOR&partsCategoryCode=ACCEL"),
          Entry(
              title: "AC COMPRESSOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
          Entry(
              title: "AC CONDENSER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
          Entry(
              title: "AC DRIER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
          Entry(
              title: "AC FAN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AC FAN&partsCategoryCode=ACFA"),
          Entry(
              title: "ACTUATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
          Entry(
              title: "ADAPTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
          Entry(
              title: "ADDITIONAL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ADDITIONAL&partsCategoryCode=ADDIT"),
          Entry(
              title: "ADJUSTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ADJUSTER&partsCategoryCode=ADJ"),
          Entry(
              title: "AIR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AIR&partsCategoryCode=AIR"),
          Entry(
              title: "ALTERNATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
          Entry(
              title: "AMPLIFIER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AMPLIFIER&partsCategoryCode=AMPLI"),
          Entry(
              title: "ARM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ARM&partsCategoryCode=ARM"),
          Entry(
              title: "AXLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=AXLE&partsCategoryCode=AX"),
          Entry(
              title: "BATTERY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BATTERY&partsCategoryCode=BA"),
          Entry(
              title: "BAFFLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BAFFLE&partsCategoryCode=BAFFL"),
          Entry(
              title: "BALL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BALL&partsCategoryCode=BALL"),
          Entry(
              title: "BALL JOINT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
          Entry(
              title: "BAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BAR&partsCategoryCode=BAR"),
          Entry(
              title: "BEARING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BEARING&partsCategoryCode=BEA"),
          Entry(
              title: "BEAM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BEAM&partsCategoryCode=BEAM"),
          Entry(
              title: "BELT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BELT&partsCategoryCode=BELT"),
          Entry(
              title: "BULB",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BULB&partsCategoryCode=BLB"),
          Entry(
              title: "BELT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BELT&partsCategoryCode=BLT"),
          Entry(
              title: "BLOWER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BLOWER&partsCategoryCode=BLW"),
          Entry(
              title: "BUMPER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BUMPER&partsCategoryCode=BMP"),
          Entry(
              title: "BONET",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BONET&partsCategoryCode=BO"),
          Entry(
              title: "BODY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BODY&partsCategoryCode=BODY"),
          Entry(
              title: "BOLT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BOLT&partsCategoryCode=BOLT"),
          Entry(
              title: "BOOT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BOOT&partsCategoryCode=BOOT"),
          Entry(
              title: "BOWDEN CABLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BOWDEN CABLE&partsCategoryCode=BOWDE"),
          Entry(
              title: "BRACKET",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BRACKET&partsCategoryCode=BRACK"),
          Entry(
              title: "BRAKE PAD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
          Entry(
              title: "BREATHER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BREATHER&partsCategoryCode=BREAT"),
          Entry(
              title: "BRAKE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BRAKE&partsCategoryCode=BRK"),
          Entry(
              title: "BUFFER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BUFFER&partsCategoryCode=BUFFE"),
          Entry(
              title: "BUMPER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BUMPER&partsCategoryCode=BUMPER"),
          Entry(
              title: "BUSH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=BUSH&partsCategoryCode=BUSH"),
        ],
      ),
      Entry(
        title: 'ELRING && GERMANY',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=CHINA&origincode=CHI",
        submenu: <Entry>[
          Entry(
              title: "CHINA",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=CHINA&origincode=CHI"),
          Entry(
              title: "CONTI",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=CONTI&origincode=CON"),
          Entry(
              title: "DENSO",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=DENSO&origincode=DSO"),
          Entry(
              title: "ELRING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=ELRING&origincode=ELR"),
          Entry(
              title: "FEBI",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=FEBI&origincode=FBI"),
          Entry(
              title: "GERMANY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=GERMANY&origincode=GER"),
          Entry(
              title: "HENGST",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=HENGST&origincode=HST"),
          Entry(
              title: "LEMFORDER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=LEMFORDER&origincode=LEM"),
          Entry(
              title: "CABLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CABLE&partsCategoryCode=CAB"),
          Entry(
              title: "CALIPER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CALIPER&partsCategoryCode=CALIP"),
          Entry(
              title: "CAP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CAP&partsCategoryCode=CAP"),
          Entry(
              title: "CARRIER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CARRIER&partsCategoryCode=CAR"),
          Entry(
              title: "CHAIN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CHAIN&partsCategoryCode=CHA"),
          Entry(
              title: "CHASSIS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CHASSIS&partsCategoryCode=CHASSIS"),
          Entry(
              title: "CHROME",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CHROME&partsCategoryCode=CHROM"),
          Entry(
              title: "CLIP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CLIP&partsCategoryCode=CLIP"),
          Entry(
              title: "CLUTCH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
          Entry(
              title: "COIL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COIL&partsCategoryCode=COIL"),
          Entry(
              title: "COMPRESSOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
          Entry(
              title: "CONDENSER ",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CONDENSER &partsCategoryCode=COND"),
          Entry(
              title: "CONNECTING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CONNECTING&partsCategoryCode=CONNTNG"),
          Entry(
              title: "CONNECTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CONNECTOR&partsCategoryCode=CONNTR"),
          Entry(
              title: "CONTACT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CONTACT&partsCategoryCode=CONTA"),
          Entry(
              title: "CONTROL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CONTROL&partsCategoryCode=CONTR"),
          Entry(
              title: "COOLANT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COOLANT&partsCategoryCode=COOLA"),
          Entry(
              title: "COOLENT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COOLENT&partsCategoryCode=COOLENT"),
          Entry(
              title: "COOLER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COOLER&partsCategoryCode=COOLER"),
          Entry(
              title: "COUPLING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COUPLING&partsCategoryCode=COUPL"),
          Entry(
              title: "COVER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=COVER&partsCategoryCode=COVER"),
          Entry(
              title: "CRANK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CRANK&partsCategoryCode=CRANK"),
          Entry(
              title: "CUT BUSH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
          Entry(
              title: "CV JOINT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CV JOINT&partsCategoryCode=CVJO"),
          Entry(
              title: "CYLINDER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=CYLINDER&partsCategoryCode=CYL"),
          Entry(
              title: "DAMPER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DAMPER&partsCategoryCode=DAMPE"),
          Entry(
              title: "DEFLECTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DEFLECTOR&partsCategoryCode=DEFLETR"),
          Entry(
              title: "DICKY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DICKY&partsCategoryCode=DICKY"),
          Entry(
              title: "DISC",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DISC&partsCategoryCode=DISC"),
          Entry(
              title: "DOOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DOOR&partsCategoryCode=DOOR"),
          Entry(
              title: "DOWEL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DOWEL&partsCategoryCode=DOWEL"),
          Entry(
              title: "DRIER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DRIER&partsCategoryCode=DRIER"),
          Entry(
              title: "DRIVE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
          Entry(
              title: "ECU",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ECU&partsCategoryCode=ECU"),
          Entry(
              title: "ELECTRICAL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ELECTRICAL&partsCategoryCode=ELECT"),
          Entry(
              title: "ELECTRICAL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
          Entry(
              title: "EMBLEM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=EMBLEM&partsCategoryCode=EMB"),
          Entry(
              title: "END",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=END&partsCategoryCode=END"),
          Entry(
              title: "ENGINE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ENGINE&partsCategoryCode=ENG"),
          Entry(
              title: "ENGINE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
          Entry(
              title: "EVAPORATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
          Entry(
              title: "EVAPORATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=EVAPORATOR&partsCategoryCode=EVAPORATOR"),
          Entry(
              title: "EXHAUST",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=EXHAUST&partsCategoryCode=EXH"),
          Entry(
              title: "EXPANSION",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
          Entry(
              title: "FAN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FAN&partsCategoryCode=FAN"),
          Entry(
              title: "FASTENER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FASTENER&partsCategoryCode=FASTE"),
          Entry(
              title: "FENDER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FENDER&partsCategoryCode=FENDE"),
          Entry(
              title: "FILTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FILTER&partsCategoryCode=FI"),
          Entry(
              title: "FIILTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FIILTER&partsCategoryCode=FIILTER"),
          Entry(
              title: "FILTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FILTER&partsCategoryCode=FILTER"),
          Entry(
              title: "FLOOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FLOOR&partsCategoryCode=FL"),
          Entry(
              title: "FLANGE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FLANGE&partsCategoryCode=FLANG"),
          Entry(
              title: "FOG",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FOG&partsCategoryCode=FOG"),
          Entry(
              title: "FRONT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FRONT&partsCategoryCode=FRNT"),
          Entry(
              title: "FUEL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FUEL&partsCategoryCode=FU"),
          Entry(
              title: "FUEL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FUEL&partsCategoryCode=FUEL"),
          Entry(
              title: "FUNNEL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FUNNEL&partsCategoryCode=FUNNE"),
          Entry(
              title: "FUSE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=FUSE&partsCategoryCode=FUSE"),
        ],
      ),
      Entry(
        title: 'MAHLE && NISSENS',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=MAHLE&origincode=MHF",
        submenu: <Entry>[
          Entry(
              title: "MAHLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAHLE&origincode=MHF"),
          Entry(
              title: "MAN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAN&origincode=MAN"),
          Entry(
              title: "MAXPART",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAXPART&origincode=MXP"),
          Entry(
              title: "MAYER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAYER&origincode=MAYER"),
          Entry(
              title: "MEYLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MEYLE&origincode=MEY"),
          Entry(
              title: "MOBIL 1",
              url:
                  "/catalog/products?make=MB&makeCode=AUDI&origin=MOBIL 1&origincode=MOB"),
          Entry(
              title: "NISSENS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=NISSENS&origincode=NIS"),
          Entry(
              title: "GASKET",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GASKET&partsCategoryCode=GAS"),
          Entry(
              title: "GASKET",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GASKET&partsCategoryCode=GASK"),
          Entry(
              title: "GEAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GEAR&partsCategoryCode=GEAR"),
          Entry(
              title: "GLASS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GLASS&partsCategoryCode=GL"),
          Entry(
              title: "GLASS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GLASS&partsCategoryCode=GLASS"),
          Entry(
              title: "GLOW",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GLOW&partsCategoryCode=GLOW"),
          Entry(
              title: "GEAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GEAR&partsCategoryCode=GR"),
          Entry(
              title: "GRILL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GRILL&partsCategoryCode=GRILL"),
          Entry(
              title: "GROMMET",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GROMMET&partsCategoryCode=GROMM"),
          Entry(
              title: "GUIDE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
          Entry(
              title: "HAND",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HAND&partsCategoryCode=HAN"),
          Entry(
              title: "HANDL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HANDL&partsCategoryCode=HANDL"),
          Entry(
              title: "HARNESS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HARNESS&partsCategoryCode=HARNE"),
          Entry(
              title: "HEAD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HEAD&partsCategoryCode=HEAD"),
          Entry(
              title: "HEAT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HEAT&partsCategoryCode=HEAT"),
          Entry(
              title: "HIGH PRESSURE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HIGH PRESSURE&partsCategoryCode=HIGH"),
          Entry(
              title: "HINGE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HINGE&partsCategoryCode=HINGE"),
          Entry(
              title: "HOLDER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HOLDER&partsCategoryCode=HOLDER"),
          Entry(
              title: "HOOD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HOOD&partsCategoryCode=HOOD"),
          Entry(
              title: "HOOK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HOOK&partsCategoryCode=HOOK"),
          Entry(
              title: "HORN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HORN&partsCategoryCode=HORN"),
          Entry(
              title: "HOSE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HOSE&partsCategoryCode=HOSE"),
          Entry(
              title: "HOUSING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=HOUSING&partsCategoryCode=HOUSING"),
        ],
      ),
      Entry(
        title: 'ORIGINAL && SACHS',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=ORIGINAL&origincode=OE",
        submenu: <Entry>[
          Entry(
              title: "ORIGINAL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=ORIGINAL&origincode=OE"),
          Entry(
              title: "OSRAM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=OSRAM&origincode=OSR"),
          Entry(
              title: "RECONDITION",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=RECONDITION&origincode=RECONDITION"),
          Entry(
              title: "REMSA",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=REMSA&origincode=REM"),
          Entry(
              title: "SACHS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=SACHS&origincode=SCH"),
          Entry(
              title: "IGNITION",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
          Entry(
              title: "INJECTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
          Entry(
              title: "INJECTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=INJECTOR&partsCategoryCode=INJECTOR"),
          Entry(
              title: "INSERT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=INSERT&partsCategoryCode=INSER"),
          Entry(
              title: "INTAKE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=INTAKE&partsCategoryCode=INTAK"),
          Entry(
              title: "INTAKE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=INTAKE&partsCategoryCode=INTAKE"),
          Entry(
              title: "JOINT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=JOINT&partsCategoryCode=JOINT"),
          Entry(
              title: "KEY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=KEY&partsCategoryCode=KEY"),
          Entry(
              title: "KIT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=KIT&partsCategoryCode=KIT"),
          Entry(
              title: "LAMP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LAMP&partsCategoryCode=LAMP"),
          Entry(
              title: "LATCH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LATCH&partsCategoryCode=LATCH"),
          Entry(
              title: "LEVER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LEVER&partsCategoryCode=LEVER"),
          Entry(
              title: "LIGHT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LIGHT&partsCategoryCode=LGHT"),
          Entry(
              title: "LINE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LINE&partsCategoryCode=LINE"),
          Entry(
              title: "LINK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LINK&partsCategoryCode=LINK"),
          Entry(
              title: "LOCK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LOCK&partsCategoryCode=LOCK"),
          Entry(
              title: "LOGO",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LOGO&partsCategoryCode=LOGO"),
          Entry(
              title: "LOWER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=LOWER&partsCategoryCode=LOWER"),
          Entry(
              title: "MIRROR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
          Entry(
              title: "MODULE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MODULE&partsCategoryCode=MODUL"),
          Entry(
              title: "MOLDING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOLDING&partsCategoryCode=MOLDI"),
          Entry(
              title: "MOTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
          Entry(
              title: "MOUDLING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
          Entry(
              title: "MOULDING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOULDING&partsCategoryCode=MOULD"),
          Entry(
              title: "MOUNT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
          Entry(
              title: "MOUNTING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOUNTING&partsCategoryCode=MOUNTING"),
          Entry(
              title: "MOUNTING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
          Entry(
              title: "NOZZLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
          Entry(
              title: "NUMBER PLATE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=NUMBER PLATE&partsCategoryCode=NUMBE"),
          Entry(
              title: "NUT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=NUT&partsCategoryCode=NUT"),
          Entry(
              title: "OIL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=OIL&partsCategoryCode=OIL"),
          Entry(
              title: "OIL",
              url:
                  "/catalog/products?make=MB&makeCode=AUDI&partsCategory=OIL&partsCategoryCode=OIL"),
          Entry(
              title: "OIL ASSY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
          Entry(
              title: "OIL CAP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=OIL CAP&partsCategoryCode=OILC"),
          Entry(
              title: "OIL COOLER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=OIL COOLER&partsCategoryCode=OILCO"),
          Entry(
              title: "O - RING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=O - RING&partsCategoryCode=O-R"),
          Entry(
              title: "OTHERS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=OTHERS&partsCategoryCode=OTHER"),
          Entry(
              title: "PIECE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PIECE&partsCategoryCode=PIECE"),
          Entry(
              title: "PIN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PIN&partsCategoryCode=PIN"),
          Entry(
              title: "PIPE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PIPE&partsCategoryCode=PIPE"),
          Entry(
              title: "PISTON",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PISTON&partsCategoryCode=PISTO"),
          Entry(
              title: "PISTON",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PISTON&partsCategoryCode=PISTON"),
          Entry(
              title: "PLATE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PLATE&partsCategoryCode=PLATE"),
          Entry(
              title: "PLUG",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PLUG&partsCategoryCode=PLUG"),
          Entry(
              title: "PRESSURE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PRESSURE&partsCategoryCode=PRESS"),
          Entry(
              title: "PULLEY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PULLEY&partsCategoryCode=PULLE"),
          Entry(
              title: "PUMP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=PUMP&partsCategoryCode=PUMP"),
          Entry(
              title: "RACK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RACK&partsCategoryCode=RACK"),
          Entry(
              title: "RADIATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
          Entry(
              title: "RADIATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
          Entry(
              title: "RAIL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RAIL&partsCategoryCode=RAIL"),
          Entry(
              title: "REAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=REAR&partsCategoryCode=REAR"),
          Entry(
              title: "REFLECTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
          Entry(
              title: "REGULATOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
          Entry(
              title: "REINFORCEMENT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=REINFORCEMENT&partsCategoryCode=REINF"),
          Entry(
              title: "RELAY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RELAY&partsCategoryCode=RELAY"),
          Entry(
              title: "REPAIR KIT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=REPAIR KIT&partsCategoryCode=REPAI"),
          Entry(
              title: "RESERVOIR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
          Entry(
              title: "RESISTOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RESISTOR&partsCategoryCode=RESIS"),
          Entry(
              title: "RING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RING&partsCategoryCode=RING"),
          Entry(
              title: "RIVET",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RIVET&partsCategoryCode=RIVET"),
          Entry(
              title: "ROD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ROD&partsCategoryCode=ROD"),
          Entry(
              title: "ROLLER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ROLLER&partsCategoryCode=ROLLE"),
          Entry(
              title: "ROOF",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=ROOF&partsCategoryCode=ROOF"),
          Entry(
              title: "RUBBER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=RUBBER&partsCategoryCode=RUBBE"),
          Entry(
              title: "SCREW",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SCREW&partsCategoryCode=SCREW"),
          Entry(
              title: "SEAL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SEAL&partsCategoryCode=SEAL"),
          Entry(
              title: "SEAT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SEAT&partsCategoryCode=SEAT"),
          Entry(
              title: "SENDER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SENDER&partsCategoryCode=SENDE"),
          Entry(
              title: "SENSOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SENSOR&partsCategoryCode=SENSO"),
          Entry(
              title: "SENSOR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SENSOR&partsCategoryCode=SENSOR"),
          Entry(
              title: "SHAFT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
          Entry(
              title: "SHOCK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
          Entry(
              title: "SIDE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SIDE&partsCategoryCode=SIDE"),
          Entry(
              title: "SLEEVE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SLEEVE&partsCategoryCode=SLEEV"),
          Entry(
              title: "SLIDE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SLIDE&partsCategoryCode=SLIDE"),
          Entry(
              title: "SPARK PLUG",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
          Entry(
              title: "SPEAKER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SPEAKER&partsCategoryCode=SPEAK"),
          Entry(
              title: "SPEAKER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SPEAKER&partsCategoryCode=SPEAKER"),
          Entry(
              title: "SPOILER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
          Entry(
              title: "SPRING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SPRING&partsCategoryCode=SPRIN"),
          Entry(
              title: "STABILIZER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STABILIZER&partsCategoryCode=STABI"),
          Entry(
              title: "STARTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STARTER&partsCategoryCode=START"),
          Entry(
              title: "STARTER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STARTER&partsCategoryCode=STARTER"),
          Entry(
              title: "STB LINK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STB LINK&partsCategoryCode=STBL"),
          Entry(
              title: "STEARING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STEARING&partsCategoryCode=STEAR"),
          Entry(
              title: "STEARING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STEARING&partsCategoryCode=STEARING"),
          Entry(
              title: "STEERING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STEERING&partsCategoryCode=STEER"),
          Entry(
              title: "STOP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STOP&partsCategoryCode=STOP"),
          Entry(
              title: "STRIP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STRIP&partsCategoryCode=STRIP"),
          Entry(
              title: "STRUT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STRUT&partsCategoryCode=STRUT"),
          Entry(
              title: "STUD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=STUD&partsCategoryCode=STUD"),
          Entry(
              title: "SUN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SUN&partsCategoryCode=SUN"),
          Entry(
              title: "SUPPORT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
          Entry(
              title: "SUSPENSION",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SUSPENSION&partsCategoryCode=SUSPENSION"),
          Entry(
              title: "SWITCH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        ],
      ),
      Entry(
        title: 'TRUCKTEC && VICTOR REINZ',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=TOPDRIVE&origincode=TDR",
        submenu: <Entry>[
          Entry(
              title: "TOPDRIVE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=TOPDRIVE&origincode=TDR"),
          Entry(
              title: "TRUCKTEC",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=TRUCKTEC&origincode=TTC"),
          Entry(
              title: "TRW",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=TRW&origincode=TRW"),
          Entry(
              title: "USED",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=USED&origincode=USD"),
          Entry(
              title: "VAICO",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=VAICO&origincode=VKO"),
          Entry(
              title: "VDO",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=VDO&origincode=VDO"),
          Entry(
              title: "VICTOR REINZ",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=VICTOR REINZ&origincode=RNZ"),
          Entry(
              title: "UPPER ARM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
          Entry(
              title: "VACCUM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=VACCUM&partsCategoryCode=VACCU"),
          Entry(
              title: "VALVE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=VALVE&partsCategoryCode=VALVE"),
          Entry(
              title: "V-BELT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
          Entry(
              title: "VENT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=VENT&partsCategoryCode=VENT"),
          Entry(
              title: "WASHER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WASHER&partsCategoryCode=WASHE"),
          Entry(
              title: "WATER PUMP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
          Entry(
              title: "WATER PUMP",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WATER PUMP&partsCategoryCode=WATER PUMP"),
          Entry(
              title: "WHEEL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
          Entry(
              title: "WIND",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WIND&partsCategoryCode=WIND"),
          Entry(
              title: "WINDOW",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WINDOW&partsCategoryCode=WINDO"),
          Entry(
              title: "WINDSHIELD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WINDSHIELD&partsCategoryCode=WINDS"),
          Entry(
              title: "WIPER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WIPER&partsCategoryCode=WIPER"),
          Entry(
              title: "WIRE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WIRE&partsCategoryCode=WIRE"),
          Entry(
              title: "WISH BONE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=WISH BONE&partsCategoryCode=WISH"),
        ],
      ),
      Entry(
        title: 'SHELL && TANK',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=CHINA&origincode=CHI",
        submenu: <Entry>[
          Entry(
              title: "SHELL",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=SHELL&origincode=SL"),
          Entry(
              title: "SIMMER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=SIMMER&origincode=SIM"),
          Entry(
              title: "SPARX",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=SPARX&origincode=SPX"),
          Entry(
              title: "TAIWAN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=TAIWAN&origincode=TWN"),
          Entry(
              title: "TEXTAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=TEXTAR&origincode=TEX"),
          Entry(
              title: "TANK",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TANK&partsCategoryCode=TANK"),
          Entry(
              title: "TENSIONER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
          Entry(
              title: "TENSIONER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TENSIONER&partsCategoryCode=TENSIONER"),
          Entry(
              title: "THERMOSTAT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
          Entry(
              title: "THERMOSTAT",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=THERMOSTAT&partsCategoryCode=THERMOSTAT"),
          Entry(
              title: "THROTTLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=THROTTLE&partsCategoryCode=THROT"),
          Entry(
              title: "TIE ROD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TIE ROD&partsCategoryCode=TIER"),
          Entry(
              title: "TIMING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TIMING&partsCategoryCode=TIMIN"),
          Entry(
              title: "TIMING CHAIN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TIMING CHAIN&partsCategoryCode=TIMINC"),
          Entry(
              title: "TRACK ROD",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TRACK ROD&partsCategoryCode=TRACK"),
          Entry(
              title: "TRANSMISSION",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
          Entry(
              title: "TRIM",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TRIM&partsCategoryCode=TRI"),
          Entry(
              title: "TUBE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TUBE&partsCategoryCode=TUBE"),
          Entry(
              title: "TURBO",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TURBO&partsCategoryCode=TURBO"),
          Entry(
              title: "TURN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TURN&partsCategoryCode=TURN"),
          Entry(
              title: "TYRE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&partsCategory=TYRE&partsCategoryCode=TYRE"),
        ],
      )
    ],
  ),
  Entry(
    title: "BMW",
    image: 'assets/brands/BMW.png',
    url: "/catalog/products?make=BMW&makeCode=BMW",
    submenu: <Entry>[
      Entry(
        title: 'AUTOSTAR && BOSCH',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=AUTOSTAR&origincode=AST",
        submenu: <Entry>[
          Entry(
              title: "AUTOSTAR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=AUTOSTAR&origincode=AST"),
          Entry(
              title: "BEHR",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BEHR&origincode=BHR"),
          Entry(
              title: "BILSTIEN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BILSTIEN&origincode=BLN"),
          Entry(
              title: "BOGE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BOGE&origincode=BOG"),
          Entry(
              title: "BOSCH",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BOSCH&origincode=BSH"),
          Entry(
              title: "BREMI",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=BREMI&origincode=BMI"),
          Entry(
              title: "A/C",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=A/C&partsCategoryCode=A/C"),
          Entry(
              title: "ABSORBER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ABSORBER&partsCategoryCode=ABS"),
          Entry(
              title: "ABSORBER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ABSORBER&partsCategoryCode=ABSORBER"),
          Entry(
              title: "A/C",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=A/C&partsCategoryCode=AC"),
          Entry(
              title: "AC ASSY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC ASSY&partsCategoryCode=AC ASSY"),
          Entry(
              title: "AC BELT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC BELT&partsCategoryCode=AC BELT"),
          Entry(
              title: "AC BLOWER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC BLOWER&partsCategoryCode=AC BLOWER"),
          Entry(
              title: "AC CONDENSER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC CONDENSER&partsCategoryCode=AC CONDENSER"),
          Entry(
              title: "AC ASSY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC ASSY&partsCategoryCode=ACAS"),
          Entry(
              title: "AC BELT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC BELT&partsCategoryCode=ACBE"),
          Entry(
              title: "AC BLOWER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC BLOWER&partsCategoryCode=ACBL"),
          Entry(
              title: "ACCELERATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ACCELERATOR&partsCategoryCode=ACCEL"),
          Entry(
              title: "AC COMPRESSOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
          Entry(
              title: "AC CONDENSER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
          Entry(
              title: "AC DRIER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
          Entry(
              title: "AC FAN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AC FAN&partsCategoryCode=ACFA"),
          Entry(
              title: "ACTUATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
          Entry(
              title: "ACTUATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ACTUATOR&partsCategoryCode=ACTUATOR"),
          Entry(
              title: "ADAPTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
          Entry(
              title: "ADDITIONAL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ADDITIONAL&partsCategoryCode=ADDIT"),
          Entry(
              title: "ADJUSTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ADJUSTER&partsCategoryCode=ADJ"),
          Entry(
              title: "AIR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AIR&partsCategoryCode=AIR"),
          Entry(
              title: "ALTERNATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
          Entry(
              title: "AMPLIFIER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AMPLIFIER&partsCategoryCode=AMPLI"),
          Entry(
              title: "ANTI FREEZE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ANTI FREEZE&partsCategoryCode=ANTI"),
          Entry(
              title: "ARM",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ARM&partsCategoryCode=ARM"),
          Entry(
              title: "ASA BOLT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ASA BOLT&partsCategoryCode=ASAB"),
          Entry(
              title: "ASA-BOLT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ASA-BOLT&partsCategoryCode=ASA-B"),
          Entry(
              title: "ASA SCREW",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ASA SCREW&partsCategoryCode=ASAS"),
          Entry(
              title: "ASHTRAY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ASHTRAY&partsCategoryCode=ASHTR"),
          Entry(
              title: "ATF",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ATF&partsCategoryCode=ATF"),
          Entry(
              title: "AUDIO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AUDIO&partsCategoryCode=AUDIO"),
          Entry(
              title: "AUXILARY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AUXILARY&partsCategoryCode=AUXIL"),
          Entry(
              title: "AXLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AXLE&partsCategoryCode=AX"),
          Entry(
              title: "AXLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=AXLE&partsCategoryCode=AXLE"),
          Entry(
              title: "BATTERY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BATTERY&partsCategoryCode=BA"),
          Entry(
              title: "BADGE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BADGE&partsCategoryCode=BADGE"),
          Entry(
              title: "BALL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BALL&partsCategoryCode=BALL"),
          Entry(
              title: "BALL JOINT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
          Entry(
              title: "BAR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BAR&partsCategoryCode=BAR"),
          Entry(
              title: "BASE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BASE&partsCategoryCode=BASE"),
          Entry(
              title: "BASIC",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BASIC&partsCategoryCode=BASIC"),
          Entry(
              title: "BEARING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BEARING&partsCategoryCode=BEA"),
          Entry(
              title: "BELLOWS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BELLOWS&partsCategoryCode=BELLO"),
          Entry(
              title: "BULB",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BULB&partsCategoryCode=BLB"),
          Entry(
              title: "BELT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BELT&partsCategoryCode=BLT"),
          Entry(
              title: "BLOWER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BLOWER&partsCategoryCode=BLW"),
          Entry(
              title: "BUMPER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BUMPER&partsCategoryCode=BMP"),
          Entry(
              title: "BONET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BONET&partsCategoryCode=BO"),
          Entry(
              title: "BODY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BODY&partsCategoryCode=BOD"),
          Entry(
              title: "BODY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BODY&partsCategoryCode=BODY"),
          Entry(
              title: "BOLT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BOLT&partsCategoryCode=BOLT"),
          Entry(
              title: "BONET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BONET&partsCategoryCode=BONET"),
          Entry(
              title: "BOOT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BOOT&partsCategoryCode=BOOT"),
          Entry(
              title: "BOWDEN CABLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BOWDEN CABLE&partsCategoryCode=BOWDE"),
          Entry(
              title: "BRACKET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BRACKET&partsCategoryCode=BRACK"),
          Entry(
              title: "BRAKE PAD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
          Entry(
              title: "BRAKE PAD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE PAD"),
          Entry(
              title: "BREATHER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BREATHER&partsCategoryCode=BREAT"),
          Entry(
              title: "BRAKE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BRAKE&partsCategoryCode=BRK"),
          Entry(
              title: "BUFFER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BUFFER&partsCategoryCode=BUFFE"),
          Entry(
              title: "BUSH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=BUSH&partsCategoryCode=BUSH"),
          Entry(
              title: "CABLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CABLE&partsCategoryCode=CAB"),
          Entry(
              title: "CALIPER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CALIPER&partsCategoryCode=CALIP"),
          Entry(
              title: "CAMERA",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CAMERA&partsCategoryCode=CAM"),
          Entry(
              title: "CAP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CAP&partsCategoryCode=CAP"),
          Entry(
              title: "CARRIER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CARRIER&partsCategoryCode=CAR"),
          Entry(
              title: "CASE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CASE&partsCategoryCode=CASE"),
          Entry(
              title: "CATALYST CONVERTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CATALYST CONVERTER&partsCategoryCode=CATAL"),
          Entry(
              title: "CATCH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CATCH&partsCategoryCode=CATCH"),
          Entry(
              title: "CENTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CENTER&partsCategoryCode=CEN"),
          Entry(
              title: "CENTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CENTER&partsCategoryCode=CENTER"),
          Entry(
              title: "CHAIN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CHAIN&partsCategoryCode=CHA"),
          Entry(
              title: "CHANNEL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CHANNEL&partsCategoryCode=CHANN"),
          Entry(
              title: "CHARGE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CHARGE&partsCategoryCode=CHARG"),
          Entry(
              title: "CHROME",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CHROME&partsCategoryCode=CHROM"),
          Entry(
              title: "CLAMP ",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CLAMP &partsCategoryCode=CLAMP"),
          Entry(
              title: "CLIP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CLIP&partsCategoryCode=CLIP"),
          Entry(
              title: "CLUTCH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
          Entry(
              title: "CLUTCH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CLUTCH&partsCategoryCode=CLUTCH"),
          Entry(
              title: "COIL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COIL&partsCategoryCode=COIL"),
          Entry(
              title: "COMPUTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COMPUTER&partsCategoryCode=COM"),
          Entry(
              title: "COMBINATION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COMBINATION&partsCategoryCode=COMBIN"),
          Entry(
              title: "COMPRESSION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COMPRESSION&partsCategoryCode=COMPRSN"),
          Entry(
              title: "COMPRESSOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
          Entry(
              title: "CONDENSER ",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CONDENSER &partsCategoryCode=COND"),
          Entry(
              title: "CONNECTING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CONNECTING&partsCategoryCode=CONNTNG"),
          Entry(
              title: "CONNECTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CONNECTOR&partsCategoryCode=CONNTR"),
          Entry(
              title: "CONTROL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CONTROL&partsCategoryCode=CONTR"),
          Entry(
              title: "CONVERTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CONVERTER&partsCategoryCode=CONVE"),
          Entry(
              title: "COOLANT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COOLANT&partsCategoryCode=COOLA"),
          Entry(
              title: "COOLER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COOLER&partsCategoryCode=COOLER"),
          Entry(
              title: "COOLING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COOLING&partsCategoryCode=COOLI"),
          Entry(
              title: "COUPLING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COUPLING&partsCategoryCode=COUPL"),
          Entry(
              title: "COVER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=COVER&partsCategoryCode=COVER"),
          Entry(
              title: "CRANK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CRANK&partsCategoryCode=CRANK"),
          Entry(
              title: "CROSS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CROSS&partsCategoryCode=CROSS"),
          Entry(
              title: "CUP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CUP&partsCategoryCode=CUP"),
          Entry(
              title: "CUT BUSH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
          Entry(
              title: "CYLINDER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CYLINDER&partsCategoryCode=CYL"),
          Entry(
              title: "CYLENDER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=CYLENDER&partsCategoryCode=CYLEN"),
          Entry(
              title: "DAMPER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DAMPER&partsCategoryCode=DAMPE"),
          Entry(
              title: "DASHBOARD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DASHBOARD&partsCategoryCode=DASHB"),
          Entry(
              title: "DEFLECTION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DEFLECTION&partsCategoryCode=DEFLETN"),
          Entry(
              title: "DEFLECTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DEFLECTOR&partsCategoryCode=DEFLETR"),
          Entry(
              title: "DELIVERY UNIT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DELIVERY UNIT&partsCategoryCode=DELIV"),
          Entry(
              title: "DICKY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DICKY&partsCategoryCode=DICKY"),
          Entry(
              title: "DISC",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DISC&partsCategoryCode=DISC"),
          Entry(
              title: "DISTRIBUTION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DISTRIBUTION&partsCategoryCode=DISTR"),
          Entry(
              title: "DME",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DME&partsCategoryCode=DME"),
          Entry(
              title: "DOOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DOOR&partsCategoryCode=DOOR"),
          Entry(
              title: "DOWEL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DOWEL&partsCategoryCode=DOWEL"),
          Entry(
              title: "DRIER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DRIER&partsCategoryCode=DRIER"),
          Entry(
              title: "DRIVE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
          Entry(
              title: "ECU",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ECU&partsCategoryCode=ECU"),
          Entry(
              title: "ELECTRICAL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ELECTRICAL&partsCategoryCode=ELECT"),
          Entry(
              title: "ELECTRICAL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
          Entry(
              title: "ELEMENT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ELEMENT&partsCategoryCode=ELEME"),
          Entry(
              title: "EMBLEM",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=EMBLEM&partsCategoryCode=EMB"),
          Entry(
              title: "END",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=END&partsCategoryCode=END"),
          Entry(
              title: "ENGINE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ENGINE&partsCategoryCode=ENG"),
          Entry(
              title: "ENGINE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
          Entry(
              title: "EVAPORATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
          Entry(
              title: "EXHAUST",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=EXHAUST&partsCategoryCode=EXH"),
          Entry(
              title: "EXPANSION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
          Entry(
              title: "EXTENSION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=EXTENSION&partsCategoryCode=EXTEN"),
          Entry(
              title: "FAN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FAN&partsCategoryCode=FAN"),
          Entry(
              title: "FENDER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FENDER&partsCategoryCode=FENDE"),
          Entry(
              title: "FILTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILTER&partsCategoryCode=FI"),
          Entry(
              title: "FILTER",
              url:
                  "/catalog/products?make=MB&makeCode=BMW&partsCategory=FILTER&partsCategoryCode=FI"),
          Entry(
              title: "FIILTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FIILTER&partsCategoryCode=FIILT"),
          Entry(
              title: "FILL-IN FLAP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILL-IN FLAP&partsCategoryCode=FILL-"),
          Entry(
              title: "FILLER PIPE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLER PIPE&partsCategoryCode=FILLER PIPE"),
          Entry(
              title: "FILLISTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLISTER&partsCategoryCode=FILLI"),
          Entry(
              title: "FILLER CAP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLER CAP&partsCategoryCode=FILLRC"),
          Entry(
              title: "FILLER FLAP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLER FLAP&partsCategoryCode=FILLRF"),
          Entry(
              title: "FILLER NECK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLER NECK&partsCategoryCode=FILLRN"),
          Entry(
              title: "FILLER PIPE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLER PIPE&partsCategoryCode=FILLRP"),
          Entry(
              title: "FILLER PIPE WASH CONTAINER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FILLER PIPE WASH CONTAINER&partsCategoryCode=FILLRPW"),
          Entry(
              title: "FINISHER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FINISHER&partsCategoryCode=FINIS"),
          Entry(
              title: "FLOOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FLOOR&partsCategoryCode=FL"),
          Entry(
              title: "FLAP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FLAP&partsCategoryCode=FLAP"),
          Entry(
              title: "FOG",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FOG&partsCategoryCode=FOG"),
          Entry(
              title: "FRAME",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FRAME&partsCategoryCode=FRAME"),
          Entry(
              title: "FRONT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FRONT&partsCategoryCode=FRNT"),
          Entry(
              title: "FRONR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FRONR&partsCategoryCode=FRONR"),
          Entry(
              title: "FUEL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FUEL&partsCategoryCode=FU"),
          Entry(
              title: "FUEL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FUEL&partsCategoryCode=FUEL"),
          Entry(
              title: "FUSE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=FUSE&partsCategoryCode=FUSE"),
          Entry(
              title: "GASKET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GASKET&partsCategoryCode=GAS"),
          Entry(
              title: "GASKET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GASKET&partsCategoryCode=GASK"),
          Entry(
              title: "GEAR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GEAR&partsCategoryCode=GEAR"),
          Entry(
              title: "GLASS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GLASS&partsCategoryCode=GL"),
          Entry(
              title: "GLASS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GLASS&partsCategoryCode=GLASS"),
          Entry(
              title: "GLOW",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GLOW&partsCategoryCode=GLOW"),
          Entry(
              title: "GEAR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GEAR&partsCategoryCode=GR"),
          Entry(
              title: "GRID",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GRID&partsCategoryCode=GRID"),
          Entry(
              title: "GRILL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GRILL&partsCategoryCode=GRILL"),
          Entry(
              title: "GROMMET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GROMMET&partsCategoryCode=GROMM"),
          Entry(
              title: "GUIDE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
          Entry(
              title: "HAND",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HAND&partsCategoryCode=HAN"),
          Entry(
              title: "HANDL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HANDL&partsCategoryCode=HANDL"),
          Entry(
              title: "HEAD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HEAD&partsCategoryCode=HEAD"),
          Entry(
              title: "HEAT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HEAT&partsCategoryCode=HEAT"),
          Entry(
              title: "HIGH PRESSURE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HIGH PRESSURE&partsCategoryCode=HIGH"),
          Entry(
              title: "HINGE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HINGE&partsCategoryCode=HINGE"),
          Entry(
              title: "HOLDER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HOLDER&partsCategoryCode=HOLDER"),
          Entry(
              title: "HOOD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HOOD&partsCategoryCode=HOOD"),
          Entry(
              title: "HORN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HORN&partsCategoryCode=HORN"),
          Entry(
              title: "HOSE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HOSE&partsCategoryCode=HOSE"),
          Entry(
              title: "HOUSING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HOUSING&partsCategoryCode=HOUSING"),
          Entry(
              title: "HUB",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HUB&partsCategoryCode=HUB"),
          Entry(
              title: "HYDRAULIC",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=HYDRAULIC&partsCategoryCode=HYDRA"),
          Entry(
              title: "IDLER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=IDLER&partsCategoryCode=IDLER"),
          Entry(
              title: "IGNITION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
          Entry(
              title: "INDICATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INDICATOR&partsCategoryCode=INDIC"),
          Entry(
              title: "INJECTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
          Entry(
              title: "INSERT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INSERT&partsCategoryCode=INSER"),
          Entry(
              title: "INSTRUMENT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INSTRUMENT&partsCategoryCode=INSTR"),
          Entry(
              title: "INSULATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
          Entry(
              title: "INTAKE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INTAKE&partsCategoryCode=INTAK"),
          Entry(
              title: "INTERIOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=INTERIOR&partsCategoryCode=INTER"),
          Entry(
              title: "JOINT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=JOINT&partsCategoryCode=JOINT"),
          Entry(
              title: "KEY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=KEY&partsCategoryCode=KEY"),
          Entry(
              title: "KIT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=KIT&partsCategoryCode=KIT"),
          Entry(
              title: "KNOB",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=KNOB&partsCategoryCode=KNOB"),
          Entry(
              title: "KNUCKLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=KNUCKLE&partsCategoryCode=KNUCK"),
          Entry(
              title: "LAMP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LAMP&partsCategoryCode=LAMP"),
          Entry(
              title: "LATCH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LATCH&partsCategoryCode=LATCH"),
          Entry(
              title: "LATERAL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LATERAL&partsCategoryCode=LATER"),
          Entry(
              title: "LEVER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LEVER&partsCategoryCode=LEVER"),
          Entry(
              title: "LIGHT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LIGHT&partsCategoryCode=LGHT"),
          Entry(
              title: "LINE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LINE&partsCategoryCode=LINE"),
          Entry(
              title: "LINK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LINK&partsCategoryCode=LINK"),
          Entry(
              title: "LOCK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LOCK&partsCategoryCode=LOCK"),
          Entry(
              title: "LOGO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LOGO&partsCategoryCode=LOGO"),
          Entry(
              title: "LOWER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=LOWER&partsCategoryCode=LOWER"),
          Entry(
              title: "MASTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MASTER&partsCategoryCode=MASTE"),
          Entry(
              title: "MECHATRONIC",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MECHATRONIC&partsCategoryCode=MECHA"),
          Entry(
              title: "MIRROR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
          Entry(
              title: "MODULE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MODULE&partsCategoryCode=MODUL"),
          Entry(
              title: "MOLDING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MOLDING&partsCategoryCode=MOLDI"),
          Entry(
              title: "MOTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
          Entry(
              title: "MOUDLING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
          Entry(
              title: "MOUNT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
          Entry(
              title: "MOUNTING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
          Entry(
              title: "MULTIRIB",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=MULTIRIB&partsCategoryCode=MULTI"),
          Entry(
              title: "NOZZLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
          Entry(
              title: "NUT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=NUT&partsCategoryCode=NUT"),
          Entry(
              title: "OIL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=OIL&partsCategoryCode=OIL"),
          Entry(
              title: "OIL ASSY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
          Entry(
              title: "OIL CAP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=OIL CAP&partsCategoryCode=OILC"),
          Entry(
              title: "OIL COOLER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=OIL COOLER&partsCategoryCode=OILCO"),
          Entry(
              title: "O - RING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=O - RING&partsCategoryCode=O-R"),
          Entry(
              title: "OTHERS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=OTHERS&partsCategoryCode=OTHER"),
          Entry(
              title: "PAD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PAD&partsCategoryCode=PAD"),
          Entry(
              title: "PANEL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PANEL&partsCategoryCode=PANEL"),
          Entry(
              title: "PIECE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PIECE&partsCategoryCode=PIECE"),
          Entry(
              title: "PIN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PIN&partsCategoryCode=PIN"),
          Entry(
              title: "PIPE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PIPE&partsCategoryCode=PIPE"),
          Entry(
              title: "PISTON",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PISTON&partsCategoryCode=PISTO"),
          Entry(
              title: "PLATE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PLATE&partsCategoryCode=PLATE"),
          Entry(
              title: "PLUG",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PLUG&partsCategoryCode=PLUG"),
          Entry(
              title: "POWER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=POWER&partsCategoryCode=POWER"),
          Entry(
              title: "PRESSURE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PRESSURE&partsCategoryCode=PRESS"),
          Entry(
              title: "PROTECTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PROTECTOR&partsCategoryCode=PROTE"),
          Entry(
              title: "PULLEY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PULLEY&partsCategoryCode=PULLE"),
          Entry(
              title: "PULLY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PULLY&partsCategoryCode=PULLY"),
          Entry(
              title: "PUMP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=PUMP&partsCategoryCode=PUMP"),
          Entry(
              title: "RADIATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
          Entry(
              title: "RADIATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
          Entry(
              title: "RAIL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RAIL&partsCategoryCode=RAIL"),
          Entry(
              title: "REAR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=REAR&partsCategoryCode=REAR"),
          Entry(
              title: "REFLECTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
          Entry(
              title: "REGISTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=REGISTER&partsCategoryCode=REGIS"),
          Entry(
              title: "REGULATOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
          Entry(
              title: "REINFORCEMENT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=REINFORCEMENT&partsCategoryCode=REINF"),
          Entry(
              title: "RELAY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RELAY&partsCategoryCode=RELAY"),
          Entry(
              title: "RELEY",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RELEY&partsCategoryCode=RELEY"),
          Entry(
              title: "REPAIR KIT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=REPAIR KIT&partsCategoryCode=REPAI"),
          Entry(
              title: "RESERVOIR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
          Entry(
              title: "RESISTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RESISTOR&partsCategoryCode=RESIS"),
          Entry(
              title: "RIVET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RIVET&partsCategoryCode=RIVET"),
          Entry(
              title: "ROD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ROD&partsCategoryCode=ROD"),
          Entry(
              title: "ROLLER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ROLLER&partsCategoryCode=ROLLE"),
          Entry(
              title: "ROOF",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ROOF&partsCategoryCode=ROOF"),
          Entry(
              title: "ROTOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
          Entry(
              title: "RUBBER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=RUBBER&partsCategoryCode=RUBBE"),
          Entry(
              title: "SCREW",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SCREW&partsCategoryCode=SCREW"),
          Entry(
              title: "SEAL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SEAL&partsCategoryCode=SEAL"),
          Entry(
              title: "SEALING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SEALING&partsCategoryCode=SEALI"),
          Entry(
              title: "SEAT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SEAT&partsCategoryCode=SEAT"),
          Entry(
              title: "SENDER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SENDER&partsCategoryCode=SENDER"),
          Entry(
              title: "SENSOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SENSOR&partsCategoryCode=SENSO"),
          Entry(
              title: "SENSOR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SENSOR&partsCategoryCode=SENSOR"),
          Entry(
              title: "SHAFT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
          Entry(
              title: "SHOCK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
          Entry(
              title: "SIDE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SIDE&partsCategoryCode=SIDE"),
          Entry(
              title: "SLEEVE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SLEEVE&partsCategoryCode=SLEEV"),
          Entry(
              title: "SLIDE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SLIDE&partsCategoryCode=SLIDE"),
          Entry(
              title: "SOCKET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SOCKET&partsCategoryCode=SOCKE"),
          Entry(
              title: "SOLENOID",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SOLENOID&partsCategoryCode=SOLEN"),
          Entry(
              title: "SPACER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPACER&partsCategoryCode=SPACE"),
          Entry(
              title: "SPARK PLUG",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
          Entry(
              title: "SPEAKER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPEAKER&partsCategoryCode=SPEAK"),
          Entry(
              title: "SPINDLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPINDLE&partsCategoryCode=SPIND"),
          Entry(
              title: "SPOILER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
          Entry(
              title: "SPRAY NOZZLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPRAY NOZZLE&partsCategoryCode=SPRAY"),
          Entry(
              title: "SPRING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPRING&partsCategoryCode=SPRIN"),
          Entry(
              title: "SPROCKET",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SPROCKET&partsCategoryCode=SPROC"),
          Entry(
              title: "ST.LINK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=ST.LINK&partsCategoryCode=ST.LI"),
          Entry(
              title: "STABILIZER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STABILIZER&partsCategoryCode=STABI"),
          Entry(
              title: "STARTER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STARTER&partsCategoryCode=START"),
          Entry(
              title: "STEARING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STEARING&partsCategoryCode=STEAR"),
          Entry(
              title: "STEERING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STEERING&partsCategoryCode=STEER"),
          Entry(
              title: "STEERING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STEERING&partsCategoryCode=STEERING"),
          Entry(
              title: "STICKER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STICKER&partsCategoryCode=STICK"),
          Entry(
              title: "STOP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STOP&partsCategoryCode=STOP"),
          Entry(
              title: "STRIP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STRIP&partsCategoryCode=STRIP"),
          Entry(
              title: "STRUT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=STRUT&partsCategoryCode=STRUT"),
          Entry(
              title: "SUCTION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SUCTION&partsCategoryCode=SUCTI"),
          Entry(
              title: "SUN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SUN&partsCategoryCode=SUN"),
          Entry(
              title: "SUPPORT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
          Entry(
              title: "SUSPENSION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
          Entry(
              title: "SUSPENSION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SUSPENSION&partsCategoryCode=SUSPENSION"),
          Entry(
              title: "SWITCH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=SWITCH&partsCategoryCode=SWITC"),
          Entry(
              title: "TANK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TANK&partsCategoryCode=TANK"),
          Entry(
              title: "TENSIONER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
          Entry(
              title: "THERMOSTAT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
          Entry(
              title: "THROTTLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=THROTTLE&partsCategoryCode=THROT"),
          Entry(
              title: "TIE ROD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TIE ROD&partsCategoryCode=TIER"),
          Entry(
              title: "TIMING CHAIN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TIMING CHAIN&partsCategoryCode=TIMINC"),
          Entry(
              title: "TIRROD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TIRROD&partsCategoryCode=TIRRO"),
          Entry(
              title: "TRANSMISSION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
          Entry(
              title: "TRIM",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TRIM&partsCategoryCode=TRI"),
          Entry(
              title: "TRUNK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TRUNK&partsCategoryCode=TRUNK"),
          Entry(
              title: "TUBE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TUBE&partsCategoryCode=TUBE"),
          Entry(
              title: "TURBO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TURBO&partsCategoryCode=TURBO"),
          Entry(
              title: "TURN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TURN&partsCategoryCode=TURN"),
          Entry(
              title: "TYRE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=TYRE&partsCategoryCode=TYRE"),
          Entry(
              title: "UPPER ARM",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
          Entry(
              title: "VACCUM",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=VACCUM&partsCategoryCode=VACCU"),
          Entry(
              title: "VALVE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=VALVE&partsCategoryCode=VALVE"),
          Entry(
              title: "V-BELT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
          Entry(
              title: "VIBRATION",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=VIBRATION&partsCategoryCode=VIBRA"),
          Entry(
              title: "VOLTAGE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=VOLTAGE&partsCategoryCode=VOLTA"),
          Entry(
              title: "WASHER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WASHER&partsCategoryCode=WASHE"),
          Entry(
              title: "WATER PUMP",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
          Entry(
              title: "WEATER STRIPE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WEATER STRIPE&partsCategoryCode=WEATE"),
          Entry(
              title: "WHEEL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
          Entry(
              title: "WIND",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WIND&partsCategoryCode=WIND"),
          Entry(
              title: "WINDOW",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WINDOW&partsCategoryCode=WINDO"),
          Entry(
              title: "WINDSHIELD",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WINDSHIELD&partsCategoryCode=WINDS"),
          Entry(
              title: "WIPER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WIPER&partsCategoryCode=WIPER"),
          Entry(
              title: "WIRING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WIRING&partsCategoryCode=WIRIN"),
          Entry(
              title: "WISH BONE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&partsCategory=WISH BONE&partsCategoryCode=WISH"),
        ],
      ),
      Entry(
        title: 'ELRING && GERMANY',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=CHINA&origincode=CHI",
        submenu: <Entry>[
          Entry(
              title: "CHINA",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=CHINA&origincode=CHI"),
          Entry(
              title: "CONTI",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=CONTI&origincode=CON"),
          Entry(
              title: "DENSO",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=DENSO&origincode=DSO"),
          Entry(
              title: "ELRING",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=ELRING&origincode=ELR"),
          Entry(
              title: "FEBI",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=FEBI&origincode=FBI"),
          Entry(
              title: "GERMANY",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=GERMANY&origincode=GER"),
          Entry(
              title: "HENGST",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=HENGST&origincode=HST"),
          Entry(
              title: "LEMFORDER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=LEMFORDER&origincode=LEM"),
        ],
      ),
      Entry(
        title: 'MAHLE && NISSENS',
        url:
            "/catalog/products?make=AU&makeCode=AUDI&origin=MAHLE&origincode=MHF",
        submenu: <Entry>[
          Entry(
              title: "MAHLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAHLE&origincode=MHF"),
          Entry(
              title: "MAN",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAN&origincode=MAN"),
          Entry(
              title: "MAXPART",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAXPART&origincode=MXP"),
          Entry(
              title: "MAYER",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MAYER&origincode=MAYER"),
          Entry(
              title: "MEYLE",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=MEYLE&origincode=MEY"),
          Entry(
              title: "MOBIL 1",
              url:
                  "/catalog/products?make=MB&makeCode=AUDI&origin=MOBIL 1&origincode=MOB"),
          Entry(
              title: "NISSENS",
              url:
                  "/catalog/products?make=AU&makeCode=AUDI&origin=NISSENS&origincode=NIS")
        ],
      ),
      Entry(
        title: 'AUTOSTAR && BOSCH',
        url: "/catalog/products?make=BM&makeCode=BMW&origin=ATC&origincode=ATC",
        submenu: <Entry>[
          Entry(
              title: "ATC",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=ATC&origincode=ATC"),
          Entry(
              title: "AUTOSTAR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=AUTOSTAR&origincode=AST"),
          Entry(
              title: "BEHR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=BEHR&origincode=BHR"),
          Entry(
              title: "BILSTIEN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=BILSTIEN&origincode=BLN"),
          Entry(
              title: "BLUE PRINT",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=BLUE PRINT&origincode=BLP"),
          Entry(
              title: "BOGE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=BOGE&origincode=BOG"),
          Entry(
              title: "BOSCH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=BOSCH&origincode=BSH"),
        ],
      ),
      Entry(
        title: 'BREMI && FERRADO',
        url:
            "/catalog/products?make=BM&makeCode=BMW&origin=BREMI&origincode=BMI",
        submenu: <Entry>[
          Entry(
              title: "BREMI",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=BREMI&origincode=BMI"),
          Entry(
              title: "CONTI",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=CONTI&origincode=CON"),
          Entry(
              title: "CORTECO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=CORTECO&origincode=COR"),
          Entry(
              title: "DENSO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=DENSO&origincode=DSO"),
          Entry(
              title: "ELFOTECH",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=ELFOTECH&origincode=ELF"),
          Entry(
              title: "ELRING",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=ELRING&origincode=ELR"),
          Entry(
              title: "FAG",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=FAG&origincode=FTE"),
          Entry(
              title: "FEBI",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=FEBI&origincode=FBI"),
          Entry(
              title: "FERRADO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=FERRADO&origincode=FER"),
        ],
      ),
      Entry(
        title: 'GERMANY && GOETZE',
        url:
            "/catalog/products?make=MB&makeCode=BMW&origin=GERMANY&origincode=GER",
        submenu: <Entry>[
          Entry(
              title: "GERMANY",
              url:
                  "/catalog/products?make=MB&makeCode=BMW&origin=GERMANY&origincode=GER"),
          Entry(
              title: "GKN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=GKN&origincode=GKN"),
          Entry(
              title: "GOETZE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=GOETZE&origincode=GTZ"),
          Entry(
              title: "HELLA",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=HELLA&origincode=HLA"),
          Entry(
              title: "HENGST",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=HENGST&origincode=HST"),
          Entry(
              title: "HENGST",
              url:
                  "/catalog/products?make=MB&makeCode=BMW&origin=HENGST&origincode=HST"),
          Entry(
              title: "JAPAN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=JAPAN&origincode=JAPAN"),
          Entry(
              title: "LEMFORDER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=LEMFORDER&origincode=LEM"),
        ],
      ),
      Entry(
        title: 'MAYER && NISSENS',
        url: "/catalog/products?make=BM&makeCode=BMW&origin=LUK&origincode=LUK",
        submenu: <Entry>[
          Entry(
              title: "LUK",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=LUK&origincode=LUK"),
          Entry(
              title: "MAGNET MARELLI",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MAGNET MARELLI&origincode=MM"),
          Entry(
              title: "MAHLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MAHLE&origincode=MHF"),
          Entry(
              title: "MAN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MAN&origincode=MAN"),
          Entry(
              title: "MAXPART",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MAXPART&origincode=MXP"),
          Entry(
              title: "MAYER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MAYER&origincode=MAYER"),
          Entry(
              title: "MEYLE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MEYLE&origincode=MEY"),
          Entry(
              title: "MOBIL 1",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=MOBIL 1&origincode=MOB"),
          Entry(
              title: "NISSENS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=NISSENS&origincode=NIS")
        ],
      ),
      Entry(
        title: 'ORIGINAL && SIMMER',
        url:
            "/catalog/products?make=BM&makeCode=BMW&origin=ORIGINAL&origincode=OE",
        submenu: <Entry>[
          Entry(
              title: "ORIGINAL",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=ORIGINAL&origincode=OE"),
          Entry(
              title: "OSRAM",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=OSRAM&origincode=OSR"),
          Entry(
              title: "PIERBURG",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=PIERBURG&origincode=PBG"),
          Entry(
              title: "PIRELLI",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=PIRELLI&origincode=PIR"),
          Entry(
              title: "REMSA",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=REMSA&origincode=REM"),
          Entry(
              title: "RHEINMANN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=RHEINMANN&origincode=RM"),
          Entry(
              title: "SACHS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=SACHS&origincode=SCH"),
          Entry(
              title: "SIMMER",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=SIMMER&origincode=SIM"),
          Entry(
              title: "SKF",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=SKF&origincode=SKF"),
          Entry(
              title: "SPARX",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=SPARX&origincode=SPX"),
        ],
      ),
      Entry(
        title: 'TEXTAR && VAICO',
        url:
            "/catalog/products?make=BM&makeCode=BMW&origin=STABILUS&origincode=STB",
        submenu: <Entry>[
          Entry(
              title: "STABILUS",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=STABILUS&origincode=STB"),
          Entry(
              title: "TAIWAN",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=TAIWAN&origincode=TWN"),
          Entry(
              title: "TEXTAR",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=TEXTAR&origincode=TEX"),
          Entry(
              title: "TOPDRIVE",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=TOPDRIVE&origincode=TDR"),
          Entry(
              title: "TRUCKTEC",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=TRUCKTEC&origincode=TTC"),
          Entry(
              title: "TRW",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=TRW&origincode=TRW"),
          Entry(
              title: "USED",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=USED&origincode=USD"),
          Entry(
              title: "VAICO",
              url:
                  "/catalog/products?make=BM&makeCode=BMW&origin=VAICO&origincode=VKO"),
        ],
      ),
      Entry(
          title: "VALEO",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=VALEO&origincode=VAL"),
      Entry(
          title: "VARTA",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=VARTA&origincode=VAR"),
      Entry(
          title: "VDO",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=VDO&origincode=VDO"),
      Entry(
          title: "VICTOR REINZ",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=VICTOR REINZ&origincode=RNZ"),
      Entry(
          title: "WABCO",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=WABCO&origincode=WAB"),
      Entry(
          title: "WAHLER",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=WAHLER&origincode=WAH"),
      Entry(
          title: "ZF",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=ZF&origincode=ZF"),
      Entry(
          title: "ZIMMERMANN",
          url:
              "/catalog/products?make=BM&makeCode=BMW&origin=ZIMMERMANN&origincode=ZIM")
    ],
  ),
  Entry(
    title: 'ACDELCO',
    image: 'assets/brands/acdelco.png',
    url: '/catalog/products?make=ACDELCO&makeCode=ACDELCO',
    submenu: <Entry>[
      Entry(
          title: "ACDELCO",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&origin=ACDELCO&origincode=ACDELCO"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "U.S.A",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&origin=U.S.A&origincode=U.S.A"),
      Entry(
          title: "ALTERNATOR",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "COMPRESSOR",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
      Entry(
          title: "CONDENSER ",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=CONDENSER &partsCategoryCode=COND"),
      Entry(
          title: "FUEL",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=FUEL&partsCategoryCode=FU"),
      Entry(
          title: "HAND",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=HAND&partsCategoryCode=HAN"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OIL ASSY",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
      Entry(
          title: "PLUG",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=PLUG&partsCategoryCode=PLUG"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHAFT",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=AD&makeCode=ACDELCO&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: 'ASTON',
    url: '/catalog/products?make=ASTON&makeCode=ASTON',
    image: 'assets/brands/ASTON.png',
    submenu: <Entry>[
      Entry(
          title: "ACDELCO",
          url:
              "/catalog/products?make=ASTON&makeCode=ASTON&origin=ACDELCO&origincode=ACDELCO"),
      Entry(
          title: "ABSORBER",
          url:
              "/catalog/products?make=ASTON&makeCode=ASTON&partsCategory=ABSORBER&partsCategoryCode=ABSORBER"),
    ],
  ),
  Entry(
    title: "BENTLEY",
    url: "/catalog/products?make=BENTLEY&makeCode=BENTLEY",
    image: 'assets/brands/BENTLEY.png',
    submenu: <Entry>[
      Entry(
          title: "BREMBO",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&origin=BREMBO&origincode=BREMBO"),
      Entry(
          title: "GERMANY",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&origin=GERMANY&origincode=GER"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "U.K",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&origin=U.K&origincode=UK"),
      Entry(
          title: "A/C",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=A/C&partsCategoryCode=A/C"),
      Entry(
          title: "AIR",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=AIR&partsCategoryCode=AIR"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "AXLE",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=AXLE&partsCategoryCode=AXLE"),
      Entry(
          title: "BALL JOINT",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=BALL JOINT&partsCategoryCode=BALL JOINT"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE PAD"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "BUMPER",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=BUMPER&partsCategoryCode=BUMPER"),
      Entry(
          title: "CONTROL",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=CONTROL&partsCategoryCode=CONTR"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "GEAR",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=GEAR&partsCategoryCode=GEAR"),
      Entry(
          title: "HEAD",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=HEAD&partsCategoryCode=HEAD"),
      Entry(
          title: "HUB",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=HUB&partsCategoryCode=HUB"),
      Entry(
          title: "PIPE",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=PIPE&partsCategoryCode=PIPE"),
      Entry(
          title: "PLUG",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=PLUG&partsCategoryCode=PLUG"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=STEERING&partsCategoryCode=STEERING"),
      Entry(
          title: "WHEEL",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=BENTLEY&makeCode=BENTLEY&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: "CADILLIC",
    url: "/catalog/products?make=CADILLIC&makeCode=CADILLIC",
    image: 'assets/brands/CADILLAC.png',
    submenu: <Entry>[
      Entry(
          title: "GERMANY",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&origin=GERMANY&origincode=GER"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "BATTERY",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=BATTERY&partsCategoryCode=BA"),
      Entry(
          title: "BAR",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=BAR&partsCategoryCode=BAR"),
      Entry(
          title: "BULB",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=BULB&partsCategoryCode=BLB"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "CONDENSER ",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=CONDENSER &partsCategoryCode=COND"),
      Entry(
          title: "DICKY",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=DICKY&partsCategoryCode=DICKY"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "GRILL",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=GRILL&partsCategoryCode=GRILL"),
      Entry(
          title: "LINK",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=LINK&partsCategoryCode=LINK"),
      Entry(
          title: "LOWER",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=LOWER&partsCategoryCode=LOWER"),
      Entry(
          title: "MASTER",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=MASTER&partsCategoryCode=MASTE"),
      Entry(
          title: "MIRROR",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
      Entry(
          title: "MODULE",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=MODULE&partsCategoryCode=MODUL"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "PLUG",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=PLUG&partsCategoryCode=PLUG"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHAFT",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "STABILIZER",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=STABILIZER&partsCategoryCode=STABI"),
      Entry(
          title: "SWITCH",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=SWITCH&partsCategoryCode=SWITC"),
      Entry(
          title: "TENSIONER",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "TIMING",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=TIMING&partsCategoryCode=TIMIN"),
      Entry(
          title: "TRANSMISSION",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
      Entry(
          title: "UPPER ARM",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WHEEL",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
      Entry(
          title: "WIRE",
          url:
              "/catalog/products?make=CADILLIC&makeCode=CADILLIC&partsCategory=WIRE&partsCategoryCode=WIRE"),
    ],
  ),
  Entry(
    title: "CHEVROLET",
    url: "/catalog/products?make=CHEVROLET&makeCode=CHEVROLET",
    image: 'assets/brands/CHEVROLET.png',
    submenu: <Entry>[
      Entry(
          title: "ACDELCO",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&origin=ACDELCO&origincode=ACDELCO"),
      Entry(
          title: "KOYO",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&origin=KOYO&origincode=KOYO"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "ABSORBER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=ABSORBER&partsCategoryCode=ABSORBER"),
      Entry(
          title: "AC DRIER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "BEARING",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=BEARING&partsCategoryCode=BEA"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BOOT",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=BOOT&partsCategoryCode=BOOT"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "BUSH",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=BUSH&partsCategoryCode=BUSH"),
      Entry(
          title: "CABLE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=CABLE&partsCategoryCode=CAB"),
      Entry(
          title: "COIL",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=COIL&partsCategoryCode=COIL"),
      Entry(
          title: "COOLANT",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=COOLANT&partsCategoryCode=COOLA"),
      Entry(
          title: "ELECTRICAL",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
      Entry(
          title: "EVAPORATOR",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
      Entry(
          title: "EXPANSION",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
      Entry(
          title: "FAN",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=FAN&partsCategoryCode=FAN"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FOG",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=FOG&partsCategoryCode=FOG"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GEAR",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=GEAR&partsCategoryCode=GR"),
      Entry(
          title: "HOSE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=HOSE&partsCategoryCode=HOSE"),
      Entry(
          title: "LAMP",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=LAMP&partsCategoryCode=LAMP"),
      Entry(
          title: "LOWER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=LOWER&partsCategoryCode=LOWER"),
      Entry(
          title: "MOUNT",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OIL ASSY",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
      Entry(
          title: "PIPE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=PIPE&partsCategoryCode=PIPE"),
      Entry(
          title: "PLUG",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=PLUG&partsCategoryCode=PLUG"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SILICON",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=SILICON&partsCategoryCode=SILIC"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "STAB LINK",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=STAB LINK&partsCategoryCode=STAB"),
      Entry(
          title: "STABILIZER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=STABILIZER&partsCategoryCode=STABI"),
      Entry(
          title: "TENSIONER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
      Entry(
          title: "THERMOSTAT",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "TRANSMISSION",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
      Entry(
          title: "VALVE",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=VALVE&partsCategoryCode=VALVE"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WINDOW",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=WINDOW&partsCategoryCode=WINDO"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=CH&makeCode=CHEVROLET&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: "FERRARI",
    url: "/catalog/products?make=FERRARI&makeCode=FERRARI",
    image: 'assets/brands/FERRARI.png',
    submenu: <Entry>[
      Entry(
          title: "BRITPART",
          url:
              "/catalog/products?make=FR&makeCode=FERRARI&origin=BRITPART&origincode=BRIT"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=FR&makeCode=FERRARI&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=FR&makeCode=FERRARI&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=FR&makeCode=FERRARI&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=FR&makeCode=FERRARI&partsCategory=STEERING&partsCategoryCode=STEERING"),
    ],
  ),
  Entry(
    title: "FORD",
    url: "/catalog/products?make=FORD&makeCode=FORD",
    image: 'assets/brands/FORD.png',
    submenu: <Entry>[
      Entry(
          title: "GERMANY",
          url:
              "/catalog/products?make=FD&makeCode=FORD&origin=GERMANY&origincode=GER"),
      Entry(
          title: "LEMFORDER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&origin=LEMFORDER&origincode=LEM"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=FD&makeCode=FORD&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=FD&makeCode=FORD&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "U.K",
          url:
              "/catalog/products?make=FD&makeCode=FORD&origin=U.K&origincode=UK"),
      Entry(
          title: "A/C",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=A/C&partsCategoryCode=AC"),
      Entry(
          title: "AC BELT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=AC BELT&partsCategoryCode=ACBE"),
      Entry(
          title: "AC COMPRESSOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
      Entry(
          title: "ADAPTER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
      Entry(
          title: "AIR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=AIR&partsCategoryCode=AIR"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "AXLE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=AXLE&partsCategoryCode=AX"),
      Entry(
          title: "BALL JOINT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
      Entry(
          title: "BAR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BAR&partsCategoryCode=BAR"),
      Entry(
          title: "BEARING",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BEARING&partsCategoryCode=BEA"),
      Entry(
          title: "BULB",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BULB&partsCategoryCode=BLB"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BUMPER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BUMPER&partsCategoryCode=BMP"),
      Entry(
          title: "BOLT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BOLT&partsCategoryCode=BOLT"),
      Entry(
          title: "BRACKET",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BRACKET&partsCategoryCode=BRACK"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRG",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BRG&partsCategoryCode=BRG"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "BUSH",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=BUSH&partsCategoryCode=BUSH"),
      Entry(
          title: "CALIPER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=CALIPER&partsCategoryCode=CALIP"),
      Entry(
          title: "CLUTCH",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
      Entry(
          title: "COMPRESSOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
      Entry(
          title: "COOLANT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=COOLANT&partsCategoryCode=COOLA"),
      Entry(
          title: "COOLENT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=COOLENT&partsCategoryCode=COOLENT"),
      Entry(
          title: "COOLER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=COOLER&partsCategoryCode=COOLER"),
      Entry(
          title: "COVER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=COVER&partsCategoryCode=COVER"),
      Entry(
          title: "CUT BUSH",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
      Entry(
          title: "CV JOINT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=CV JOINT&partsCategoryCode=CVJO"),
      Entry(
          title: "CYLINDER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=CYLINDER&partsCategoryCode=CYL"),
      Entry(
          title: "DISC",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=DISC&partsCategoryCode=DISC"),
      Entry(
          title: "DOOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=DOOR&partsCategoryCode=DOOR"),
      Entry(
          title: "DRIER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=DRIER&partsCategoryCode=DRIER"),
      Entry(
          title: "DRIVE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FOG",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=FOG&partsCategoryCode=FOG"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "FUEL",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=FUEL&partsCategoryCode=FU"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GLASS",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=GLASS&partsCategoryCode=GL"),
      Entry(
          title: "GEAR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=GEAR&partsCategoryCode=GR"),
      Entry(
          title: "HEAD",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=HEAD&partsCategoryCode=HEAD"),
      Entry(
          title: "HEAT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=HEAT&partsCategoryCode=HEAT"),
      Entry(
          title: "HOOD",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=HOOD&partsCategoryCode=HOOD"),
      Entry(
          title: "HOSE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=HOSE&partsCategoryCode=HOSE"),
      Entry(
          title: "IDLER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=IDLER&partsCategoryCode=IDLER"),
      Entry(
          title: "INJECTOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
      Entry(
          title: "JOINT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=JOINT&partsCategoryCode=JOINT"),
      Entry(
          title: "KIT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=KIT&partsCategoryCode=KIT"),
      Entry(
          title: "LAMP",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=LAMP&partsCategoryCode=LAMP"),
      Entry(
          title: "LINK",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=LINK&partsCategoryCode=LINK"),
      Entry(
          title: "LOCK",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=LOCK&partsCategoryCode=LOCK"),
      Entry(
          title: "LOWER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=LOWER&partsCategoryCode=LOWER"),
      Entry(
          title: "MASTER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=MASTER&partsCategoryCode=MASTE"),
      Entry(
          title: "MIRROR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
      Entry(
          title: "MODULE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=MODULE&partsCategoryCode=MODUL"),
      Entry(
          title: "MOUDLING",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
      Entry(
          title: "MOUNT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OIL ASSY",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "PAD",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=PAD&partsCategoryCode=PAD"),
      Entry(
          title: "PIPE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=PIPE&partsCategoryCode=PIPE"),
      Entry(
          title: "PLUG",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=PLUG&partsCategoryCode=PLUG"),
      Entry(
          title: "PULLEY",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=PULLEY&partsCategoryCode=PULLE"),
      Entry(
          title: "PUMP",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=PUMP&partsCategoryCode=PUMP"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "REAR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=REAR&partsCategoryCode=REAR"),
      Entry(
          title: "RING",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=RING&partsCategoryCode=RING"),
      Entry(
          title: "ROTOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHAFT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "STABILIZER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=STABILIZER&partsCategoryCode=STABI"),
      Entry(
          title: "STARTER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=STARTER&partsCategoryCode=START"),
      Entry(
          title: "STB LINK",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=STB LINK&partsCategoryCode=STBL"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=STEERING&partsCategoryCode=STEER"),
      Entry(
          title: "STRUT",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=STRUT&partsCategoryCode=STRUT"),
      Entry(
          title: "SWITCH",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=SWITCH&partsCategoryCode=SWITC"),
      Entry(
          title: "TENSIONER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
      Entry(
          title: "THROTTLE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=THROTTLE&partsCategoryCode=THROT"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "TIMING",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=TIMING&partsCategoryCode=TIMIN"),
      Entry(
          title: "TIMING CHAIN",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=TIMING CHAIN&partsCategoryCode=TIMINC"),
      Entry(
          title: "TRANSMISSION",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
      Entry(
          title: "UPPER ARM",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
      Entry(
          title: "VALVE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=VALVE&partsCategoryCode=VALVE"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WHEEL",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=WIPER&partsCategoryCode=WIPER"),
      Entry(
          title: "WISH BONE",
          url:
              "/catalog/products?make=FD&makeCode=FORD&partsCategory=WISH BONE&partsCategoryCode=WISH"),
    ],
  ),
  Entry(
    title: "FREELANDER LR2",
    url: "/catalog/products?make=FREELANDER LR2&makeCode=FREELANDER LR2",
    image: 'assets/brands/land-rover3.jpg',
    submenu: <Entry>[
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=FLLR2&makeCode=FREELANDER LR2&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=FLLR2&makeCode=FREELANDER LR2&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
    ],
  ),
  Entry(
    title: "G.M.C",
    url: "/catalog/products?make=G.M.C&makeCode=G.M.C",
    image: 'assets/brands/GMC.png',
    submenu: <Entry>[
      Entry(
          title: "ACDELCO",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&origin=ACDELCO&origincode=ACDELCO"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "BEARING",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=BEARING&partsCategoryCode=BEA"),
      Entry(
          title: "BLADE",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=BLADE&partsCategoryCode=BLADE"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "CHAIN",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=CHAIN&partsCategoryCode=CHA"),
      Entry(
          title: "COIL",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=COIL&partsCategoryCode=COIL"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GUIDE",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
      Entry(
          title: "HAND",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=HAND&partsCategoryCode=HAN"),
      Entry(
          title: "HEAD",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=HEAD&partsCategoryCode=HEAD"),
      Entry(
          title: "HOUSING",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=HOUSING&partsCategoryCode=HOUSING"),
      Entry(
          title: "INJECTOR",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
      Entry(
          title: "LINK",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=LINK&partsCategoryCode=LINK"),
      Entry(
          title: "LOWER",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=LOWER&partsCategoryCode=LOWER"),
      Entry(
          title: "MOUNT",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "STEARING",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=STEARING&partsCategoryCode=STEAR"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=STEERING&partsCategoryCode=STEER"),
      Entry(
          title: "TENSIONER",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
      Entry(
          title: "VALVE",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=VALVE&partsCategoryCode=VALVE"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=G.M.C&makeCode=G.M.C&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: "HONDA",
    url: "/catalog/products?make=HONDA&makeCode=HONDA",
    image: 'assets/brands/HONDA.jpg',
    submenu: <Entry>[
      Entry(
          title: "GERMANY",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&origin=GERMANY&origincode=GER"),
      Entry(
          title: "JAPAN",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&origin=JAPAN&origincode=JAPAN"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "USED",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&origin=USED&origincode=USD"),
      Entry(
          title: "AC COMPRESSOR",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "ATF",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=ATF&partsCategoryCode=ATF"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BUMPER",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BUMPER&partsCategoryCode=BMP"),
      Entry(
          title: "BOOT",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BOOT&partsCategoryCode=BOOT"),
      Entry(
          title: "BRACKET",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BRACKET&partsCategoryCode=BRACK"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "BUSH",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=BUSH&partsCategoryCode=BUSH"),
      Entry(
          title: "COIL",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=COIL&partsCategoryCode=COIL"),
      Entry(
          title: "CONDENSER ",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=CONDENSER &partsCategoryCode=COND"),
      Entry(
          title: "COVER",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=COVER&partsCategoryCode=COVER"),
      Entry(
          title: "DISC",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=DISC&partsCategoryCode=DISC"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "EXPANSION",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GEAR",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=GEAR&partsCategoryCode=GR"),
      Entry(
          title: "LINE",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=LINE&partsCategoryCode=LINE"),
      Entry(
          title: "MIRROR",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OIL ASSY",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "PAD",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=PAD&partsCategoryCode=PAD"),
      Entry(
          title: "PULLEY",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=PULLEY&partsCategoryCode=PULLE"),
      Entry(
          title: "PUMP",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=PUMP&partsCategoryCode=PUMP"),
      Entry(
          title: "REGISTER",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=REGISTER&partsCategoryCode=REGIS"),
      Entry(
          title: "RUBBER",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=RUBBER&partsCategoryCode=RUBBE"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "STEARING",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=STEARING&partsCategoryCode=STEAR"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=STEERING&partsCategoryCode=STEER"),
      Entry(
          title: "STRUT",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=STRUT&partsCategoryCode=STRUT"),
      Entry(
          title: "WINDOW",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=WINDOW&partsCategoryCode=WINDO"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=HO&makeCode=HONDA&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: "HUMMER",
    url: "/catalog/products?make=HUMMER&makeCode=HUMMER",
    image: 'assets/brands/hummer.png',
    submenu: <Entry>[
      Entry(
          title: "HENGST",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&origin=HENGST&origincode=HST"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "U.S.A",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&origin=U.S.A&origincode=U.S.A"),
      Entry(
          title: "ABSORBER",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=ABSORBER&partsCategoryCode=ABS"),
      Entry(
          title: "BEARING",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=BEARING&partsCategoryCode=BEA"),
      Entry(
          title: "BULB",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=BULB&partsCategoryCode=BLB"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BUSH",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=BUSH&partsCategoryCode=BUSH"),
      Entry(
          title: "CAP",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=CAP&partsCategoryCode=CAP"),
      Entry(
          title: "CUT BUSH",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "GRILL",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=GRILL&partsCategoryCode=GRILL"),
      Entry(
          title: "HAND",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=HAND&partsCategoryCode=HAN"),
      Entry(
          title: "HEAD",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=HEAD&partsCategoryCode=HEAD"),
      Entry(
          title: "JOINT",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=JOINT&partsCategoryCode=JOINT"),
      Entry(
          title: "LOWER",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=LOWER&partsCategoryCode=LOWER"),
      Entry(
          title: "MIRROR",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "POWER",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=POWER&partsCategoryCode=POWER"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "REAR",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=REAR&partsCategoryCode=REAR"),
      Entry(
          title: "RELAY",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=RELAY&partsCategoryCode=RELAY"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "SPRING",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=SPRING&partsCategoryCode=SPRIN"),
      Entry(
          title: "STABILIZER",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=STABILIZER&partsCategoryCode=STABI"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=HUMMER&makeCode=HUMMER&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: "HYUNDAI",
    url: "/catalog/products?make=HYUNDAI&makeCode=HYUNDAI",
    image: 'assets/brands/Hyundai.png',
    submenu: <Entry>[
      Entry(
          title: "KOYO",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&origin=KOYO&origincode=KOYO"),
      Entry(
          title: "NISSENS",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&origin=NISSENS&origincode=NIS"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "ABSORBER",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=ABSORBER&partsCategoryCode=ABS"),
      Entry(
          title: "A/C",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=A/C&partsCategoryCode=AC"),
      Entry(
          title: "AIR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=AIR&partsCategoryCode=AIR"),
      Entry(
          title: "ALTERNATOR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
      Entry(
          title: "BALL JOINT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
      Entry(
          title: "BEARING",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BEARING&partsCategoryCode=BEA"),
      Entry(
          title: "BEAM",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BEAM&partsCategoryCode=BEAM"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BLOWER",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BLOWER&partsCategoryCode=BLW"),
      Entry(
          title: "BUMPER",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BUMPER&partsCategoryCode=BMP"),
      Entry(
          title: "BOOT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BOOT&partsCategoryCode=BOOT"),
      Entry(
          title: "BRACKET",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BRACKET&partsCategoryCode=BRACK"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "CHAIN",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=CHAIN&partsCategoryCode=CHA"),
      Entry(
          title: "COIL",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=COIL&partsCategoryCode=COIL"),
      Entry(
          title: "COMPRESSOR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
      Entry(
          title: "CONDENSER ",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=CONDENSER &partsCategoryCode=COND"),
      Entry(
          title: "COVER",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=COVER&partsCategoryCode=COVER"),
      Entry(
          title: "CUT BUSH",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
      Entry(
          title: "DOOR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=DOOR&partsCategoryCode=DOOR"),
      Entry(
          title: "EMBLEM",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=EMBLEM&partsCategoryCode=EMB"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "EVAPORATOR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
      Entry(
          title: "EXPANSION",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FOG",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=FOG&partsCategoryCode=FOG"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GRILL",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=GRILL&partsCategoryCode=GRILL"),
      Entry(
          title: "GUIDE",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
      Entry(
          title: "HEAD",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=HEAD&partsCategoryCode=HEAD"),
      Entry(
          title: "HOOD",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=HOOD&partsCategoryCode=HOOD"),
      Entry(
          title: "HOSE",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=HOSE&partsCategoryCode=HOSE"),
      Entry(
          title: "INJECTOR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
      Entry(
          title: "JOINT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=JOINT&partsCategoryCode=JOINT"),
      Entry(
          title: "KEY",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=KEY&partsCategoryCode=KEY"),
      Entry(
          title: "KIT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=KIT&partsCategoryCode=KIT"),
      Entry(
          title: "MIRROR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
      Entry(
          title: "MOUDLING",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
      Entry(
          title: "NOZZLE",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "PANEL",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=PANEL&partsCategoryCode=PANEL"),
      Entry(
          title: "PISTON",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=PISTON&partsCategoryCode=PISTO"),
      Entry(
          title: "PUMP",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=PUMP&partsCategoryCode=PUMP"),
      Entry(
          title: "RESERVOIR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHAFT",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "STABILIZER",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=STABILIZER&partsCategoryCode=STABI"),
      Entry(
          title: "STB LINK",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=STB LINK&partsCategoryCode=STBL"),
      Entry(
          title: "STEARING",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=STEARING&partsCategoryCode=STEAR"),
      Entry(
          title: "STRIP",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=STRIP&partsCategoryCode=STRIP"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "VALVE",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=VALVE&partsCategoryCode=VALVE"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WHEEL",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
      Entry(
          title: "WINDOW",
          url:
              "/catalog/products?make=HY&makeCode=HYUNDAI&partsCategory=WINDOW&partsCategoryCode=WINDO"),
    ],
  ),
  Entry(
    title: "JAGUAR",
    url: "/catalog/products?make=JAGUAR&makeCode=JAGUAR",
    image: 'assets/brands/JAGUAR.png',
    submenu: <Entry>[
      Entry(
          title: "COUNTY",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=COUNTY&origincode=COUNTY"),
      Entry(
          title: "DENSO",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=DENSO&origincode=DSO"),
      Entry(
          title: "GERMANY",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=GERMANY&origincode=GER"),
      Entry(
          title: "GKN",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=GKN&origincode=GKN"),
      Entry(
          title: "HELLA",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=HELLA&origincode=HLA"),
      Entry(
          title: "LEMFORDER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=LEMFORDER&origincode=LEM"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TRW",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=TRW&origincode=TRW"),
      Entry(
          title: "U.K",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=U.K&origincode=UK"),
      Entry(
          title: "USED",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&origin=USED&origincode=USD"),
      Entry(
          title: "AC COMPRESSOR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
      Entry(
          title: "AC CONDENSER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
      Entry(
          title: "ANTI FREEZE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=ANTI FREEZE&partsCategoryCode=ANTI"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "AXLE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=AXLE&partsCategoryCode=AXLE"),
      Entry(
          title: "BATTERY",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BATTERY&partsCategoryCode=BA"),
      Entry(
          title: "BADGE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BADGE&partsCategoryCode=BADGE"),
      Entry(
          title: "BALL JOINT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
      Entry(
          title: "BAR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BAR&partsCategoryCode=BAR"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BELT&partsCategoryCode=BELT"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BONET",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BONET&partsCategoryCode=BO"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "BUMPER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BUMPER&partsCategoryCode=BUMPER"),
      Entry(
          title: "BUSH",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=BUSH&partsCategoryCode=BUSH"),
      Entry(
          title: "CAP",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=CAP&partsCategoryCode=CAP"),
      Entry(
          title: "CHAIN",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=CHAIN&partsCategoryCode=CHAIN"),
      Entry(
          title: "COOLANT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=COOLANT&partsCategoryCode=COOLA"),
      Entry(
          title: "COVER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=COVER&partsCategoryCode=COVER"),
      Entry(
          title: "CUT BUSH",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
      Entry(
          title: "ELEMENT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=ELEMENT&partsCategoryCode=ELEME"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
      Entry(
          title: "EVAPORATOR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
      Entry(
          title: "EXPANSION",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FOG",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=FOG&partsCategoryCode=FOG"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GRILL",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=GRILL&partsCategoryCode=GRILL"),
      Entry(
          title: "IGNITION",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
      Entry(
          title: "INSULATOR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
      Entry(
          title: "JOINT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=JOINT&partsCategoryCode=JOINT"),
      Entry(
          title: "KIT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=KIT&partsCategoryCode=KIT"),
      Entry(
          title: "LINK",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=LINK&partsCategoryCode=LINK"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OIL ASSY",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "PULLEY",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=PULLEY&partsCategoryCode=PULLE"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "REAR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=REAR&partsCategoryCode=REAR"),
      Entry(
          title: "REGULATOR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHAFT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "SPRING",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=SPRING&partsCategoryCode=SPRIN"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=STEERING&partsCategoryCode=STEER"),
      Entry(
          title: "SUSPENSION",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
      Entry(
          title: "TANK",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=TANK&partsCategoryCode=TANK"),
      Entry(
          title: "TENSIONER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
      Entry(
          title: "THERMOSTAT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
      Entry(
          title: "THERMOSTAT",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=THERMOSTAT&partsCategoryCode=THERMOSTAT"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "UPPER ARM",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
      Entry(
          title: "VALVE",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=VALVE&partsCategoryCode=VALVE"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WHEEL",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=JAGUAR&makeCode=JAGUAR&partsCategory=WIPER&partsCategoryCode=WIPER"),
    ],
  ),
  Entry(
    title: "JEEP",
    url: "/catalog/products?make=JEEP&makeCode=JEEP",
    image: 'assets/brands/JEEP.png',
    submenu: <Entry>[
      Entry(
          title: "ACDELCO",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=ACDELCO&origincode=ACDELCO"),
      Entry(
          title: "CHINA",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=CHINA&origincode=CHI"),
      Entry(
          title: "DENSO",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=DENSO&origincode=DSO"),
      Entry(
          title: "GERMANY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=GERMANY&origincode=GER"),
      Entry(
          title: "JAPAN",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=JAPAN&origincode=JAPAN"),
      Entry(
          title: "LEMFORDER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=LEMFORDER&origincode=LEM"),
      Entry(
          title: "LUK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=LUK&origincode=LUK"),
      Entry(
          title: "MAXPART",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=MAXPART&origincode=MXP"),
      Entry(
          title: "ORIGINAL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=ORIGINAL&origincode=OE"),
      Entry(
          title: "TAIWAN",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=TAIWAN&origincode=TWN"),
      Entry(
          title: "TURKEY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=TURKEY&origincode=TKY"),
      Entry(
          title: "U.K",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=U.K&origincode=UK"),
      Entry(
          title: "U.S.A",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&origin=U.S.A&origincode=U.S.A"),
      Entry(
          title: "A/C",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=A/C&partsCategoryCode=A/C"),
      Entry(
          title: "ABSORBER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ABSORBER&partsCategoryCode=ABS"),
      Entry(
          title: "ABSORBER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ABSORBER&partsCategoryCode=ABSORBER"),
      Entry(
          title: "A/C",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=A/C&partsCategoryCode=AC"),
      Entry(
          title: "AC COMPRESSOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
      Entry(
          title: "AC CONDENSER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
      Entry(
          title: "AC DRIER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
      Entry(
          title: "ACTUATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
      Entry(
          title: "ADAPTER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
      Entry(
          title: "ADJUSTER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ADJUSTER&partsCategoryCode=ADJ"),
      Entry(
          title: "AIR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=AIR&partsCategoryCode=AIR"),
      Entry(
          title: "ALTERNATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
      Entry(
          title: "ANTENNA",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ANTENNA&partsCategoryCode=ANTEN"),
      Entry(
          title: "ARM",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ARM&partsCategoryCode=ARM"),
      Entry(
          title: "ATF",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ATF&partsCategoryCode=ATF"),
      Entry(
          title: "AXLE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=AXLE&partsCategoryCode=AX"),
      Entry(
          title: "BATTERY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BATTERY&partsCategoryCode=BA"),
      Entry(
          title: "BAFFLE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BAFFLE&partsCategoryCode=BAFFL"),
      Entry(
          title: "BALL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BALL&partsCategoryCode=BALL"),
      Entry(
          title: "BALL JOINT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
      Entry(
          title: "BAR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BAR&partsCategoryCode=BAR"),
      Entry(
          title: "BAZEL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BAZEL&partsCategoryCode=BAZEL"),
      Entry(
          title: "BEARING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BEARING&partsCategoryCode=BEA"),
      Entry(
          title: "BEAM",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BEAM&partsCategoryCode=BEAM"),
      Entry(
          title: "BULB",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BULB&partsCategoryCode=BLB"),
      Entry(
          title: "BELT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BELT&partsCategoryCode=BLT"),
      Entry(
          title: "BUMPER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BUMPER&partsCategoryCode=BMP"),
      Entry(
          title: "BONET",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BONET&partsCategoryCode=BO"),
      Entry(
          title: "BODY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BODY&partsCategoryCode=BODY"),
      Entry(
          title: "BOLT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BOLT&partsCategoryCode=BOLT"),
      Entry(
          title: "BOOT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BOOT&partsCategoryCode=BOOT"),
      Entry(
          title: "BRACKET",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BRACKET&partsCategoryCode=BRACK"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
      Entry(
          title: "BRAKE PAD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE PAD"),
      Entry(
          title: "BRG",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BRG&partsCategoryCode=BRG"),
      Entry(
          title: "BRAKE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BRAKE&partsCategoryCode=BRK"),
      Entry(
          title: "BUSH",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=BUSH&partsCategoryCode=BUSH"),
      Entry(
          title: "CABLE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CABLE&partsCategoryCode=CAB"),
      Entry(
          title: "CAP",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CAP&partsCategoryCode=CAP"),
      Entry(
          title: "CATCH",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CATCH&partsCategoryCode=CATCH"),
      Entry(
          title: "CHROME",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CHROME&partsCategoryCode=CHROM"),
      Entry(
          title: "CLIP",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CLIP&partsCategoryCode=CLIP"),
      Entry(
          title: "CLUTCH",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
      Entry(
          title: "COIL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COIL&partsCategoryCode=COIL"),
      Entry(
          title: "COMPRESSOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
      Entry(
          title: "CONDENSER ",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CONDENSER &partsCategoryCode=COND"),
      Entry(
          title: "CONNECTOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CONNECTOR&partsCategoryCode=CONNTR"),
      Entry(
          title: "CONTROL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CONTROL&partsCategoryCode=CONTR"),
      Entry(
          title: "COOLANT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COOLANT&partsCategoryCode=COOLA"),
      Entry(
          title: "COOLER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COOLER&partsCategoryCode=COOLER"),
      Entry(
          title: "COOLING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COOLING&partsCategoryCode=COOLING"),
      Entry(
          title: "COUPLING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COUPLING&partsCategoryCode=COUPL"),
      Entry(
          title: "COVER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=COVER&partsCategoryCode=COVER"),
      Entry(
          title: "CROSS",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CROSS&partsCategoryCode=CROSS"),
      Entry(
          title: "CUSHION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CUSHION&partsCategoryCode=CUSHI"),
      Entry(
          title: "CUT BUSH",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
      Entry(
          title: "CYLINDER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=CYLINDER&partsCategoryCode=CYL"),
      Entry(
          title: "DISC",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=DISC&partsCategoryCode=DISC"),
      Entry(
          title: "DOOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=DOOR&partsCategoryCode=DOOR"),
      Entry(
          title: "DRIER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=DRIER&partsCategoryCode=DRIER"),
      Entry(
          title: "ELECTRICAL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
      Entry(
          title: "END",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=END&partsCategoryCode=END"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ENGINE&partsCategoryCode=ENG"),
      Entry(
          title: "ENGINE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
      Entry(
          title: "EVAPORATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
      Entry(
          title: "EXHAUST",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=EXHAUST&partsCategoryCode=EXH"),
      Entry(
          title: "EXPANSION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
      Entry(
          title: "EXTENSION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=EXTENSION&partsCategoryCode=EXTEN"),
      Entry(
          title: "FAN",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=FAN&partsCategoryCode=FAN"),
      Entry(
          title: "FENDER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=FENDER&partsCategoryCode=FENDE"),
      Entry(
          title: "FILTER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=FILTER&partsCategoryCode=FI"),
      Entry(
          title: "FOG",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=FOG&partsCategoryCode=FOG"),
      Entry(
          title: "FRONT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=FRONT&partsCategoryCode=FRNT"),
      Entry(
          title: "FUEL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=FUEL&partsCategoryCode=FU"),
      Entry(
          title: "GASKET",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=GASKET&partsCategoryCode=GASK"),
      Entry(
          title: "GLASS",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=GLASS&partsCategoryCode=GL"),
      Entry(
          title: "GLOW",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=GLOW&partsCategoryCode=GLOW"),
      Entry(
          title: "GEAR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=GEAR&partsCategoryCode=GR"),
      Entry(
          title: "GRILL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=GRILL&partsCategoryCode=GRILL"),
      Entry(
          title: "GROMMET",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=GROMMET&partsCategoryCode=GROMM"),
      Entry(
          title: "HAND",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HAND&partsCategoryCode=HAN"),
      Entry(
          title: "HANDL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HANDL&partsCategoryCode=HANDL"),
      Entry(
          title: "HEAD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HEAD&partsCategoryCode=HEAD"),
      Entry(
          title: "HINGE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HINGE&partsCategoryCode=HINGE"),
      Entry(
          title: "HOOD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HOOD&partsCategoryCode=HOOD"),
      Entry(
          title: "HOOK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HOOK&partsCategoryCode=HOOK"),
      Entry(
          title: "HORN",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HORN&partsCategoryCode=HORN"),
      Entry(
          title: "HOSE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HOSE&partsCategoryCode=HOSE"),
      Entry(
          title: "HUB",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=HUB&partsCategoryCode=HUB"),
      Entry(
          title: "IDLER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=IDLER&partsCategoryCode=IDLER"),
      Entry(
          title: "IGNITION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
      Entry(
          title: "INJECTOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
      Entry(
          title: "INSERT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=INSERT&partsCategoryCode=INSER"),
      Entry(
          title: "INSULATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
      Entry(
          title: "JOINT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=JOINT&partsCategoryCode=JOINT"),
      Entry(
          title: "KEY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=KEY&partsCategoryCode=KEY"),
      Entry(
          title: "KIT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=KIT&partsCategoryCode=KIT"),
      Entry(
          title: "KNUCKLE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=KNUCKLE&partsCategoryCode=KNUCK"),
      Entry(
          title: "LAMP",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LAMP&partsCategoryCode=LAMP"),
      Entry(
          title: "LATCH",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LATCH&partsCategoryCode=LATCH"),
      Entry(
          title: "LIGHT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LIGHT&partsCategoryCode=LGHT"),
      Entry(
          title: "LINE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LINE&partsCategoryCode=LINE"),
      Entry(
          title: "LINK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LINK&partsCategoryCode=LINK"),
      Entry(
          title: "LOCK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LOCK&partsCategoryCode=LOCK"),
      Entry(
          title: "LOWER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=LOWER&partsCategoryCode=LOWER"),
      Entry(
          title: "MIRROR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
      Entry(
          title: "MODULE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MODULE&partsCategoryCode=MODUL"),
      Entry(
          title: "MOLDING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MOLDING&partsCategoryCode=MOLDI"),
      Entry(
          title: "MOTOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
      Entry(
          title: "MOUDLING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
      Entry(
          title: "MOULDING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MOULDING&partsCategoryCode=MOULD"),
      Entry(
          title: "MOUNT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
      Entry(
          title: "MOUNTING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
      Entry(
          title: "NAME PLATE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=NAME PLATE&partsCategoryCode=NAME"),
      Entry(
          title: "NOZZLE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
      Entry(
          title: "NUT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=NUT&partsCategoryCode=NUT"),
      Entry(
          title: "OIL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=OIL&partsCategoryCode=OIL"),
      Entry(
          title: "OIL ASSY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
      Entry(
          title: "O - RING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=O - RING&partsCategoryCode=O-R"),
      Entry(
          title: "OTHERS",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=OTHERS&partsCategoryCode=OTHER"),
      Entry(
          title: "PAD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PAD&partsCategoryCode=PAD"),
      Entry(
          title: "PANEL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PANEL&partsCategoryCode=PANEL"),
      Entry(
          title: "PIN",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PIN&partsCategoryCode=PIN"),
      Entry(
          title: "PIPE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PIPE&partsCategoryCode=PIPE"),
      Entry(
          title: "PISTON",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PISTON&partsCategoryCode=PISTO"),
      Entry(
          title: "PLATE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PLATE&partsCategoryCode=PLATE"),
      Entry(
          title: "PLUG",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PLUG&partsCategoryCode=PLUG"),
      Entry(
          title: "POWER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=POWER&partsCategoryCode=POWER"),
      Entry(
          title: "PULLEY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PULLEY&partsCategoryCode=PULLE"),
      Entry(
          title: "PUMP",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=PUMP&partsCategoryCode=PUMP"),
      Entry(
          title: "RACK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RACK&partsCategoryCode=RACK"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
      Entry(
          title: "RADIATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
      Entry(
          title: "RAIL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RAIL&partsCategoryCode=RAIL"),
      Entry(
          title: "REAR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=REAR&partsCategoryCode=REAR"),
      Entry(
          title: "REGULATOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
      Entry(
          title: "RELAY",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RELAY&partsCategoryCode=RELAY"),
      Entry(
          title: "RESERVOIR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
      Entry(
          title: "RESISTOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RESISTOR&partsCategoryCode=RESIS"),
      Entry(
          title: "RETAINER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RETAINER&partsCategoryCode=RETAI"),
      Entry(
          title: "RING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RING&partsCategoryCode=RING"),
      Entry(
          title: "RIVET",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=RIVET&partsCategoryCode=RIVET"),
      Entry(
          title: "ROOF",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ROOF&partsCategoryCode=ROOF"),
      Entry(
          title: "ROTOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
      Entry(
          title: "SCREW",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SCREW&partsCategoryCode=SCREW"),
      Entry(
          title: "SEAL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SEAL&partsCategoryCode=SEAL"),
      Entry(
          title: "SEAT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SEAT&partsCategoryCode=SEAT"),
      Entry(
          title: "SENSOR",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      Entry(
          title: "SHAFT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
      Entry(
          title: "SHIELD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SHIELD&partsCategoryCode=SHIEL"),
      Entry(
          title: "SHOCK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
      Entry(
          title: "SILICON",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SILICON&partsCategoryCode=SILIC"),
      Entry(
          title: "SOLENOID",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SOLENOID&partsCategoryCode=SOLEN"),
      Entry(
          title: "SPACER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SPACER&partsCategoryCode=SPACE"),
      Entry(
          title: "SPARK PLUG",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
      Entry(
          title: "SPRING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SPRING&partsCategoryCode=SPRIN"),
      Entry(
          title: "STAB LINK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STAB LINK&partsCategoryCode=STAB"),
      Entry(
          title: "STABILIZER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STABILIZER&partsCategoryCode=STABI"),
      Entry(
          title: "STARTER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STARTER&partsCategoryCode=START"),
      Entry(
          title: "STEARING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STEARING&partsCategoryCode=STEAR"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STEERING&partsCategoryCode=STEER"),
      Entry(
          title: "STEERING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STEERING&partsCategoryCode=STEERING"),
      Entry(
          title: "STRUT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STRUT&partsCategoryCode=STRUT"),
      Entry(
          title: "STUD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=STUD&partsCategoryCode=STUD"),
      Entry(
          title: "SUPPORT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
      Entry(
          title: "SUSPENSION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
      Entry(
          title: "SUSPENSION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SUSPENSION&partsCategoryCode=SUSPENSION"),
      Entry(
          title: "SWITCH",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=SWITCH&partsCategoryCode=SWITC"),
      Entry(
          title: "TANK",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TANK&partsCategoryCode=TANK"),
      Entry(
          title: "TENSIONER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
      Entry(
          title: "THERMOSTAT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
      Entry(
          title: "THERMOSTAT",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=THERMOSTAT&partsCategoryCode=THERMOSTAT"),
      Entry(
          title: "THROTTLE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=THROTTLE&partsCategoryCode=THROT"),
      Entry(
          title: "THRUST",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=THRUST&partsCategoryCode=THRUS"),
      Entry(
          title: "TIE ROD",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TIE ROD&partsCategoryCode=TIER"),
      Entry(
          title: "TIMING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TIMING&partsCategoryCode=TIMIN"),
      Entry(
          title: "TRANSMISSION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
      Entry(
          title: "TRANSMISSION",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TRANSMISSION&partsCategoryCode=TRANSMISSION"),
      Entry(
          title: "TUBE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TUBE&partsCategoryCode=TUBE"),
      Entry(
          title: "TYRE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=TYRE&partsCategoryCode=TYRE"),
      Entry(
          title: "UPPER ARM",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
      Entry(
          title: "VALVE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=VALVE&partsCategoryCode=VALVE"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
      Entry(
          title: "WATER PUMP",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WATER PUMP&partsCategoryCode=WATER PUMP"),
      Entry(
          title: "WEATER STRIPE",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WEATER STRIPE&partsCategoryCode=WEATE"),
      Entry(
          title: "WHEEL",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
      Entry(
          title: "WINDOW",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WINDOW&partsCategoryCode=WINDO"),
      Entry(
          title: "WIPER",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WIPER&partsCategoryCode=WIPER"),
      Entry(
          title: "WIRING",
          url:
              "/catalog/products?make=JP&makeCode=JEEP&partsCategory=WIRING&partsCategoryCode=WIRIN"),
    ],
  ),
  Entry(
      title: "KIA",
      url: "/catalog/products?make=KIA&makeCode=KIA",
      image: 'assets/brands/kia.jpg',
      submenu: <Entry>[
        Entry(
            title: "BREMI",
            url:
                "/catalog/products?make=KI&makeCode=KIA&origin=BREMI&origincode=BMI"),
        Entry(
            title: "KOYO",
            url:
                "/catalog/products?make=KI&makeCode=KIA&origin=KOYO&origincode=KOYO"),
        Entry(
            title: "OEM",
            url:
                "/catalog/products?make=KI&makeCode=KIA&origin=OEM&origincode=OEM"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "CARRIER",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=CARRIER&partsCategoryCode=CAR"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CROSS",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=CROSS&partsCategoryCode=CROSS"),
        Entry(
            title: "CUT BUSH",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "KNUCKLE",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=KNUCKLE&partsCategoryCode=KNUCK"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PAD",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=PAD&partsCategoryCode=PAD"),
        Entry(
            title: "POWER",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=POWER&partsCategoryCode=POWER"),
        Entry(
            title: "RAIL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=RAIL&partsCategoryCode=RAIL"),
        Entry(
            title: "REGULATOR",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
        Entry(
            title: "RESERVOIR",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
        Entry(
            title: "RESISTOR",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=RESISTOR&partsCategoryCode=RESIS"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "STB LINK",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=STB LINK&partsCategoryCode=STBL"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "STRUT",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=STRUT&partsCategoryCode=STRUT"),
        Entry(
            title: "SUN",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=SUN&partsCategoryCode=SUN"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WINDOW",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=WINDOW&partsCategoryCode=WINDO"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=KI&makeCode=KIA&partsCategory=WIPER&partsCategoryCode=WIPER"),
      ]),
  Entry(
      title: "LAND ROVER",
      url: "/catalog/products?make=LAND ROVER&makeCode=LAND ROVER",
      image: 'assets/brands/LAND-ROVER.png',
      submenu: <Entry>[
        Entry(
            title: "ALLMAKES 4X4",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&origin=ALLMAKES 4X4&origincode=ALL"),
        Entry(
            title: "BRITPART",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&origin=BRITPART&origincode=BRIT"),
        Entry(
            title: "DENSO",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&origin=DENSO&origincode=DSO"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "VALEO",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&origin=VALEO&origincode=VAL"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "AXLE",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&partsCategory=AXLE&partsCategoryCode=AXLE"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=LR&makeCode=LAND ROVER&partsCategory=WIPER&partsCategoryCode=WIPER"),
      ]),
  Entry(
      title: "MASERATI",
      url: "/catalog/products?make=MASERATI&makeCode=MASERATI",
      image: 'assets/brands/MASERATI.png',
      submenu: <Entry>[
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=BODY&partsCategoryCode=BODY"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FIILTER",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=FIILTER&partsCategoryCode=FIILTER"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "VACCUM",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=VACCUM&partsCategoryCode=VACCUM"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=MAS&makeCode=MASERATI&partsCategory=WIPER&partsCategoryCode=WIPER"),
      ]),
  Entry(
      title: "MERCEDES BENZ",
      url: "/catalog/products?make=MERCEDES BENZ&makeCode=MERCEDES BENZ",
      image: 'assets/brands/MERCEDES.png',
      submenu: <Entry>[
        Entry(
            title: "ATC",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=ATC&origincode=ATC"),
        Entry(
            title: "AUTOSTAR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=AUTOSTAR&origincode=AST"),
        Entry(
            title: "BEHR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BEHR&origincode=BHR"),
        Entry(
            title: "BERU",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BERU&origincode=BER"),
        Entry(
            title: "BILSTIEN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BILSTIEN&origincode=BLN"),
        Entry(
            title: "BILSTIEN",
            url:
                "/catalog/products?make=TY&makeCode=MERCEDES BENZ&origin=BILSTIEN&origincode=BLN"),
        Entry(
            title: "BLUE PRINT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BLUE PRINT&origincode=BLP"),
        Entry(
            title: "BOGE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BOGE&origincode=BOG"),
        Entry(
            title: "BOSCH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BOSCH&origincode=BSH"),
        Entry(
            title: "BREMI",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=BREMI&origincode=BMI"),
        Entry(
            title: "CONTI",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=CONTI&origincode=CON"),
        Entry(
            title: "DELPHI",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=DELPHI&origincode=DELPHI"),
        Entry(
            title: "DENSO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=DENSO&origincode=DSO"),
        Entry(
            title: "ELFOTECH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=ELFOTECH&origincode=ELF"),
        Entry(
            title: "ELRING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=ELRING&origincode=ELR"),
        Entry(
            title: "FAG",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=FAG&origincode=FTE"),
        Entry(
            title: "FEBI",
            url:
                "/catalog/products?make=BM&makeCode=MERCEDES BENZ&origin=FEBI&origincode=FBI"),
        Entry(
            title: "FEBI",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=FEBI&origincode=FBI"),
        Entry(
            title: "FERRADO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=FERRADO&origincode=FER"),
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=GERMANY&origincode=GER"),
        Entry(
            title: "GLYCO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=GLYCO&origincode=GLY"),
        Entry(
            title: "GULF",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=GULF&origincode=GLF"),
        Entry(
            title: "HELLA",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=HELLA&origincode=HLA"),
        Entry(
            title: "HENGST",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=HENGST&origincode=HST"),
        Entry(
            title: "IWIS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=IWIS&origincode=IWS"),
        Entry(
            title: "JAPAN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=JAPAN&origincode=JAPAN"),
        Entry(
            title: "KDR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=KDR&origincode=KDR"),
        Entry(
            title: "KS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=KS&origincode=KS"),
        Entry(
            title: "LEMFORDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=LEMFORDER&origincode=LEM"),
        Entry(
            title: "LIQUI MOLY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=LIQUI MOLY&origincode=LIQUI"),
        Entry(
            title: "LUK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=LUK&origincode=LUK"),
        Entry(
            title: "MAGNET MARELLI",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=MAGNET MARELLI&origincode=MM"),
        Entry(
            title: "MAHLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=MAHLE&origincode=MHF"),
        Entry(
            title: "MAN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=MAN&origincode=MAN"),
        Entry(
            title: "MAXPART",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=MAXPART&origincode=MXP"),
        Entry(
            title: "MAYER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=MAYER&origincode=MAYER"),
        Entry(
            title: "MEYLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=MEYLE&origincode=MEY"),
        Entry(
            title: "MEYLE",
            url:
                "/catalog/products?make=MS&makeCode=MERCEDES BENZ&origin=MEYLE&origincode=MEY"),
        Entry(
            title: "NISSENS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=NISSENS&origincode=NIS"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=BM&makeCode=MERCEDES BENZ&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "OSRAM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=OSRAM&origincode=OSR"),
        Entry(
            title: "PIERBURG",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=PIERBURG&origincode=PBG"),
        Entry(
            title: "RECONDITION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=RECONDITION&origincode=RECONDITION"),
        Entry(
            title: "REMSA",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=REMSA&origincode=REM"),
        Entry(
            title: "RHEINMANN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=RHEINMANN&origincode=RM"),
        Entry(
            title: "SACHS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=SACHS&origincode=SCH"),
        Entry(
            title: "SACHS",
            url:
                "/catalog/products?make=TY&makeCode=MERCEDES BENZ&origin=SACHS&origincode=SCH"),
        Entry(
            title: "SIMMER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=SIMMER&origincode=SIM"),
        Entry(
            title: "SKF",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=SKF&origincode=SKF"),
        Entry(
            title: "SPARX",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=SPARX&origincode=SPX"),
        Entry(
            title: "STABILUS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=STABILUS&origincode=STB"),
        Entry(
            title: "STABILUS",
            url:
                "/catalog/products?make=NS&makeCode=MERCEDES BENZ&origin=STABILUS&origincode=STB"),
        Entry(
            title: "SWEDEN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=SWEDEN&origincode=SW"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=TAIWAN&origincode=TWN"),
        Entry(
            title: "TEXTAR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=TEXTAR&origincode=TEX"),
        Entry(
            title: "TOPDRIVE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=TOPDRIVE&origincode=TDR"),
        Entry(
            title: "TRUCKTEC",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=TRUCKTEC&origincode=TTC"),
        Entry(
            title: "TRW",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=TRW&origincode=TRW"),
        Entry(
            title: "USED",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=USED&origincode=USD"),
        Entry(
            title: "VAICO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=VAICO&origincode=VKO"),
        Entry(
            title: "VALEO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=VALEO&origincode=VAL"),
        Entry(
            title: "VARTA",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=VARTA&origincode=VAR"),
        Entry(
            title: "VDO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=VDO&origincode=VDO"),
        Entry(
            title: "VICTOR REINZ",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=VICTOR REINZ&origincode=RNZ"),
        Entry(
            title: "WABCO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=WABCO&origincode=WAB"),
        Entry(
            title: "WAHLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=WAHLER&origincode=WAH"),
        Entry(
            title: "ZF",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=ZF&origincode=ZF"),
        Entry(
            title: "ZIMMERMANN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&origin=ZIMMERMANN&origincode=ZIM"),
        Entry(
            title: "A/C",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=A/C&partsCategoryCode=A/C"),
        Entry(
            title: "ABSORBER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ABSORBER&partsCategoryCode=ABS"),
        Entry(
            title: "ABSORBER",
            url:
                "/catalog/products?make=TY&makeCode=MERCEDES BENZ&partsCategory=ABSORBER&partsCategoryCode=ABS"),
        Entry(
            title: "ABSORBER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ABSORBER&partsCategoryCode=ABSORBER"),
        Entry(
            title: "A/C",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=A/C&partsCategoryCode=AC"),
        Entry(
            title: "AC ASSY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AC ASSY&partsCategoryCode=AC ASSY"),
        Entry(
            title: "AC BLOWER MOTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AC BLOWER MOTOR&partsCategoryCode=AC BLOWER MOTOR"),
        Entry(
            title: "AC CONDENSER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AC CONDENSER&partsCategoryCode=AC CONDENSER"),
        Entry(
            title: "ACCELERATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ACCELERATOR&partsCategoryCode=ACCEL"),
        Entry(
            title: "ACCELERATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ACCELERATOR&partsCategoryCode=ACCELERATOR"),
        Entry(
            title: "AC CONDENSER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
        Entry(
            title: "ACCUMUALTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ACCUMUALTOR&partsCategoryCode=ACCUM"),
        Entry(
            title: "AC DRIER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
        Entry(
            title: "ACTUATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
        Entry(
            title: "ADAPTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
        Entry(
            title: "ADJUSTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ADJUSTER&partsCategoryCode=ADJ"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "AMPLIFIER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AMPLIFIER&partsCategoryCode=AMPLI"),
        Entry(
            title: "ANTENNA",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ANTENNA&partsCategoryCode=ANTEN"),
        Entry(
            title: "ARM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ARM&partsCategoryCode=ARM"),
        Entry(
            title: "ASHTRAY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ASHTRAY&partsCategoryCode=ASHTR"),
        Entry(
            title: "AUDIO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AUDIO&partsCategoryCode=AUDIO"),
        Entry(
            title: "AUXILARY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AUXILARY&partsCategoryCode=AUXIL"),
        Entry(
            title: "AXLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=AXLE&partsCategoryCode=AX"),
        Entry(
            title: "BATTERY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BATTERY&partsCategoryCode=BA"),
        Entry(
            title: "BADGE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BADGE&partsCategoryCode=BADGE"),
        Entry(
            title: "BAFFLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BAFFLE&partsCategoryCode=BAFFL"),
        Entry(
            title: "BALL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BALL&partsCategoryCode=BALL"),
        Entry(
            title: "BALL JOINT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
        Entry(
            title: "BAR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BAR&partsCategoryCode=BAR"),
        Entry(
            title: "BASE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BASE&partsCategoryCode=BASE"),
        Entry(
            title: "BASIC",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BASIC&partsCategoryCode=BASIC"),
        Entry(
            title: "BATTERY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BATTERY&partsCategoryCode=BATTERY"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BEARING&partsCategoryCode=BEA"),
        Entry(
            title: "BEAM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BEAM&partsCategoryCode=BEAM"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BEARING&partsCategoryCode=BEARING"),
        Entry(
            title: "BELLOWS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BELLOWS&partsCategoryCode=BELLO"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BELT&partsCategoryCode=BELT"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BULB&partsCategoryCode=BLB"),
        Entry(
            title: "BLINKER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BLINKER&partsCategoryCode=BLINK"),
        Entry(
            title: "BLOWER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BLOWER&partsCategoryCode=BLOWER"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BLOWER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BLOWER&partsCategoryCode=BLW"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BUMPER&partsCategoryCode=BMP"),
        Entry(
            title: "BONET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BONET&partsCategoryCode=BO"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BODY&partsCategoryCode=BOD"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BODY&partsCategoryCode=BODY"),
        Entry(
            title: "BOLT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BOLT&partsCategoryCode=BOLT"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=BM&makeCode=MERCEDES BENZ&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE PAD"),
        Entry(
            title: "BREATHER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BREATHER&partsCategoryCode=BREAT"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BUFFER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BUFFER&partsCategoryCode=BUFFE"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BUMPER&partsCategoryCode=BUMPER"),
        Entry(
            title: "BUSH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=BUSH&partsCategoryCode=BUSH"),
        Entry(
            title: "CABLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CABLE&partsCategoryCode=CAB"),
        Entry(
            title: "CABLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CABLE&partsCategoryCode=CABLE"),
        Entry(
            title: "CALIPER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CALIPER&partsCategoryCode=CALIP"),
        Entry(
            title: "CAMERA",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CAMERA&partsCategoryCode=CAM"),
        Entry(
            title: "CAP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CAP&partsCategoryCode=CAP"),
        Entry(
            title: "CATALYST CONVERTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CATALYST CONVERTER&partsCategoryCode=CATAL"),
        Entry(
            title: "CATCH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CATCH&partsCategoryCode=CATCH"),
        Entry(
            title: "CENTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CENTER&partsCategoryCode=CEN"),
        Entry(
            title: "CHAIN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CHAIN&partsCategoryCode=CHA"),
        Entry(
            title: "CHAIN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CHAIN&partsCategoryCode=CHAIN"),
        Entry(
            title: "CHARGE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CHARGE&partsCategoryCode=CHARG"),
        Entry(
            title: "CHASSIS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CHASSIS&partsCategoryCode=CHASSIS"),
        Entry(
            title: "CHECK ASSY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CHECK ASSY&partsCategoryCode=CHECK"),
        Entry(
            title: "CHROME",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CHROME&partsCategoryCode=CHROM"),
        Entry(
            title: "CLAMP ",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CLAMP &partsCategoryCode=CLAMP "),
        Entry(
            title: "CLAMP ",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CLAMP &partsCategoryCode=CLAMP"),
        Entry(
            title: "CLIP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CLIP&partsCategoryCode=CLIP"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CLUTCH&partsCategoryCode=CLUTCH"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMBINATION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COMBINATION&partsCategoryCode=COMBIN"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "CONDENSER ",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONDENSER &partsCategoryCode=COND"),
        Entry(
            title: "CONNECTING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONNECTING&partsCategoryCode=CONNTNG"),
        Entry(
            title: "CONNECTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONNECTOR&partsCategoryCode=CONNTR"),
        Entry(
            title: "CONSOLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONSOLE&partsCategoryCode=CONSO"),
        Entry(
            title: "CONSOLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONSOLE&partsCategoryCode=CONSOLE"),
        Entry(
            title: "CONTACT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONTACT&partsCategoryCode=CONTA"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=MS&makeCode=MERCEDES BENZ&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CONTROL&partsCategoryCode=CONTROL"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COOLANT&partsCategoryCode=COOLA"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COOLANT&partsCategoryCode=COOLANT"),
        Entry(
            title: "COOLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COOLER&partsCategoryCode=COOLER"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CRANK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CRANK&partsCategoryCode=CRANK"),
        Entry(
            title: "CROSS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CROSS&partsCategoryCode=CROSS"),
        Entry(
            title: "CUP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CUP&partsCategoryCode=CUP"),
        Entry(
            title: "CV JOINT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CV JOINT&partsCategoryCode=CVJO"),
        Entry(
            title: "CYLINDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CYLINDER&partsCategoryCode=CYL"),
        Entry(
            title: "CYLINDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=CYLINDER&partsCategoryCode=CYLINDER"),
        Entry(
            title: "DAMPER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DAMPER&partsCategoryCode=DAMPE"),
        Entry(
            title: "DASHBOARD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DASHBOARD&partsCategoryCode=DASHB"),
        Entry(
            title: "DEFLECTION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DEFLECTION&partsCategoryCode=DEFLETN"),
        Entry(
            title: "DELIVERY UNIT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DELIVERY UNIT&partsCategoryCode=DELIV"),
        Entry(
            title: "DICKY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DICKY&partsCategoryCode=DICKY"),
        Entry(
            title: "DISC",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DISC&partsCategoryCode=DISC"),
        Entry(
            title: "DISTRIBUTION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DISTRIBUTION&partsCategoryCode=DISTR"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "DOWEL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DOWEL&partsCategoryCode=DOWEL"),
        Entry(
            title: "DRIER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DRIER&partsCategoryCode=DRIER"),
        Entry(
            title: "DRIVE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
        Entry(
            title: "ECU",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ECU&partsCategoryCode=ECU"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ELECTRICAL&partsCategoryCode=ELECT"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "EMBLEM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=EMBLEM&partsCategoryCode=EMB"),
        Entry(
            title: "EMBLEM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=EMBLEM&partsCategoryCode=EMBLEM"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ENGINE&partsCategoryCode=ENG"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "EVAPORATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
        Entry(
            title: "EXHAUST",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=EXHAUST&partsCategoryCode=EXH"),
        Entry(
            title: "EXHAUST",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=EXHAUST&partsCategoryCode=EXHAUST"),
        Entry(
            title: "EXPANSION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
        Entry(
            title: "FAN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FAN&partsCategoryCode=FAN"),
        Entry(
            title: "FASTENER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FASTENER&partsCategoryCode=FASTE"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FENDER&partsCategoryCode=FENDE"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FENDER&partsCategoryCode=FENDER"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FIILTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FIILTER&partsCategoryCode=FIILTER"),
        Entry(
            title: "FILLER CAP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FILLER CAP&partsCategoryCode=FILLRC"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FILTER&partsCategoryCode=FILTER"),
        Entry(
            title: "FITTING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FITTING&partsCategoryCode=FITTI"),
        Entry(
            title: "FLOOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FLOOR&partsCategoryCode=FL"),
        Entry(
            title: "FLANGE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FLANGE&partsCategoryCode=FLANG"),
        Entry(
            title: "FLAP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FLAP&partsCategoryCode=FLAP"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRAME",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FRAME&partsCategoryCode=FRAME"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FUEL&partsCategoryCode=FUEL"),
        Entry(
            title: "FUSE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=FUSE&partsCategoryCode=FUSE"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GASKET&partsCategoryCode=GAS"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GASKET&partsCategoryCode=GASKET"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GEAR&partsCategoryCode=GEAR"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GLASS&partsCategoryCode=GL"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GLASS&partsCategoryCode=GLASS"),
        Entry(
            title: "GLOW",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GLOW&partsCategoryCode=GLOW"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GEAR&partsCategoryCode=GR"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "GROMMET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GROMMET&partsCategoryCode=GROMM"),
        Entry(
            title: "GUIDE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
        Entry(
            title: "HAND",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HAND&partsCategoryCode=HAN"),
        Entry(
            title: "HAND",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HAND&partsCategoryCode=HAND"),
        Entry(
            title: "HANDL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HANDL&partsCategoryCode=HANDL"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "HEAT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HEAT&partsCategoryCode=HEAT"),
        Entry(
            title: "HIGH PRESSURE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HIGH PRESSURE&partsCategoryCode=HIGH"),
        Entry(
            title: "HINGE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HINGE&partsCategoryCode=HINGE"),
        Entry(
            title: "HOLDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HOLDER&partsCategoryCode=HOLDER"),
        Entry(
            title: "HOOD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HOOD&partsCategoryCode=HOOD"),
        Entry(
            title: "HOOK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HOOK&partsCategoryCode=HOOK"),
        Entry(
            title: "HORN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HORN&partsCategoryCode=HORN"),
        Entry(
            title: "HOSE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HOSE&partsCategoryCode=HOSE"),
        Entry(
            title: "HOUSING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HOUSING&partsCategoryCode=HOUSING"),
        Entry(
            title: "HUB",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HUB&partsCategoryCode=HUB"),
        Entry(
            title: "HYDRAULIC",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=HYDRAULIC&partsCategoryCode=HYDRA"),
        Entry(
            title: "IDLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=IDLER&partsCategoryCode=IDLER"),
        Entry(
            title: "IGNITION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
        Entry(
            title: "INDICATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INDICATOR&partsCategoryCode=INDIC"),
        Entry(
            title: "INJECTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
        Entry(
            title: "INJECTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INJECTOR&partsCategoryCode=INJECTOR"),
        Entry(
            title: "INSERT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INSERT&partsCategoryCode=INSER"),
        Entry(
            title: "INSTRUMENT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INSTRUMENT&partsCategoryCode=INSTR"),
        Entry(
            title: "INSULATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
        Entry(
            title: "INTAKE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=INTAKE&partsCategoryCode=INTAK"),
        Entry(
            title: "JOINT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=JOINT&partsCategoryCode=JOINT"),
        Entry(
            title: "KIT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=KIT&partsCategoryCode=KIT"),
        Entry(
            title: "KNOB",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=KNOB&partsCategoryCode=KNOB"),
        Entry(
            title: "KNUCKLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=KNUCKLE&partsCategoryCode=KNUCKLE"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LEVER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LEVER&partsCategoryCode=LEVER"),
        Entry(
            title: "LIGHT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LIGHT&partsCategoryCode=LGHT"),
        Entry(
            title: "LIGHT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LIGHT&partsCategoryCode=LIGHT"),
        Entry(
            title: "LINE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LINE&partsCategoryCode=LINE"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOCK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LOCK&partsCategoryCode=LOCK"),
        Entry(
            title: "LOGO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LOGO&partsCategoryCode=LOGO"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MASTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MASTER&partsCategoryCode=MASTE"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MIRROR&partsCategoryCode=MIRROR"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "MOLDING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOLDING&partsCategoryCode=MOLDI"),
        Entry(
            title: "MOUDLING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
        Entry(
            title: "MOULDING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOULDING&partsCategoryCode=MOULD"),
        Entry(
            title: "MOULDING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOULDING&partsCategoryCode=MOULDING"),
        Entry(
            title: "MOUNT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOUNTING&partsCategoryCode=MOUNTING"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "MUD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=MUD&partsCategoryCode=MUD"),
        Entry(
            title: "NOZZLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
        Entry(
            title: "NOZZLE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=NOZZLE&partsCategoryCode=NOZZLE"),
        Entry(
            title: "NUT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=NUT&partsCategoryCode=NUT"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "OIL COOLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=OIL COOLER&partsCategoryCode=OIL COOLER"),
        Entry(
            title: "OIL ASSY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
        Entry(
            title: "OIL CAP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=OIL CAP&partsCategoryCode=OILC"),
        Entry(
            title: "OIL COOLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=OIL COOLER&partsCategoryCode=OILCO"),
        Entry(
            title: "O - RING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=O - RING&partsCategoryCode=O-R"),
        Entry(
            title: "ORNAMENTAL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ORNAMENTAL&partsCategoryCode=ORNAM"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PAD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PAD&partsCategoryCode=PAD"),
        Entry(
            title: "PANEL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PANEL&partsCategoryCode=PANEL"),
        Entry(
            title: "PIECE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PIECE&partsCategoryCode=PIECE"),
        Entry(
            title: "PIN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PIN&partsCategoryCode=PIN"),
        Entry(
            title: "PIPE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PIPE&partsCategoryCode=PIPE"),
        Entry(
            title: "PISTON",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PISTON&partsCategoryCode=PISTO"),
        Entry(
            title: "PISTON",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PISTON&partsCategoryCode=PISTON"),
        Entry(
            title: "PLATE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PLATE&partsCategoryCode=PLATE"),
        Entry(
            title: "PLUG",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PLUG&partsCategoryCode=PLUG"),
        Entry(
            title: "POWER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=POWER&partsCategoryCode=POWER"),
        Entry(
            title: "PRESSURE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PRESSURE&partsCategoryCode=PRESS"),
        Entry(
            title: "PROTECTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PROTECTOR&partsCategoryCode=PROTE"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PULLEY&partsCategoryCode=PULLE"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PULLEY&partsCategoryCode=PULLEY"),
        Entry(
            title: "PULLY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PULLY&partsCategoryCode=PULLY"),
        Entry(
            title: "PUMP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=PUMP&partsCategoryCode=PUMP"),
        Entry(
            title: "RACK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RACK&partsCategoryCode=RACK"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=BM&makeCode=MERCEDES BENZ&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
        Entry(
            title: "RAIL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RAIL&partsCategoryCode=RAIL"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "REFLECTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
        Entry(
            title: "REFLECTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=REFLECTOR&partsCategoryCode=REFLECTOR"),
        Entry(
            title: "REGULATOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
        Entry(
            title: "REINFORCEMENT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=REINFORCEMENT&partsCategoryCode=REINF"),
        Entry(
            title: "RELAY",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RELAY&partsCategoryCode=RELAY"),
        Entry(
            title: "REPAIR KIT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=REPAIR KIT&partsCategoryCode=REPAI"),
        Entry(
            title: "RESERVOIR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
        Entry(
            title: "RESISTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RESISTOR&partsCategoryCode=RESIS"),
        Entry(
            title: "RETAINER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RETAINER&partsCategoryCode=RETAI"),
        Entry(
            title: "RING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RING&partsCategoryCode=RING"),
        Entry(
            title: "RIVET",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RIVET&partsCategoryCode=RIVET"),
        Entry(
            title: "ROD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ROD&partsCategoryCode=ROD"),
        Entry(
            title: "ROLLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ROLLER&partsCategoryCode=ROLLE"),
        Entry(
            title: "ROLLER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ROLLER&partsCategoryCode=ROLLER"),
        Entry(
            title: "ROOF",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ROOF&partsCategoryCode=ROOF"),
        Entry(
            title: "ROTOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
        Entry(
            title: "RUBBER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=RUBBER&partsCategoryCode=RUBBE"),
        Entry(
            title: "SCREW",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SCREW&partsCategoryCode=SCREW"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "SEALING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SEALING&partsCategoryCode=SEALI"),
        Entry(
            title: "SEAT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SEAT&partsCategoryCode=SEAT"),
        Entry(
            title: "SENDER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SENDER&partsCategoryCode=SENDE"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SENSOR&partsCategoryCode=SENSO"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SENSOR&partsCategoryCode=SENSOR"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=NS&makeCode=MERCEDES BENZ&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=TY&makeCode=MERCEDES BENZ&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SIDE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SIDE&partsCategoryCode=SIDE"),
        Entry(
            title: "SILICON",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SILICON&partsCategoryCode=SILIC"),
        Entry(
            title: "SLEEVE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SLEEVE&partsCategoryCode=SLEEVE"),
        Entry(
            title: "SLIDE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SLIDE&partsCategoryCode=SLIDE"),
        Entry(
            title: "SOLENOID",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SOLENOID&partsCategoryCode=SOLEN"),
        Entry(
            title: "SPACER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SPACER&partsCategoryCode=SPACE"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
        Entry(
            title: "SPEAKER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SPEAKER&partsCategoryCode=SPEAK"),
        Entry(
            title: "SPOILER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SPRING&partsCategoryCode=SPRING"),
        Entry(
            title: "STAB LINK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STAB LINK&partsCategoryCode=STAB"),
        Entry(
            title: "STABILIZER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STABILIZER&partsCategoryCode=STABI"),
        Entry(
            title: "STABILIZER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STABILIZER&partsCategoryCode=STABILIZER"),
        Entry(
            title: "STARTER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STARTER&partsCategoryCode=START"),
        Entry(
            title: "STB LINK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STB LINK&partsCategoryCode=STB LINK"),
        Entry(
            title: "STEARING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STEARING&partsCategoryCode=STEAR"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STEERING&partsCategoryCode=STEERING"),
        Entry(
            title: "STICKER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STICKER&partsCategoryCode=STICK"),
        Entry(
            title: "STOP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STOP&partsCategoryCode=STOP"),
        Entry(
            title: "STRIP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STRIP&partsCategoryCode=STRIP"),
        Entry(
            title: "STRUT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STRUT&partsCategoryCode=STRUT"),
        Entry(
            title: "STUD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=STUD&partsCategoryCode=STUD"),
        Entry(
            title: "SUCTION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SUCTION&partsCategoryCode=SUCTI"),
        Entry(
            title: "SUN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SUN&partsCategoryCode=SUN"),
        Entry(
            title: "SUPPORT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SUSPENSION&partsCategoryCode=SUSPENSION"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=SWITCH&partsCategoryCode=SWITCH"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TENSIONER&partsCategoryCode=TENSIONER"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=THERMOSTAT&partsCategoryCode=THERMOSTAT"),
        Entry(
            title: "THRUST",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=THRUST&partsCategoryCode=THRUS"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TIE ROD&partsCategoryCode=TIE ROD"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TIE ROD&partsCategoryCode=TIER"),
        Entry(
            title: "TIMING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TIMING&partsCategoryCode=TIMIN"),
        Entry(
            title: "TIMING CHAIN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TIMING CHAIN&partsCategoryCode=TIMINC"),
        Entry(
            title: "TRANSMISSION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
        Entry(
            title: "TRIM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TRIM&partsCategoryCode=TRI"),
        Entry(
            title: "TRUNK",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TRUNK&partsCategoryCode=TRUNK"),
        Entry(
            title: "TUBE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TUBE&partsCategoryCode=TUBE"),
        Entry(
            title: "TURBO",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TURBO&partsCategoryCode=TURBO"),
        Entry(
            title: "TURN",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TURN&partsCategoryCode=TURN"),
        Entry(
            title: "TYPE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TYPE&partsCategoryCode=TYPE"),
        Entry(
            title: "TYRE LINER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=TYRE LINER&partsCategoryCode=TYREL"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=UPPER ARM&partsCategoryCode=UPPER ARM"),
        Entry(
            title: "VACCUM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=VACCUM&partsCategoryCode=VACCU"),
        Entry(
            title: "VACCUM",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=VACCUM&partsCategoryCode=VACCUM"),
        Entry(
            title: "VALVE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=VALVE&partsCategoryCode=VALVE"),
        Entry(
            title: "V-BELT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
        Entry(
            title: "VENT",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=VENT&partsCategoryCode=VENT"),
        Entry(
            title: "VIBRATION",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=VIBRATION&partsCategoryCode=VIBRA"),
        Entry(
            title: "VOLTAGE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=VOLTAGE&partsCategoryCode=VOLTA"),
        Entry(
            title: "WASHER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WASHER&partsCategoryCode=WASHE"),
        Entry(
            title: "WASHER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WASHER&partsCategoryCode=WASHER"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WATER PUMP&partsCategoryCode=WATER PUMP"),
        Entry(
            title: "WEATER STRIPE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WEATER STRIPE&partsCategoryCode=WEATE"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIND",
            url:
                "/catalog/products?make=BM&makeCode=MERCEDES BENZ&partsCategory=WIND&partsCategoryCode=WIND"),
        Entry(
            title: "WIND",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WIND&partsCategoryCode=WIND"),
        Entry(
            title: "WINDOW",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WINDOW&partsCategoryCode=WINDO"),
        Entry(
            title: "WINDOW",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WINDOW&partsCategoryCode=WINDOW"),
        Entry(
            title: "WINDSHIELD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WINDSHIELD&partsCategoryCode=WINDS"),
        Entry(
            title: "WINDSHIELD",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WINDSHIELD&partsCategoryCode=WINDSHIELD"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WIPER&partsCategoryCode=WIPER"),
        Entry(
            title: "WIRING",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WIRING&partsCategoryCode=WIRIN"),
        Entry(
            title: "WISH BONE",
            url:
                "/catalog/products?make=MB&makeCode=MERCEDES BENZ&partsCategory=WISH BONE&partsCategoryCode=WISH"),
      ]),
  Entry(
      title: "MITSUBISHI",
      url: "/catalog/products?make=MITSUBISHI&makeCode=MITSUBISHI",
      image: 'assets/brands/MITSUBISHI.png',
      submenu: <Entry>[
        Entry(
            title: "AUTOSTAR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=AUTOSTAR&origincode=AST"),
        Entry(
            title: "BREMI",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=BREMI&origincode=BMI"),
        Entry(
            title: "FEBI",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=FEBI&origincode=FBI"),
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=GERMANY&origincode=GER"),
        Entry(
            title: "HELLA",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=HELLA&origincode=HLA"),
        Entry(
            title: "JAPAN",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=JAPAN&origincode=JAPAN"),
        Entry(
            title: "MEYLE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=MEYLE&origincode=MEY"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "PRESTONE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=PRESTONE&origincode=PST"),
        Entry(
            title: "SHELL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=SHELL&origincode=SL"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=TAIWAN&origincode=TWN"),
        Entry(
            title: "VAICO",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&origin=VAICO&origincode=VKO"),
        Entry(
            title: "A/C",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=A/C&partsCategoryCode=AC"),
        Entry(
            title: "ACCUMUALTOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ACCUMUALTOR&partsCategoryCode=ACCUM"),
        Entry(
            title: "AC DRIER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
        Entry(
            title: "ACTUATOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
        Entry(
            title: "ADJUSTER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ADJUSTER&partsCategoryCode=ADJ"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "ARM",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ARM&partsCategoryCode=ARM"),
        Entry(
            title: "BALL JOINT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BEARING&partsCategoryCode=BEA"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BULB&partsCategoryCode=BLB"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BLOWER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BLOWER&partsCategoryCode=BLW"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BUMPER&partsCategoryCode=BMP"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BODY&partsCategoryCode=BOD"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BUSH",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=BUSH&partsCategoryCode=BUSH"),
        Entry(
            title: "CASE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CASE&partsCategoryCode=CASE"),
        Entry(
            title: "CLIP",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CLIP&partsCategoryCode=CLIP"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "CONNECTING",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CONNECTING&partsCategoryCode=CONNTNG"),
        Entry(
            title: "CONNECTOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CONNECTOR&partsCategoryCode=CONNTR"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "CONVERTER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CONVERTER&partsCategoryCode=CONVE"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=COOLANT&partsCategoryCode=COOLA"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CUP",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CUP&partsCategoryCode=CUP"),
        Entry(
            title: "CYLINDER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CYLINDER&partsCategoryCode=CYL"),
        Entry(
            title: "CYLENDER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=CYLENDER&partsCategoryCode=CYLEN"),
        Entry(
            title: "DISC",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=DISC&partsCategoryCode=DISC"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "END",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=END&partsCategoryCode=END"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "EVAPORATOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
        Entry(
            title: "FAN",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FAN&partsCategoryCode=FAN"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FENDER&partsCategoryCode=FENDE"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FILTER&partsCategoryCode=FILTER"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=GLASS&partsCategoryCode=GL"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "GROMMET",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=GROMMET&partsCategoryCode=GROMM"),
        Entry(
            title: "HARNESS",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=HARNESS&partsCategoryCode=HARNE"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "HOLDER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=HOLDER&partsCategoryCode=HOLDER"),
        Entry(
            title: "HUB",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=HUB&partsCategoryCode=HUB"),
        Entry(
            title: "HYDRAULIC",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=HYDRAULIC&partsCategoryCode=HYDRA"),
        Entry(
            title: "JOINT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=JOINT&partsCategoryCode=JOINT"),
        Entry(
            title: "KIT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=KIT&partsCategoryCode=KIT"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LINE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=LINE&partsCategoryCode=LINE"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOCK",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=LOCK&partsCategoryCode=LOCK"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "MOTOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "OIL ASSY",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PAD",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=PAD&partsCategoryCode=PAD"),
        Entry(
            title: "PANEL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=PANEL&partsCategoryCode=PANEL"),
        Entry(
            title: "PLATE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=PLATE&partsCategoryCode=PLATE"),
        Entry(
            title: "PLUG",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=PLUG&partsCategoryCode=PLUG"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=PULLEY&partsCategoryCode=PULLE"),
        Entry(
            title: "PUMP",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=PUMP&partsCategoryCode=PUMP"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "REFLECTOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
        Entry(
            title: "REINFORCEMENT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=REINFORCEMENT&partsCategoryCode=REINF"),
        Entry(
            title: "RELAY",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=RELAY&partsCategoryCode=RELAY"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "SEAT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SEAT&partsCategoryCode=SEAT"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SENSOR&partsCategoryCode=SENSO"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHIELD",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SHIELD&partsCategoryCode=SHIEL"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
        Entry(
            title: "SPOILER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "STABILIZER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=STABILIZER&partsCategoryCode=STABI"),
        Entry(
            title: "STARTER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=STARTER&partsCategoryCode=START"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=TIE ROD&partsCategoryCode=TIER"),
        Entry(
            title: "TIMING",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=TIMING&partsCategoryCode=TIMIN"),
        Entry(
            title: "TRIM",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=TRIM&partsCategoryCode=TRI"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
        Entry(
            title: "VALVE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=VALVE&partsCategoryCode=VALVE"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
        Entry(
            title: "WEATER STRIPE",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=WEATER STRIPE&partsCategoryCode=WEATE"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=MS&makeCode=MITSUBISHI&partsCategory=WIPER&partsCategoryCode=WIPER"),
      ]),
  Entry(
      title: "NISSAN",
      url: "/catalog/products?make=NISSAN&makeCode=NISSAN",
      image: 'assets/brands/NISSAN.png',
      submenu: <Entry>[
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&origin=GERMANY&origincode=GER"),
        Entry(
            title: "INCOE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&origin=INCOE&origincode=INCOE"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&origin=TAIWAN&origincode=TWN"),
        Entry(
            title: "ABSORBER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ABSORBER&partsCategoryCode=ABS"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "ATF",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ATF&partsCategoryCode=ATF"),
        Entry(
            title: "BASE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BASE&partsCategoryCode=BASE"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BEARING&partsCategoryCode=BEA"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BULB&partsCategoryCode=BLB"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BUMPER&partsCategoryCode=BMP"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BODY&partsCategoryCode=BOD"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BODY&partsCategoryCode=BODY"),
        Entry(
            title: "BOLT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BOLT&partsCategoryCode=BOLT"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE PAD"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BUFFER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BUFFER&partsCategoryCode=BUFFE"),
        Entry(
            title: "BUSH",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=BUSH&partsCategoryCode=BUSH"),
        Entry(
            title: "CABLE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CABLE&partsCategoryCode=CAB"),
        Entry(
            title: "CALIPER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CALIPER&partsCategoryCode=CALIP"),
        Entry(
            title: "CAP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CAP&partsCategoryCode=CAP"),
        Entry(
            title: "CLIP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CLIP&partsCategoryCode=CLIP"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "CONDENSER ",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CONDENSER &partsCategoryCode=COND"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=COOLANT&partsCategoryCode=COOLA"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CUP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CUP&partsCategoryCode=CUP"),
        Entry(
            title: "CUT BUSH",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
        Entry(
            title: "CYLINDER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=CYLINDER&partsCategoryCode=CYL"),
        Entry(
            title: "DISC",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=DISC&partsCategoryCode=DISC"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "EMBLEM",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=EMBLEM&partsCategoryCode=EMB"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ENGINE&partsCategoryCode=ENG"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "EVAPORATOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
        Entry(
            title: "FAN",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FAN&partsCategoryCode=FAN"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FENDER&partsCategoryCode=FENDE"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FINISHER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FINISHER&partsCategoryCode=FINIS"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "FUSE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=FUSE&partsCategoryCode=FUSE"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=GLASS&partsCategoryCode=GL"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=GEAR&partsCategoryCode=GR"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "HOSE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=HOSE&partsCategoryCode=HOSE"),
        Entry(
            title: "IDLER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=IDLER&partsCategoryCode=IDLER"),
        Entry(
            title: "IGNITION",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
        Entry(
            title: "INSERT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=INSERT&partsCategoryCode=INSER"),
        Entry(
            title: "INSULATOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
        Entry(
            title: "KIT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=KIT&partsCategoryCode=KIT"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LINE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=LINE&partsCategoryCode=LINE"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOCK",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=LOCK&partsCategoryCode=LOCK"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "MOTOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
        Entry(
            title: "MOUDLING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "NOZZLE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
        Entry(
            title: "NUT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=NUT&partsCategoryCode=NUT"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "OIL ASSY",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PAD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=PAD&partsCategoryCode=PAD"),
        Entry(
            title: "PIPE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=PIPE&partsCategoryCode=PIPE"),
        Entry(
            title: "PLUG",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=PLUG&partsCategoryCode=PLUG"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=PULLEY&partsCategoryCode=PULLE"),
        Entry(
            title: "PUMP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=PUMP&partsCategoryCode=PUMP"),
        Entry(
            title: "RACK",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=RACK&partsCategoryCode=RACK"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "REGULATOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
        Entry(
            title: "REPAIR KIT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=REPAIR KIT&partsCategoryCode=REPAI"),
        Entry(
            title: "RING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=RING&partsCategoryCode=RING"),
        Entry(
            title: "ROD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ROD&partsCategoryCode=ROD"),
        Entry(
            title: "ROTOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "SENDER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SENDER&partsCategoryCode=SENDE"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SENSOR&partsCategoryCode=SENSO"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SENSOR&partsCategoryCode=SENSOR"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SOCKET",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SOCKET&partsCategoryCode=SOCKE"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "STARTER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=STARTER&partsCategoryCode=START"),
        Entry(
            title: "STEARING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=STEARING&partsCategoryCode=STEAR"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "STUD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=STUD&partsCategoryCode=STUD"),
        Entry(
            title: "SUPPORT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=TIE ROD&partsCategoryCode=TIER"),
        Entry(
            title: "TRANSMISSION",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
        Entry(
            title: "TUBE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=TUBE&partsCategoryCode=TUBE"),
        Entry(
            title: "TYRE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=TYRE&partsCategoryCode=TYRE"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
        Entry(
            title: "VALVE",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=VALVE&partsCategoryCode=VALVE"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=WATER PUMP&partsCategoryCode=WATER PUMP"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=NS&makeCode=NISSAN&partsCategory=WIPER&partsCategoryCode=WIPER"),
      ]),
  Entry(
      title: "PORSCHE",
      url: "/catalog/products?make=PORSCHE&makeCode=PORSCHE",
      image: 'assets/brands/PORSCHE.png',
      submenu: <Entry>[
        Entry(
            title: "BEHR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=BEHR&origincode=BHR"),
        Entry(
            title: "BERU",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=BERU&origincode=BER"),
        Entry(
            title: "BOSCH",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=BOSCH&origincode=BSH"),
        Entry(
            title: "CONTI",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=CONTI&origincode=CON"),
        Entry(
            title: "DENSO",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=DENSO&origincode=DSO"),
        Entry(
            title: "ELRING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=ELRING&origincode=ELR"),
        Entry(
            title: "FEBI",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=FEBI&origincode=FBI"),
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=GERMANY&origincode=GER"),
        Entry(
            title: "HENGST",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=HENGST&origincode=HST"),
        Entry(
            title: "LEMFORDER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=LEMFORDER&origincode=LEM"),
        Entry(
            title: "MAHLE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=MAHLE&origincode=MHF"),
        Entry(
            title: "MAN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=MAN&origincode=MAN"),
        Entry(
            title: "MAXPART",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=MAXPART&origincode=MXP"),
        Entry(
            title: "MEYLE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=MEYLE&origincode=MEY"),
        Entry(
            title: "NISSENS",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=NISSENS&origincode=NIS"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "RECONDITION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=RECONDITION&origincode=RECONDITION"),
        Entry(
            title: "REMSA",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=REMSA&origincode=REM"),
        Entry(
            title: "SACHS",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=SACHS&origincode=SCH"),
        Entry(
            title: "SPARX",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=SPARX&origincode=SPX"),
        Entry(
            title: "STABILUS",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=STABILUS&origincode=STB"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=TAIWAN&origincode=TWN"),
        Entry(
            title: "TEXTAR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=TEXTAR&origincode=TEX"),
        Entry(
            title: "TOPDRIVE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=TOPDRIVE&origincode=TDR"),
        Entry(
            title: "TRUCKTEC",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=TRUCKTEC&origincode=TTC"),
        Entry(
            title: "TRW",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=TRW&origincode=TRW"),
        Entry(
            title: "USED",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=USED&origincode=USD"),
        Entry(
            title: "VAICO",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=VAICO&origincode=VKO"),
        Entry(
            title: "VDO",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=VDO&origincode=VDO"),
        Entry(
            title: "VICTOR REINZ",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&origin=VICTOR REINZ&origincode=RNZ"),
        Entry(
            title: "A/C",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=A/C&partsCategoryCode=AC"),
        Entry(
            title: "AC BLOWER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AC BLOWER&partsCategoryCode=AC BLOWER"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AC COMPRESSOR&partsCategoryCode=AC COMPRESSOR"),
        Entry(
            title: "AC ASSY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AC ASSY&partsCategoryCode=ACAS"),
        Entry(
            title: "AC BLOWER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AC BLOWER&partsCategoryCode=ACBL"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
        Entry(
            title: "AC CONDENSER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
        Entry(
            title: "ACTUATOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
        Entry(
            title: "ADAPTER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
        Entry(
            title: "ADDITIONAL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ADDITIONAL&partsCategoryCode=ADDIT"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "AXLE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=AXLE&partsCategoryCode=AX"),
        Entry(
            title: "BATTERY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BATTERY&partsCategoryCode=BA"),
        Entry(
            title: "BAR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BAR&partsCategoryCode=BAR"),
        Entry(
            title: "BASE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BASE&partsCategoryCode=BASE"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BEARING&partsCategoryCode=BEA"),
        Entry(
            title: "BELLOWS",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BELLOWS&partsCategoryCode=BELLO"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BULB&partsCategoryCode=BLB"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BLOWER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BLOWER&partsCategoryCode=BLW"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BUMPER&partsCategoryCode=BMP"),
        Entry(
            title: "BONET",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BONET&partsCategoryCode=BO"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BODY&partsCategoryCode=BODY"),
        Entry(
            title: "BOLT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BOLT&partsCategoryCode=BOLT"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BREATHER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BREATHER&partsCategoryCode=BREAT"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BUSH",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=BUSH&partsCategoryCode=BUSH"),
        Entry(
            title: "CABLE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CABLE&partsCategoryCode=CAB"),
        Entry(
            title: "CAP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CAP&partsCategoryCode=CAP"),
        Entry(
            title: "CHAIN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CHAIN&partsCategoryCode=CHA"),
        Entry(
            title: "CLAMP ",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CLAMP &partsCategoryCode=CLAMP"),
        Entry(
            title: "CLIP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CLIP&partsCategoryCode=CLIP"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "CONDENSER ",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CONDENSER &partsCategoryCode=COND"),
        Entry(
            title: "CONNECTOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CONNECTOR&partsCategoryCode=CONNTR"),
        Entry(
            title: "CONSOLE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CONSOLE&partsCategoryCode=CONSO"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "CONVERTER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CONVERTER&partsCategoryCode=CONVE"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=COOLANT&partsCategoryCode=COOLA"),
        Entry(
            title: "COOLING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=COOLING&partsCategoryCode=COOLI"),
        Entry(
            title: "COUPLING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=COUPLING&partsCategoryCode=COUPL"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CRANK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CRANK&partsCategoryCode=CRANK"),
        Entry(
            title: "CROSS",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CROSS&partsCategoryCode=CROSS"),
        Entry(
            title: "CUT BUSH",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
        Entry(
            title: "DICKY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=DICKY&partsCategoryCode=DICKY"),
        Entry(
            title: "DISC",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=DISC&partsCategoryCode=DISC"),
        Entry(
            title: "DISTRIBUTION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=DISTRIBUTION&partsCategoryCode=DISTR"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "DOWEL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=DOWEL&partsCategoryCode=DOWEL"),
        Entry(
            title: "DRIVE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ELECTRICAL&partsCategoryCode=ELECT"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "END",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=END&partsCategoryCode=END"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ENGINE&partsCategoryCode=ENG"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "EVAPORATOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
        Entry(
            title: "EXHAUST",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=EXHAUST&partsCategoryCode=EXH"),
        Entry(
            title: "EXPANSION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
        Entry(
            title: "EXPANSION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=EXPANSION&partsCategoryCode=EXPANSION"),
        Entry(
            title: "FAN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FAN&partsCategoryCode=FAN"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FENDER&partsCategoryCode=FENDE"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FILLER NECK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FILLER NECK&partsCategoryCode=FILLRN"),
        Entry(
            title: "FILM",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FILM&partsCategoryCode=FILM"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FILTER&partsCategoryCode=FILTER"),
        Entry(
            title: "FLOOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FLOOR&partsCategoryCode=FL"),
        Entry(
            title: "FLANGE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FLANGE&partsCategoryCode=FLANG"),
        Entry(
            title: "FLAP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FLAP&partsCategoryCode=FLAP"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRAME",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FRAME&partsCategoryCode=FRAME"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "FUSE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=FUSE&partsCategoryCode=FUSE"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GASKET&partsCategoryCode=GAS"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GASKET&partsCategoryCode=GASKET"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GEAR&partsCategoryCode=GEAR"),
        Entry(
            title: "GLOW",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GLOW&partsCategoryCode=GLOW"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GEAR&partsCategoryCode=GR"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "GUIDE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "HEAT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HEAT&partsCategoryCode=HEAT"),
        Entry(
            title: "HIGH PRESSURE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HIGH PRESSURE&partsCategoryCode=HIGH"),
        Entry(
            title: "HINGE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HINGE&partsCategoryCode=HINGE"),
        Entry(
            title: "HOOD",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HOOD&partsCategoryCode=HOOD"),
        Entry(
            title: "HOOK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HOOK&partsCategoryCode=HOOK"),
        Entry(
            title: "HORN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HORN&partsCategoryCode=HORN"),
        Entry(
            title: "HOSE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HOSE&partsCategoryCode=HOSE"),
        Entry(
            title: "HOUSING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HOUSING&partsCategoryCode=HOUSING"),
        Entry(
            title: "HUB",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=HUB&partsCategoryCode=HUB"),
        Entry(
            title: "IGNITION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
        Entry(
            title: "INDICATOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=INDICATOR&partsCategoryCode=INDIC"),
        Entry(
            title: "INTAKE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=INTAKE&partsCategoryCode=INTAK"),
        Entry(
            title: "JOINT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=JOINT&partsCategoryCode=JOINT"),
        Entry(
            title: "KEY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=KEY&partsCategoryCode=KEY"),
        Entry(
            title: "KNOB",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=KNOB&partsCategoryCode=KNOB"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LEVER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LEVER&partsCategoryCode=LEVER"),
        Entry(
            title: "LIGHT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LIGHT&partsCategoryCode=LGHT"),
        Entry(
            title: "LINE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LINE&partsCategoryCode=LINE"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOCK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LOCK&partsCategoryCode=LOCK"),
        Entry(
            title: "LOGO",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LOGO&partsCategoryCode=LOGO"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MIRROR&partsCategoryCode=MIRROR"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "MOTOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
        Entry(
            title: "MOUDLING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
        Entry(
            title: "MOULDING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MOULDING&partsCategoryCode=MOULD"),
        Entry(
            title: "MOUNT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MOUNTING&partsCategoryCode=MOUNTING"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "NOZZLE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
        Entry(
            title: "NUT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=NUT&partsCategoryCode=NUT"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "OIL ASSY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
        Entry(
            title: "OIL COOLER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=OIL COOLER&partsCategoryCode=OILCO"),
        Entry(
            title: "O - RING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=O - RING&partsCategoryCode=O-R"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PIECE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PIECE&partsCategoryCode=PIECE"),
        Entry(
            title: "PIPE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PIPE&partsCategoryCode=PIPE"),
        Entry(
            title: "PLATE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PLATE&partsCategoryCode=PLATE"),
        Entry(
            title: "PLUG",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PLUG&partsCategoryCode=PLUG"),
        Entry(
            title: "POWER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=POWER&partsCategoryCode=POWER"),
        Entry(
            title: "PRESSURE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PRESSURE&partsCategoryCode=PRESS"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PULLEY&partsCategoryCode=PULLE"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PULLEY&partsCategoryCode=PULLEY"),
        Entry(
            title: "PULLY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PULLY&partsCategoryCode=PULLY"),
        Entry(
            title: "PUMP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=PUMP&partsCategoryCode=PUMP"),
        Entry(
            title: "RACK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RACK&partsCategoryCode=RACK"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "RAIL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RAIL&partsCategoryCode=RAIL"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "REFLECTOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
        Entry(
            title: "RELEY",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RELEY&partsCategoryCode=RELEY"),
        Entry(
            title: "REPAIR KIT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=REPAIR KIT&partsCategoryCode=REPAI"),
        Entry(
            title: "RESERVOIR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RESERVOIR&partsCategoryCode=RESER"),
        Entry(
            title: "RING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RING&partsCategoryCode=RING"),
        Entry(
            title: "ROLLER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ROLLER&partsCategoryCode=ROLLE"),
        Entry(
            title: "ROOF",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=ROOF&partsCategoryCode=ROOF"),
        Entry(
            title: "RUBBER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=RUBBER&partsCategoryCode=RUBBE"),
        Entry(
            title: "SCREW",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SCREW&partsCategoryCode=SCREW"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "SEALING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SEALING&partsCategoryCode=SEALI"),
        Entry(
            title: "SEAT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SEAT&partsCategoryCode=SEAT"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SENSOR&partsCategoryCode=SENSO"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHIELD",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SHIELD&partsCategoryCode=SHIEL"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SLEEVE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SLEEVE&partsCategoryCode=SLEEV"),
        Entry(
            title: "SOCKET",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SOCKET&partsCategoryCode=SOCKE"),
        Entry(
            title: "SPACER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SPACER&partsCategoryCode=SPACE"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
        Entry(
            title: "SPOILER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "STAB LINK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STAB LINK&partsCategoryCode=STAB"),
        Entry(
            title: "STABILIZER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STABILIZER&partsCategoryCode=STABI"),
        Entry(
            title: "STARTER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STARTER&partsCategoryCode=START"),
        Entry(
            title: "STEARING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STEARING&partsCategoryCode=STEAR"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STEERING&partsCategoryCode=STEERING"),
        Entry(
            title: "STOP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STOP&partsCategoryCode=STOP"),
        Entry(
            title: "STRIP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STRIP&partsCategoryCode=STRIP"),
        Entry(
            title: "STRUT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=STRUT&partsCategoryCode=STRUT"),
        Entry(
            title: "SUN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SUN&partsCategoryCode=SUN"),
        Entry(
            title: "SUPPORT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SUSPENSION&partsCategoryCode=SUSPENSION"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=SWITCH&partsCategoryCode=SWITCH"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TIE ROD&partsCategoryCode=TIER"),
        Entry(
            title: "TRACK ROD",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TRACK ROD&partsCategoryCode=TRACK"),
        Entry(
            title: "TRANSMISSION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
        Entry(
            title: "TRIM",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TRIM&partsCategoryCode=TRI"),
        Entry(
            title: "TUBE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TUBE&partsCategoryCode=TUBE"),
        Entry(
            title: "TURBO",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TURBO&partsCategoryCode=TURBO"),
        Entry(
            title: "TURN",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TURN&partsCategoryCode=TURN"),
        Entry(
            title: "TYRE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TYRE&partsCategoryCode=TYRE"),
        Entry(
            title: "TYRE LINER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=TYRE LINER&partsCategoryCode=TYREL"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
        Entry(
            title: "VACCUM",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=VACCUM&partsCategoryCode=VACCU"),
        Entry(
            title: "VALVE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=VALVE&partsCategoryCode=VALVE"),
        Entry(
            title: "V-BELT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
        Entry(
            title: "VENT",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=VENT&partsCategoryCode=VENT"),
        Entry(
            title: "VIBRATION",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=VIBRATION&partsCategoryCode=VIBRA"),
        Entry(
            title: "WASHER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WASHER&partsCategoryCode=WASHE"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WATER PUMP&partsCategoryCode=WATER PUMP"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIND",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WIND&partsCategoryCode=WIND"),
        Entry(
            title: "WINDOW",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WINDOW&partsCategoryCode=WINDO"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WIPER&partsCategoryCode=WIPER"),
        Entry(
            title: "WIRE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WIRE&partsCategoryCode=WIRE"),
        Entry(
            title: "WIRING",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WIRING&partsCategoryCode=WIRIN"),
        Entry(
            title: "WISH BONE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WISH BONE&partsCategoryCode=WISH"),
        Entry(
            title: "WISH BONE",
            url:
                "/catalog/products?make=PO&makeCode=PORSCHE&partsCategory=WISH BONE&partsCategoryCode=WISH BONE"),
      ]),
  Entry(
      title: "RANGE ROVER",
      image: 'assets/brands/range_rover_0.png',
      url: "/catalog/products?make=RANGE ROVER&makeCode=RANGE ROVER",
      submenu: <Entry>[
        Entry(
            title: "AIR TEX",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=AIR TEX&origincode=AIR"),
        Entry(
            title: "ALLMAKES 4X4",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=ALLMAKES 4X4&origincode=ALL"),
        Entry(
            title: "BEHR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=BEHR&origincode=BHR"),
        Entry(
            title: "BLUE PRINT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=BLUE PRINT&origincode=BLP"),
        Entry(
            title: "BORG WARNER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=BORG WARNER&origincode=BORG"),
        Entry(
            title: "BOSCH",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=BOSCH&origincode=BSH"),
        Entry(
            title: "BRITPART",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=BRITPART&origincode=BRIT"),
        Entry(
            title: "CALTEX",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=CALTEX&origincode=CAL"),
        Entry(
            title: "CASTROL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=CASTROL&origincode=CAS"),
        Entry(
            title: "CHAMPION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=CHAMPION&origincode=CHAM"),
        Entry(
            title: "CORTECO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=CORTECO&origincode=COR"),
        Entry(
            title: "COUNTY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=COUNTY&origincode=COUNTY"),
        Entry(
            title: "DAYCO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=DAYCO&origincode=DAY"),
        Entry(
            title: "DELPHI",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=DELPHI&origincode=DELPHI"),
        Entry(
            title: "DENSO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=DENSO&origincode=DSO"),
        Entry(
            title: "DPS",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=DPS&origincode=DPS"),
        Entry(
            title: "DUNLOP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=DUNLOP&origincode=DLP"),
        Entry(
            title: "EURO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=EURO&origincode=EURO"),
        Entry(
            title: "FEBI",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=FEBI&origincode=FBI"),
        Entry(
            title: "FERRADO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=FERRADO&origincode=FER"),
        Entry(
            title: "GARRETT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=GARRETT&origincode=GAR"),
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=GERMANY&origincode=GER"),
        Entry(
            title: "GKN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=GKN&origincode=GKN"),
        Entry(
            title: "HASTINGS",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=HASTINGS&origincode=HAS"),
        Entry(
            title: "HELLA",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=HELLA&origincode=HLA"),
        Entry(
            title: "HENGST",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=HENGST&origincode=HST"),
        Entry(
            title: "HITACHI",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=HITACHI&origincode=HIT"),
        Entry(
            title: "LEMFORDER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=LEMFORDER&origincode=LEM"),
        Entry(
            title: "MAGNET MARELLI",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=MAGNET MARELLI&origincode=MM"),
        Entry(
            title: "MAHLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=MAHLE&origincode=MHF"),
        Entry(
            title: "MAN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=MAN&origincode=MAN"),
        Entry(
            title: "MAXPART",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=MAXPART&origincode=MXP"),
        Entry(
            title: "MAYER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=MAYER&origincode=MAYER"),
        Entry(
            title: "MEYLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=MEYLE&origincode=MEY"),
        Entry(
            title: "NGK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=NGK&origincode=NGK"),
        Entry(
            title: "NISSENS",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=NISSENS&origincode=NIS"),
        Entry(
            title: "OEM",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=OEM&origincode=OEM"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "SANDEN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=SANDEN&origincode=SAN"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=TAIWAN&origincode=TWN"),
        Entry(
            title: "TEXTAR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=TEXTAR&origincode=TEX"),
        Entry(
            title: "TRUCKTEC",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=TRUCKTEC&origincode=TTC"),
        Entry(
            title: "TRW",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=TRW&origincode=TRW"),
        Entry(
            title: "U.K",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=U.K&origincode=UK"),
        Entry(
            title: "VALEO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=VALEO&origincode=VAL"),
        Entry(
            title: "VDO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=VDO&origincode=VDO"),
        Entry(
            title: "ZF",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&origin=ZF&origincode=ZF"),
        Entry(
            title: "A/C",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=A/C&partsCategoryCode=A/C"),
        Entry(
            title: "ABSORBER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ABSORBER&partsCategoryCode=ABS"),
        Entry(
            title: "A/C",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=A/C&partsCategoryCode=AC"),
        Entry(
            title: "AC BLOWER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC BLOWER&partsCategoryCode=AC BLOWER"),
        Entry(
            title: "AC CONDENSER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC CONDENSER&partsCategoryCode=AC CONDENSER"),
        Entry(
            title: "AC ASSY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC ASSY&partsCategoryCode=ACAS"),
        Entry(
            title: "AC BELT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC BELT&partsCategoryCode=ACBE"),
        Entry(
            title: "AC BLOWER MOTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC BLOWER MOTOR&partsCategoryCode=ACBLM"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
        Entry(
            title: "AC CONDENSER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
        Entry(
            title: "ACCUMUALTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ACCUMUALTOR&partsCategoryCode=ACCUM"),
        Entry(
            title: "AC DRIER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AC DRIER&partsCategoryCode=ACDR"),
        Entry(
            title: "ACTUATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
        Entry(
            title: "ACTUATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ACTUATOR&partsCategoryCode=ACTUATOR"),
        Entry(
            title: "ADAPTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ADAPTER&partsCategoryCode=ADAPT"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "ANTI FREEZE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ANTI FREEZE&partsCategoryCode=ANTI"),
        Entry(
            title: "ARM",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ARM&partsCategoryCode=ARM"),
        Entry(
            title: "ASHTRAY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ASHTRAY&partsCategoryCode=ASHTRAY"),
        Entry(
            title: "AUXILARY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AUXILARY&partsCategoryCode=AUXIL"),
        Entry(
            title: "AXLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AXLE&partsCategoryCode=AX"),
        Entry(
            title: "AXLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=AXLE&partsCategoryCode=AXLE"),
        Entry(
            title: "BATTERY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BATTERY&partsCategoryCode=BA"),
        Entry(
            title: "BADGE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BADGE&partsCategoryCode=BADGE"),
        Entry(
            title: "BALL JOINT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
        Entry(
            title: "BAR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BAR&partsCategoryCode=BAR"),
        Entry(
            title: "BATTERY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BATTERY&partsCategoryCode=BATTERY"),
        Entry(
            title: "BAZEL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BAZEL&partsCategoryCode=BAZEL"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BEARING&partsCategoryCode=BEA"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BULB&partsCategoryCode=BLB"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BUMPER&partsCategoryCode=BMP"),
        Entry(
            title: "BONET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BONET&partsCategoryCode=BO"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BODY&partsCategoryCode=BODY"),
        Entry(
            title: "BOLT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BOLT&partsCategoryCode=BOLT"),
        Entry(
            title: "BONET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BONET&partsCategoryCode=BONET"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE PAD"),
        Entry(
            title: "BREATHER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BREATHER&partsCategoryCode=BREATHER"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BUMPER&partsCategoryCode=BUMPER"),
        Entry(
            title: "BUSH",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=BUSH&partsCategoryCode=BUSH"),
        Entry(
            title: "CAMERA",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CAMERA&partsCategoryCode=CAM"),
        Entry(
            title: "CAMERA",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CAMERA&partsCategoryCode=CAMERA"),
        Entry(
            title: "CAP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CAP&partsCategoryCode=CAP"),
        Entry(
            title: "CATALYST CONVERTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CATALYST CONVERTER&partsCategoryCode=CATAL"),
        Entry(
            title: "CENTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CENTER&partsCategoryCode=CEN"),
        Entry(
            title: "CHAIN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CHAIN&partsCategoryCode=CHA"),
        Entry(
            title: "CHAIN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CHAIN&partsCategoryCode=CHAIN"),
        Entry(
            title: "CHROME",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CHROME&partsCategoryCode=CHROM"),
        Entry(
            title: "CLIP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CLIP&partsCategoryCode=CLIP"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMPRESSION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COMPRESSION&partsCategoryCode=COMPRESSION"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "COMPUTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COMPUTER&partsCategoryCode=COMPUTER"),
        Entry(
            title: "CONDENSER ",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CONDENSER &partsCategoryCode=COND"),
        Entry(
            title: "CONNECTING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CONNECTING&partsCategoryCode=CONNTNG"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "CONVERTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CONVERTER&partsCategoryCode=CONVE"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COOLANT&partsCategoryCode=COOLA"),
        Entry(
            title: "COOLER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COOLER&partsCategoryCode=COOLER"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CRANK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CRANK&partsCategoryCode=CRANK"),
        Entry(
            title: "CUP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CUP&partsCategoryCode=CUP"),
        Entry(
            title: "CUT BUSH",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CUT BUSH&partsCategoryCode=CUTB"),
        Entry(
            title: "CYLINDER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=CYLINDER&partsCategoryCode=CYL"),
        Entry(
            title: "DAMPER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DAMPER&partsCategoryCode=DAMPE"),
        Entry(
            title: "DASHBOARD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DASHBOARD&partsCategoryCode=DASHB"),
        Entry(
            title: "DEFLECTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DEFLECTOR&partsCategoryCode=DEFLETR"),
        Entry(
            title: "DISC",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DISC&partsCategoryCode=DISC"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "DRIER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DRIER&partsCategoryCode=DRIER"),
        Entry(
            title: "DRIVE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ENGINE&partsCategoryCode=ENG"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "EVAPORATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
        Entry(
            title: "EXHAUST",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=EXHAUST&partsCategoryCode=EXH"),
        Entry(
            title: "EXHAUST",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=EXHAUST&partsCategoryCode=EXHAUST"),
        Entry(
            title: "EXPANSION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
        Entry(
            title: "FAN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FAN&partsCategoryCode=FAN"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FENDER&partsCategoryCode=FENDE"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FILTER&partsCategoryCode=FILTER"),
        Entry(
            title: "FINISHER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FINISHER&partsCategoryCode=FINIS"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FUEL&partsCategoryCode=FUEL"),
        Entry(
            title: "FUSE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=FUSE&partsCategoryCode=FUSE"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GASKET&partsCategoryCode=GAS"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GASKET&partsCategoryCode=GASKET"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GLASS&partsCategoryCode=GL"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GLASS&partsCategoryCode=GLASS"),
        Entry(
            title: "GLOW",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GLOW&partsCategoryCode=GLOW"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GEAR&partsCategoryCode=GR"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "GUIDE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
        Entry(
            title: "HAND",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HAND&partsCategoryCode=HAND"),
        Entry(
            title: "HANDL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HANDL&partsCategoryCode=HANDL"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "HIGH PRESSURE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HIGH PRESSURE&partsCategoryCode=HIGH"),
        Entry(
            title: "HINGE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HINGE&partsCategoryCode=HINGE"),
        Entry(
            title: "HOOD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HOOD&partsCategoryCode=HOOD"),
        Entry(
            title: "HOOK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HOOK&partsCategoryCode=HOOK"),
        Entry(
            title: "HORN",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=HORN&partsCategoryCode=HORN"),
        Entry(
            title: "HOSE",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=HOSE&partsCategoryCode=HOSE"),
        Entry(
            title: "HOSE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HOSE&partsCategoryCode=HOSE"),
        Entry(
            title: "HUB",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=HUB&partsCategoryCode=HUB"),
        Entry(
            title: "IDLER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=IDLER&partsCategoryCode=IDLER"),
        Entry(
            title: "IGNITION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
        Entry(
            title: "INJECTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
        Entry(
            title: "INSERT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=INSERT&partsCategoryCode=INSER"),
        Entry(
            title: "INSTRUMENT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=INSTRUMENT&partsCategoryCode=INSTR"),
        Entry(
            title: "INSULATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
        Entry(
            title: "INTAKE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=INTAKE&partsCategoryCode=INTAK"),
        Entry(
            title: "INTAKE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=INTAKE&partsCategoryCode=INTAKE"),
        Entry(
            title: "JOINT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=JOINT&partsCategoryCode=JOINT"),
        Entry(
            title: "KIT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=KIT&partsCategoryCode=KIT"),
        Entry(
            title: "KNUCKLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=KNUCKLE&partsCategoryCode=KNUCK"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LATCH",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LATCH&partsCategoryCode=LATCH"),
        Entry(
            title: "LEVER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LEVER&partsCategoryCode=LEVER"),
        Entry(
            title: "LIGHT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LIGHT&partsCategoryCode=LGHT"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOCK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LOCK&partsCategoryCode=LOCK"),
        Entry(
            title: "LOGO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LOGO&partsCategoryCode=LOGO"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MASTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MASTER&partsCategoryCode=MASTE"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MIRROR&partsCategoryCode=MIRROR"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "MOTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
        Entry(
            title: "MOUDLING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
        Entry(
            title: "MOULDING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MOULDING&partsCategoryCode=MOULD"),
        Entry(
            title: "MOUNT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MOUNTING&partsCategoryCode=MOUNTING"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "MUD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=MUD&partsCategoryCode=MUD"),
        Entry(
            title: "NAME PLATE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=NAME PLATE&partsCategoryCode=NAME"),
        Entry(
            title: "NAME PLATE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=NAME PLATE&partsCategoryCode=NAME PLATE"),
        Entry(
            title: "NOZZLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
        Entry(
            title: "NUT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=NUT&partsCategoryCode=NUT"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "OIL ASSY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
        Entry(
            title: "OIL COOLER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=OIL COOLER&partsCategoryCode=OILCO"),
        Entry(
            title: "O - RING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=O - RING&partsCategoryCode=O-R"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PANEL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PANEL&partsCategoryCode=PANEL"),
        Entry(
            title: "PIPE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PIPE&partsCategoryCode=PIPE"),
        Entry(
            title: "PISTON",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PISTON&partsCategoryCode=PISTO"),
        Entry(
            title: "PLATE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PLATE&partsCategoryCode=PLATE"),
        Entry(
            title: "PLUG",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PLUG&partsCategoryCode=PLUG"),
        Entry(
            title: "POWER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=POWER&partsCategoryCode=POWER"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PULLEY&partsCategoryCode=PULLE"),
        Entry(
            title: "PUMP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=PUMP&partsCategoryCode=PUMP"),
        Entry(
            title: "RACK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=RACK&partsCategoryCode=RACK"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=RADIATOR&partsCategoryCode=RADIATOR"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "REFLECTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
        Entry(
            title: "REGULATOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
        Entry(
            title: "RETAINER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=RETAINER&partsCategoryCode=RETAI"),
        Entry(
            title: "ROD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ROD&partsCategoryCode=ROD"),
        Entry(
            title: "ROTOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
        Entry(
            title: "SCREW",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SCREW&partsCategoryCode=SCREW"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "SEAT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SEAT&partsCategoryCode=SEAT"),
        Entry(
            title: "SENDER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SENDER&partsCategoryCode=SENDE"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SENSOR&partsCategoryCode=SENSO"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SENSOR&partsCategoryCode=SENSOR"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHIELD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SHIELD&partsCategoryCode=SHIEL"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SIDE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SIDE&partsCategoryCode=SIDE"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SPARK PLUG&partsCategoryCode=SPARK PLUG"),
        Entry(
            title: "SPOILER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "SPROCKET",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SPROCKET&partsCategoryCode=SPROCKET"),
        Entry(
            title: "STABILIZER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=STABILIZER&partsCategoryCode=STABI"),
        Entry(
            title: "STARTER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=STARTER&partsCategoryCode=START"),
        Entry(
            title: "STEARING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=STEARING&partsCategoryCode=STEAR"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "SUPPORT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=BM&makeCode=RANGE ROVER&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=THERMOSTAT&partsCategoryCode=THERMOSTAT"),
        Entry(
            title: "THERMOSTAT AND HOUSING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=THERMOSTAT AND HOUSING&partsCategoryCode=THERMOSTAT AND HOUSING"),
        Entry(
            title: "THROTTLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=THROTTLE&partsCategoryCode=THROT"),
        Entry(
            title: "THROTTLE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=THROTTLE&partsCategoryCode=THROTTLE"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TIE ROD&partsCategoryCode=TIER"),
        Entry(
            title: "TIMING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TIMING&partsCategoryCode=TIMIN"),
        Entry(
            title: "TIMING CHAIN",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TIMING CHAIN&partsCategoryCode=TIMINC"),
        Entry(
            title: "TIMING",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TIMING&partsCategoryCode=TIMING"),
        Entry(
            title: "TRACK ROD",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TRACK ROD&partsCategoryCode=TRACK"),
        Entry(
            title: "TRANSMISSION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
        Entry(
            title: "TRANSMISSION",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TRANSMISSION&partsCategoryCode=TRANSMISSION"),
        Entry(
            title: "TUBE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TUBE&partsCategoryCode=TUBE"),
        Entry(
            title: "TURBO",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=TURBO&partsCategoryCode=TURBO"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=UPPER ARM&partsCategoryCode=UPPER ARM"),
        Entry(
            title: "VACCUM",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=VACCUM&partsCategoryCode=VACCU"),
        Entry(
            title: "VALVE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=VALVE&partsCategoryCode=VALVE"),
        Entry(
            title: "V-BELT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
        Entry(
            title: "VENT",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=VENT&partsCategoryCode=VENT"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
        Entry(
            title: "WEATER STRIPE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WEATER STRIPE&partsCategoryCode=WEATE"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIND",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WIND&partsCategoryCode=WIND"),
        Entry(
            title: "WINDOW",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WINDOW&partsCategoryCode=WINDO"),
        Entry(
            title: "WIPER",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WIPER&partsCategoryCode=WIPER"),
        Entry(
            title: "WISH BONE",
            url:
                "/catalog/products?make=RR&makeCode=RANGE ROVER&partsCategory=WISH BONE&partsCategoryCode=WISH"),
      ]),
  Entry(
      title: "SSANG YONG",
      url: "/catalog/products?make=SSANG YONG&makeCode=SSANG YONG",
      image: 'assets/brands/SSANG-YONG.png',
      submenu: <Entry>[
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=SSANG YONG&makeCode=SSANG YONG&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=SSANG YONG&makeCode=SSANG YONG&partsCategory=HEAD&partsCategoryCode=HEAD"),
      ]),
  Entry(
      title: "TOYOTA",
      url: "/catalog/products?make=TOYOTA&makeCode=TOYOTA",
      image: 'assets/brands/TOYOTA.png',
      submenu: <Entry>[
        Entry(
            title: "ACDELCO",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=ACDELCO&origincode=ACDELCO"),
        Entry(
            title: "ADNOC",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=ADNOC&origincode=ADNOC"),
        Entry(
            title: "DENSO",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=DENSO&origincode=DSO"),
        Entry(
            title: "FJ TECH",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=FJ TECH&origincode=FJ"),
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=GERMANY&origincode=GER"),
        Entry(
            title: "GMB",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=GMB&origincode=GMB"),
        Entry(
            title: "INCOE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=INCOE&origincode=INCOE"),
        Entry(
            title: "JAPAN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=JAPAN&origincode=JAPAN"),
        Entry(
            title: "KOYO",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=KOYO&origincode=KOYO"),
        Entry(
            title: "LEMFORDER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=LEMFORDER&origincode=LEM"),
        Entry(
            title: "MAXPART",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=MAXPART&origincode=MXP"),
        Entry(
            title: "MOBIS",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=MOBIS&origincode=MOBIS"),
        Entry(
            title: "NGK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=NGK&origincode=NGK"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=TO&makeCode=TOYOTA&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "OSRAM",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=OSRAM&origincode=OSR"),
        Entry(
            title: "PIERBURG",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=PIERBURG&origincode=PBG"),
        Entry(
            title: "PRESTONE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=PRESTONE&origincode=PST"),
        Entry(
            title: "SF",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=SF&origincode=SF"),
        Entry(
            title: "SHELL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=SHELL&origincode=SL"),
        Entry(
            title: "SUPER GRIP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=SUPER GRIP&origincode=SPG"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=TAIWAN&origincode=TWN"),
        Entry(
            title: "TRW",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&origin=TRW&origincode=TRW"),
        Entry(
            title: "ABSORBER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ABSORBER&partsCategoryCode=ABS"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=AC COMPRESSOR&partsCategoryCode=AC COMPRESSOR"),
        Entry(
            title: "ACCELERATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ACCELERATOR&partsCategoryCode=ACCEL"),
        Entry(
            title: "AC COMPRESSOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=AC COMPRESSOR&partsCategoryCode=ACCOM"),
        Entry(
            title: "AC CONDENSER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=AC CONDENSER&partsCategoryCode=ACCON"),
        Entry(
            title: "ACCUMUALTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ACCUMUALTOR&partsCategoryCode=ACCUM"),
        Entry(
            title: "ACTUATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ACTUATOR&partsCategoryCode=ACTUA"),
        Entry(
            title: "ADJUSTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ADJUSTER&partsCategoryCode=ADJ"),
        Entry(
            title: "AIR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=AIR&partsCategoryCode=AIR"),
        Entry(
            title: "ALTERNATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ALTERNATOR&partsCategoryCode=ALTER"),
        Entry(
            title: "AMPLIFIER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=AMPLIFIER&partsCategoryCode=AMPLI"),
        Entry(
            title: "ANTENNA",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ANTENNA&partsCategoryCode=ANTEN"),
        Entry(
            title: "ARM",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ARM&partsCategoryCode=ARM"),
        Entry(
            title: "AXLE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=AXLE&partsCategoryCode=AX"),
        Entry(
            title: "BATTERY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BATTERY&partsCategoryCode=BA"),
        Entry(
            title: "BALL JOINT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BALL JOINT&partsCategoryCode=BALLJ"),
        Entry(
            title: "BAR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BAR&partsCategoryCode=BAR"),
        Entry(
            title: "BASE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BASE&partsCategoryCode=BASE"),
        Entry(
            title: "BEARING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BEARING&partsCategoryCode=BEA"),
        Entry(
            title: "BLADE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BLADE&partsCategoryCode=BLADE"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BULB&partsCategoryCode=BLB"),
        Entry(
            title: "BELT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BELT&partsCategoryCode=BLT"),
        Entry(
            title: "BLOWER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BLOWER&partsCategoryCode=BLW"),
        Entry(
            title: "BUMPER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BUMPER&partsCategoryCode=BMP"),
        Entry(
            title: "BONET",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BONET&partsCategoryCode=BO"),
        Entry(
            title: "BODY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BODY&partsCategoryCode=BODY"),
        Entry(
            title: "BOLT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BOLT&partsCategoryCode=BOLT"),
        Entry(
            title: "BOOT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BOOT&partsCategoryCode=BOOT"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=TO&makeCode=TOYOTA&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "BULB",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BULB&partsCategoryCode=BULB"),
        Entry(
            title: "BUSH",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=BUSH&partsCategoryCode=BUSH"),
        Entry(
            title: "CABLE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CABLE&partsCategoryCode=CAB"),
        Entry(
            title: "CALIPER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CALIPER&partsCategoryCode=CALIP"),
        Entry(
            title: "CAMERA",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CAMERA&partsCategoryCode=CAM"),
        Entry(
            title: "CAP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CAP&partsCategoryCode=CAP"),
        Entry(
            title: "CARRIER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CARRIER&partsCategoryCode=CAR"),
        Entry(
            title: "CASE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CASE&partsCategoryCode=CASE"),
        Entry(
            title: "CATALYST CONVERTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CATALYST CONVERTER&partsCategoryCode=CATAL"),
        Entry(
            title: "CHAIN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CHAIN&partsCategoryCode=CHA"),
        Entry(
            title: "CHANNEL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CHANNEL&partsCategoryCode=CHANN"),
        Entry(
            title: "CHECK ASSY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CHECK ASSY&partsCategoryCode=CHECK"),
        Entry(
            title: "CLAMP ",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CLAMP &partsCategoryCode=CLAMP"),
        Entry(
            title: "CLIP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CLIP&partsCategoryCode=CLIP"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CLUTCH&partsCategoryCode=CLUTC"),
        Entry(
            title: "CLUTCH",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CLUTCH&partsCategoryCode=CLUTCH"),
        Entry(
            title: "CLY ASSY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CLY ASSY&partsCategoryCode=CLYA"),
        Entry(
            title: "COIL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COIL&partsCategoryCode=COIL"),
        Entry(
            title: "COMPUTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COMPUTER&partsCategoryCode=COM"),
        Entry(
            title: "COMPRESSOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COMPRESSOR&partsCategoryCode=COMPRSR"),
        Entry(
            title: "CONDENSER ",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CONDENSER &partsCategoryCode=COND"),
        Entry(
            title: "CONNECTING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CONNECTING&partsCategoryCode=CONNTNG"),
        Entry(
            title: "CONTROL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CONTROL&partsCategoryCode=CONTR"),
        Entry(
            title: "COOLANT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COOLANT&partsCategoryCode=COOLA"),
        Entry(
            title: "COOLER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COOLER&partsCategoryCode=COOLER"),
        Entry(
            title: "COOLING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COOLING&partsCategoryCode=COOLI"),
        Entry(
            title: "COUPLING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COUPLING&partsCategoryCode=COUPL"),
        Entry(
            title: "COVER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=COVER&partsCategoryCode=COVER"),
        Entry(
            title: "CUP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CUP&partsCategoryCode=CUP"),
        Entry(
            title: "CUSHION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CUSHION&partsCategoryCode=CUSHI"),
        Entry(
            title: "CV JOINT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CV JOINT&partsCategoryCode=CVJO"),
        Entry(
            title: "CYLINDER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CYLINDER&partsCategoryCode=CYL"),
        Entry(
            title: "CYLENDER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=CYLENDER&partsCategoryCode=CYLEN"),
        Entry(
            title: "DAMPER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DAMPER&partsCategoryCode=DAMPE"),
        Entry(
            title: "DASHBOARD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DASHBOARD&partsCategoryCode=DASHB"),
        Entry(
            title: "DEFLECTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DEFLECTOR&partsCategoryCode=DEFLETR"),
        Entry(
            title: "DISC",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DISC&partsCategoryCode=DISC"),
        Entry(
            title: "DOOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DOOR&partsCategoryCode=DOOR"),
        Entry(
            title: "DRIER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DRIER&partsCategoryCode=DRIER"),
        Entry(
            title: "DRIVE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DRIVE&partsCategoryCode=DRIVE"),
        Entry(
            title: "DRUM",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=DRUM&partsCategoryCode=DRUM"),
        Entry(
            title: "ECU",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ECU&partsCategoryCode=ECU"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ELECTRICAL&partsCategoryCode=ELECT"),
        Entry(
            title: "ELECTRICAL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ELECTRICAL&partsCategoryCode=ELECTRICAL"),
        Entry(
            title: "ELEMENT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ELEMENT&partsCategoryCode=ELEME"),
        Entry(
            title: "EMBLEM",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=EMBLEM&partsCategoryCode=EMB"),
        Entry(
            title: "END",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=END&partsCategoryCode=END"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ENGINE&partsCategoryCode=ENG"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ENGINE&partsCategoryCode=ENGINE"),
        Entry(
            title: "EVAPORATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=EVAPORATOR&partsCategoryCode=EVA"),
        Entry(
            title: "EXHAUST",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=EXHAUST&partsCategoryCode=EXHAUST"),
        Entry(
            title: "EXPANSION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=EXPANSION&partsCategoryCode=EXPAN"),
        Entry(
            title: "EXTENSION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=EXTENSION&partsCategoryCode=EXTEN"),
        Entry(
            title: "FAN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FAN&partsCategoryCode=FAN"),
        Entry(
            title: "FENDER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FENDER&partsCategoryCode=FENDE"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FILTER&partsCategoryCode=FI"),
        Entry(
            title: "FILLER SUB ASSY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FILLER SUB ASSY&partsCategoryCode=FILLRS"),
        Entry(
            title: "FILTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FILTER&partsCategoryCode=FILTER"),
        Entry(
            title: "FITTING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FITTING&partsCategoryCode=FITTI"),
        Entry(
            title: "FLANGE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FLANGE&partsCategoryCode=FLANG"),
        Entry(
            title: "FOG",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FOG&partsCategoryCode=FOG"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FUEL&partsCategoryCode=FU"),
        Entry(
            title: "FUEL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FUEL&partsCategoryCode=FUEL"),
        Entry(
            title: "FUSE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=FUSE&partsCategoryCode=FUSE"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GASKET&partsCategoryCode=GASK"),
        Entry(
            title: "GASKET",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GASKET&partsCategoryCode=GASKET"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GEAR&partsCategoryCode=GEAR"),
        Entry(
            title: "GLASS",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GLASS&partsCategoryCode=GL"),
        Entry(
            title: "GLOW",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GLOW&partsCategoryCode=GLOW"),
        Entry(
            title: "GEAR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GEAR&partsCategoryCode=GR"),
        Entry(
            title: "GRILL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GRILL&partsCategoryCode=GRILL"),
        Entry(
            title: "GROMMET",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GROMMET&partsCategoryCode=GROMM"),
        Entry(
            title: "GUIDE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=GUIDE&partsCategoryCode=GUIDE"),
        Entry(
            title: "HAND",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HAND&partsCategoryCode=HAN"),
        Entry(
            title: "HANDL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HANDL&partsCategoryCode=HANDL"),
        Entry(
            title: "HEAD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HEAD&partsCategoryCode=HEAD"),
        Entry(
            title: "HIGH PRESSURE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HIGH PRESSURE&partsCategoryCode=HIGH"),
        Entry(
            title: "HINGE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HINGE&partsCategoryCode=HINGE"),
        Entry(
            title: "HOLDER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HOLDER&partsCategoryCode=HOLDER"),
        Entry(
            title: "HOOD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HOOD&partsCategoryCode=HOOD"),
        Entry(
            title: "HOOK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HOOK&partsCategoryCode=HOOK"),
        Entry(
            title: "HORN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HORN&partsCategoryCode=HORN"),
        Entry(
            title: "HOSE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HOSE&partsCategoryCode=HOSE"),
        Entry(
            title: "HOUSING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HOUSING&partsCategoryCode=HOUSING"),
        Entry(
            title: "HUB",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=HUB&partsCategoryCode=HUB"),
        Entry(
            title: "IDLER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=IDLER&partsCategoryCode=IDLER"),
        Entry(
            title: "IGNITION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=IGNITION&partsCategoryCode=IGNIT"),
        Entry(
            title: "INJECTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=INJECTOR&partsCategoryCode=INJEC"),
        Entry(
            title: "INSTRUMENT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=INSTRUMENT&partsCategoryCode=INSTR"),
        Entry(
            title: "INSULATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=INSULATOR&partsCategoryCode=INSUL"),
        Entry(
            title: "JOINT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=JOINT&partsCategoryCode=JOINT"),
        Entry(
            title: "KEY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=KEY&partsCategoryCode=KEY"),
        Entry(
            title: "KIT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=KIT&partsCategoryCode=KIT"),
        Entry(
            title: "KNOB",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=KNOB&partsCategoryCode=KNOB"),
        Entry(
            title: "KNUCKLE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=KNUCKLE&partsCategoryCode=KNUCK"),
        Entry(
            title: "LAMP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LAMP&partsCategoryCode=LAMP"),
        Entry(
            title: "LATERAL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LATERAL&partsCategoryCode=LATER"),
        Entry(
            title: "LENS & BODY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LENS & BODY&partsCategoryCode=LENS"),
        Entry(
            title: "LEVER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LEVER&partsCategoryCode=LEVER"),
        Entry(
            title: "LIGHT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LIGHT&partsCategoryCode=LGHT"),
        Entry(
            title: "LIGHT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LIGHT&partsCategoryCode=LIGHT"),
        Entry(
            title: "LINE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LINE&partsCategoryCode=LINE"),
        Entry(
            title: "LINK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LINK&partsCategoryCode=LINK"),
        Entry(
            title: "LOCK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LOCK&partsCategoryCode=LOCK"),
        Entry(
            title: "LOWER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=LOWER&partsCategoryCode=LOWER"),
        Entry(
            title: "MASTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MASTER&partsCategoryCode=MASTE"),
        Entry(
            title: "MIRROR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MIRROR&partsCategoryCode=MIRRO"),
        Entry(
            title: "MODULE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MODULE&partsCategoryCode=MODUL"),
        Entry(
            title: "MOTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MOTOR&partsCategoryCode=MOTOR"),
        Entry(
            title: "MOUDLING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MOUDLING&partsCategoryCode=MOUDL"),
        Entry(
            title: "MOUNT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MOUNT&partsCategoryCode=MOUNT"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "MUD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=MUD&partsCategoryCode=MUD"),
        Entry(
            title: "NOZZLE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=NOZZLE&partsCategoryCode=NOZZL"),
        Entry(
            title: "NUT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=NUT&partsCategoryCode=NUT"),
        Entry(
            title: "OIL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=OIL&partsCategoryCode=OIL"),
        Entry(
            title: "OIL ASSY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=OIL ASSY&partsCategoryCode=OILA"),
        Entry(
            title: "O - RING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=O - RING&partsCategoryCode=O-R"),
        Entry(
            title: "ORNAMENTAL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ORNAMENTAL&partsCategoryCode=ORNAM"),
        Entry(
            title: "OTHERS",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=OTHERS&partsCategoryCode=OTHER"),
        Entry(
            title: "PAD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PAD&partsCategoryCode=PAD"),
        Entry(
            title: "PANEL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PANEL&partsCategoryCode=PANEL"),
        Entry(
            title: "PIN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PIN&partsCategoryCode=PIN"),
        Entry(
            title: "PIPE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PIPE&partsCategoryCode=PIPE"),
        Entry(
            title: "PISTON",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PISTON&partsCategoryCode=PISTO"),
        Entry(
            title: "PLATE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PLATE&partsCategoryCode=PLATE"),
        Entry(
            title: "PLUG",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PLUG&partsCategoryCode=PLUG"),
        Entry(
            title: "POWER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=POWER&partsCategoryCode=POWER"),
        Entry(
            title: "PRESSURE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PRESSURE&partsCategoryCode=PRESS"),
        Entry(
            title: "PROTECTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PROTECTOR&partsCategoryCode=PROTE"),
        Entry(
            title: "PULLEY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PULLEY&partsCategoryCode=PULLE"),
        Entry(
            title: "PUMP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=PUMP&partsCategoryCode=PUMP"),
        Entry(
            title: "RACK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RACK&partsCategoryCode=RACK"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "RAIL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RAIL&partsCategoryCode=RAIL"),
        Entry(
            title: "REAR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=REAR&partsCategoryCode=REAR"),
        Entry(
            title: "REFLECTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=REFLECTOR&partsCategoryCode=REFLE"),
        Entry(
            title: "REGISTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=REGISTER&partsCategoryCode=REGIS"),
        Entry(
            title: "REGULATOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=REGULATOR&partsCategoryCode=REGUL"),
        Entry(
            title: "REINFORCEMENT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=REINFORCEMENT&partsCategoryCode=REINF"),
        Entry(
            title: "RELAY",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RELAY&partsCategoryCode=RELAY"),
        Entry(
            title: "RESISTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RESISTOR&partsCategoryCode=RESIS"),
        Entry(
            title: "RETAINER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RETAINER&partsCategoryCode=RETAI"),
        Entry(
            title: "RING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RING&partsCategoryCode=RING"),
        Entry(
            title: "ROD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ROD&partsCategoryCode=ROD"),
        Entry(
            title: "ROLLER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ROLLER&partsCategoryCode=ROLLE"),
        Entry(
            title: "ROTOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=ROTOR&partsCategoryCode=ROTOR"),
        Entry(
            title: "RUBBER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=RUBBER&partsCategoryCode=RUBBE"),
        Entry(
            title: "SCREW",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SCREW&partsCategoryCode=SCREW"),
        Entry(
            title: "SEAL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SEAL&partsCategoryCode=SEAL"),
        Entry(
            title: "SEAT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SEAT&partsCategoryCode=SEAT"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SENSOR&partsCategoryCode=SENSO"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SENSOR&partsCategoryCode=SENSOR"),
        Entry(
            title: "SHAFT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SHAFT&partsCategoryCode=SHAFT"),
        Entry(
            title: "SHIELD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SHIELD&partsCategoryCode=SHIEL"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "SILICON",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SILICON&partsCategoryCode=SILIC"),
        Entry(
            title: "SLEEVE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SLEEVE&partsCategoryCode=SLEEV"),
        Entry(
            title: "SOLENOID",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SOLENOID&partsCategoryCode=SOLEN"),
        Entry(
            title: "SPACER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SPACER&partsCategoryCode=SPACE"),
        Entry(
            title: "SPARK PLUG",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SPARK PLUG&partsCategoryCode=SPARK"),
        Entry(
            title: "SPINDLE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SPINDLE&partsCategoryCode=SPIND"),
        Entry(
            title: "SPOILER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SPOILER&partsCategoryCode=SPOIL"),
        Entry(
            title: "SPRING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SPRING&partsCategoryCode=SPRIN"),
        Entry(
            title: "STABILIZER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STABILIZER&partsCategoryCode=STABI"),
        Entry(
            title: "STARTER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STARTER&partsCategoryCode=START"),
        Entry(
            title: "STEARING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STEARING&partsCategoryCode=STEAR"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STEERING&partsCategoryCode=STEER"),
        Entry(
            title: "STEERING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STEERING&partsCategoryCode=STEERING"),
        Entry(
            title: "STOP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STOP&partsCategoryCode=STOP"),
        Entry(
            title: "STRUT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=STRUT&partsCategoryCode=STRUT"),
        Entry(
            title: "SUPPORT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SUPPORT&partsCategoryCode=SUPPO"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SUSPENSION&partsCategoryCode=SUSPE"),
        Entry(
            title: "SUSPENSION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SUSPENSION&partsCategoryCode=SUSPENSION"),
        Entry(
            title: "SWITCH",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=SWITCH&partsCategoryCode=SWITC"),
        Entry(
            title: "TANK",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TANK&partsCategoryCode=TANK"),
        Entry(
            title: "TENSIONER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TENSIONER&partsCategoryCode=TENSI"),
        Entry(
            title: "THERMOSTAT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=THERMOSTAT&partsCategoryCode=THERM"),
        Entry(
            title: "THROTTLE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=THROTTLE&partsCategoryCode=THROT"),
        Entry(
            title: "THRUST",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=THRUST&partsCategoryCode=THRUS"),
        Entry(
            title: "TIE ROD",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TIE ROD&partsCategoryCode=TIER"),
        Entry(
            title: "TIMING",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TIMING&partsCategoryCode=TIMIN"),
        Entry(
            title: "TIMING CHAIN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TIMING CHAIN&partsCategoryCode=TIMINC"),
        Entry(
            title: "TIMING CHAIN",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TIMING CHAIN&partsCategoryCode=TIMING CHAIN"),
        Entry(
            title: "TRANSMISSION",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TRANSMISSION&partsCategoryCode=TRANS"),
        Entry(
            title: "TUBE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TUBE&partsCategoryCode=TUBE"),
        Entry(
            title: "TURBO",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TURBO&partsCategoryCode=TURBO"),
        Entry(
            title: "TYRE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=TYRE&partsCategoryCode=TYRE"),
        Entry(
            title: "UPPER ARM",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=UPPER ARM&partsCategoryCode=UPPER"),
        Entry(
            title: "VALVE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=VALVE&partsCategoryCode=VALVE"),
        Entry(
            title: "V-BELT",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
        Entry(
            title: "WASHER",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=WASHER&partsCategoryCode=WASHE"),
        Entry(
            title: "WATER PUMP",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=WATER PUMP&partsCategoryCode=WATER"),
        Entry(
            title: "WEATER STRIPE",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=WEATER STRIPE&partsCategoryCode=WEATE"),
        Entry(
            title: "WHEEL",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=WHEEL&partsCategoryCode=WHEEL"),
        Entry(
            title: "WIND",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=WIND&partsCategoryCode=WIND"),
        Entry(
            title: "WINDOW",
            url:
                "/catalog/products?make=TY&makeCode=TOYOTA&partsCategory=WINDOW&partsCategoryCode=WINDO"),
      ]),
  Entry(
      title: "UK",
      image: 'assets/brands/uk.jpg',
      url: "/catalog/products?make=UK&makeCode=UK",
      submenu: <Entry>[
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=UK&makeCode=UK&origin=GERMANY&origincode=GER"),
        Entry(
            title: "NISSENS",
            url:
                "/catalog/products?make=UK&makeCode=UK&origin=NISSENS&origincode=NIS"),
        Entry(
            title: "DRIER",
            url:
                "/catalog/products?make=UK&makeCode=UK&partsCategory=DRIER&partsCategoryCode=DRIER"),
        Entry(
            title: "RADIATOR",
            url:
                "/catalog/products?make=UK&makeCode=UK&partsCategory=RADIATOR&partsCategoryCode=RADIA"),
        Entry(
            title: "SENSOR",
            url:
                "/catalog/products?make=UK&makeCode=UK&partsCategory=SENSOR&partsCategoryCode=SENSO"),
      ]),
  Entry(
      title: "VOLKS WAGON",
      url: "/catalog/products?make=VOLKS WAGON&makeCode=VOLKS WAGON",
      image: 'assets/brands/VOLKSWAGEN.jpg',
      submenu: <Entry>[
        Entry(
            title: "GERMANY",
            url:
                "/catalog/products?make=CADILLIC&makeCode=CADILLIC&origin=GERMANY&origincode=GER"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=CADILLIC&makeCode=CADILLIC&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "TAIWAN",
            url:
                "/catalog/products?make=CADILLIC&makeCode=CADILLIC&origin=TAIWAN&origincode=TWN"),
      ]),
  Entry(
      title: "VOLVO",
      url: "/catalog/products?make=VOLVO&makeCode=VOLVO",
      image: 'assets/brands/volvo.jpg',
      submenu: <Entry>[
        Entry(
            title: "BOGE",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&origin=BOGE&origincode=BOG"),
        Entry(
            title: "CONTI",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&origin=CONTI&origincode=CON"),
        Entry(
            title: "ORIGINAL",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&origin=ORIGINAL&origincode=OE"),
        Entry(
            title: "REMSA",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&origin=REMSA&origincode=REM"),
        Entry(
            title: "SWEDEN",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&origin=SWEDEN&origincode=SW"),
        Entry(
            title: "TEXTAR",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&origin=TEXTAR&origincode=TEX"),
        Entry(
            title: "BRACKET",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=BRACKET&partsCategoryCode=BRACK"),
        Entry(
            title: "BRAKE PAD",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=BRAKE PAD&partsCategoryCode=BRAKE"),
        Entry(
            title: "BRAKE",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=BRAKE&partsCategoryCode=BRK"),
        Entry(
            title: "ENGINE",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=ENGINE&partsCategoryCode=ENG"),
        Entry(
            title: "FRONT",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=FRONT&partsCategoryCode=FRNT"),
        Entry(
            title: "MOUNTING",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=MOUNTING&partsCategoryCode=MOUNTNG"),
        Entry(
            title: "SHOCK",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=SHOCK&partsCategoryCode=SHOCK"),
        Entry(
            title: "V-BELT",
            url:
                "/catalog/products?make=VO&makeCode=VOLVO&partsCategory=V-BELT&partsCategoryCode=V-BEL"),
      ]),
  Entry(
    title: 'Blog',
    url: '/car-accessories-in-sharjah-dubai-world',
    image: 'assets/brands/blog.png',
    submenu: <Entry>[
      Entry(
        title: 'Auto Spare Parts Uae',
        url: '/auto-spare-parts-uae',
      ),
      Entry(
        title: 'BMW Listen To Your Car',
        url: '/BMW-LISTEN-TO-YOUR-CAR-change-spare-parts',
      ),
      Entry(
        title: 'Online Car Spare Parts In Dubai',
        url: '/ONLINE-CAR-SPARE-PARTS-IN-DUBAI',
      ),
      Entry(
        title: 'Top Online Car Parts Dubai',
        url: '/TOP-ONLINE-CAR-PARTS-DUBAI',
      ),
      Entry(
        title: 'Nissan Car Spare Parts Dubai',
        url: '/nissan-car-spare-parts-dubai',
      ),
      Entry(
        title: 'Jaguar Spare Parts',
        url: '/jaguar-spare-parts',
      ),
      Entry(
        title: 'Rolls Royce Car Parts',
        url: '/rolls-royce-car-parts',
      ),
      Entry(
        title: 'Toyota Genuine Spare Parts',
        url: '/toyota-genuine-spare-parts',
      ),
      Entry(
        title: 'Toyota Genuine Spare Parts Online',
        url: '/Toyota-genuine-spare-parts-online',
      ),
      Entry(
        title: 'Volkswagen Vento Spar Parts Uae',
        url: '/volkswagen-vento-spare-parts-uae',
      ),
      Entry(
        title: 'Bmw Genuine Spare Parts Near Me',
        url: '/bmw-genuine-spare-parts-near-me',
      ),
      Entry(
        title: 'Audi Spare Parts Catalogue',
        url: '/audi-spare-parts-catalogue',
      ),
      Entry(
        title: 'Porsche Cayenne Spare Parts Dubai',
        url: '/porsche–cayenne-spare-parts–dubai',
      ),
      Entry(
        title: 'Mercedes Benz Spare Parts Uae',
        url: '/mercedes-benz-spare-parts-uae',
      ),
      Entry(
        title: 'Nissan Altima Headlight Bulb Replacement',
        url: '/nissan-altima-headlight-bulb-replacement',
      ),
      Entry(
        title: 'How it all work: rear lights',
        url: '/how-it-all-work-rear-lights',
      ),
      Entry(
        title: 'Blog Grid',
        url: '/demo/blog/grid-right-sidebar',
      )
    ],
  ),
  Entry(
    title: 'Account',
    url: '/account/dashboard',
    image: 'assets/brands/account.png',
    submenu: <Entry>[
      Entry(title: 'Login & Register', url: '/account/login'),
      Entry(title: 'Dashboard', url: '/account/dashboard'),
      Entry(title: 'Garage', url: '/account/garage'),
      Entry(title: 'Edit Profile', url: '/account/profile'),
      Entry(title: 'Order History', url: '/account/orders'),
      Entry(title: 'Address Book', url: '/account/addresses'),
      Entry(title: 'Change Password', url: '/account/password'),
    ],
  ),
  Entry(
    title: 'Enquiry',
    url: '/about-us',
    image: 'assets/brands/blog.png',
    submenu: <Entry>[
      Entry(title: 'About Us', url: '/about-us'),
      Entry(title: 'Services', url: '/services'),
      Entry(title: 'Contact Us', url: '/contact-us-v1'),
      // Entry( title: 'Shop Branches', url: '/demo/site/contact-us-v2' ),

      Entry(title: 'Terms And Conditions', url: '/terms'),
      Entry(title: 'FAQ', url: '/faq'),
    ],
  )
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root, BuildContext context) {
    var _theme = Theme.of(context);
    if (root.submenu == null || root.submenu.isEmpty)
      return ListTile(
          title: Text(root.title,
              style: _theme.textTheme.display1
                  .copyWith(fontWeight: FontWeight.bold)));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: InkWell(
        onTap: () {},
        child: ListTile(
            title: Text(root.title,
                style: _theme.textTheme.display1
                    .copyWith(fontWeight: FontWeight.bold)),
            leading: root.image != null
                ? Image(height: 25, width: 25, image: AssetImage(root.image))
                : null),
      ),
      children:
          root.submenu.map((title) => _buildTiles(title, context)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry, context);
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: theme.primaryTextTheme.title.color)),
        primaryColor: theme.primaryColor,
        primaryIconTheme: theme.primaryIconTheme,
        primaryColorBrightness: theme.primaryColorBrightness,
        primaryTextTheme: theme.primaryTextTheme,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.body2.copyWith(
                color: theme.primaryTextTheme.body2.color, fontSize: 14)));
  }

  @override
  String get searchFieldLabel => 'Search By Part Name or Part Number';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Algolia algolia = Application.algolia;
    if (query == '') return Container();
    AlgoliaQuery algoliaQuery = algolia.instance
        .index('royalautopartsmarket.com')
        .setHitsPerPage(20)
        .search(query);
    Future<AlgoliaQuerySnapshot> snap = algoliaQuery.setLength(20).getObjects();

    return FutureBuilder<AlgoliaQuerySnapshot>(
      future: snap,
      builder: (ctx, datas) {
        if (datas.data != null)
          return ListView(
            children: datas.data.hits.map((data) {
              String BASE64_STRING = data.data['imagepath']
                  .replaceAll('data:image/jpeg;base64,', '');
              //String BASE64_STRING =
              // 'iVBORw0KGgoAAAANSUhEUgAAANIAAAAzCAYAAADigVZlAAAQN0lEQVR4nO2dCXQTxxnHl0LT5jVteHlN+5q+JCKBJITLmHIfKzBHHCCYBAiEw+I2GIMhDQ0kqQolIRc1SV5e+prmqX3JawgQDL64bK8x2Ajb2Bg7NuBjjSXftmRZhyXZ1nZG1eL1eGa1kg2iyua9X2TvzvHNN/Ofb2Z2ZSiO4ygZGZm+EXADZGSCgYAbICMTDATcABmZYCDgBsjIBAMBN0BGJhgIuAEyMsGA1wQdHZ1UV1cX5XK5qM7OzgcMRuNTrSbTEraq6strhdfzruTk5Wpz8q5c1l7Jyb6szc3K1l7RggtFxcWX2dvVB02mtmVOp3NIV2fnQFie2WyB5QS84TIy/YnXBFBI8BMM/pDqat0XzIVM08lTSVxyytn6jAuZV4FuzmtzclJz8/LT8vML0nJzr54HYkpLS88oTkxMMZ48mchlXrxUX1ffcBCUM8xms8lCkgk6pCT6aZvZvCrzYpbu2PfxHAg8l+obGmOt1vaJQBAPkvI5nM5fWyyWWTU1tfuA+IqOHDvGgehVCK4pA91oGZn+xluCAc0thtj4hCT72XOp9S0thi2FBQWPvb13z9RN61QH5s8NYxbMDct7KXyudt7MGeeWLFrwn8iVKz7auDZy3Z7dbzz91p43B8ZsjYLlDKmprd3/ffwpLjWNqbW32xcFuuEyMv2J2M1BJpMpKiExxZKZeamira1tvvqdt8OWL1l8asq4kNbRzz7NTRo7uuMPo4Y7Rz/zFBc64lluzHNDuZFDFe5PICx25/aY2B3bogf/dd9fKCA+CuytohOSkjuyLmtLXRwXGujGy8j0F8Qbdrt9bDpzQQ8jSHl5+dLt0VsOThgzwj7i6Se5kOHDuIljR9mXRrykjZj/wlVeSONHP8+FhykrJoeOsY8aNoQLAYJa9erShIPvvRsKhQTK/YleX3Pw5KlErpKt+iLQjZeR6S9IN35VXl75r3gw4HU6/Z6ojes/gMKAUQiKBQKiUvvLC1/MXL18WcKsaZOrJ4WObly7euUJsOQ7FjZ9Sh2IVC4oLhihZk6d1LB5/dpt+9R/hnuq4Xl5VwvT0jLKXS7XOHgaCAm0I2Rk+gL2os1mewXsiUw5uXlZn8T9LVI5ZWI1jEQTxozkgECgkDrmKqfrFy8ILwJ7om+3bNoQumTRwtDoqE0fTBsf2ggwg+jVBdOCT7eYwGfnti2bQXA6ME2nr9mbnHLOWV/fEI3WTdO0jMzdZjBAKWBwX8ojCqm8vOJoYvLp9qPfHTmy5rXlJ+BSbtzI5+5EI4ALRCTHHHpaQ8zWqOidO2IooBAKRKRDQDwGevJ4w8SQUR0e0bmB0QxEKh2IYsdbTW0zmIxM4/Wi4q9BfQMkCikCoAEUADgEeI3xOOVedkicp14e1V2uLwSpTwxNAPwRaGC7OQFqQp9xGDT+1ksUUubFrMoLFy/VL5g7+4ep48fa+P0Pz9jnn4H7JCcQBbP79V1rgJDmASE9um7NqvmxMdFbVateiwd7KKswHx+dwBKwzGq1jgDRrjQ7W5sB6hvsRUhQQCyh8Sg4xwW64/oTpUQ/CIm7xz652yg9flb40R+xIn5i/LWJKKSk5NOuwqIi7cSQkXooAD6ywE8YneDyLWrDuq/WR67+BvxcB5dtG9dGHgF7oZsgSuWFz555c0LISKcwIvHlAHSdnR0P37h5699pzIW6NrNlptFoIglJ7cOAgcTf40711nH3g5AguEH3/4YGaZPSj/6Ix/hGmKd/hXQqIanz5q1b8WA5VwOXdLwgoIjAsk2/Y1v0odUrXj0OT+vgNSCkjgXzZleANF3wpI6PRALxcDDt7BlTby+NWPgdqOPBisrKz8E+zFFXX79Sp9fjhKQiDAqjx6kRHmfCdHDWZek+zCp+gnac6i7XhxOSUkAExiZI7D32y73wtbKfy/CnPDdEISUkJjsrKiqPhocp86ZPGGeDSzkIWJa1Rq5ccXyDas1X8PBBuG9Cow8UE/yEaYYPeZybPnFcM1gGRh/6+KNhNbV1o7Mua29dysrOdblcQ4SvDHmMg5s/I2ZAxNP+bQz5zaVaABz0ij7kh6D7NVJnwL1NLJLXn47DCQmXjkXSqAnpFB4/CO2KkODjEE861B9i7VcKwPldgaQJQfKi4yFWkNZbPXzZuP4iQRobaLrBIhEpubP0xq2E9989MHnLpg3rX5hFlz3/1BMcWLaVRm/eeIieNL4KRhi450EjDxQOvAf2T+mrli9bDZaAq3Zu37b3nbf2zvnwg/d/DoRENbcYRmhzcn84n5peDkQ0FbNHUmMGjD/LtsGesnCi5GEEnYbLH+clP9ox6ABiRdKzmDz9ISR0wKgx7WJE7ILtxUUxlQQfGDFtQutC7cH1OUPIi8NbPWjZUtBgbIzApFMQhZSccrbrav61zAqWfWR79JbJ8+eG5Q97/HccfB0I/P4eEJADRigoJP6NBvgzBC715s2coTuwf9+0qI3rKbB3ooCQKCAkCgiJgkKCS7uWFuMbiUkpjpzcvCvg9yGIkFicwZiGeRMR7oQPB+x8VEy+5OcRDiDcoCdBErI/QsINdmH5pGiPAxUT6cQLxYjkY5D7aozdaiQNQ8iLoz+EhPY1i7FRg7ORKKTUtHSdVptTarPZhr737oFHgRj+7lmeVcRsjfrwxdkzc+DSDj50VU6Z0LR5/drDK5a8HLt4QfhusAfaBUQz8tDHHw/atE5FEhLkods6/ZfHjsdzZWXlJwRCGoxppAbTKG+gjeadoyZ0Duo43MbU6LmuJpTPCwk3WGFHqTyg9xiJbcIJSS2AtJkWG9R89Imgew8mI91zmcfQPfeo/D21iC9wdUZg2oaWoaG7xYvm59vFQ6qHt0EloQycb4WTN25cuttBFBKIRpfAsstkNpvD4Xtye9/802PLFi/6J1y6LXpx3mUQleJARHKCaGRbvWLZO1AwQEgUEBIFhOQWDRAS5UVIFOfinrheVHw2MTmFEwgJ1yAVxvFiKDBlaJA0uJmbrycEcw+3P0PTCDtOeJ1F8uKWCFL2fr5EOZzNOL+g0Qq9Lxz0IQQ7ceUKhSR2jzRxqb2Uj/MP46Ueb2WwyH1hREaPzln+HlFIjY1N+1NSzlirq/Wfg99/9saunVRszLaHdu3YHg32PueAOP4Klm8lk0JHt4GfZ6yPXE0tf2WxZCHZ7Q7K4XC667I77IuZC5nehIRzvBhqJD86s/KgM7CG7p4FUafh8pPsRAeFhu69SfWnjTgBisEi5aKDoQBjl7f9FSqgWBq/FPdVSIxIvTh/+Sok3OSI5kf7XbgvR/1yR2REIXV0dIRmX9beys7WljsdzhEeIQFBxFDLXl5E7doRMzFs+pTG+XNmFX726acPHo6Loz45fJhasmihG29CstraqfZ2+wCXyzWCZau+T0w63d9CQgcy6aACdRxDcJqKkJ9kp9Q9iK9tVGPyqQXgDkbg7wqCX6SgRmyAdmpo7w/JAyEk1Calj2WgYjOKXL8zsRKFBKNQA4hKp8+c62poaPwjfI0HLOfcX4WAYoqO2jQKLPVSdr++azsUkK9CagdCstnah14rvJ767XdHHSUlN64IhISbOdDO9IZYp4gNTIbGd7wCk1ch0jHodf4VJjGkHDig9nKYNLCDWSQN/3YD6hdWgl38JOLtpA9FTEg4f6JlqwX3pAoJTRMiUgZDKAP1HcyHTrgaYR4xIVFOp/PJgmuFFfngf52dnU+Q0nkDLuOsVitlb293Cwhib7dTFotlWloaU3s1vyANpHsUObVDHcISGt1XIWkIzpXSabhlli8zsD+oJdpGirRS/YIDd4LJeurCTX68WKQsqXA+E9qG+ho9FSSVIbwnVUgajB1olO8xEYgKCdLaaoouKv6hrNXYOt9ut8PlGAF3hMGWAa83NjVRNpDG4XDcwWg0rklLZ7iS0hufgXQDESHhliBCx3oDdUYBIR1LqAOtGxct0DqEHYd7eHg3hMRKbD9D8KvUZ3MqTFuFbVKI+AIdwDh/4soXTj5ouxkabyfJBl+E5G0f2isfUUjwD5RAzGbzQzW1dXOqdbphNbW1VE0NHp1OD6KOTVRI7UCIgusP6Gtq9iWnnOmqul0dhXkgi3M+BM5+pNOtELp7pvDWMRDcC4x8B6OzLzrgcLOssOPQAcuK2N0XIfXqVI9tqJB5+8Xa7Eu96IuwuP4Suyf0J85ejhYX0t2MSBTBHh4Vmp4opJYWgxujsZWqr2+ggJAoXY2eAoO/F/Ce1YYXkVBIMKKB5SJc0sGl3rC8/ALt2fNpzQ6HM9zVW0i4WVXoRP5ZjprufrbB0d0RBfccx0h3v8aCK1voWLTjOE+d/GsxJEeLzbAFdPdRMv/KUSwtfX+Es4ulex42kHzGd74Cc8/ouc8LXen5PV6QD62XEaRXENrrbVI00uIPvMWExHl8F0/37DeSDb4KieRHFpeeKCSDwegGCqmurt4tFn9E1CMigaWd52/jQX5fUlqakprOmMB/LzU3N+OEJNYgKc735agYfbPBl6f/pI5jfMgnNVr5UiYPuqxV+5CXFz4uAguFgFuKS53hSQj7UuzrD3x09LYXQ9vN0GQ/k8aOGpe+T0K6XV1NWaxWKYcNA1sMhgdANHLvgzo7u9zXK1n20PnzaVYQ8ZbB5SFBSPzszkp0vgLjEG+dyNL4iEBacvBovHQcFIeU42ZWpEP7KiTSS75qifmF/sS1lwc30H3pB1xkEgpJIZKfj5q4yOevkEjix054fgsJfu0BwkcZEqCs3zQ2Ne8pLin5urpad8hkaltQUnLjGbDfimQyLhjg298gDe7tb9Isoabx3wRV0/jXTvgBrfKkE+aLE8kjzCtcQvD5FB7UCLgyQgh288tTJSEfaVJB68QRQXt/N1GBaRuPmsY/OyP5UYov+DTCvBq65/JRCGq/AlM3tF+4xBSzQYncw7VPCOlhff8ICQqotq7OfRghWKphMZstaxKTUywnTp5qPHP2vOn0mXNcKpNhPpWYxKWmpjeDZd0WtG4vjZORuRcoafEI2QO/hASXdAajUcozpEGF14uPpgPhWK22xRaLdUbV7eo3b9ws28+yVXsdDvtceHonC0nmPoShey89ien9jkjNLQaqrc1MxASw2donpaZn1JeVlyeBfdEv2232O/sjMe4DJ8r8+GDo7i8K4va1KrH8PgsJPkuC+yL4tgL8JAGPucvKK2MzM7PaWltbl4AyB/wvj10Wksz9CCeCaDSC+CQkGInq6utF90Q8oIzf5l0tuFheXvkPsI962HN6JwtJ5n6FofEiwn3hsxeShVQF9kVQRPDfSZKwN6Kampt3Xiu83mQymcL5a/BrE1BMspBk7kNUdO8TVeGJoCiShOR+DaiuTvKfFQbpHqmoqMzW6/WJ8PgbOQ6XkQlKsBd5IUFaDAbJkQhitdpWgKUg226zLYS/y0KS+TGAvdjc3OKmqamFamtroywWq+gpHY/ZbBnU3GL4FHx+A8r5BeEhrYxM0BFwA2RkgoGAGyAjEwwE3AAZmWAg4AbIyAQDATdARiYYCLgBMjLBQMANkJEJBgJugIxMMPBfChd6NRZ5pkMAAAAASUVORK5CYII=';
              Uint8List bytes =
                  data.data['imagepath'].indexOf('data:image/jpeg;base64,') > -1
                      ? base64Decode(BASE64_STRING)
                      : null;
              final ImageProvider image =
                  data.data['imagepath'].indexOf('data:image/jpeg;base64,') > -1
                      ? MemoryImage(bytes)
                      : NetworkImage(data.data['imagepath']);
              return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        OpenFlutterEcommerceRoutes.product,
                        arguments: ProductDetailsParameters(65, 20));
                  },
                  child: Row(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.imageRadius),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: image, fit: BoxFit.cover),
                            color: AppColors.background,
                            borderRadius:
                                BorderRadius.circular(AppSizes.imageRadius),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(data.data['descr'],
                                    style:
                                        Theme.of(context).textTheme.display1),
                                Text(data.data['Partno'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontSize: 14)),
                              ])),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: <Widget>[
                              buildPriceSearch(
                                  Theme.of(context), data.data['salesPrice']),
                            ],
                          )),
                    ],
                  ));
            }).toList(),
          );
        else
          return Container();
      },
    );
  }

  Widget buildPriceSearch(ThemeData _theme, String productPrice) {
    return Row(children: <Widget>[
      Text(
        productPrice != null ? '\AED' + productPrice : '',
        style: _theme.textTheme.display3.copyWith(
          decoration: TextDecoration.none,
        ),
      ),
      SizedBox(
        width: 4.0,
      ),
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Algolia algolia = Application.algolia;
    AlgoliaQuery algoliaQuery = algolia.instance
        .index('royalautopartsmarket.com')
        .setHitsPerPage(20)
        .search(query);
    Future<AlgoliaQuerySnapshot> snap = algoliaQuery.setLength(20).getObjects();

    return FutureBuilder<AlgoliaQuerySnapshot>(
      future: snap,
      builder: (ctx, datas) {
        if (datas.data != null)
          return ListView(
            children: datas.data.hits.map((data) {
              String BASE64_STRING = data.data['imagepath']
                  .replaceAll('data:image/jpeg;base64,', '');
              //String BASE64_STRING =
              // 'iVBORw0KGgoAAAANSUhEUgAAANIAAAAzCAYAAADigVZlAAAQN0lEQVR4nO2dCXQTxxnHl0LT5jVteHlN+5q+JCKBJITLmHIfKzBHHCCYBAiEw+I2GIMhDQ0kqQolIRc1SV5e+prmqX3JawgQDL64bK8x2Ajb2Bg7NuBjjSXftmRZhyXZ1nZG1eL1eGa1kg2iyua9X2TvzvHNN/Ofb2Z2ZSiO4ygZGZm+EXADZGSCgYAbICMTDATcABmZYCDgBsjIBAMBN0BGJhgIuAEyMsGA1wQdHZ1UV1cX5XK5qM7OzgcMRuNTrSbTEraq6strhdfzruTk5Wpz8q5c1l7Jyb6szc3K1l7RggtFxcWX2dvVB02mtmVOp3NIV2fnQFie2WyB5QS84TIy/YnXBFBI8BMM/pDqat0XzIVM08lTSVxyytn6jAuZV4FuzmtzclJz8/LT8vML0nJzr54HYkpLS88oTkxMMZ48mchlXrxUX1ffcBCUM8xms8lCkgk6pCT6aZvZvCrzYpbu2PfxHAg8l+obGmOt1vaJQBAPkvI5nM5fWyyWWTU1tfuA+IqOHDvGgehVCK4pA91oGZn+xluCAc0thtj4hCT72XOp9S0thi2FBQWPvb13z9RN61QH5s8NYxbMDct7KXyudt7MGeeWLFrwn8iVKz7auDZy3Z7dbzz91p43B8ZsjYLlDKmprd3/ffwpLjWNqbW32xcFuuEyMv2J2M1BJpMpKiExxZKZeamira1tvvqdt8OWL1l8asq4kNbRzz7NTRo7uuMPo4Y7Rz/zFBc64lluzHNDuZFDFe5PICx25/aY2B3bogf/dd9fKCA+CuytohOSkjuyLmtLXRwXGujGy8j0F8Qbdrt9bDpzQQ8jSHl5+dLt0VsOThgzwj7i6Se5kOHDuIljR9mXRrykjZj/wlVeSONHP8+FhykrJoeOsY8aNoQLAYJa9erShIPvvRsKhQTK/YleX3Pw5KlErpKt+iLQjZeR6S9IN35VXl75r3gw4HU6/Z6ojes/gMKAUQiKBQKiUvvLC1/MXL18WcKsaZOrJ4WObly7euUJsOQ7FjZ9Sh2IVC4oLhihZk6d1LB5/dpt+9R/hnuq4Xl5VwvT0jLKXS7XOHgaCAm0I2Rk+gL2os1mewXsiUw5uXlZn8T9LVI5ZWI1jEQTxozkgECgkDrmKqfrFy8ILwJ7om+3bNoQumTRwtDoqE0fTBsf2ggwg+jVBdOCT7eYwGfnti2bQXA6ME2nr9mbnHLOWV/fEI3WTdO0jMzdZjBAKWBwX8ojCqm8vOJoYvLp9qPfHTmy5rXlJ+BSbtzI5+5EI4ALRCTHHHpaQ8zWqOidO2IooBAKRKRDQDwGevJ4w8SQUR0e0bmB0QxEKh2IYsdbTW0zmIxM4/Wi4q9BfQMkCikCoAEUADgEeI3xOOVedkicp14e1V2uLwSpTwxNAPwRaGC7OQFqQp9xGDT+1ksUUubFrMoLFy/VL5g7+4ep48fa+P0Pz9jnn4H7JCcQBbP79V1rgJDmASE9um7NqvmxMdFbVateiwd7KKswHx+dwBKwzGq1jgDRrjQ7W5sB6hvsRUhQQCyh8Sg4xwW64/oTpUQ/CIm7xz652yg9flb40R+xIn5i/LWJKKSk5NOuwqIi7cSQkXooAD6ywE8YneDyLWrDuq/WR67+BvxcB5dtG9dGHgF7oZsgSuWFz555c0LISKcwIvHlAHSdnR0P37h5699pzIW6NrNlptFoIglJ7cOAgcTf40711nH3g5AguEH3/4YGaZPSj/6Ix/hGmKd/hXQqIanz5q1b8WA5VwOXdLwgoIjAsk2/Y1v0odUrXj0OT+vgNSCkjgXzZleANF3wpI6PRALxcDDt7BlTby+NWPgdqOPBisrKz8E+zFFXX79Sp9fjhKQiDAqjx6kRHmfCdHDWZek+zCp+gnac6i7XhxOSUkAExiZI7D32y73wtbKfy/CnPDdEISUkJjsrKiqPhocp86ZPGGeDSzkIWJa1Rq5ccXyDas1X8PBBuG9Cow8UE/yEaYYPeZybPnFcM1gGRh/6+KNhNbV1o7Mua29dysrOdblcQ4SvDHmMg5s/I2ZAxNP+bQz5zaVaABz0ij7kh6D7NVJnwL1NLJLXn47DCQmXjkXSqAnpFB4/CO2KkODjEE861B9i7VcKwPldgaQJQfKi4yFWkNZbPXzZuP4iQRobaLrBIhEpubP0xq2E9989MHnLpg3rX5hFlz3/1BMcWLaVRm/eeIieNL4KRhi450EjDxQOvAf2T+mrli9bDZaAq3Zu37b3nbf2zvnwg/d/DoRENbcYRmhzcn84n5peDkQ0FbNHUmMGjD/LtsGesnCi5GEEnYbLH+clP9ox6ABiRdKzmDz9ISR0wKgx7WJE7ILtxUUxlQQfGDFtQutC7cH1OUPIi8NbPWjZUtBgbIzApFMQhZSccrbrav61zAqWfWR79JbJ8+eG5Q97/HccfB0I/P4eEJADRigoJP6NBvgzBC715s2coTuwf9+0qI3rKbB3ooCQKCAkCgiJgkKCS7uWFuMbiUkpjpzcvCvg9yGIkFicwZiGeRMR7oQPB+x8VEy+5OcRDiDcoCdBErI/QsINdmH5pGiPAxUT6cQLxYjkY5D7aozdaiQNQ8iLoz+EhPY1i7FRg7ORKKTUtHSdVptTarPZhr737oFHgRj+7lmeVcRsjfrwxdkzc+DSDj50VU6Z0LR5/drDK5a8HLt4QfhusAfaBUQz8tDHHw/atE5FEhLkods6/ZfHjsdzZWXlJwRCGoxppAbTKG+gjeadoyZ0Duo43MbU6LmuJpTPCwk3WGFHqTyg9xiJbcIJSS2AtJkWG9R89Imgew8mI91zmcfQPfeo/D21iC9wdUZg2oaWoaG7xYvm59vFQ6qHt0EloQycb4WTN25cuttBFBKIRpfAsstkNpvD4Xtye9/802PLFi/6J1y6LXpx3mUQleJARHKCaGRbvWLZO1AwQEgUEBIFhOQWDRAS5UVIFOfinrheVHw2MTmFEwgJ1yAVxvFiKDBlaJA0uJmbrycEcw+3P0PTCDtOeJ1F8uKWCFL2fr5EOZzNOL+g0Qq9Lxz0IQQ7ceUKhSR2jzRxqb2Uj/MP46Ueb2WwyH1hREaPzln+HlFIjY1N+1NSzlirq/Wfg99/9saunVRszLaHdu3YHg32PueAOP4Klm8lk0JHt4GfZ6yPXE0tf2WxZCHZ7Q7K4XC667I77IuZC5nehIRzvBhqJD86s/KgM7CG7p4FUafh8pPsRAeFhu69SfWnjTgBisEi5aKDoQBjl7f9FSqgWBq/FPdVSIxIvTh/+Sok3OSI5kf7XbgvR/1yR2REIXV0dIRmX9beys7WljsdzhEeIQFBxFDLXl5E7doRMzFs+pTG+XNmFX726acPHo6Loz45fJhasmihG29CstraqfZ2+wCXyzWCZau+T0w63d9CQgcy6aACdRxDcJqKkJ9kp9Q9iK9tVGPyqQXgDkbg7wqCX6SgRmyAdmpo7w/JAyEk1Calj2WgYjOKXL8zsRKFBKNQA4hKp8+c62poaPwjfI0HLOfcX4WAYoqO2jQKLPVSdr++azsUkK9CagdCstnah14rvJ767XdHHSUlN64IhISbOdDO9IZYp4gNTIbGd7wCk1ch0jHodf4VJjGkHDig9nKYNLCDWSQN/3YD6hdWgl38JOLtpA9FTEg4f6JlqwX3pAoJTRMiUgZDKAP1HcyHTrgaYR4xIVFOp/PJgmuFFfngf52dnU+Q0nkDLuOsVitlb293Cwhib7dTFotlWloaU3s1vyANpHsUObVDHcISGt1XIWkIzpXSabhlli8zsD+oJdpGirRS/YIDd4LJeurCTX68WKQsqXA+E9qG+ho9FSSVIbwnVUgajB1olO8xEYgKCdLaaoouKv6hrNXYOt9ut8PlGAF3hMGWAa83NjVRNpDG4XDcwWg0rklLZ7iS0hufgXQDESHhliBCx3oDdUYBIR1LqAOtGxct0DqEHYd7eHg3hMRKbD9D8KvUZ3MqTFuFbVKI+AIdwDh/4soXTj5ouxkabyfJBl+E5G0f2isfUUjwD5RAzGbzQzW1dXOqdbphNbW1VE0NHp1OD6KOTVRI7UCIgusP6Gtq9iWnnOmqul0dhXkgi3M+BM5+pNOtELp7pvDWMRDcC4x8B6OzLzrgcLOssOPQAcuK2N0XIfXqVI9tqJB5+8Xa7Eu96IuwuP4Suyf0J85ejhYX0t2MSBTBHh4Vmp4opJYWgxujsZWqr2+ggJAoXY2eAoO/F/Ce1YYXkVBIMKKB5SJc0sGl3rC8/ALt2fNpzQ6HM9zVW0i4WVXoRP5ZjprufrbB0d0RBfccx0h3v8aCK1voWLTjOE+d/GsxJEeLzbAFdPdRMv/KUSwtfX+Es4ulex42kHzGd74Cc8/ouc8LXen5PV6QD62XEaRXENrrbVI00uIPvMWExHl8F0/37DeSDb4KieRHFpeeKCSDwegGCqmurt4tFn9E1CMigaWd52/jQX5fUlqakprOmMB/LzU3N+OEJNYgKc735agYfbPBl6f/pI5jfMgnNVr5UiYPuqxV+5CXFz4uAguFgFuKS53hSQj7UuzrD3x09LYXQ9vN0GQ/k8aOGpe+T0K6XV1NWaxWKYcNA1sMhgdANHLvgzo7u9zXK1n20PnzaVYQ8ZbB5SFBSPzszkp0vgLjEG+dyNL4iEBacvBovHQcFIeU42ZWpEP7KiTSS75qifmF/sS1lwc30H3pB1xkEgpJIZKfj5q4yOevkEjix054fgsJfu0BwkcZEqCs3zQ2Ne8pLin5urpad8hkaltQUnLjGbDfimQyLhjg298gDe7tb9Isoabx3wRV0/jXTvgBrfKkE+aLE8kjzCtcQvD5FB7UCLgyQgh288tTJSEfaVJB68QRQXt/N1GBaRuPmsY/OyP5UYov+DTCvBq65/JRCGq/AlM3tF+4xBSzQYncw7VPCOlhff8ICQqotq7OfRghWKphMZstaxKTUywnTp5qPHP2vOn0mXNcKpNhPpWYxKWmpjeDZd0WtG4vjZORuRcoafEI2QO/hASXdAajUcozpEGF14uPpgPhWK22xRaLdUbV7eo3b9ws28+yVXsdDvtceHonC0nmPoShey89ien9jkjNLQaqrc1MxASw2donpaZn1JeVlyeBfdEv2232O/sjMe4DJ8r8+GDo7i8K4va1KrH8PgsJPkuC+yL4tgL8JAGPucvKK2MzM7PaWltbl4AyB/wvj10Wksz9CCeCaDSC+CQkGInq6utF90Q8oIzf5l0tuFheXvkPsI962HN6JwtJ5n6FofEiwn3hsxeShVQF9kVQRPDfSZKwN6Kampt3Xiu83mQymcL5a/BrE1BMspBk7kNUdO8TVeGJoCiShOR+DaiuTvKfFQbpHqmoqMzW6/WJ8PgbOQ6XkQlKsBd5IUFaDAbJkQhitdpWgKUg226zLYS/y0KS+TGAvdjc3OKmqamFamtroywWq+gpHY/ZbBnU3GL4FHx+A8r5BeEhrYxM0BFwA2RkgoGAGyAjEwwE3AAZmWAg4AbIyAQDATdARiYYCLgBMjLBQMANkJEJBgJugIxMMPBfChd6NRZ5pkMAAAAASUVORK5CYII=';
              Uint8List bytes =
                  data.data['imagepath'].indexOf('data:image/jpeg;base64,') > -1
                      ? base64Decode(BASE64_STRING)
                      : null;
              final ImageProvider image =
                  data.data['imagepath'].indexOf('data:image/jpeg;base64,') > -1
                      ? MemoryImage(bytes)
                      : NetworkImage(data.data['imagepath']);
              return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        OpenFlutterEcommerceRoutes.product,
                        arguments: ProductDetailsParameters(65, 20));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.imageRadius),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: image, fit: BoxFit.cover),
                            color: AppColors.background,
                            borderRadius:
                                BorderRadius.circular(AppSizes.imageRadius),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(data.data['descr'],
                                    style:
                                        Theme.of(context).textTheme.display1),
                                Text(data.data['Partno'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontSize: 14)),
                              ])),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: <Widget>[
                              buildPriceSearch(
                                  Theme.of(context), data.data['salesPrice']),
                            ],
                          )),
                    ],
                  ));
            }).toList(),
          );
        else
          return Container();
      },
    );
  }
}
