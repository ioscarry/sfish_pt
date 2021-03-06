
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-0984
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(30233);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 8 2008-0984: kernel");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-0984 (kernel)");
 script_set_attribute(attribute: "description", value: "The kernel package contains the Linux kernel (vmlinuz), the core of any
Linux operating system.  The kernel handles the basic functions
of the operating system: memory allocation, process allocation, device
input and output, etc.

-
Update Information:

Update to Linux kernel 2.6.23.14:
[9]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23.10
[10]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23.11
[11]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23.12
[12]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23.13
[13]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.23.14
CVE-2008-0001:  VFS in the Linux kernel before 2.6.22.16, and 2.6.23.x before
2.6.23.14, performs tests of access mode by using the flag variable instead of
the acc_mode variable, which might allow local users to bypass intended
permissions and remove directories.    Plus:  Major wireless driver updates.
Restored the /proc/slabinfo file.  Radeon R500 2D DRM support.  Enable the USB
IO-Warrior driver.  Additional bug fixes for the listed Bugzilla entries.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-5938", "CVE-2008-0001");
script_summary(english: "Check for the version of the kernel package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"kernel-2.6.23.14-115.fc8", prefix:"kernel-", release:"FC8") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
