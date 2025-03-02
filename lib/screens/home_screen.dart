import 'dart:async';
import 'dart:convert';
import 'package:cienfuegos_folklore/screens/legend_detail_screen.dart';
import 'package:cienfuegos_folklore/widgets/info_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> legends = [];

  @override
  void initState() {
    super.initState();
    loadLegends();
  }

  Future<void> loadLegends() async {
    final String response =
        await rootBundle.loadString('assets/data/legends.json');
    final data = json.decode(response);
    setState(() {
      legends = data["legends"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final collapsedHeight = width < 380 ? 120.0 : 140.0;
    final rowsHeight = height < 600 ? 120.0 : 145.0;
    return Scaffold(
      backgroundColor: Color(0xFFF3EBD7),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              physics: BouncingScrollPhysics(),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  collapsedHeight: collapsedHeight,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  forceMaterialTransparency: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image(
                      image: AssetImage('assets/images/main_header.png'),
                      width: MediaQuery.of(context).size.width,
                      height: collapsedHeight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: rowsHeight,
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                    ),
                    itemCount: legends.length,
                    itemBuilder: (context, index) {
                      final legend = legends[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      LegendDetailScreen(
                                legendTitle: legend['title'],
                                legendContent: legend['content'],
                                icon: legend['icon'],
                                audio: legend['audio'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              child: Hero(
                                tag: legend['icon'],
                                child: Image.asset(
                                  legend['icon2'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 25,
            right: 10,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                    color: Color(0xFFDAB589),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => showCustomModal(context),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.question_mark,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
