#!/usr/bin/perl

use CGI qw/:standard/;

$head = "/home/content/05/10587905/html/includes/head.html";
$foot = "/home/content/05/10587905/html/includes/foot.html";
$messages = "/home/content/05/10587905/html/includes/messages.txt";
$imgdir = "/images";
$cardimgdir = "/webcards/images";

# get html passed-in variables
$query = new CGI;
$id = $query->param('id');

# read header
open(SPFILE, "$head") || die("Can't open file $!");
@lines = <SPFILE>;
close(SPFILE);
# read messages file
open(SPFILE, "$messages") || die("Can't open file $!");
@msglines = <SPFILE>;
close(SPFILE);
# read footer
open(SPFILE, "$foot") || die("Can't open file $!");
@footlines = <SPFILE>;
close(SPFILE);

print header;

# ----------------------- header -----------------------
foreach $line (@lines)
{
	print "$line\n";
}

# ----------------------- SHOW POSTCARD -----------------------
if ($id ne "")
{
# extract postcard info from array
foreach $line (@msglines)
{
	if ( $line =~ /$id/ )
	{
		@pairs = split(/\t/, $line);
#0$id|1$toName|2$toAddress|3$fromName|4$fromAddress|5$message|6$postdate|7$showdate|8$pic
	}
}

$s = CGI::escape(@pairs[3]);
$se = CGI::escape(@pairs[4]);
$r = CGI::escape(@pairs[1]);
$re = CGI::escape(@pairs[2]);
print <<EOF;
<br>
<IMG SRC="$imgdir/titl_getpost.gif" WIDTH="366" HEIGHT="28" ALT="Get Your HelpDavey.com Web Postcards">

<P>
<a HREF="/cgi/postcards.pl?action=picker&pic=@pairs[8]&s=$s&se=$se&r=$r&re=$re"><img src="$cardimgdir/reply_button.gif" width="144" height="19" border="0"></a>

<a HREF="/postcard.shtml"><img src="$cardimgdir/send_button.gif" width="144" height="19" border="0"></a>

    <br>
    <br>
    <table width="418" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><font size="1" face="arial, helvetica">You have just received a HelpDavey.com web postcard. If you would like to send a postcard yourself, click SEND CARD. To reply to your sender, click REPLY.</font></td>
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
<IMG SRC="$cardimgdir/@pairs[8]" ALT="Front of Postcard" HEIGHT="300" WIDTH="200">	
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
	@pairs[7]</p>
	To: @pairs[1]<br>
	From: @pairs[3]<hr noshade size="1" width="85%">
	@pairs[5]</TD>
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