#
# (C) Tenable Network Security, Inc.
#

# References:
# http://www.kamborio.com/?Section=Articles&Mode=select&ID=55
#
# From: "Mark Litchfield" <mark@ngssoftware.com>
# To: bugtraq@securityfocus.com, vulnwatch@vulnwatch.org,
#   vulndb@securityfocus.com
# Date: Tue, 24 Jun 2003 15:22:21 -0700
# Subject: Remote Buffer Overrun WebAdmin.exe
#

include( 'compat.inc' );

if(description)
{
  script_id(11771);
  script_version ("$Revision: 1.17 $");
  script_cve_id("CVE-2003-0471", "CVE-2003-1463");
  script_bugtraq_id(7438, 7439, 8024);
  script_xref(name:"OSVDB", value:"2207");
  script_xref(name:"OSVDB", value:"2653");
  script_xref(name:"OSVDB", value:"53493");

  script_name(english: "Alt-N WebAdmin Multiple Vulnerabilities");
  script_summary(english:"Checks for the presence of webadmin.dll");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote CGI is vulnerable to multiple flaws.'
  );

  script_set_attribute(
    attribute:'description',
    value:"webadmin.dll was found on your web server.
Old versions of this CGI suffered from numerous problems:
 - installation path disclosure
 - directory traversal, allowing anybody with
   administrative permission on WebAdmin to read any file
 - buffer overflow, allowing anybody to run arbitrary code on
   your server with SYSTEM privileges.

*** Note that no attack was performed, and the version number was
*** not checked, so this might be a false alert"
  );

  script_set_attribute(
    attribute:'solution',
    value: "Upgrade to Alt-N WebAdmin 2.0.5 or later."
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://marc.info/?l=bugtraq&m=105647081418155&w=2'
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://www.securityfocus.com/archive/1/319735'
  );


  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);

  script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
  script_family(english:"CGI abuses");
  script_dependencie("http_version.nasl", "find_service1.nasl", "no404.nasl");
  script_require_ports("Services/www", 80);
  script_require_keys("Settings/ParanoidReport");
  exit(0);
}

#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

if ( report_paranoia < 2 ) exit(0);

port = get_http_port(default:80);
res = is_cgi_installed3(port:port, item:"webadmin.dll");
if (res) security_hole(port);
