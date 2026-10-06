import 'package:plate_core/plate_core.dart';

import 'kyrgyzstan_colors.dart';

/// Kyrgyzstan as a `PlateCountry`. There is no country panel: the flag and
/// `KG` are drawn by the spec (a flag of two shapes is a band and a disc).
abstract final class KyrgyzstanCountry {
  static const PlateCountry kyrgyzstan = PlateCountry(
    code: 'kg',
    captionLines: <String>[],
    panelColor: KyrgyzstanColors.flagRed,
    panelTextColor: KyrgyzstanColors.white,
  );
}
