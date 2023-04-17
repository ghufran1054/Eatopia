import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/custom_shimmer.dart';
import 'package:flutter/material.dart';

//THis is the Customer's view of the restaurant page

class UserRestauarantPage extends StatefulWidget {
  const UserRestauarantPage({super.key});

  @override
  State<UserRestauarantPage> createState() => _UserRestauarantPageState();
}

class _UserRestauarantPageState extends State<UserRestauarantPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  TabController? _tabController;
  Map<String, dynamic>? data;
  double titleOpacity = 0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 250) {
      if (titleOpacity == 1) return;
      setState(() {
        {
          titleOpacity = 1;
        }
      });
    } else {
      if (titleOpacity == 0) return;
      setState(() {
        {
          titleOpacity = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Opacity(
                opacity: titleOpacity,
                child: Text(
                  data!['restaurant'],
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'ubuntu-bold',
                      fontSize: 20),
                ),
              ),
              forceElevated: true,
              elevation: 5,
              //scrolledUnderElevation: 50,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              expandedHeight: 350,
              //floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data!['image'],
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              data!['restaurant'],
                              style: const TextStyle(
                                  fontFamily: 'ubuntu-bold', fontSize: 20),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Reviews',
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: ResTabs(
                  tabController: _tabController!,
                  id: data!['id'],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _buildSection1Widget(),
            _buildSection2Widget(),
            _buildSection3Widget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection1Widget() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('Section 1 Item $index'));
      },
    );
  }

  Widget _buildSection2Widget() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('Section 2 Item $index'));
      },
    );
  }

  Widget _buildSection3Widget() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('Section 3 Item $index'));
      },
    );
  }
}

class ResTabs extends StatefulWidget {
  const ResTabs({super.key, required this.tabController, required this.id});
  final TabController tabController;
  final String id;

  @override
  State<ResTabs> createState() => _ResTabsState();
}

class _ResTabsState extends State<ResTabs> {
  List<String> tabs = [];
  bool isLoading = true;
  void getCategories() async {
    tabs = [];
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(widget.id)
        .get();
    List<dynamic> fetched = doc['Categories'];
    for (var cat in fetched) {
      tabs.add(cat);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CustomShimmer(
            width: MediaQuery.of(context).size.width,
            height: 50,
          )
        : Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBar(
              isScrollable: true,
              controller: widget.tabController,
              labelColor: appGreen,
              labelStyle: const TextStyle(
                fontFamily: 'ubuntu-bold',
                fontSize: 15,
              ),
              unselectedLabelColor: Colors.grey,
              indicatorColor: appGreen,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: appGreen,
                  width: 3.0,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              tabs: tabs
                  .map(
                    (e) => Tab(
                      text: e,
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
