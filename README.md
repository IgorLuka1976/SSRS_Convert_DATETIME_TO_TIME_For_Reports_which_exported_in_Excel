# SSRS_Convert_DATETIME_TO_TIME_For_Reports_which_saved_in_Excel
SSRS Use Date In Time format (YYYY-MM-DD HH:mm:ss convert to HH:mm:ss), when report save in Excel

First, design a simple report with datetime columns.
Problem description:
https://docs.google.com/document/d/1FcjFunIpC6sVezLXWtgOK0wx6j4AQGVViAEuS6rz7ow/edit?usp=sharing

Solution:
We use expression in SSRS for datetime column 'datetimecolumn':

'=DateAdd(DateInterval.Day, -1, CDATE(DateTime.ParseExact("1/1/1900 " & (TimeSpan.FromSeconds(Fields!datetimecolumn.Value).ToString()),"d/M/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)))'


