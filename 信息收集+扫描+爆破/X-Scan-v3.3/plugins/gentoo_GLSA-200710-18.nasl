# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200710-18.xml
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
 script_id(27516);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200710-18");
 script_cve_id("CVE-2007-5191");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200710-18 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200710-18
(util-linux: Local privilege escalation)


    Ludwig Nussel discovered that the check_special_mountprog() and
    check_special_umountprog() functions call setuid() and setgid() in the
    wrong order and do not check the return values, which can lead to
    privileges being dropped improperly.
  
Impact

    A local attacker may be able to exploit this vulnerability by using
    mount helpers such as the mount.nfs program to gain root privileges and
    run arbitrary commands.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All util-linux users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=sys-apps/util-linux-2.12r-r8"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:M/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-5191');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200710-18.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200710-18] util-linux: Local privilege escalation');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'util-linux: Local privilege escalation');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "sys-apps/util-linux", unaffected: make_list("ge 2.12r-r8"), vulnerable: make_list("lt 2.12r-r8")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
