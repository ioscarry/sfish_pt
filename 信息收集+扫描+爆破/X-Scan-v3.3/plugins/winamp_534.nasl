#
#  (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(25770);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2007-1921", "CVE-2007-1922");
  script_bugtraq_id(23350, 23351);
  script_xref(name:"OSVDB", value:"34430");
  script_xref(name:"OSVDB", value:"34431");
  script_xref(name:"OSVDB", value:"34432");

  script_name(english:"Winamp < 5.34 Multiple Vulnerabilities");
  script_summary(english:"Checks the version number of Winamp"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host contains a multimedia application that is
affected by multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is using Winamp, a popular media player for Windows. 

The version of Winamp installed on the remote Windows host reportedly
contains a flaw in its 'libsndfile.dll' library that may allow an
attacker to corrupt memory using a specially-crafted Matlab (.MAT)
sound file and execute arbitrary code subject to the privileges of the
user. 

In addition, it may also be affected by similar issues in its optional
Module Decoder (in_mod.dll) plugin involving malicious .IT and .S3M
files." );
 script_set_attribute(attribute:"see_also", value:"http://www.piotrbania.com/all/adv/nullsoft-winamp-libsndfile-adv.txt" );
 script_set_attribute(attribute:"see_also", value:"http://www.piotrbania.com/all/adv/nullsoft-winamp-s3m_module-in_mod-adv.txt" );
 script_set_attribute(attribute:"see_also", value:"http://www.piotrbania.com/all/adv/nullsoft-winamp-it_module-in_mod-adv.txt" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/464889/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/464890/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/464893/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://forums.winamp.com/showthread.php?threadid=269831" );
 script_set_attribute(attribute:"see_also", value:"http://www.winamp.com/player/version-history" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Winamp version 5.34 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );

script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");
  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");
  script_dependencies("winamp_in_cdda_buffer_overflow.nasl");
  script_require_keys("SMB/Winamp/Version");
  exit(0);
}

# Check version of Winamp.

#
# nb: the KB item is based on GetFileVersion, which may differ
#     from what the client reports.

ver = get_kb_item("SMB/Winamp/Version");
if (ver && ver =~ "^([0-4]\.|5\.([0-2]\.|3\.[0-3]\.))") 
  security_hole(get_kb_item("SMB/transport"));
