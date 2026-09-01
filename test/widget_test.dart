import 'package:flutter_test/flutter_test.dart';
import 'package:daily_habit_tracker/main.dart';

void main() {
  testWidgets('Daily Habit Tracker app test', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyHabitApp());
    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    await tester.pump();
  });
}
