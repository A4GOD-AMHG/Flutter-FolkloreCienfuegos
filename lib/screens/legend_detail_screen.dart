import 'package:cienfuegos_folklore/widgets/audio_player.dart';
import 'package:cienfuegos_folklore/widgets/info_modal.dart';
import 'package:flutter/material.dart';

class LegendDetailScreen extends StatefulWidget {
  final String legendTitle;
  final String legendContent;
  final String icon;
  final String audio;

  const LegendDetailScreen({
    super.key,
    required this.legendTitle,
    required this.legendContent,
    required this.icon,
    required this.audio,
  });

  @override
  State<LegendDetailScreen> createState() => _LegendDetailScreenState();
}

class _LegendDetailScreenState extends State<LegendDetailScreen> {
  final GlobalKey _headerWidgetKey = GlobalKey();
  double _navigationTopDistance = 0;
  double _legendIconTopDistance = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculatePosition();
    });
  }

  void _calculatePosition() {
    final RenderBox renderBox =
        _headerWidgetKey.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    setState(() {
      _navigationTopDistance = position.dy + size.height + 10;
      _legendIconTopDistance = position.dy + size.height - 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EBD7),
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
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  forceMaterialTransparency: true,
                  flexibleSpace: FlexibleSpaceBar(
                    key: _headerWidgetKey,
                    background: Image(
                      image: AssetImage('assets/images/legend_header.png'),
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              widget.legendTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.legendContent,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: _legendIconTopDistance,
            right: 30,
            child: Hero(
              tag: widget.icon,
              child: Image(
                image: AssetImage(widget.icon),
                height: 100,
                width: 90,
                fit: BoxFit.fill,
              ),
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
          Positioned(
            top: _navigationTopDistance,
            left: 20,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                    color: Color(0xFFDAB589),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.arrow_back,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFDAB589),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (BuildContext context) {
              return AudioPlayerWidget(
                title: widget.legendTitle,
                audioPath: widget.audio,
              );
            },
          );
        },
        child: const Icon(Icons.audiotrack_rounded),
      ),
    );
  }
}
