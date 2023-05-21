import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectakhir_praktpm/detail.dart';
import 'package:projectakhir_praktpm/favorite.dart';

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
  void navigateToFavoriteAgentsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteAgentsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF000000),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: navigateToFavoriteAgentsPage,
          ),
        ],
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
    );
  }
}
