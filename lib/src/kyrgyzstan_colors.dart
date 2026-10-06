import 'package:flutter/widgets.dart';

/// Sampled from `Plak_shakhsi-KG` (flag, ink) and
/// `Green-Eco-License-Plate-Kyrgyzstan-2024` (eco green and its grey ink).
abstract final class KyrgyzstanColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color flagRed = Color(0xFFE8112D);
  static const Color flagSun = Color(0xFFFFEF00);

  /// The electric-vehicle plate prints in a dark grey, not black.
  static const Color ecoInk = Color(0xFF363636);
  static const Color ecoGreen = Color(0xFF4AAA3E);

  static const Color inactive = Color(0xFFB0B0B0);
}
