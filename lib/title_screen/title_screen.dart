import 'package:flutter/material.dart';
import 'package:outpost_app/assets.dart';
import 'package:outpost_app/styles.dart';
import 'package:outpost_app/title_screen/title_screen_ui.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  Color get _emitColor =>
      AppColors.emitColors[_difficultyOverride ?? _difficulty];
  Color get _orbColor =>
      AppColors.emitColors[_difficultyOverride ?? _difficulty];

  int _difficulty = 0;
  int? _difficultyOverride;

  void _handleDifficultyPressed(int value) {
    setState(() => _difficulty = value);
  }

  void _handleDifficultyFocused(int? value) {
    setState(() => _difficultyOverride = value);
  }

  final _finalReceiveLightAmt = 0.7;
  final _finalEmitLightAmt = 0.5;

  @override
  Widget build(BuildContext context) {
    final orbColor = AppColors.orbColors[0];
    final emitColor = AppColors.emitColors[0];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Stack(
        children: [
          Image.asset(AssetPaths.titleBgBase),
          _LitImage(
              color: orbColor,
              image: AssetPaths.titleBgReceive,
              lightAmt: _finalReceiveLightAmt),
          _LitImage(
              color: orbColor,
              image: AssetPaths.titleMgBase,
              lightAmt: _finalReceiveLightAmt),
          _LitImage(
              color: orbColor,
              image: AssetPaths.titleMgReceive,
              lightAmt: _finalReceiveLightAmt),
          _LitImage(
              color: emitColor,
              image: AssetPaths.titleMgEmit,
              lightAmt: _finalEmitLightAmt),
          Image.asset(AssetPaths.titleFgBase),
          _LitImage(
              color: orbColor,
              image: AssetPaths.titleFgReceive,
              lightAmt: _finalReceiveLightAmt),
          _LitImage(
              color: emitColor,
              image: AssetPaths.titleFgEmit,
              lightAmt: _finalEmitLightAmt),
          Positioned.fill(
              child: TitleScreenUi(
                  difficulty: _difficulty,
                  onDifficultyPressed: _handleDifficultyPressed,
                  onDifficultyFocused: _handleDifficultyFocused))
        ],
      )),
    );
  }
}

class _LitImage extends StatelessWidget {
  const _LitImage(
      {super.key,
      required this.color,
      required this.image,
      required this.lightAmt});

  final Color color;
  final String image;
  final double lightAmt;

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          hsl.withLightness(hsl.lightness * lightAmt).toColor(),
          BlendMode.modulate),
      child: Image.asset(image),
    );
  }
}
