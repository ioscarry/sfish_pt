# This script was automatically generated from the dsa-1089
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22631);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1089");
 script_cve_id("CVE-2005-4744", "CVE-2006-1354");
 script_bugtraq_id(17171, 17293);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1089 security update');
 script_set_attribute(attribute: 'description', value:
'Several problems have been discovered in freeradius, a
high-performance and highly configurable RADIUS server.  The Common
Vulnerabilities and Exposures project identifies the following
problems:
CVE-2005-4744
    SuSE researchers have discovered several off-by-one errors may
    allow remote attackers to cause a denial of service and possibly
    execute arbitrary code.
CVE-2006-1354
    Due to insufficient input validation it is possible for a remote
    attacker to bypass authentication or cause a denial of service.
The old stable distribution (woody) does not contain this package.
For the stable distribution (sarge) this problem has been fixed in
version 1.0.2-4sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1089');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your freeradius package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1089] DSA-1089-1 freeradius");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1089-1 freeradius");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'freeradius', release: '3.1', reference: '1.0.2-4sarge1');
deb_check(prefix: 'freeradius-dialupadmin', release: '3.1', reference: '1.0.2-4sarge1');
deb_check(prefix: 'freeradius-iodbc', release: '3.1', reference: '1.0.2-4sarge1');
deb_check(prefix: 'freeradius-krb5', release: '3.1', reference: '1.0.2-4sarge1');
deb_check(prefix: 'freeradius-ldap', release: '3.1', reference: '1.0.2-4sarge1');
deb_check(prefix: 'freeradius-mysql', release: '3.1', reference: '1.0.2-4sarge1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
