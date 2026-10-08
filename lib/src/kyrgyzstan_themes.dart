import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'kyrgyzstan_colors.dart';

/// Frame widths and corner radii are measured off the artwork in plate units
/// and divided by each canvas's height: the frame is 4.3 on the 110-high
/// plates (4.1 on the 160-high square, 4.2 on the 200-high motorcycle plate),
/// the corner radius about 7.3 on all of them.
abstract final class KyrgyzstanThemes {
  /// Black on white.
  static final PlateTheme private = _theme(
    KyrgyzstanColors.white,
    KyrgyzstanColors.black,
    border: 4.3 / 110,
    radius: 7.3 / 110,
  );

  /// Black on white, the square two-row plate (160 high).
  static final PlateTheme square = _theme(
    KyrgyzstanColors.white,
    KyrgyzstanColors.black,
    border: 4.1 / 160,
    radius: 7.2 / 160,
  );

  /// Black on white, the motorcycle plate (200 high).
  static final PlateTheme motorcycle = _theme(
    KyrgyzstanColors.white,
    KyrgyzstanColors.black,
    border: 4.2 / 200,
    radius: 7.4 / 200,
  );

  /// Dark grey on white, for the green-striped electric plate. Its frame is
  /// thinner (3.0); the artwork's extra outer ring is not drawn.
  static final PlateTheme eco = _theme(
    KyrgyzstanColors.white,
    KyrgyzstanColors.ecoInk,
    border: 3.0 / 110,
    radius: 7.3 / 110,
  );

  /// Black on yellow: foreign citizens, residents, firms and media.
  static final PlateTheme foreign = _theme(
    KyrgyzstanColors.yellow,
    KyrgyzstanColors.yellowInk,
    border: 4.0 / 110,
    radius: 7.3 / 110,
  );

  /// White on red: diplomatic and consular.
  static final PlateTheme diplomatic = _theme(
    KyrgyzstanColors.diplomaticRed,
    KyrgyzstanColors.white,
    border: 4.3 / 110,
    radius: 7.3 / 110,
  );

  /// White on blue: United Nations missions.
  static final PlateTheme unitedNations = _theme(
    KyrgyzstanColors.unBlue,
    KyrgyzstanColors.white,
    border: 4.3 / 110,
    radius: 7.3 / 110,
  );
}

PlateTheme _theme(
  Color field,
  Color ink, {
  required double border,
  required double radius,
}) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  inactive: KyrgyzstanColors.inactive,
  borderWidthRatio: border,
  plateRadiusRatio: radius,
);
