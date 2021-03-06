
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(39943);
 script_version("$Revision: 1.4 $");
 script_name(english: "SuSE 11.0 Security Update:  cups (2008-12-03)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for cups");
 script_set_attribute(attribute: "description", value: "Previous updates for the PNG and HPGL filters were
incomplete and are corrected now. Also cups used a guest
user account for RSS subscriptions which made it eeasier
for attackers to conduct CSRF attacks. (CVE-2008-3641,
CVE-2008-5184, CVE-2008-5286)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for cups");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=448631");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=430543");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=446975");
script_end_attributes();

 script_cve_id("CVE-2008-3641", "CVE-2008-5184", "CVE-2008-5286");
script_summary(english: "Check for the cups package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"cups-1.3.7-25.6", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-1.3.7-25.6", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-client-1.3.7-25.6", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-client-1.3.7-25.6", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-devel-1.3.7-25.6", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-devel-1.3.7-25.6", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-libs-1.3.7-25.6", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-libs-1.3.7-25.6", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"cups-libs-32bit-1.3.7-25.6", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
