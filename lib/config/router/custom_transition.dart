import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

Route createSlideTransitionRoute(Widget page) {
  return SwipeablePageRoute(
    builder: (context) => page,
  );
}
