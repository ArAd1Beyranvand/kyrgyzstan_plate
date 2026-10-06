import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// Judges a Kyrgyz plate by its groups `region`, `number`, `letters`.
///
/// `01 123ABC`: a two-digit region code (01–11 in the article), three digits,
/// and two or three letters (the article gives both `xxx` and `xx`). Gated on
/// the letters, so nothing is reported until the serial is started. Reports,
/// never bars a keystroke.
class KyrgyzstanValidator extends GatedPlateValidator {
  const KyrgyzstanValidator();

  @override
  String get gateGroup => 'letters';

  static const String reasonRegion = 'The region code is 01 to 11.';
  static const String reasonNumber = 'The number is three digits.';
  static const String reasonLetters =
      'The serial ends in two or three letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!KyrgyzstanAlphabets.regionCodes.contains(entry.group('region'))) {
      return const PlateValidation.invalid(reasonRegion);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!RegExp(r'^[A-Z]{2,3}$').hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    return const PlateValidation.valid();
  }
}
