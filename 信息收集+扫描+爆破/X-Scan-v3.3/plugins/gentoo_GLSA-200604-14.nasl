# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200604-14.xml
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
 script_id(21279);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200604-14");
 script_cve_id("CVE-2006-1550");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200604-14 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200604-14
(Dia: Arbitrary code execution through XFig import)


    infamous41md discovered multiple buffer overflows in Dia\'s XFig
    file import plugin.
  
Impact

    By enticing a user to import a specially crafted XFig file into
    Dia, an attacker could exploit this issue to execute arbitrary code
    with the rights of the user running Dia.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Dia users should upgrade to the latest available version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-office/dia-0.94-r5"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-1550');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200604-14.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200604-14] Dia: Arbitrary code execution through XFig import');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Dia: Arbitrary code execution through XFig import');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-office/dia", unaffected: make_list("ge 0.94-r5"), vulnerable: make_list("lt 0.94-r5")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
