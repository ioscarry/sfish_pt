#
# (C) Tenable Network Security, Inc.
#


if (!defined_func("bn_random")) exit(0);
if ( NASL_LEVEL < 3004 ) exit(0);



include("compat.inc");

if (description)
{
  script_id(33281);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2005-3164", "CVE-2007-1355", "CVE-2007-2449", "CVE-2007-2450", "CVE-2007-3382",
                "CVE-2007-3383", "CVE-2007-3385", "CVE-2007-5333", "CVE-2007-5461", "CVE-2007-6276",
                "CVE-2008-0960", "CVE-2008-1105", "CVE-2008-1145", "CVE-2008-2307", "CVE-2008-2308",
                "CVE-2008-2309", "CVE-2008-2310", "CVE-2008-2311", "CVE-2008-2313", "CVE-2008-2314",
                "CVE-2008-2662", "CVE-2008-2663", "CVE-2008-2664", "CVE-2008-2725", "CVE-2008-2726");
  script_bugtraq_id(15003, 24058, 24475, 24476, 24999, 25316, 26070, 26699, 27706,
                    28123, 29404, 29623, 29836, 30018);
  script_xref(name:"OSVDB", value:"19821");
  script_xref(name:"OSVDB", value:"34875");
  script_xref(name:"OSVDB", value:"36079");
  script_xref(name:"OSVDB", value:"36080");
  script_xref(name:"OSVDB", value:"37070");
  script_xref(name:"OSVDB", value:"37071");
  script_xref(name:"OSVDB", value:"38187");
  script_xref(name:"OSVDB", value:"39000");
  script_xref(name:"OSVDB", value:"40278");
  script_xref(name:"OSVDB", value:"41435");
  script_xref(name:"OSVDB", value:"45657");
  script_xref(name:"OSVDB", value:"46059");
  script_xref(name:"OSVDB", value:"46502");
  script_xref(name:"OSVDB", value:"46663");
  script_xref(name:"OSVDB", value:"46664");
  script_xref(name:"OSVDB", value:"46665");
  script_xref(name:"OSVDB", value:"46666");
  script_xref(name:"OSVDB", value:"46667");
  script_xref(name:"OSVDB", value:"46668");
  script_xref(name:"OSVDB", value:"46669");
  script_xref(name:"Secunia", value:"30802");

  script_name(english:"Mac OS X < 10.5.4 Multiple Vulnerabilities");
  script_summary(english:"Check the version of Mac OS X");

 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a Mac OS X update that fixes various
security issues." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of Mac OS X 10.5 that is older
than version 10.5.4. 

Mac OS X 10.5.4 contains security fixes for a number of programs." );
 script_set_attribute(attribute:"see_also", value:"http://support.apple.com/kb/HT2163" );
 script_set_attribute(attribute:"see_also", value:"http://lists.apple.com/archives/security-announce/2008/jun/msg00002.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Mac OS X 10.5.4 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"MacOS X Local Security Checks");
  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");
  script_dependencies("ssh_get_info.nasl", "os_fingerprint.nasl");
  exit(0);
}


os = get_kb_item("Host/MacOSX/Version");
if (!os) os = get_kb_item("Host/OS");
if (!os) exit(0);

if (ereg(pattern:"Mac OS X 10\.5\.[0-3]([^0-9]|$)", string:os)) security_hole(0);
