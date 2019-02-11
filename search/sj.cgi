#!/usr/bin/perl
# for web new search
require 'cgi-lib.pl';

&ReadParse(*input);
$html = ".html";
$str = "There is no entry for ";

$typedname = $input{'sname'};                    #name the user typed in (1)
$input{'sname'} =~ y/A-Z/a-z/;                  #convert to all lower case (2)
@fullname = split(' ', $input{'sname'});        #element 0 = first name, element1 = last name (3)
if (!$fullname[1])
{
	$str = "Search for: ";
	$fullname[1] = $fullname[0];
}
$firstletterF = substr($fullname[0], 0, 1);    #get first letter of first name
$firstletterL = substr($fullname[1], 0, 1);    #get first letter of last name for later in script
$firstletterF =~ y/a-z/A-Z/;                  #convert first letter to upper case
$input{'sname'} =~ s/^./$firstletterF/; #replace first letter of first name with cap
$fullname[0] =~ s/^./$firstletterF/; #also do the same to fullname no match in next line works
$input{'sname'} =~ s/(@fullname[0]) (@fullname[1])/$2 $1/;    #reverse first and last name (4)
$input{'sname'} =~ s/\s//;                          #remove spaces in name to use as filename (5)


if (-e "judges/$input{'sname'}$html")          #look for /judges/filename.html
{
	print "Location: http://www.onlinecourt.com/judges/$input{'sname'}$html\n\n";
}
else
{
	print "Content-type: text/html\n\n";

	print "<html><head>\n";
	print "<title>Search Results</title>\n";
	print "</head>\n";
	print "<body background=\"images/bkgnd.gif\" bgcolor=\"FFFFFF\" text=\"FFFFFF\" link=\"add8e6\" vlink=\"add8e6\">\n";
	print "<center>\n";
	print "<br><br><br><br><br>\n";

	printf ("<h1><font color=FF0000 face=Helvetica>Search Results</font></h1><p>\n");
	printf ("$str <font size=+2 color=FF0000 face=Helvetica>%s</font>\n", $typedname);
	print "<form><br>\n";
	print "<input type=button name=back value=back onClick=\"history.back()\">\n";
	print "</form><br>\n";


	&displaysearch;

	print "</center>\n";
	print "</body></html>\n";
}

sub displaysearch
{
	#CODE STARTS HERE FOR DISPLAYING ALPHABETICAL LINKS
	#printf ("<p><br><br>First letter of last name is %s.\n", $firstletterL);
	#printf ("<br>Search string is %s.\n", "$input{'sname'}$html");

	$dircont = `cd judges; ls *.html`;              #change to judges directory and list html files
	@files = split(' ', $dircont);                      #store each file separately
	$matches = 0;
	foreach $htmlfile (@files)
	{
		#code for extracting judge's name from filename
		$firstlet = $htmlfile;    #make a copy of the current filename 
		$tempL = $firstletterL;    #make a copy of the first letter last name so we can uppercase it
		$tempL =~ y/a-z/A-Z/; #upper case letter so we can print in IF statement
		$firstlet =~ tr/a-z.//d;    #get first letter of first name, delete lowercase & '.'
		@restorename = split(/[A-Z.]/, $htmlfile);   #0=last name, 1=first name, 2=html(discard)
		$restorename[0] =~ y/a-z/A-Z/;                  #convert to upper case
		$restorename[1] =~ y/a-z/A-Z/;                  #convert to upper case
		$tempLet = substr($htmlfile, 0, 1);    #get 1st letter of filename for alpha testing
		if ($firstletterL eq $tempLet)              #if it matches letter of typed name, print it
		{
			$matches = $matches + 1;
			if ($matches == 1) {print "<h4>Here are Links to all the judges<br>starting with the letter \"$tempL\"</h4>\n"};
			print "<br><a href=\"judges/$htmlfile\">JUDGE $firstlet$restorename[1] $restorename[0]</a>\n";   #print each file as a link
		}
	}
	#CODE ENDS HERE FOR DISPLAYING ALPHABETICAL LINKS
}