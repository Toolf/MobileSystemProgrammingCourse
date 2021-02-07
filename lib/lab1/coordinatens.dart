enum Direction {
  north,
  south,
  east,
  west,
}

class CoordinateNS {
  Direction direction;

  int degree;
  // Dart does not have a native unsigned integer.
  int minutes;
  int seconds;

  CoordinateNS(
      {this.degree: 0,
      this.minutes: 0,
      this.seconds: 0,
      this.direction: Direction.north})
      : assert(
            (direction == Direction.north ||
                    direction == Direction.south &&
                        -90 <= degree &&
                        degree <= 90) ||
                (direction == Direction.west ||
                        direction == Direction.east &&
                            -180 <= degree &&
                            degree <= 180) &&
                    (0 <= minutes && minutes <= 59) &&
                    (0 <= seconds && seconds <= 59),
            'degree: $degree, minutes: $minutes, seconds: $seconds, direction: $direction');

  String getNamedDirection() {
    String directionChar;
    switch (direction) {
      case Direction.north:
        directionChar = "N";
        break;
      case Direction.south:
        directionChar = "S";
        break;
      case Direction.east:
        directionChar = "E";
        break;
      case Direction.west:
        directionChar = "W";
        break;
      default:
        directionChar = "?";
    }
    return directionChar;
  }

  @override
  String toString() {
    String directionChar = getNamedDirection();

    return "$degree°$minutes′$seconds″ $directionChar";
  }

  String decimalDegree() {
    double decimaldegree = degree + minutes / 60 + seconds / 3600;
    String directionChar = getNamedDirection();

    return "$decimaldegree° $directionChar";
  }

  CoordinateNS getMiddlePoint(CoordinateNS coordinate) {
    if (coordinate.direction != direction) {
      return null;
    }

    int sumOfDigree = degree + coordinate.degree;
    int sumOfMinutes = minutes + coordinate.minutes + 60 * (sumOfDigree % 2);
    int sumOfSeconds = seconds + coordinate.seconds + 60 * (sumOfMinutes % 2);
    if (sumOfMinutes >= 120) {
      sumOfMinutes -= 120;
      sumOfDigree += 2;
    }
    if (sumOfSeconds >= 120) {
      sumOfSeconds -= 120;
      sumOfMinutes += 2;
    }

    CoordinateNS middlePoint = CoordinateNS(
        degree: sumOfDigree ~/ 2,
        minutes: sumOfMinutes ~/ 2,
        seconds: sumOfSeconds ~/ 2,
        direction: direction);

    return middlePoint;
  }

  static CoordinateNS middlePoint(
      CoordinateNS coordObj1, CoordinateNS coordObj2) {
    return coordObj1.getMiddlePoint(coordObj2);
  }
}

void main(List<String> args) {
  CoordinateNS c1 = CoordinateNS(
      degree: 90, minutes: 3, seconds: 0, direction: Direction.south);
  CoordinateNS middlePoint =
      c1.getMiddlePoint(CoordinateNS(direction: Direction.south));
  print(c1.toString());
  print(c1.decimalDegree());
  if (middlePoint != null) {
    print(middlePoint.toString());
    print(middlePoint.decimalDegree());
    print(CoordinateNS.middlePoint(c1, middlePoint));
  }
}
