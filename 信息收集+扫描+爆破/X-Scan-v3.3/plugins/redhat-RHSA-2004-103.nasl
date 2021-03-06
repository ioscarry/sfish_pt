
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(12476);
 script_version ("$Revision: 1.8 $");
 script_name(english: "RHSA-2004-103: gdk");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2004-103");
 script_set_attribute(attribute: "description", value: '
  Updated gdk-pixbuf packages that fix a crash are now available.

  The gdk-pixbuf package contains an image loading library used with the
  GNOME GUI desktop environment.

  Thomas Kristensen discovered a bitmap file that would cause versions of
  gdk-pixbuf prior to 0.20 to crash. To exploit this flaw, an attacker would
  need to get a victim to open a carefully-crafted BMP file in an application
  that used gdk-pixbuf. The Common Vulnerabilities and Exposures project
  (cve.mitre.org) has assigned the name CAN-2004-0111 to this issue.

  Users are advised to upgrade to these updated packages containing
  gdk-pixbuf version 0.22, which is not vulnerable to this issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2004-103.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2004-0111");
script_summary(english: "Check for the version of the gdk packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"gdk-pixbuf-0.22.0-6.0.3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gdk-pixbuf-devel-0.22.0-6.0.3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gdk-pixbuf-gnome-0.22.0-6.0.3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gdk-pixbuf-0.22.0-6.1.1", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gdk-pixbuf-devel-0.22.0-6.1.1", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"gdk-pixbuf-gnome-0.22.0-6.1.1", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
