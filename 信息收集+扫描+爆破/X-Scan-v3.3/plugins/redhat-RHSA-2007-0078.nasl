
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(24774);
 script_version ("$Revision: 1.5 $");
 script_name(english: "RHSA-2007-0078: thunderbird");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-0078");
 script_set_attribute(attribute: "description", value: '
  Updated thunderbird packages that fix several security bugs are now
  available for Red Hat Enterprise Linux 4.

  This update has been rated as having critical security impact by the Red
  Hat Security Response Team.

  [Updated 06 March 2007]
  Updated text description to add CVE-2007-1282 and remove CVE-2007-0994,
  which was mistakenly listed as affecting Thunderbird. No changes have been
  made to these erratum packages.

  Mozilla Thunderbird is a standalone mail and newsgroup client.

  Several flaws were found in the way Thunderbird processed certain malformed
  JavaScript code. A malicious HTML mail message could execute JavaScript
  code in such a way that may result in Thunderbird crashing or executing
  arbitrary code as the user running Thunderbird. JavaScript support is
  disabled by default in Thunderbird; these issues are not exploitable unless
  the user has enabled JavaScript. (CVE-2007-0775, CVE-2007-0777,
  CVE-2007-1092)

  A flaw was found in the way Thunderbird processed text/enhanced and
  text/richtext formatted mail message. A specially crafted mail message
  could execute arbitrary code with the privileges of the user running
  Thunderbird. (CVE-2007-1282)

  Several cross-site scripting (XSS) flaws were found in the way Thunderbird
  processed certain malformed HTML mail messages. A malicious HTML mail
  message could display misleading information which may result in a user
  unknowingly divulging sensitive information such as a password.
  (CVE-2006-6077, CVE-2007-0995, CVE-2007-0996)

  A flaw was found in the way Thunderbird cached web content on the local
  disk. A malicious HTML mail message may be able to inject arbitrary HTML
  into a browsing session if the user reloads a targeted site. (CVE-2007-0778)

  A flaw was found in the way Thunderbird displayed certain web content. A
  malicious HTML mail message could generate content which could overlay user
  interface elements such as the hostname and security indicators, tricking a
  user into thinking they are visiting a different site. (CVE-2007-0779)

  Two flaws were found in the way Thunderbird displayed blocked popup
  windows. If a user can be convinced to open a blocked popup, it is possible
  to read arbitrary local files, or conduct an XSS attack against the user.
  (CVE-2007-0780, CVE-2007-0800)

  Two buffer overflow flaws were found in the Network Security Services (NSS)
  code for processing the SSLv2 protocol. Connecting to a malicious secure
  web server could cause the execution of arbitrary code as the user running
  Thunderbird. (CVE-2007-0008, CVE-2007-0009)

  A flaw was found in the way Thunderbird handled the "location.hostname"
  value during certain browser domain checks. This flaw could allow a
  malicious HTML mail message to set domain cookies for an arbitrary site, or
  possibly perform an XSS attack. (CVE-2007-0981)

  Users of Thunderbird are advised to apply this update, which contains
  Thunderbird version 1.5.0.10 that corrects these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-0078.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2006-6077", "CVE-2007-0008", "CVE-2007-0009", "CVE-2007-0775", "CVE-2007-0777", "CVE-2007-0778", "CVE-2007-0779", "CVE-2007-0780", "CVE-2007-0800", "CVE-2007-0981", "CVE-2007-0995", "CVE-2007-0996", "CVE-2007-1092", "CVE-2007-1282");
script_summary(english: "Check for the version of the thunderbird packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"thunderbird-1.5.0.10-0.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
