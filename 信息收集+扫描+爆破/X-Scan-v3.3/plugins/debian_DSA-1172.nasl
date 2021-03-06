# This script was automatically generated from the dsa-1172
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22714);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1172");
 script_cve_id("CVE-2006-4095", "CVE-2006-4096");
 script_xref(name: "CERT", value: "697164");
 script_xref(name: "CERT", value: "915404");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1172 security update');
 script_set_attribute(attribute: 'description', value:
'Two vulnerabilities have been discovered in BIND9, the Berkeley
Internet Name Domain server.  The first relates to SIG query
processing and the second relates to a condition that can trigger an
INSIST failure, both lead to a denial of service.
For the stable distribution (sarge) these problems have been fixed in
version 9.2.4-1sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1172');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your bind9 package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1172] DSA-1172-1 bind9");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1172-1 bind9");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'bind9', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'bind9-doc', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'bind9-host', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'dnsutils', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'libbind-dev', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'libdns16', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'libisc7', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'libisccc0', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'libisccfg0', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'liblwres1', release: '3.1', reference: '9.2.4-1sarge1');
deb_check(prefix: 'lwresd', release: '3.1', reference: '9.2.4-1sarge1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
