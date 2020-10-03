///Extend this class in order to assign values to enums
abstract class Enum {
  const Enum.internal(this.value);

  final String value;

  static const List<Enum> values = [];
}
