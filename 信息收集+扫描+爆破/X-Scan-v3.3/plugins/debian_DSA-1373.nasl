# This script was automatically generated from the dsa-1373
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(26034);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "1373");
 script_cve_id("CVE-2007-1799");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1373 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that ktorrent, a BitTorrent client for KDE, was vulnerable
to a directory traversal bug which potentially allowed remote users to
overwrite arbitrary files.
For the old stable distribution (sarge), this package was not present.
For the stable distribution (etch), this problem has been fixed in version
2.0.3+dfsg1-2.2etch1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2007/dsa-1373');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your ktorrent package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1373] DSA-1373-2 ktorrent");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1373-2 ktorrent");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'ktorrent', release: '4.0', reference: '2.0.3+dfsg1-2.2etch1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
