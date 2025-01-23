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
                  collapsedHeight: 180,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  forceMaterialTransparency: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image(
                      image: AssetImage('assets/images/main_header.png'),
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 180,
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
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
                            Expanded(
                              flex: 7,
                              child: Hero(
                                tag: legend['icon'],
                                child: Image.asset(
                                  legend['icon'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, left: 10, right: 10),
                                child: Text(
                                  legend['title'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
            top: 30,
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
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.question_mark,
                      color: Colors.black,
                      size: 28,
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
