# This script was automatically generated from the dsa-726
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(18513);
 script_version("$Revision: 1.7 $");
 script_xref(name: "DSA", value: "726");
 script_cve_id("CVE-2005-1121");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-726 security update');
 script_set_attribute(attribute: 'description', value:
'A format string vulnerability has been discovered in the MySQL/PgSQL
authentication module of Oops, a caching HTTP proxy server written
for performance.
For the stable distribution (woody) this problem has been fixed in
version 1.5.19.cvs.20010818-0.1woody1
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-726');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your oops package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA726] DSA-726-1 oops");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-726-1 oops");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'oops', release: '3.0', reference: '1.5.19.cvs.20010818-0.1woody1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
