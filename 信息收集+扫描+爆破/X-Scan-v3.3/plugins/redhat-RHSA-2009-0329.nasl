
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(38870);
 script_version ("$Revision: 1.2 $");
 script_name(english: "RHSA-2009-0329: freetype");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2009-0329");
 script_set_attribute(attribute: "description", value: '
  Updated freetype packages that fix various security issues are now
  available for Red Hat Enterprise Linux 3 and 4.

  This update has been rated as having important security impact by the Red
  Hat Security Response Team.

  FreeType is a free, high-quality, portable font engine that can open and
  manage font files. It also loads, hints, and renders individual glyphs
  efficiently. These packages provide both the FreeType 1 and FreeType 2
  font engines.

  Tavis Ormandy of the Google Security Team discovered several integer
  overflow flaws in the FreeType 2 font engine. If a user loaded a
  carefully-crafted font file with an application linked against FreeType 2,
  it could cause the application to crash or, possibly, execute arbitrary
  code with the privileges of the user running the application.
  (CVE-2009-0946)

  Chris Evans discovered multiple integer overflow flaws in the FreeType font
  engine. If a user loaded a carefully-crafted font file with an application
  linked against FreeType, it could cause the application to crash or,
  possibly, execute arbitrary code with the privileges of the user running
  the application. (CVE-2006-1861)

  An integer overflow flaw was found in the way the FreeType font engine
  processed TrueType® Font (TTF) files. If a user loaded a carefully-crafted
  font file with an application linked against FreeType, it could cause the
  application to crash or, possibly, execute arbitrary code with the
  privileges of the user running the application. (CVE-2007-2754)

  A flaw was discovered in the FreeType TTF font-file format parser when the
  TrueType virtual machine Byte Code Interpreter (BCI) is enabled. If a user
  loaded a carefully-crafted font file with an application linked against
  FreeType, it could cause the application to crash or, possibly, execute
  arbitrary code with the privileges of the user running the application.
  (CVE-2008-1808)

  The CVE-2008-1808 flaw did not affect the freetype packages as distributed
  in Red Hat Enterprise Linux 3 and 4, as they are not compiled with TrueType
  BCI support. A fix for this flaw has been included in this update as users
  may choose to recompile the freetype packages in order to enable TrueType
  BCI support. Red Hat does not, however, provide support for modified and
  recompiled packages.

  Note: For the FreeType 2 font engine, the CVE-2006-1861, CVE-2007-2754,
  and CVE-2008-1808 flaws were addressed via RHSA-2006:0500, RHSA-2007:0403,
  and RHSA-2008:0556 respectively. This update provides corresponding
  updates for the FreeType 1 font engine, included in the freetype packages
  distributed in Red Hat Enterprise Linux 3 and 4.

  Users are advised to upgrade to these updated packages, which contain
  backported patches to correct these issues. The X server must be restarted
  (log out, then log back in) for this update to take effect.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2009-0329.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2006-1861", "CVE-2007-2754", "CVE-2008-1808", "CVE-2009-0946");
script_summary(english: "Check for the version of the freetype packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"freetype-2.1.4-12.el3", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-devel-2.1.4-12.el3", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-2.1.9-10.el4.7", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-demos-2.1.9-10.el4.7", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-devel-2.1.9-10.el4.7", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-utils-2.1.9-10.el4.7", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-2.1.9-10.el4.7", release:'RHEL4.8.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-demos-2.1.9-10.el4.7", release:'RHEL4.8.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-devel-2.1.9-10.el4.7", release:'RHEL4.8.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"freetype-utils-2.1.9-10.el4.7", release:'RHEL4.8.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
