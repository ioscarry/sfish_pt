
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-11484
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(36324);
 script_version ("$Revision: 1.1 $");
script_name(english: "Fedora 10 2008-11484: zoneminder");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-11484 (zoneminder)");
 script_set_attribute(attribute: "description", value: "ZoneMinder is a set of applications which is intended to provide a complete
solution allowing you to capture, analyse, record and monitor any cameras you
have attached to a Linux based machine. It is designed to run on kernels which
support the Video For Linux (V4L) interface and has been tested with cameras
attached to BTTV cards, various USB cameras and IP network cameras. It is
designed to support as many cameras as you can attach to your computer without
too much degradation of performance. This package includes cambozola.jar.

-
Update Information:

Fix permissions on /etc/zm.conf
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

script_summary(english: "Check for the version of the zoneminder package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"zoneminder-1.23.3-2.fc10", release:"FC10") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
