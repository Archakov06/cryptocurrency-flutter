import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cryptocurrency/widgets/CoinCard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Coin> coins = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<List<Coin>> fetchCoins() async {
    final response = await http.get(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=30&convert=USD',
        headers: {'X-CMC_PRO_API_KEY': 'aaaaeb4d-1fb7-4ee2-a438-a2bc866a08f1'});
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> dataList = data['data'];
    List<Coin> coins = dataList.map((coin) => Coin.fromJson(coin)).toList();

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return coins;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchCoins().then((coins) {
      setState(() {
        this.coins = coins;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return this.fetchCoins().then((coins) {
            setState(() {
              this.coins = coins;
            });
          });
        },
        child: ListView.builder(
          itemCount: coins.length,
          itemBuilder: (BuildContext context, int index) {
            return CoinCard(
                pos: index + 1,
                name: coins[index].name,
                shortName: coins[index].shortName,
                price: coins[index].price,
                marketCap: coins[index].marketCap,
                change24h: coins[index].change24h);
          },
        ),
      ),
    ));
  }
}

class Coin {
  String name;
  String shortName;
  double price;
  double marketCap;
  double change24h;

  Coin({
    this.name,
    this.shortName,
    this.price,
    this.marketCap,
    this.change24h,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      shortName: json['symbol'],
      price: json['quote']['USD']['price'],
      marketCap: json['quote']['USD']['market_cap'],
      change24h: json['quote']['USD']['percent_change_24h'],
    );
  }
}
