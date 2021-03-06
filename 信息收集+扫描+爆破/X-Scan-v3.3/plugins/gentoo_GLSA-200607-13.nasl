# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200607-13.xml
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
 script_id(22142);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200607-13");
 script_cve_id("CVE-2006-3581", "CVE-2006-3582");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200607-13 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200607-13
(Audacious: Multiple heap and buffer overflows)


    Luigi Auriemma has found that the adplug library fails to verify the
    size of the destination buffers in the unpacking instructions,
    resulting in various possible heap and buffer overflows.
  
Impact

    An attacker can entice a user to load a specially crafted media file,
    resulting in a crash or possible execution of arbitrary code.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Audacious users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-sound/audacious-1.1.0"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://www.securityfocus.com/archive/1/439432/30/0/threaded');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3581');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3582');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200607-13.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200607-13] Audacious: Multiple heap and buffer overflows');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Audacious: Multiple heap and buffer overflows');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-sound/audacious", unaffected: make_list("ge 1.1.0"), vulnerable: make_list("lt 1.1.0")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
