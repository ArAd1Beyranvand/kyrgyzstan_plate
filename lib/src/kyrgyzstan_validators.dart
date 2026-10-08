import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

bool _letters(String value, int min, int max) =>
    RegExp('^[A-Z]{$min,$max}\$').hasMatch(value);

bool _month(String value) {
  final int? m = int.tryParse(value);
  return value.length == 2 && m != null && m >= 1 && m <= 12;
}

/// Judges the `01 | 123 ABC` plates (private, government, eco, square,
/// motorcycle) by their groups `region`, `number`, `letters`.
///
/// A two-digit region code (01–11 in the article), three digits, and two or
/// three letters (the article gives both `xxx` and `xx`). Gated on the letters,
/// so nothing is reported until the serial is started. Reports, never bars a
/// keystroke.
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
    if (!_letters(entry.group('letters'), 2, 3)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    return const PlateValidation.valid();
  }
}

/// Judges the yellow foreign plate: `01 | 1234 H`, the letter one of H, K, M
/// or P (citizen, media, firm, resident).
class KyrgyzstanForeignValidator extends GatedPlateValidator {
  const KyrgyzstanForeignValidator();

  @override
  String get gateGroup => 'letters';

  static const String reasonRegion = 'The region code is 01 to 11.';
  static const String reasonNumber = 'The number is four digits.';
  static const String reasonLetter = 'The class letter is H, K, M or P.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!KyrgyzstanAlphabets.regionCodes.contains(entry.group('region'))) {
      return const PlateValidation.invalid(reasonRegion);
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!KyrgyzstanAlphabets.foreignClasses.contains(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetter);
    }
    return const PlateValidation.valid();
  }
}

/// Judges the white-on-colour plates by their groups `class`, `number`, and
/// where the design has them `mission` and `month`/`year`.
///
/// Three shapes share this: `D 01 001` (a class letter, a mission code and
/// three digits, dated), `HC 1001` (honorary consul, four digits, dated) and
/// `CMD 001` (head of mission, three digits, undated).
class KyrgyzstanDiplomaticValidator extends GatedPlateValidator {
  const KyrgyzstanDiplomaticValidator({
    required this.classes,
    required this.numberLength,
    this.hasMission = false,
    this.dated = false,
  });

  final List<String> classes;
  final int numberLength;
  final bool hasMission;
  final bool dated;

  /// `D 01 001`: class C, D or T, a mission code, three digits, dated.
  static const KyrgyzstanDiplomaticValidator diplomatic =
      KyrgyzstanDiplomaticValidator(
        classes: KyrgyzstanAlphabets.diplomaticClasses,
        numberLength: 3,
        hasMission: true,
        dated: true,
      );

  /// `HC 1001`: honorary consul, dated.
  static const KyrgyzstanDiplomaticValidator honorary =
      KyrgyzstanDiplomaticValidator(
        classes: <String>['HC'],
        numberLength: 4,
        dated: true,
      );

  /// `CMD 001`: head of mission.
  static const KyrgyzstanDiplomaticValidator mission =
      KyrgyzstanDiplomaticValidator(classes: <String>['CMD'], numberLength: 3);

  @override
  String get gateGroup => 'number';

  static const String reasonClass = 'The class is not one this plate uses.';
  static const String reasonMission =
      'The mission code is 01 to 19 (countries) or 50 to 64 (organisations).';
  static const String reasonNumber = 'The number has the wrong length.';
  static const String reasonMonth = 'The month is 01 to 12.';
  static const String reasonYear = 'The year is two digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!classes.contains(entry.group('class'))) {
      return const PlateValidation.invalid(reasonClass);
    }
    if (hasMission &&
        !KyrgyzstanAlphabets.missionCodes.contains(entry.group('mission'))) {
      return const PlateValidation.invalid(reasonMission);
    }
    if (!isDigitsOfLength(entry.group('number'), numberLength)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (dated) {
      if (!_month(entry.group('month'))) {
        return const PlateValidation.invalid(reasonMonth);
      }
      if (!isDigitsOfLength(entry.group('year'), 2)) {
        return const PlateValidation.invalid(reasonYear);
      }
    }
    return const PlateValidation.valid();
  }
}
