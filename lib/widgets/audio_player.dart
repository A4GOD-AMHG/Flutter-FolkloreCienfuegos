import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;
  final String title;

  const AudioPlayerWidget({
    super.key,
    required this.audioPath,
    required this.title,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((d) {
      if (mounted) {
        setState(() {
          duration = d;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() {
          position = p;
        });
      }
    });

    // Rebuild so the play/pause icon follows the real player state.
    _audioPlayer.onPlayerStateChanged.listen((_) {
      if (mounted) setState(() {});
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          position = Duration.zero;
        });
      }
    });

    _loadAudio();
  }

  Future<void> _loadAudio() async {
    Duration? audioDuration;
    try {
      await _audioPlayer.setSource(AssetSource(widget.audioPath));
      audioDuration = await _audioPlayer.getDuration();
    } catch (e) {
      debugPrint('Failed to load audio ${widget.audioPath}: $e');
    }
    if (mounted) {
      setState(() {
        duration = audioDuration ?? Duration.zero;
      });
    }
  }

  void handlePlayPause() {
    switch (_audioPlayer.state) {
      case PlayerState.playing:
        _audioPlayer.pause();
      case PlayerState.paused:
        // Resume keeps the current position; play() would reload the source.
        _audioPlayer.resume();
      default:
        _audioPlayer.play(AssetSource(widget.audioPath));
    }
  }

  void handleSeek(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Audio: ${widget.title}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(formatDuration(position)),
          Slider(
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds
                .toDouble()
                .clamp(0.0, duration.inSeconds.toDouble()),
            onChanged: (value) => handleSeek(value),
          ),
          Text(formatDuration(duration)),
          IconButton(
            onPressed: handlePlayPause,
            icon: Icon(
              _audioPlayer.state == PlayerState.playing
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.black,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
