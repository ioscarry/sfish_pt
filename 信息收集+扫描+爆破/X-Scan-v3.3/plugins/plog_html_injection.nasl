#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(16207);
 script_version ("$Revision: 1.6 $");
 script_bugtraq_id(11082);
 script_xref(name:"OSVDB", value:"9437");

 script_name(english:"pLog register.php Multiple Parameter XSS"); 
 
 script_set_attribute(attribute:"synopsis", value:
"A remote CGI is vulnerable to cross site scripting." );
 script_set_attribute(attribute:"description", value:
"The remote host is running pLog, a blogging system written in PHP.

The remote version of this software does not perform a proper validation
of user-supplied input, and is therefore vulnerable to a cross-site 
scripting attack.

To exploit this flaw, an attacker would need to use the script 
'register.php' to register a user profile containing HTML and script 
code as his name or blog.

Regular users of the remote website would then display the HTML and/or
script code in their browser when visiting the page 'summary.php'." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to pLog 0.3.3 or newer" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );

script_end_attributes();

 script_summary(english:"Checks for the presence of pLog");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses : XSS");
 script_dependencie("http_version.nasl", "webmirror.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

       
foreach dir ( cgi_dirs() )
{
 u = strcat(dir, "/index.php");
 r = http_send_recv3(method: "GET", port: port, item: u);
 if (isnull(r)) exit(0);

 if (  '<meta name="generator" content="PLOG_0_' >< r[2] )
 {
  if ( egrep(pattern:'<meta name="generator" content="PLOG_0_([0-2]|3_[0-2][^0-9])', string: r[2]) )
  {
	security_warning ( port );
	set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
  }
 }
}
       
