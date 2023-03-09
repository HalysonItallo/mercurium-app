selectType<T>(
    dynamic testingValue, List<dynamic> testingItems, List<T> returnValue) {
  try {
    if (testingItems.length != returnValue.length) {
      throw Exception("Array sizes are not compatible");
    }

    for (var i = 0; i < testingItems.length; i++) {
      if (testingItems[i] == testingValue) {
        return returnValue[i];
      }
    }

    throw Exception("No type found");
  } catch (e) {
    throw Exception("Could not find the type");
  }
}
