class Legend {
  final String title;
  final String content;

  /// Large image shown on the detail screen (also used as the Hero tag).
  final String icon;

  /// Thumbnail shown on the home grid.
  final String icon2;

  /// Path relative to `assets/`, as expected by audioplayers' AssetSource.
  final String audio;

  const Legend({
    required this.title,
    required this.content,
    required this.icon,
    required this.icon2,
    required this.audio,
  });

  factory Legend.fromJson(Map<String, dynamic> json) => Legend(
        title: json['title'] as String,
        content: json['content'] as String,
        icon: json['icon'] as String,
        icon2: json['icon2'] as String,
        audio: json['audio'] as String,
      );
}
