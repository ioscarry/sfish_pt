# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200711-10.xml
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
 script_id(27827);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200711-10");
 script_cve_id("CVE-2007-5197");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200711-10 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200711-10
(Mono: Buffer overflow)


    IOActive discovered an error in the Mono.Math.BigInteger class, in the
    reduction step of the Montgomery-based Pow methods, that could lead to
    a buffer overflow.
  
Impact

    A remote attacker could exploit this vulnerability by sending specially
    crafted data to Mono applications using the BigInteger class, which
    might lead to the execution of arbitrary code with the privileges of
    the user running the application (possibly root) or a Denial of
    Service.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Mono users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-lang/mono-1.2.5.1-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-5197');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200711-10.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200711-10] Mono: Buffer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Mono: Buffer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-lang/mono", unaffected: make_list("ge 1.2.5.1-r1"), vulnerable: make_list("lt 1.2.5.1-r1")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
