
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42324);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  neon security update (libneon-devel-6550)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libneon-devel-6550");
 script_set_attribute(attribute: "description", value: "neon did not properly handle embedded NUL characters in
X.509 certificates when comparing host names. Attackers
could exploit that to spoof SSL servers (CVE-2009-2408).

Specially crafted XML documents that contain a large number
of nested entity references could cause neon to consume
large amounts of CPU and memory (CVE-2009-2473).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch libneon-devel-6550");
script_end_attributes();

script_cve_id("CVE-2009-2408", "CVE-2009-2473");
script_summary(english: "Check for the libneon-devel-6550 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"neon-0.26.4-17.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"neon-32bit-0.26.4-17.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"neon-64bit-0.26.4-17.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"neon-devel-0.26.4-17.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
