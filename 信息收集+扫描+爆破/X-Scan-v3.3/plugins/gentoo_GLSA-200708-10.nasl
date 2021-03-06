# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200708-10.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(25916);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200708-10");
 script_cve_id("CVE-2007-3780", "CVE-2007-3781");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200708-10 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200708-10
(MySQL: Denial of Service and information leakage)


    Dormando reported a vulnerability within the handling of password
    packets in the connection protocol (CVE-2007-3780). Andrei Elkin also
    found that the "CREATE TABLE LIKE" command didn\'t require SELECT
    privileges on the source table (CVE-2007-3781).
  
Impact

    A remote unauthenticated attacker could use the first vulnerability to
    make the server crash. The second vulnerability can be used by
    authenticated users to obtain information on tables they are not
    normally able to access.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All MySQL users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-db/mysql-5.0.44"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-3780');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-3781');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200708-10.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200708-10] MySQL: Denial of Service and information leakage');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'MySQL: Denial of Service and information leakage');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-db/mysql", unaffected: make_list("ge 5.0.44"), vulnerable: make_list("lt 5.0.44")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
