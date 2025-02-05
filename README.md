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

For Case where is greater than or equal 86400 seconds or 24 hours
, but Time Format will turn out to be a String Format !

or :
=Floor(30000000 / 3600) &":"& Format(DateAdd("s", 30000000 , "00:00"), "mm:ss")

Description:
https://docs.google.com/document/d/1mEnP3v5_GPT_WkcQXTU9S_P6BWSgrl218ISZxujqOcY/edit?usp=sharing

New solution! :For Case where is greater than or equal 86400 seconds or 24 hours

=DateTime.ParseExact((IIf(Floor(Fields!ShiftDuration.Value / 86400)<1 ,"31/12/1899 ",IIf(Floor(Fields!ShiftDuration.Value / 86400)>=1 AND Floor(Fields!ShiftDuration.Value / 86400)<32 ,Format(Floor(Fields!ShiftDuration.Value / 86400))+"/1/1900 ",Format(Floor(Fields!ShiftDuration.Value / 86400)-31)+"/2/1900 "))) & (Format(DateAdd("s", Fields!ShiftDuration.Value, TimeValue("00:00:00")), "HH:mm:ss")),"d/M/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)

Or the best way to create a function in the Code page of Report Builder ->Report Properties -> Code
Insert this into the window of Code:
Public Function ConvertSecondsToHourMinSec(ByVal intTotalSeconds) As DateTime

        ConvertSecondsToHourMinSec = DateTime.ParseExact((IIf(Floor(intTotalSeconds / 86400)<1 ,"31/12/1899 ",IIf(Floor(intTotalSeconds / 86400)>=1 AND Floor(intTotalSeconds / 86400)<32 ,Format(Floor(intTotalSeconds / 86400))+"/1/1900 ",IIf(Floor(intTotalSeconds / 86400)>=32 AND Floor(intTotalSeconds / 86400)<61 ,Format(Floor(intTotalSeconds / 86400)-31)+"/2/1900 ",IIf(Floor(intTotalSeconds / 86400)>=61 AND Floor(intTotalSeconds / 86400)<92 ,Format(Floor(intTotalSeconds / 86400)-60)+"/3/1900 ",IIf(Floor(intTotalSeconds / 86400)>=92 AND Floor(intTotalSeconds / 86400)<122 ,Format(Floor(intTotalSeconds / 86400)-91)+"/4/1900 ",IIf(Floor(intTotalSeconds / 86400)>=122 AND Floor(intTotalSeconds / 86400)<153 ,Format(Floor(intTotalSeconds / 86400)-121)+"/5/1900 ",IIf(Floor(intTotalSeconds / 86400)>=153 AND Floor(intTotalSeconds / 86400)<183 ,Format(Floor(intTotalSeconds / 86400)-152)+"/6/1900 ",IIf(Floor(intTotalSeconds / 86400)>=183 AND Floor(intTotalSeconds / 86400)<214 ,Format(Floor(intTotalSeconds / 86400)-182)+"/7/1900 ",IIf(Floor(intTotalSeconds / 86400)>=214 AND Floor(intTotalSeconds / 86400)<245 ,Format(Floor(intTotalSeconds / 86400)-213)+"/8/1900 ", IIf(Floor(intTotalSeconds / 86400)>=245 AND Floor(intTotalSeconds / 86400)<275 ,Format(Floor(intTotalSeconds / 86400)-244)+"/9/1900 ",IIf(Floor(intTotalSeconds / 86400)>=275 AND Floor(intTotalSeconds / 86400)<306 ,Format(Floor(intTotalSeconds / 86400)-274)+"/10/1900 ",IIf(Floor(intTotalSeconds / 86400)>=306 AND Floor(intTotalSeconds / 86400)<336 ,Format(Floor(intTotalSeconds / 86400)-305)+"/11/1900 ",IIf(Floor(intTotalSeconds / 86400)>=336 AND Floor(intTotalSeconds / 86400)<367 ,Format(Floor(intTotalSeconds / 86400)-335)+"/12/1900 ","1/1/1901 ")))))))))))))) & (Format(DateAdd("s", intTotalSeconds, TimeValue("00:00:00")), "HH:mm:ss")),"d/M/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)

End Function

And then call this function from the cell's Expression Window:
=code.ConvertSecondsToHourMinSec(30000000)



