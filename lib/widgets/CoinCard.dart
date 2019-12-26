import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final int pos;
  final String name;
  final String shortName;
  final double price;
  final double marketCap;
  final double change24h;

  CoinCard({
    this.pos,
    this.name,
    this.shortName,
    this.price,
    this.marketCap,
    this.change24h,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(pos.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Color(0xffB0B0B0))),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(this.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18)),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Text(this.shortName,
                                    style: TextStyle(color: Color(0xffB0B0B0))),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 16,
                                      width: 16,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: -3,
                                            child: Icon(
                                              this.change24h > 0
                                                  ? Icons.arrow_drop_up
                                                  : Icons.arrow_drop_down,
                                              color: this.change24h > 0
                                                  ? Color(0xff5CAE2A)
                                                  : Color(0xffEC5353),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                        this.change24h.toStringAsFixed(2) + '%',
                                        style: TextStyle(
                                            color: this.change24h > 0
                                                ? Color(0xff5CAE2A)
                                                : Color(0xffEC5353),
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('\$' + this.price.toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18)),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              '\$' +
                                  (this.marketCap / 10000000)
                                      .toStringAsFixed(2) +
                                  ' B',
                              style: TextStyle(color: Color(0xffB0B0B0)))
                        ],
                      )
                    ]),
              )),
          Container(height: 1, color: Colors.grey[200])
        ],
      ),
    );
  }
}
