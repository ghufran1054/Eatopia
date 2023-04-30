import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia/services/db.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/custom_shimmer.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key, required this.query});
  final String query;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> results = [];
  void getResults() async {
    results = await Db().searchRestauarants(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CustomShimmer(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: results.isEmpty ? 1 : results.length,
              itemBuilder: (context, index) {
                if (results.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 120,
                          color: appGreen,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No results found',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '(Please try a different search term)',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  constraints: const BoxConstraints(minHeight: 140),
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3)),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          results[index]['restaurant'],
                          style: const TextStyle(
                              fontFamily: 'Ubuntu-bold',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          results[index]['description'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
