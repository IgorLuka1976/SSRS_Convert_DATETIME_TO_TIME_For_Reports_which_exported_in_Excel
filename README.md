# SSRS_Convert_DATETIME_TO_TIME_For_Reports_which_saved_in_Excel
SSRS Use Date In Time format (YYYY-MM-DD HH:mm:ss convert to HH:mm:ss), when report save in Excel

Important!
1. The input data for displaying the Time format should be seconds!
2. The option described below is suitable for the case if no more than 86400 seconds or no more than 24 hours!
-----------------===============For case no more 24 hours
First, design a simple report with datetime columns.
Problem description:
https://docs.google.com/document/d/1FcjFunIpC6sVezLXWtgOK0wx6j4AQGVViAEuS6rz7ow/edit?usp=sharing

Solution:
1.We need to convert datetime column to the seconds in INT format.
Change script in dataset:
change:’,ModifiedDate AS Date’
to
,’DATEDIFF(SECOND, CONVERT(date, ModifiedDate), ModifiedDate) AS Date’

2. We use expression in SSRS for datetime column 'datetimecolumn':

'=DateAdd(DateInterval.Day, -1, CDATE(DateTime.ParseExact("1/1/1900 " & (TimeSpan.FromSeconds(Fields!Date.Value).ToString()),"d/M/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)))'
and than set TIME format for this column:

Now, run again and It's ok!
Solution:
https://docs.google.com/document/d/1mvVR76jQdEnWwySmO-UGrLvxz6EsKxD930cHFZjth-0/edit?usp=sharing
----------------=============================================================================

