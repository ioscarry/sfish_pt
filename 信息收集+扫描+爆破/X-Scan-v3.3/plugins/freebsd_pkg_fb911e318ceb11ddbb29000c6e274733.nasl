#
# (C) Tenable Network Security, Inc.
#
# This script contains information extracted from VuXML :
#
# Copyright 2003-2006 Jacques Vidrine and contributors
#
# Redistribution and use in source (VuXML) and 'compiled' forms (SGML,
# HTML, PDF, PostScript, RTF and so forth) with or without modification,
# are permitted provided that the following conditions are met:
# 1. Redistributions of source code (VuXML) must retain the above
#   copyright notice, this list of conditions and the following
#   disclaimer as the first lines of this file unmodified.
# 2. Redistributions in compiled form (transformed to other DTDs,
#   published online in any format, converted to PDF, PostScript,
#   RTF and other formats) must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer
#   in the documentation and/or other materials provided with the
#   distribution.
#
# THIS DOCUMENTATION IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
# OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS DOCUMENTATION,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
#

include('compat.inc');

if ( description )
{
 script_id(34310);
 script_version("$Revision: 1.9 $");
 script_bugtraq_id(31434);

 script_name(english:"FreeBSD : lighttpd -- multiple vulnerabilities (2501)");

script_set_attribute(attribute:'synopsis', value: 'The remote host is missing a security update');
script_set_attribute(attribute:'description', value:'The following package needs to be updated: lighttpd');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:N/A:N');
script_set_attribute(attribute:'solution', value: 'Update the package on the remote host');
script_set_attribute(attribute: 'see_also', value: 'http://bugzilla.mozilla.org/show_bug.cgi?id=251381
http://dl.sourceforge.net/sourceforge/libpng/ADVISORY.txt
http://drupal.org/files/sa-2005-008/advisory.txt
http://secunia.com/advisories/12219
http://secunia.com/advisories/12232
http://www.lighttpd.net/security/lighttpd_sa_2008_05.txt
http://www.lighttpd.net/security/lighttpd_sa_2008_06.txt
http://www.lighttpd.net/security/lighttpd_sa_2008_07.txt
http://www.mozilla.org/projects/security/known-vulnerabilities.html#seamonkey1.0.3
http://www.mozilla.org/security/announce/2006/mfsa2006-09.html
http://www.mozilla.org/security/announce/2006/mfsa2006-10.html
http://www.mozilla.org/security/announce/2006/mfsa2006-11.html
http://www.mozilla.org/security/announce/2006/mfsa2006-12.html
http://www.mozilla.org/security/announce/2006/mfsa2006-13.html
http://www.mozilla.org/security/announce/2006/mfsa2006-44.html
http://www.mozilla.org/security/announce/2008/mfsa2008-47.html
http://www.mozilla.org/security/announce/2008/mfsa2008-48.html
http://www.osvdb.org/8315
http://www.osvdb.org/8316');
script_set_attribute(attribute:'see_also', value: 'http://www.FreeBSD.org/ports/portaudit/fb911e31-8ceb-11dd-bb29-000c6e274733.html');

 script_end_attributes();
 script_cve_id("CVE-2008-4298", "CVE-2008-4359", "CVE-2008-4360");
 script_summary(english:"Check for lighttpd");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 family["english"] = "FreeBSD Local Security Checks";
 script_family(english:family["english"]);
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/FreeBSD/pkg_info");
 exit(0);
}
global_var cvss_score;
cvss_score=7;
include('freebsd_package.inc');


holes_nb += pkg_test(pkg:"lighttpd<1.4.19_3");

if (holes_nb == 0) exit(0,"Host is not affected");
