
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2007-427
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(25030);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 5 2007-427: libX11");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2007-427 (libX11)");
 script_set_attribute(attribute: "description", value: "X.Org X11 libX11 runtime library



Update information :

* Fri Apr  6 2007 Adam Jackson <ajax redhat com> 1.0.0-4
- libX11-cve-2007-1667.patch: Fix CVE 2007-1667
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

script_summary(english: "Check for the version of the libX11 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"libX11-1.0.0-4.fc5", release:"FC5") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
