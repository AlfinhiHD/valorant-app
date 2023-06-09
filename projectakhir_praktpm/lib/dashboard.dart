import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectakhir_praktpm/datadiri.dart';
import 'package:projectakhir_praktpm/detail.dart';
import 'package:projectakhir_praktpm/favorite.dart';
import 'package:projectakhir_praktpm/login_screen.dart';
import 'package:projectakhir_praktpm/moneyconverter.dart';
import 'package:projectakhir_praktpm/sarankesan.dart';
import 'package:projectakhir_praktpm/timeconverter.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> agents = [];

  @override
  void initState() {
    super.initState();
    fetchAgents();
  }

  Future<void> fetchAgents() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents?isPlayableCharacter=true'));
    if (response.statusCode == 200) {
      setState(() {
        agents = json.decode(response.body)['data'];
      });
    }
  }

  void navigateToDetailPage(dynamic agent) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentDetailPage(agent: agent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF000000),
      ),
      body: agents.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
        children: [
          Image.asset(
            'assets/valobackground.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: agents.length,
            itemBuilder: (context, index) {
              final agent = agents[index];
              return GestureDetector(
                onTap: () => navigateToDetailPage(agent),
                child: Card(
                  margin: EdgeInsets.all(8),
                  color: Color(0xFF232323),
                  child: Stack(
                    children: [
                      Image.network(
                        agent['displayIcon'],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Color(0xFF000000).withOpacity(0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                agent['displayName'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                agent['role']['displayName'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF000000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: navigateToFavoriteAgentsPage,
            ),
            IconButton(
              icon: Icon(Icons.monetization_on, color: Colors.white),
              onPressed: navigateToCurrencyConverterPage,
            ),
            IconButton(
              icon: Icon(Icons.access_time_filled, color: Colors.white),
              onPressed: navigateToTimeConverterPage,
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: navigateToProfilePage,
            ),
            IconButton(
              icon: Icon(Icons.feedback, color: Colors.white),
              onPressed: navigateToFeedbackPage,
            ),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: navigateToLogout,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToFavoriteAgentsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteAgentsPage(),
      ),
    );
  }

  void navigateToCurrencyConverterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrencyConverterPage(),
      ),
    );
  }

  void navigateToTimeConverterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimeConverterPage(),
      ),
    );
  }

  void navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  void navigateToFeedbackPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackPage(),
      ),
    );
  }

  void navigateToLogout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}