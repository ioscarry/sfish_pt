
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2007-525
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(25448);
 script_version ("$Revision: 1.4 $");
script_name(english: "Fedora 6 2007-525: quagga");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2007-525 (quagga)");
 script_set_attribute(attribute: "description", value: "Quagga is a free software that manages TCP/IP based routing
protocol. It takes multi-server and multi-thread approach to resolve
the current complexity of the Internet.

Quagga supports BGP4, BGP4+, OSPFv2, OSPFv3, RIPv1, RIPv2, and RIPng.

Quagga is intended to be used as a Route Server and a Route Reflector. It is
not a toolkit, it provides full routing power under a new architecture.
Quagga by design has a process for each protocol.

Quagga is a fork of GNU Zebra.

Update Information:

This update contains rebase to quagga-0.99.7 along with fix
for CVE-2007-1995.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:S/C:N/I:N/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-1995");
script_summary(english: "Check for the version of the quagga package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"quagga-0.99.7-1.fc6", release:"FC6") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
