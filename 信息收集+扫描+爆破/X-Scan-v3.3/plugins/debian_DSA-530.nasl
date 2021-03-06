# This script was automatically generated from the dsa-530
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15367);
 script_version("$Revision: 1.11 $");
 script_xref(name: "DSA", value: "530");
 script_cve_id("CVE-2004-0649");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-530 security update');
 script_set_attribute(attribute: 'description', value:
'Thomas Walpuski reported a buffer overflow in l2tpd, an implementation
of the layer 2 tunneling protocol, whereby a remote attacker could
potentially cause arbitrary code to be executed by transmitting a
specially crafted packet.  The exploitability of this vulnerability
has not been verified.
For the current stable distribution (woody), this problem has been
fixed in version 0.67-1.2.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-530');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2004/dsa-530
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA530] DSA-530-1 l2tpd");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-530-1 l2tpd");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'l2tpd', release: '3.0', reference: '0.67-1.2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
