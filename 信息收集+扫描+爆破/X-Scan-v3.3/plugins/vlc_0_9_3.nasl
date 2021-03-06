#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(34400);
  script_version("$Revision: 1.3 $");

  script_bugtraq_id(31758);
  script_xref(name:"OSVDB", value:"49112");
  script_cve_id("CVE-2008-4558");

  script_name(english:"VLC Media Player < 0.9.3 XSPF Playlist Handling Memory Corruption");
  script_summary(english:"Checks version of VLC");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host contains an application that is affected by a
memory corruption vulnerability." );
 script_set_attribute(attribute:"description", value:
"The version of VLC media player installed on the remote host is
earlier than 0.9.3.  Such versions do not properly bounds-check an
identifier tag in XSPF files in the 'demux/playlist/xspf.c' library
before using it to index into an array on the heap.  By tricking a
user into opening a malicious XSPF file, it may be possible to execute
arbitrary code within the context of the affected application." );
 script_set_attribute(attribute:"see_also", value:"http://www.coresecurity.com/content/vlc-xspf-memory-corruption" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2008-10/0267.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?eb7b1baf" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to VLC Media Player version 0.9.4 or later (there are no
official binaries for Windows of version 0.9.3)." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("vlc_installed.nasl");
  script_require_keys("SMB/VLC/Version");

  exit(0);
}

include("global_settings.inc");

ver = get_kb_item("SMB/VLC/Version");
if (ver && tolower(ver) =~ "^0\.([0-8]\.|9\.[0-2]($|[^0-9]))")
{
  if (report_verbosity)
  {
    report = string(
      "\n",
      "VLC Media Player version ", ver, " is currently installed on the remote host.\n"
    );
    security_hole(port:get_kb_item("SMB/transport"), extra:report);
  }
  else security_hole(get_kb_item("SMB/transport"));
}
