
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(13891);
 script_version ("$Revision: 1.5 $");
 script_name(english: "MDKSA-2001:076: xinetd");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2001:076 (xinetd).");
 script_set_attribute(attribute: "description", value: "An audit has been performed on the xinetd 2.3.0 source code by Solar
Designer for many different possible vulnerabilities. The 2.3.1
release incorporated his patches into the xinetd source tree. The
audit was very thorough and found and fixed many problems. This xinetd
update includes his audit patch.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2001:076");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the xinetd package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"xinetd-2.3.0-5.2mdk", release:"MDK7.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xinetd-2.3.0-5.1mdk", release:"MDK8.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xinetd-ipv6-2.3.0-5.1mdk", release:"MDK8.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
