import 'package:flutter/material.dart';

class InvestorPortofolioPage extends StatefulWidget {
  const InvestorPortofolioPage({super.key});

  @override
  State<InvestorPortofolioPage> createState() => _InvestorPortofolioPageState();
}

class _InvestorPortofolioPageState extends State<InvestorPortofolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 188, 217, 241),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Total Asetmu",
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Rp 0",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Total Profit Rp 0",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // Add padding around the search bar
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // Use a Material design search bar
            child: TextField(
              // controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Quick Search',
                // Add a clear button to the search bar
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                ),
                // Add a search icon or button to the search bar
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Perform the search here
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
