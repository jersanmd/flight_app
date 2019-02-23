import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:intl/intl.dart';
import 'CustomAppBar.dart';
import 'FlightList.dart';

void main() => runApp(MaterialApp(
      title: "Flight App",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: appTheme,
    ));

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(color: appTheme.primaryColor),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                HomeScreenTopPart(),
                HomeScreenBottomPart,
                HomeScreenBottomPart,
                HomeScreenBottomPart
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<String> locations = ['Boston (BOS)', 'New York City (JFK)'];
TextStyle dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16);
TextStyle dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16);

class HomeScreenTopPart extends StatefulWidget {
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(color: Colors.white, height: 400),
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [firstColor, secondColor])),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.white),
                    SizedBox(width: 16),
                    PopupMenuButton(
                      onSelected: (index) {
                        setState(() {
                          selectedLocationIndex = index;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Text(locations[selectedLocationIndex],
                              style: dropDownLabelStyle),
                          Icon(Icons.arrow_drop_down, color: Colors.white)
                        ],
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<int>>[
                            PopupMenuItem(
                              child: Text(locations[0],
                                  style: dropDownMenuItemStyle),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Text(locations[1],
                                  style: dropDownMenuItemStyle),
                              value: 1,
                            )
                          ],
                    ),
                    Spacer(),
                    Icon(Icons.settings, color: Colors.white)
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text("Where would \nyou want to go?",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      controller: TextEditingController(text: locations[1]),
                      style: dropDownMenuItemStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        border: InputBorder.none,
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FlightListing()));
                              },
                              child: Icon(Icons.search, color: Colors.black)),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        setState(() {
                          isFlightSelected = !isFlightSelected;
                        });
                      },
                      child: ChoiceChip(
                          Icons.flight_takeoff, "Flights", isFlightSelected)),
                  SizedBox(width: 20),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isFlightSelected = !isFlightSelected;
                        });
                      },
                      child:
                          ChoiceChip(Icons.hotel, "Hotels", !isFlightSelected)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isFlightSelected;

  ChoiceChip(this.icon, this.text, this.isFlightSelected);

  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isFlightSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(20)))
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(widget.icon, color: Colors.white),
          SizedBox(width: 8.0),
          Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16))
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14, color: appTheme.primaryColor);

var HomeScreenBottomPart = Column(
  children: <Widget>[
    Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Currently Watched Items", style: dropDownMenuItemStyle),
            Spacer(),
            Text("View All", style: viewAllStyle)
          ],
        ),
      ),
    ),
    Container(
      color: Colors.white,
      height: 245,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cityCards,
      ),
    )
  ],
);

List<CityCard> cityCards = [
  CityCard("assets/images/lasvegas.jpg", "Las Vegas", "Feb 2019", "45", "4299",
      "2250"),
  CityCard(
      "assets/images/athens.jpg", "Athens", "Apr 2019", "50", "9999", "4159"),
  CityCard(
      "assets/images/sydney.jpeg", "Sydney", "Dec 2018", "40", "5999", "2399"),
];

final formatCurrency = NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount,
      this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 210,
                    width: 160,
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    width: 160,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black, Colors.black12])),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    right: 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(cityName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18)),
                            Text(monthYear,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14))
                          ],
                        ),
                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text("$discount%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14)))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 5),
                Text(
                  "${formatCurrency.format(int.parse(newPrice))}",
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Text(
                  "(${formatCurrency.format(int.parse(oldPrice))})",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
