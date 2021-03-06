
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-0154
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(35391);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 8 2009-0154: xterm");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-0154 (xterm)");
 script_set_attribute(attribute: "description", value: "The xterm program is a terminal emulator for the X Window System. It
provides DEC VT102 and Tektronix 4014 compatible terminals for
programs that can't use the window system directly.

-
Update Information:

This update fixes the following security issue:    CRLF injection vulnerability
in xterm allows user-assisted attackers to execute arbitrary commands via LF
(aka \n) characters surrounding a command name within a Device Control Request
Status String (DECRQSS) escape sequence in a text file, a related issue to
CVE-2003-0063 and CVE-2003-0071.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2003-0071", "CVE-2008-2383");
script_summary(english: "Check for the version of the xterm package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"xterm-238-1.fc8", release:"FC8") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
