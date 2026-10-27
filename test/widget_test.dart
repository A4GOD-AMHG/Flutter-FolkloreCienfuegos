import 'package:cienfuegos_folklore/models/legend.dart';
import 'package:cienfuegos_folklore/services/legend_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('legends.json parses into Legend models', () async {
    final legends = await LegendRepository().loadLegends();
    expect(legends, isNotEmpty);
    for (final legend in legends) {
      expect(legend.title, isNotEmpty);
      expect(legend.audio.startsWith('assets/'), isFalse,
          reason: 'AssetSource already prefixes assets/');
    }
  });

  test('Legend.fromJson maps every field', () {
    final legend = Legend.fromJson({
      'title': 't',
      'content': 'c',
      'icon': 'i',
      'icon2': 'i2',
      'audio': 'audio/a.mp3',
    });
    expect(
        [legend.title, legend.content, legend.icon, legend.icon2, legend.audio],
        ['t', 'c', 'i', 'i2', 'audio/a.mp3']);
  });
}
