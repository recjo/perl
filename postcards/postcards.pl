#!/usr/bin/perl

use CGI qw/:standard/;

$head = "/home/content/05/10587905/html/includes/head.html";
$foot = "/home/content/05/10587905/html/includes/foot.html";
$messages = "/home/content/05/10587905/html/includes/messages.txt";
$imgdir = "/images";
$cardimgdir = "/webcards/images";

# get html passed-in variables
$query = new CGI;
$pic = $query->param('pic');
$action = $query->param('action');

# read header
open(SPFILE, "$head") || die("Can't open file $!");
@lines = <SPFILE>;
close(SPFILE);
# read footer
open(SPFILE, "$foot") || die("Can't open file $!");
@footlines = <SPFILE>;
close(SPFILE);

#print "Content-type: text/html\n\n";

print header;

# ----------------------- header -----------------------
foreach $line (@lines)
{
	print "$line\n";
}


# ----------------------- SHOW POSTCARD -----------------------
if ($action eq "picker")
{
#calculate a date
($sec,$min,$hour,$mday,$mmon,$year,$wday,$yday,$isdst) = localtime(time);
$year4 = 1900 + $year;
$mon = 1 + $mmon;
$dateStr = "$mon/$mday/$year4";

#calculate a unique ID number
$randNum = time."-".$$;

# if card is being replied to, there will be info passed in
$s = $query->param('s');
$se = $query->param('se');
$r = $query->param('r');
$re = $query->param('re');

print <<EOF;
<SCRIPT LANGUAGE="JavaScript">
<!-- Beginning of JavaScript -
function check()
{
	var str = "";

	if (document.theForm.toName.value == "" )
    {
        str = str + "Recipient Name cannot be blank.\\n";
    }

	if (document.theForm.toAddress.value == "" )
    {
        str = str + "Recipient E-mail Address cannot be blank.\\n";
    }
	else if (document.theForm.toAddress.value.indexOf('\@') == -1 ||  document.theForm.toAddress.value.indexOf('.') == -1 ||  document.theForm.toAddress.value.length <  7)
	{
  		str = str + "Recipient E-mail address needs to be in the form of name\@host.com.\\n";
 	}
	else if (document.theForm.toAddress.value.indexOf(' ') > 0 )
	{
  		str = str + "Recipient E-mail address cannot contain a space.\\n";
 	}

	if (document.theForm.fromName.value == "" )
    {
        str = str + "Sender Name cannot be blank.\\n";
    }

	if (document.theForm.fromAddress.value == "" )
    {
        str = str + "Sender E-mail Address cannot be blank.\\n";
    }
	else if (document.theForm.fromAddress.value.indexOf('\@') == -1 ||  document.theForm.fromAddress.value.indexOf('.') == -1 ||  document.theForm.fromAddress.value.length <  7)
	{
  		str = str + "Sender E-mail address needs to be in the form of name\@host.com.\\n";
 	}
	else if (document.theForm.fromAddress.value.indexOf(' ') > 0 )
	{
  		str = str + "Sender E-mail address cannot contain a space.\\n";
 	}

	if (document.theForm.message.value == "" )
    {
        str = str + "Message cannot be blank.\\n";
    }
	else if (document.theForm.message.value.length <  5)
	{
  		str = str + "Message must be more than 5 characters.\\n";
 	}

 	if (str != "")
	{
		alert("The following fields need your attention:\\n\\n" + str);
		return false;
	}
	else 
	{
		return true;
	}
}
// - End of JavaScript - -->
</SCRIPT>
  <br>
  <IMG SRC="$imgdir/titl_sendpost.gif" WIDTH="327" HEIGHT="28" ALT="HelpDavey.com Web Postcards">


<form name="theForm" action="/cgi/postcards.pl" method="post" onSubmit="return check();">
<input type="hidden" name="action" value="send">
<input type="hidden" name="pic" value="$pic">
<input type="hidden" name="id" value="$randNum">
<input type="hidden" name="postdate" value="$dateStr">

<a HREF="/postcard.shtml"><img src="$cardimgdir/change_button.gif" width="144" height="19" border="0"></a> 
			
<!-- <IMG SRC="$imgdir/dot.gif" WIDTH="20" HEIGHT="1" ALT="">
<input type="image" src="$cardimgdir/preview_button.gif" border="0" name="previewcard"> -->

<IMG SRC="$imgdir/dot.gif" WIDTH="20" HEIGHT="1" ALT="">
<input type="image" src="$cardimgdir/send_button.gif" border="0" name="sendcard">


    <br>
    <br>
    <table width="418" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><font size="1" face="arial, helvetica">Got the perfect image? It's 
          time for the perfect message. Just type in your name and email address, 
          your friend's name and email address, and your message. If you want 
          to review your masterpiece, click on PREVIEW CARD. If you've decided 
          that the perfect image isn't all that, click on CHANGE IMAGE. If all's 
          right with your card, and the world, click on SEND CARD.</font></td>
      </tr>
    </table>
    <BR>
        <P>
        
    <TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#ffffff" width="483">
<tr>
<td valign="top" colspan="2"><IMG SRC="$imgdir/corner1.gif" WIDTH="28" HEIGHT="26"></td>
<td valign="top" align="right" colspan="3"><IMG SRC="$imgdir/corner2.gif" WIDTH="24" HEIGHT="26"></td>
</tr>
 <tr>
<td width="20" nowrap>&nbsp;</td>
<td valign="middle"><img src="$cardimgdir/$pic" width=200 height=300></td>
<td width="20" nowrap>&nbsp;</td>
<td align="left" valign="middle"><font size="2" color="#000000" face="arial,helvetica">
<b>Recipient name:</b>
<br>
<input type="TEXT" name="toName" size="21" value="$s">
<br>
<b>Recipient e-mail address:</b><br>
<input type="TEXT" name="toAddress" size="21" value="$se">
<br>
<b>Sender name:</b>
<br>
<input type="TEXT" name="fromName" size="21" value="$r">
<br>
<b>Sender e-mail address:</b>
<br>
<input type="TEXT" name="fromAddress" size="21" value="$re"><br>
<b>Message:</b>
<br>
<textarea name="message" rows="5" cols="25" wrap="virtual"></textarea>
<br>
<font size="1"><input type="checkbox" name="showdate" value="$dateStr">
<b>Include Today's Date</b> - $dateStr</font></font>
</td>
<td width="20" nowrap>&nbsp;</td>
</tr>
<tr>
<td valign="top" colspan="2"><IMG SRC="$imgdir/corner3.gif" WIDTH="28" HEIGHT="25"></td>
<td valign="top" align="right" colspan="3"><IMG SRC="$imgdir/corner4.gif" WIDTH="28" HEIGHT="25"></td>
</tr>
</table>
</form>
EOF
}
# ----------------------- SEND POSTCARD -----------------------
elsif ($action eq "send")
{
	$id = $query->param('id');
	$toName = $query->param('toName');
	$toAddress = $query->param('toAddress');
	$fromName = $query->param('fromName');
	$fromAddress = $query->param('fromAddress');
	$message = $query->param('message');
	$postdate = $query->param('postdate');
	$showdate = $query->param('showdate');
	
	#replace line breaks with <br>
	$message =~ s/\r\n/<br>/g;
	$message =~ s/\n/<br>/g;
	
	#write message to database
	flock(HIGH, 2); # 2 exclusively locks the file
	open(HIGH, ">> $messages") || die("Can't open file $!");
	print HIGH "$id\t$toName\t$toAddress\t$fromName\t$fromAddress\t$message\t$postdate\t$showdate\t$pic\n";
	close(HIGH);
	flock(HIGH, 8); # 8 unlocks the file
	
	#send email to recipient
	$mailprog = '/usr/sbin/sendmail';
	open(MAIL,"|$mailprog -t") || die "Can't open: \n";
	print MAIL "To: $toAddress\n";
	print MAIL "From: webpostcard\@helpdavey.com\n";
	print MAIL "Subject: Web Postcard from $fromName\n\n";
	print MAIL <<"StopPrint";
$postdate
	
Dear $toName,

$fromName wants you to know about the web site that has been put up by Dave Hassenpflug's family to raise money for his bone marrow transplant operation. That's why $fromName has sent you a web postcard from www.HelpDavey.com.
But don't delay. Your postcard will be deleted from the server in 3 weeks.

Click on the link below (or cut and paste this URL into your browser) to read your web postcard.

http://www.HelpDavey.com/cgi/postcardget.pl?id=$id

Feel free to send HelpDavey.com Web Postcards to your friends by "clicking over" to http://www.HelpDavey.com/postcard.shtml. They're FREE!!!

Don't forget to check out HelpDavey.com and find out how Dave's efforts are going!
http://www.HelpDavey.com
StopPrint
	close (MAIL);

	print <<EOF;

<IMG SRC="$imgdir/titl_cardsent.gif" WIDTH="379" HEIGHT="28" ALT="Card Sent Successfully"><p>

     <a HREF="/postcard.shtml"><img SRC="$cardimgdir/sendmore_button.gif" BORDER=0></a>
     <P>
<table width="418" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><font size="2" face="arial, helvetica">
		  Congratulations -- your card has been sent. If you'd like to send more HelpDavey.com web postcards, click on SEND MORE button.
		  </font></td>
      </tr>
    </table>

<P>
  
<TABLE border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" width="483">
<tr>
<td valign="top" colspan="2"><IMG SRC="$imgdir/corner1.gif" WIDTH="28" HEIGHT="26"></td>
<td valign="top" align="right"><IMG SRC="$imgdir/corner2.gif" WIDTH="24" HEIGHT="26"></td>
</tr>

<tr>
<td width="20" nowrap>&nbsp;</td>
<td valign="middle">
<TABLE BORDER=0>
<TR>
<TD ALIGN="center" VALIGN="top">
<IMG SRC="$cardimgdir/$pic" ALT="Front of Postcard" HEIGHT="300" WIDTH="200">	
</TD>
<TD ALIGN="right" VALIGN="top">
	<TABLE BORDER=0 cellpadding="0" cellspacing="0">
	<TR>
	<TD colspan="5"><IMG src="$cardimgdir/back_top.gif" ALT="Back of Postcard" HEIGHT="60" WIDTH="197"></TD>
	</TR>
	
	<TR>
	<TD width="1" bgcolor="#000000" nowrap>
	<IMG src="$imgdir/dot.gif" HEIGHT="221" WIDTH="1"><br></TD>
	<TD width="5" bgcolor="#FFFFFF" nowrap>
	<IMG src="$imgdir/dot.gif" HEIGHT="221" WIDTH="5"><br></TD>
	<TD width="185" bgcolor="#FFFFFF" nowrap valign="top">
	<font face="verdana,helvetica,arial" size="1" color="#000000"><br>
	$showdate</p>
	To: $toName<br>
	From: $fromName<hr noshade size="1" width="85%">
	$message</TD>
	<TD width="5" bgcolor="#FFFFFF" nowrap>
	<IMG src="$imgdir/dot.gif" HEIGHT="221" WIDTH="5"><br></TD>
	<TD width="1" bgcolor="#000000" nowrap>
	<IMG src="$imgdir/dot.gif" HEIGHT="221" WIDTH="1"><br></TD>
	</TR>
	
	<TR>
	<TD colspan="5"><IMG src="$cardimgdir/back_bot.gif" ALT="Back of Postcard" HEIGHT="21" WIDTH="197"></TD>
	</TR>
	</TABLE>
</TD>
</TR>
</TABLE>
</td>
<td width="20" nowrap>&nbsp;</td>
</tr>

<TR>
<TD ALIGN=CENTER COLSPAN=5 VALIGN=TOP>
<FONT SIZE="2" FACE="arial, helvetica" color="#000000">
<B>An email notification has been sent to $toAddress. <BR>
This postcard will be deleted from the server after 3 weeks.</B>
</FONT>
</TD>
</TR>

<tr>
<td valign="top" colspan="2"><IMG SRC="$imgdir/corner3.gif" WIDTH="28" HEIGHT="25"></td>
<td valign="top" align="right"><IMG SRC="$imgdir/corner4.gif" WIDTH="28" HEIGHT="25"></td>
</tr>
</table>

EOF
}
# ----------------------- none -----------------------
else
{
	print <<EOF;
	<P>Access error: Action not defined.
EOF
}


# ----------------------- footer -----------------------
foreach $line (@footlines)
{
	print "$line\n";
}