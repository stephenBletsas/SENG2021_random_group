// Function that calculates age from today when given a DateTime date of birth 
int calculateAge(DateTime dob) {
  DateTime today = DateTime.now();
  int age = today.year - dob.year;
  // If dob's month is ahead of today's month (OR) if dob's day is ahead of today in the same month
  // The last year isn't complete yet
  if (dob.month > today.month || (dob.month == today.day && dob.day > today.day)) age --;
  return age;
}