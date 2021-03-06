#
# (C) Tenable Network Security, Inc.
#

# Note: this script is not very useful because mldonkey only allows
# connections from localhost by default

include("compat.inc");

if(description)
{
  script_id(11125);
  script_version ("$Revision: 1.10 $");
 
  script_name(english:"mldonkey Detection (WWW)");
  script_summary(english:"Detect mldonkey www interface");
 
  script_set_attribute(
    attribute:"synopsis",
    value:"A peer-to-peer application is running on the remote host."
  );
  script_set_attribute(
    attribute:"description",
    value:string(
      "The mldonkey web interface appears to be running on the remote host.\n",
      "mldonkey is a peer-to-peer filesharing application.  This application\n",
      "could be used to share copyright infringing material.  It could also\n",
      "result in the inadvertent disclosure of confidential information."
    )
  );
  script_set_attribute(
    attribute:"see_also",
    value:"http://mldonkey.sourceforge.net/"
  );
  script_set_attribute(
    attribute:"solution",
    value:string(
      "Make sure the use of this program is in accordance with your\n",
      "corporate security policy."
    )
  );
  script_set_attribute(
    attribute:"risk_factor",
    value:"None"
  );
  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Peer-To-Peer File Sharing");

  script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");

  script_dependencie("find_service1.nasl", "http_version.nasl");
  script_require_ports("Services/www", 4080);
  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


ports = add_port_in_list(list:get_kb_list("Services/www"), port:4080);

foreach port (ports)
{
 banner = get_http_banner(port: port);
 if (banner && ("MLdonkey" >< banner)) security_note(port);
}
