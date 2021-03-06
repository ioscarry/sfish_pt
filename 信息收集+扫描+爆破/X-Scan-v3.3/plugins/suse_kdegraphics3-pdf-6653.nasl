
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42816);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  Security update for kdegraphics3-pdf (kdegraphics3-pdf-6653)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch kdegraphics3-pdf-6653");
 script_set_attribute(attribute: "description", value: "Specially crafted PDF files could cause buffer overflows in
the pdftops filter when printing such a document.
CVE-2009-3608: CVSS v2 Base Score: 9.3 CVE-2009-3609: CVSS
v2 Base Score: 4.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch kdegraphics3-pdf-6653");
script_end_attributes();

script_cve_id("CVE-2009-3608", "CVE-2009-3609");
script_summary(english: "Check for the kdegraphics3-pdf-6653 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"kdegraphics3-pdf-3.5.1-23.26.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
