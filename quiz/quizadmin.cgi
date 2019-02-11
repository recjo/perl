#!/usr/bin/perl

############################################################
#
#
#           Perl CGI Script allows administrator to easily change the weekly quiz
#           questions. It reads a file named 'weeklyquiz'.
#           Author: Joel Recinos.
#
#
############################################################

require 'cgi-lib.pl';

&ReadParse(*input);


#constants
$filename = 'weeklyquiz';

#initialization
$x = 0;


#flock(HIGH, 2); # 2 exclusively locks the file
open(HIGH, $filename) || die("Can't open file $!");


while(<HIGH>)
{
	@quizary[$x] = $_; 
	$x = $x + 1;                                      #increment counter
}
#element 0=question, 1=A1, 2=A2, 3=A3, 4=A4, 5=correct
@q1 = split(':', $quizary[0]);
@q2 = split(':', $quizary[1]); 
@q3 = split(':', $quizary[2]); 
@q4 = split(':', $quizary[3]); 

# output html headers
print "Content-type: text/html\n\n";
print "<html><head>\n";
print "<title>Quiz Administration</title>\n";
print "<body bgcolor=FFFFFF text=000000 background=../images/win_bk.gif>\n";
print "\n";
print "<font color=0000ff><h1>Weekly Quiz Administration Page</h1><P></font>\n";

print "<FORM ACTION=quizadminwrite.cgi METHOD=POST>\n";

print "Q1: <INPUT NAME=Q1 TYPE=Text VALUE=\"$q1[0]\" SIZE=75 MAXLENGTH=100><BR>\n";
print "A: <INPUT NAME=A1 TYPE=Text VALUE=\"$q1[1]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "B: <INPUT NAME=B1 TYPE=Text VALUE=\"$q1[2]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "C: <INPUT NAME=C1 TYPE=Text VALUE=\"$q1[3]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "D: <INPUT NAME=D1 TYPE=Text VALUE=\"$q1[4]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "Correct Answer: <INPUT NAME=Answer1 TYPE=Text VALUE=\"$q1[5]\" SIZE=3 MAXLENGTH=1><P>\n";

print "Q2: <INPUT NAME=Q2 TYPE=Text VALUE=\"$q2[0]\" SIZE=75 MAXLENGTH=100><BR>\n";
print "A: <INPUT NAME=A2 TYPE=Text VALUE=\"$q2[1]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "B: <INPUT NAME=B2 TYPE=Text VALUE=\"$q2[2]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "C: <INPUT NAME=C2 TYPE=Text VALUE=\"$q2[3]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "D: <INPUT NAME=D2 TYPE=Text VALUE=\"$q2[4]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "Correct Answer: <INPUT NAME=Answer2 TYPE=Text VALUE=\"$q2[5]\" SIZE=3 MAXLENGTH=1><P>\n";

print "Q3: <INPUT NAME=Q3 TYPE=Text VALUE=\"$q3[0]\" SIZE=75 MAXLENGTH=100><BR>\n";
print "A: <INPUT NAME=A3 TYPE=Text VALUE=\"$q3[1]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "B: <INPUT NAME=B3 TYPE=Text VALUE=\"$q3[2]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "C: <INPUT NAME=C3 TYPE=Text VALUE=\"$q3[3]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "D: <INPUT NAME=D3 TYPE=Text VALUE=\"$q3[4]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "Correct Answer: <INPUT NAME=Answer3 TYPE=Text VALUE=\"$q3[5]\" SIZE=3 MAXLENGTH=1><P>\n";

print "Q4: <INPUT NAME=Q4 TYPE=Text VALUE=\"$q4[0]\" SIZE=75 MAXLENGTH=100><BR>\n";
print "A: <INPUT NAME=A4 TYPE=Text VALUE=\"$q4[1]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "B: <INPUT NAME=B4 TYPE=Text VALUE=\"$q4[2]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "C: <INPUT NAME=C4 TYPE=Text VALUE=\"$q4[3]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "D: <INPUT NAME=D4 TYPE=Text VALUE=\"$q4[4]\" SIZE=30 MAXLENGTH=75><BR>\n";
print "Correct Answer: <INPUT NAME=Answer4 TYPE=Text VALUE=\"$q4[5]\" SIZE=3 MAXLENGTH=1><P>\n";

print "<INPUT TYPE=SUBMIT VALUE=\"COMMIT CHANGES\">\n";
print "</FORM>\n";








# output html footer
print "</body> </html>\n";


close(HIGH);
#flock(HIGH, 8); # 8 unlocks the file
