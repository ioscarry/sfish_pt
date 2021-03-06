# This script was automatically generated from the dsa-371
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15208);
 script_version("$Revision: 1.11 $");
 script_xref(name: "DSA", value: "371");
 script_cve_id("CVE-2003-0615");
 script_bugtraq_id(8231);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-371 security update');
 script_set_attribute(attribute: 'description', value:
'A cross-site scripting vulnerability exists in the start_form()
function in CGI.pm.  This function outputs user-controlled data into
the action attribute of a form element without sanitizing it, allowing
a remote user to execute arbitrary web script within the context of
the generated page.  Any program which uses this function in the
CGI.pm module may be affected.
For the current stable distribution (woody) this problem has been fixed
in version 5.6.1-8.3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2003/dsa-371');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2003/dsa-371
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA371] DSA-371-1 perl");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-371-1 perl");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libcgi-fast-perl', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'libperl-dev', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'libperl5.6', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'perl', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'perl-base', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'perl-debug', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'perl-doc', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'perl-modules', release: '3.0', reference: '5.6.1-8.3');
deb_check(prefix: 'perl-suid', release: '3.0', reference: '5.6.1-8.3');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
