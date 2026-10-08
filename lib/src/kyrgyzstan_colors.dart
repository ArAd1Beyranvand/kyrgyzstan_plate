import 'package:flutter/widgets.dart';

/// Sampled from the flats of `.plateref/kg` (modal colour of each field and
/// ink), not read from the article's adjectives.
abstract final class KyrgyzstanColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color flagRed = Color(0xFFE8112D);

  /// The electric-vehicle plate prints in a dark grey, not black.
  static const Color ecoInk = Color(0xFF363636);
  static const Color ecoGreen = Color(0xFF4AAA3E);

  /// Foreign-owned vehicles: black on a yellow that is closer to amber.
  static const Color yellow = Color(0xFFFFC913);
  static const Color yellowInk = Color(0xFF1D1D1D);

  /// Diplomatic and consular plates print white on red; UN plates on blue.
  static const Color diplomaticRed = Color(0xFFED1C24);
  static const Color unBlue = Color(0xFF064DB9);

  static const Color inactive = Color(0xFFB0B0B0);
}
