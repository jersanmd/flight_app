import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'main.dart';

final Color discountBackgroundColor = Color(0xFFFFE08D);
final Color flightBorderColor = Color(0xFFE6E6E6);
final Color chipBackgroundColor = Color(0xFFF6F6F6);

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

class FlightListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text("Seach Result", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
              child: Column(
          children: <Widget>[FlightListTopPart(), SizedBox(height: 20), FlightListingBottomPart()],
        ),
      ),
    );
  }
}

class FlightListingBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Best Deals for Next 6 Months", style: dropDownMenuItemStyle)),
            SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                FlightCard(),
                FlightCard(),
                FlightCard()
              ],
            )
          ],
        ));
  }
}

class FlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
          child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: flightBorderColor)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('${formatCurrency.format(4159)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(width: 4),
                      Text('(${formatCurrency.format(999)})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey)),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: -8,
                    children: <Widget>[
                      FlightDetailChip(Icons.calendar_today, "June 2019"),
                      FlightDetailChip(Icons.flight_takeoff, "Jet Airways"),
                      FlightDetailChip(Icons.star, "4.4"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: discountBackgroundColor, 
                borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text('55%', style: TextStyle(color: appTheme.primaryColor, fontSize: 14),),
            ),
          )
        ],
      ),
    );
  }
}

class FlightDetailChip extends StatelessWidget {
  final String label;
  final IconData iconData;
  FlightDetailChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
      backgroundColor: chipBackgroundColor,
      avatar: Icon(iconData, size: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    );
  }
}

class FlightListTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [firstColor, secondColor])),
            height: 160,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Boston (BOS)", style: TextStyle(fontSize: 16)),
                          Divider(color: Colors.grey, height: 20),
                          Text("New York (JFK)",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.import_export,
                            color: Colors.black, size: 32))
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
