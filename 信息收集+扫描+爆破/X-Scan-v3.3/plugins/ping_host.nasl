#TRUSTED a1f9fb9a90131c7dfc7341b1846c8b1c04d06312de31ca97f24e1418d4cd643b8c3cd59e1a1f36bc1cd74060e153236123338382aec6d0bbed9c3ce3bebaefa2703721e733f9a112a76192219b0dc59fb44664a5bd45596693c7bf4c6a7fe5f187a2e972e68638adf3950af558bb5af286c1e8b5cb7e47a6c51cbf697989aeccef49a0a5990470555cf8eea8596e5d6f55e926a547711eae82a7392f543d66d07d73e966510d85fbbced94fa63ea75aad8bc38a03a94c55d9faba5142b6ba4addf869b5d630b0214d6ff163dac06c7772a0828a8f36dbf2db2c981364b5626bf94041f4f1b1e2b42b9e895f51fc1d4ce264035d6c52ae04375b36e71d88154bf7456d9e6faee0dc3e6bd7b0a9bde7dc0c9045445a35769870955aeb9904477dfa6ce49a1e8a7b70a571030253fda9e469c3e15bd7a2773fc82b5e2a7e6dc4429c713c1ba9099b381690c01f658c06a5725aae9feb57605015bb173817e51007abaa161aea5e5999308e80a6ac1f86489655c99740e2510fb366f866de8ae24475661a647af603a05da12b5c37e104808dc9657c19589e81ac788a790d8794909f54fe8ef36046e6f6ec3e160684d947dfeefd817938124a7c9099b0c927de47b3756705b21a6370991b723e8faee995493e19a14cf02d8be1504993cf8b26e82fe5290e1fbdfda0ced499cc7496f043d3c7b2e030e46f6ab2f83e92449ced769
#
# (C) Tenable Network Security, Inc.
#

#defportlist= "22;80;443";
defportlist= "built-in";
# Or try this one:
# defportlist= "113;139;445";

# MA 2005-05-01
# 'built-in' port list is defined in nasl_tcp_ping C function 
# (libnasl/nasl/nasl_packet_forgery.c). Currently it is 
# 139, 135, 445, 80, 22, 515, 23, 21, 6000, 1025, 25, 111, 1028, 9100, 
# 1029, 79, 497, 548, 5000, 1917
# The rest of the list is truncated on Nessus <= 2.2.4:
# 53, 161, 9001, 65535, 443, 113, 993, 8080

# H D Moore & Michel Arboi's Port list :
# if you want more reliable but slower results, use 'extended' as the port list
# 21, 22, 23, 25, 53, 79, 80, 110, 113, 135, 139, 143, 264, 389, 443, 445, 
# 993, 1454, 1723, 3389, 8080, 2869 (uPNP)

include("compat.inc");

if(description)
{
 script_id(10180);
 script_version ("1.79");

 script_name(english:"Ping the remote host");
 script_summary(english:"Pings the remote host");

 script_set_attribute(
  attribute:"synopsis",
  value:"The remote host is alive."
 );
 script_set_attribute(
  attribute:"description", 
  value:string(
   "This plugin determines if the remote host is alive using one or more\n",
   "ping types :\n",
   "\n",
   "  - An ARP ping, provided the host is on the local subnet\n",
   "    and Nessus is running over ethernet.\n",
   "\n",
   "  - An ICMP ping.\n",
   "\n",
   "  - A TCP ping, in which the plugin sends to the remote host \n",
   "    a packet with the flag SYN, and the host will reply with\n",
   "    a RST or a SYN/ACK. \n",
   "\n",
   "  - A UDP ping (DNS, RPC, NTP, etc)."
  )
 );
 script_set_attribute(attribute:"solution", value:"N/A");
 script_set_attribute(attribute:"risk_factor", value:"None");
 script_end_attributes();
 
 script_category(ACT_SCANNER);
 
 script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");
 script_family(english:"Port scanners");

 script_add_preference(name:"TCP ping destination port(s) :",
                       type:"entry", value:defportlist);
 if ( defined_func("inject_packet") )
  script_add_preference(name:"Do an ARP ping", 
                       type:"checkbox", value:"yes");

 script_add_preference(name:"Do a TCP ping", 
                      type:"checkbox", value:"yes");
 script_add_preference(name:"Do an ICMP ping", 
                      type:"checkbox", value:"yes");		      
 script_add_preference(name:"Number of retries (ICMP) :", 
 			type:"entry", value:"2");	
 script_add_preference(name:"Do an applicative UDP ping (DNS,RPC...)", 
                      type:"checkbox", value:"no");
			
 script_add_preference(name:"Make the dead hosts appear in the report",
 			type:"checkbox", value:"no");
			
 script_add_preference(name:"Log live hosts in the report",
		      type:"checkbox", value:"no");			

 script_add_preference(name:"Test the local Nessus host", type:"checkbox", value:"yes");			
 script_add_preference(name:"Fast network discovery", type:"checkbox", value:"no");			
 exit(0);
}

#
# The script code starts here
#
include("raw.inc");

global_var log_live, do_tcp, do_arp, do_icmp, do_udp, test, show_dead, did_arp;

tcp_opt = raw_string(
	0x02, 0x04, 0x05, 0xB4,	# Maximum segment size = 1460
	0x01,			# NOP
	0x01,			# NOP
	0x04, 0x02 );		# SACK permitted

# 
# Utilities
#


function mkipaddr()
{
 local_var ip;
 local_var str;

 ip = _FCT_ANON_ARGS[0];
 str = split(ip, sep:'.', keep:FALSE);
 return raw_string(int(str[0]), int(str[1]), int(str[2]), int(str[3])); 
}


function mk_icmp_pkt(id)
{
 if ( NASL_LEVEL < 4000 )
 { 
  if ( TARGET_IS_IPV6 ) return NULL;
   local_var ip,icmp;
   ip = forge_ip_packet(ip_v:4, ip_hl:5, ip_tos:0, ip_off:0,ip_len:20, ip_p:IPPROTO_ICMP, ip_id:id, ip_ttl:0x40,
		        ip_src:this_host());
   icmp = forge_icmp_packet(ip:ip, icmp_type:8, icmp_code:0, icmp_seq: 1, icmp_id:1);
   return make_list(icmp, string("ip and src host ", get_host_ip()));
 }
 else
 {
  if ( TARGET_IS_IPV6 ) 
	return make_list(mkpacket(ip6(), icmp(ih_type:128, ih_code:0, ih_seq:id)), "ip6 and src host " + get_host_ip());
  else
  	return make_list(mkpacket(ip(), icmp(ih_type:8, ih_code:0, ih_seq:id)),  "ip and src host " + get_host_ip());
 }
}


#
# Global Initialisation
#
set_kb_item(name: "/tmp/start_time", value: unixtime());
do_arp = script_get_preference("Do an ARP ping");
if(!do_arp)do_arp = "yes";

do_tcp = script_get_preference("Do a TCP ping");
if(!do_tcp)do_tcp = "yes";

do_icmp = script_get_preference("Do an ICMP ping");
if(!do_icmp)do_icmp = "yes"; 

do_udp = script_get_preference("Do an applicative UDP ping (DNS,RPC...)");
if (! do_udp) do_udp = "no";

fast_network_discovery = script_get_preference("Fast network discovery");
if ( !fast_network_discovery) fast_network_discovery = "no";

test = 0;


show_dead = script_get_preference("Make the dead hosts appear in the report");
log_live = script_get_preference("Log live hosts in the report");
if ( "yes" >< show_dead ) set_kb_item(name: '/tmp/ping/show_dead', value:TRUE);
if ( "yes" >< log_live ) set_kb_item(name: '/tmp/ping/log_live', value:TRUE);



scan_local = script_get_preference("Test the local Nessus host");
if ( scan_local == "no" && islocalhost() ) 
{
 set_kb_item(name:"Host/ping_failed", value:TRUE);
 exit(0);
}


#
# Fortinet Firewalls act as an AV gateway. They do that
# by acting as a man-in-the-middle between the connection
# and the recipient. If there is NO recipient, then sending
# data to one of the filtered ports will result in a timeout.
#
# By default, Fortinet listens on port 21,25,80,110 and 143.
#
#
function check_fortinet_av_gateway()
{
 local_var soc, now, r;

 if ( did_arp ) return FALSE;
 if ( fast_network_discovery == "yes" ) return FALSE;
 soc = open_sock_tcp(25, timeout:3);
 if ( !soc ) return 0;
 now = unixtime();
 r = recv_line(socket:soc, length:1024, timeout:5);
 if ( r || unixtime() - now < 4 ) return 0;
 close(soc);

  
 soc = open_sock_tcp(110, timeout:3);
 if ( ! soc ) return 0;
 now = unixtime();
 r = recv_line(socket:soc, length:1024, timeout:5);
 if ( r || unixtime() - now < 4 ) return 0;
 close(soc);

 soc = open_sock_tcp(143, timeout:3);
 if ( ! soc ) return 0;
 now = unixtime();
 r = recv_line(socket:soc, length:1024, timeout:5);
 if ( r || unixtime() - now < 4 ) return 0;
 close(soc);

 # ?
 soc = open_sock_tcp(80, timeout:3);
 if ( ! soc ) return 0;
 send(socket:soc, data:http_get(item:"/", port:80));
 now = unixtime();
 r = recv_line(socket:soc, length:1024, timeout:5);
 if ( r || unixtime() - now < 4 ) return 0;
 close(soc);
 

 return 1;
}



function check_riverhead_and_consorts()
{
 local_var ip, tcpip, i, flags, j, r;

  if ( TARGET_IS_IPV6 ) return 0;
  if ( did_arp ) return 0;
  if ( fast_network_discovery == "yes") return 0;

   ip = forge_ip_packet(ip_v : 4,
                        ip_hl : 5,
                        ip_tos : 0,
                        ip_len : 40,
                        ip_id : rand() % 65535,
                        ip_p : IPPROTO_TCP,
                        ip_ttl : 175,
                        ip_off : 0,
			ip_src : this_host());



 for ( i = 0 ; i < 10 ; i ++ )
 {
    tcpip = forge_tcp_packet(ip       : ip,
                             th_sport : 63000 + i,
                             th_dport : 60000 + i,
                             th_flags : TH_SYN,
                             th_seq   : rand(),
                             th_ack   : 0,
                             th_x2    : 0,
                             th_off   : 5,
                             th_win   : 512,
			     data:	tcp_opt);

    for ( j = 0 ; j < 3 ; j ++ )
    {
    r = send_packet(tcpip, pcap_active:TRUE, pcap_filter:"src host " + get_host_ip()+ " and dst host " + this_host() + " and src port " + int(60000 + i) + " and dst port " + int(63000 + i ), pcap_timeout:1);
    if ( r ) break;
    }
    if ( ! r ) return 0;
    flags = get_tcp_element(tcp:r, element:"th_flags");
    if( flags != (TH_SYN|TH_ACK) ) return 0;
 }

 security_note(data:"
The remote host seems to be a RiverHead device, or some sort of decoy (it 
returns a SYN|ACK for any port), so Nessus will not scan it. If you want 
to force a scan of this host, disable the 'ping' plugin and restart a 
scan.", port:0);
 return 1;
}


function check_netware()
{
 local_var ports, then, port, soc, num_sockets, num_ready;
 local_var report, banner;

 if ( NASL_LEVEL < 3000 ) return 0;
 if (  get_kb_item("Scan/Do_Scan_Novell") ) return 0;

 report = "
Synopsis :

The remote host appears to be running Novell Netware and will not be
scanned. 

Description :

The remote host appears to be running Novell Netware.  This operating
system has a history of crashing or otherwise being adversely affected
by scans.  As a result, the scan has been disabled against this host. 

See also :

http://www.nessus.org/u?08f07636
http://www.nessus.org/u?87d03f4c

Solution :

If you want to scan the remote host enable the option 'Scan Novell
Netware hosts' in the Nessus client and re-scan it. 

Risk factor :

None";

  ports = make_list(80, 81, 8009);
  then = unixtime();
  foreach port ( ports )
     soc[port] = open_sock_tcp(port, nonblocking:TRUE);

  while ( TRUE )
  {
   num_sockets = 0;
   num_ready   = 0;
   foreach port ( ports )
   {
    if ( soc[port] )
    {
    num_sockets ++;
    if ( socket_ready(soc[port]) ) 
	{
	 num_ready ++;
    	 send(socket:soc[port], data:string("GET / HTTP/1.0\r\n\r\n"));
	 banner = recv(socket:soc, length:4096);
	 close(soc[port]);
	 soc[port] = 0;
	 if ( banner && egrep(pattern:"Server: (NetWare HTTP Stack|Apache(/[^ ]*)? \(NETWARE\))", string:banner) )
		{
      	 	 security_note(port:0, data:report);
      		 return 1;
		}
	}
    }
  }

  if ( num_sockets == 0 ) return 0;
  if ( num_ready   == 0 && (unixtime() - then) >= 3 ) return 0;
  usleep(50000);
 }
 return 0;
}


function difftime(t1, t2)
{
 local_var	s1, s2, u1, u2, v;
 local_var      ret;

 v = split(t1, sep: '.', keep: 0);
 s1 = int(v[0]);
 u1 = int(v[1]);
 v = split(t2, sep: '.', keep: 0);
 s2 = int(v[0]);
 u2 = int(v[1]);
 ret = (u2 - u1) + (s2 - s1) * 1000000;
 if ( ret <= 0 ) return NULL;
 return ret;
}

function log_live(rtt, cause)
{
 #
 # Let's make sure the remote host is not a riverhead or one of those annoying
 # devices replying on every port
 #
 if ( check_fortinet_av_gateway() || 
      check_riverhead_and_consorts() ||
      check_netware() 
     )
  set_kb_item(name:"Host/ping_failed", value:TRUE);

 #debug_print(get_host_ip(), " is up\n");
 if ("yes" >< log_live)
 {
  security_note(data:"The remote host is up", port:0, extra:cause);
 }
 if (rtt) {
	set_kb_item(name: "/tmp/ping/RTT", value: rtt);
	set_kb_item(name: "ping_host/RTT", value: rtt);
	}
 #debug_print('RTT=', rtt, 'us\n');
 exit(0);
}


function log_dead()
{
 local_var reason;
 reason = _FCT_ANON_ARGS[0];
 #debug_print(get_host_ip(), " is dead\n");
 if("yes" >< show_dead)
 {
 if ( isnull(reason) )
  security_note(data:"The remote host is considered as dead - not scanning", port:0);
 else
  security_note(data:"The remote host is considered as dead - not scanning", port:0, extra:reason);
 }
 set_kb_item(name:"Host/ping_failed", value:TRUE);
 exit(0);
}


function send_arp_ping()
{
 local_var broadcast, macaddr, ethernet, arp, r, i, srcip, dstmac, t1, t2;
 local_var ip;

 ip = _FCT_ANON_ARGS[0];

 broadcast = crap(data:raw_string(0xff), length:6);
 macaddr   = get_local_mac_addr();

 if ( ! macaddr ) return NULL ;  # Not an ethernet interface

 arp       = mkword(0x0806); 


 ethernet = broadcast + macaddr + arp;

 arp      = ethernet +              			# Ethernet
           mkword(0x0001) +        			# Hardware Type
           mkword(0x0800) +        			# Protocol Type
           mkbyte(0x06)   +        			# Hardware Size
           mkbyte(0x04)   +        			# Protocol Size
           mkword(0x0001) +        			# Opcode (Request)
           macaddr        +        			# Sender mac addr
           mkipaddr(this_host()) + 			# Sender IP addr
           crap(data:raw_string(0), length:6) + 	# Target Mac Addr
           mkipaddr(ip);

 for ( i = 0 ; i < 3 ; i ++ )
 {
  r = inject_packet(packet:arp, filter:"arp and arp[7] = 2 and src host " + ip, timeout:1);
 if ( r && strlen(r) > 31 ) 
 	return r;
 }
 return NULL;
}
 

function arp_ping()
{
 local_var t1, t2, dstmac;
 local_var rand_mac;
 local_var r, srcip;
 if ( ! defined_func("inject_packet") ) return (0);
 if ( ! islocalnet()  || islocalhost() ) return(0);
 if ( get_local_mac_addr() == NULL ) return(0);

  t1 = gettimeofday();
  r = send_arp_ping(get_host_ip());
  t2 = gettimeofday();
  if ( r && strlen(r) > 31 ) 
  {
  srcip = substr(r, 28, 31);
  if ( srcip == mkipaddr(get_host_ip() ) )
   {
    dstmac = substr(r, 6, 11);
    # Make sure there's no arp proxy on the local subnet
    if ( fast_network_discovery != "yes" )
	{
	 r = send_arp_ping(string("169.254.", rand()%254, ".", rand()%254));
    	 if ( r && substr(r, 6, 11) == dstmac ) return 0;
	}
    dstmac = strcat(hexstr(dstmac[0]), ":",
	            hexstr(dstmac[1]), ":",
		    hexstr(dstmac[2]), ":",
		    hexstr(dstmac[3]), ":",
		    hexstr(dstmac[4]), ":",
		    hexstr(dstmac[5]));
    set_kb_item(name:"ARP/mac_addr", value:dstmac);
    did_arp = TRUE;
    set_kb_item(name: "/tmp/ping/ARP", value: TRUE);
    log_live(rtt: difftime(t1: t1, t2: t2), cause:"The host replied to an ARP who-is query");
    exit(0);
   }
 }
 log_dead("The remote host is on the local network and failed to reply to an ARP who-is query");
 exit(0);
}

if(islocalhost()) exit(0);


# do_arp = "no"; do_tcp = "no"; do_icmp = "no"; do_udp = "yes"; # TEST

###
if ("yes" >< do_arp && islocalnet() && !TARGET_IS_IPV6 )
{
 # If the remote is on the local subnet and we are running over ethernet, and 
 # if arp fails, then arp_ping() will exit and mark the remote host as dead
 # (ie: it overrides the other tests)
 arp_ping();
}

meth_tried = NULL;

####
if("yes" >< do_tcp)
{
 test = test + 1;
 p = script_get_preference("TCP ping destination port(s) :");
 if (!p) p = defportlist;
 if ("extended" >< p)
 {
   p = ereg_replace(string: p, pattern: "(^|;)extended(;|$)", 
     replace: "\1built-in;110;113;143;264;389;1454;1723;3389\2");    
 }

 if ( TARGET_IS_IPV6 ) p = "built-in";

 #debug_print("TCP ports=",p,"\n");
 foreach dport (split(p, sep: ';', keep: 0))
 {
   t1 = gettimeofday();
   if (dport == "built-in")
   {
     if (tcp_ping())
     {
       t2 = gettimeofday();
       #debug_print('Host answered to TCP SYN (built-in port list)\n');
       log_live(rtt: difftime(t1: t1, t2: t2), cause:"The remote host replied to a TCP SYN packet (built-in port list)");
     }
   }
   else
   {
     if(tcp_ping(port:dport))
     {
       t2 = gettimeofday();
       # debug_print('Host answered to TCP SYN on port ', dport, '\n');
       set_kb_item(name: '/tmp/ping/TCP', value: dport);
       log_live(rtt: difftime(t1: t1, t2: t2), cause:"The remote host replied to a TCP SYN packet on port " + dport);
     }
   }
 }
 meth_tried += '- TCP ping\n';
}

####


if ("yes" >< do_icmp)
{
src = this_host();
dst = get_host_ip();
retry = script_get_preference("Number of retries (ICMP) :");
retry = int(retry);
alive = 0;
if(retry <= 0) retry = 2;	# default

  #debug_print("ICMP retry count=", retry, "\n");
  j = 0;
  test = test + 1;
  icmpid = rand() % 0xFFFF;
  filter = strcat("icmp and src host ", get_host_ip());
  while(j < retry)
  {
   id = 1235 +j;
   icmp = mk_icmp_pkt(id:id);

   t1 = gettimeofday();
   if ( NASL_LEVEL < 4000 )
    rep = send_packet(pcap_active:TRUE, pcap_filter:icmp[1], pcap_timeout:1, icmp[0]);
   else
   {
    rep = inject_packet(packet:link_layer() + icmp[0], filter:icmp[1], timeout:1);
   }

   if(rep){
        t2 = gettimeofday(); rtt = NULL;
	#debug_print(get_host_ip(), ' answered to ICMP ping\n');
	set_kb_item(name: "/tmp/ping/ICMP", value: TRUE);
	# If the packet is not a valid answer to our ping, do not store the RTT
	hl = ord(rep[0]) & 0xF; hl *= 4;
	if (strlen(rep) >=  hl +8)
	{
	  type = ord(rep[hl + 0]);
	  code = ord(rep[hl + 1]);
	  id2 = ord(rep[hl + 4]) * 256 + ord(rep[hl + 5]);
	  if (type == 0 && code == 0 && id2 == icmpid)
	    rtt = difftime(t1: t1, t2: t2);
	}
   	log_live(rtt: rtt, cause:"The remote host replied to an ICMP ping packet");
	}
   j = j+1;
 }
 meth_tried += '- ICMP ping\n';
}

###

if("yes" >< do_udp)
{
 test ++;
 n = 0;

 tid = raw_string(rand() % 256, rand() % 256);
 dstports[n] = 53;
 requests[n] = 
   strcat(	tid,
		'\x00\x00',		# Standard query (not recursive)
		'\x00\x01',		# 1 question
		'\x00\x00',		# 0 answer RR
		'\x00\x00',		# 0 authority RR
		'\x00\x00',		# 0 additional RR
		'\x03www', '\x07example', '\x03com', '\x00',
		'\x00\x01',		# Type A
		'\x00\x01'		# Classe IN
	);
 n ++;

 xid = raw_string(rand() % 256, rand() % 256, rand() % 256, rand() % 256);
 dstports[n] = 111;
 requests[n] = 
   strcat(	xid,			# XID
		'\x00\x00\x00\x00',	# Call
		'\x00\x00\x00\x02',	# RPC version = 2
		'\x00\x01\x86\xA0',	# Programm = portmapper (10000)
		'\x00\x00\x00\x02',	# Program version = 2
		'\x00\x00\x00\x03',	# Procedure = GETPORT(3)
		'\0\0\0\0\0\0\0\0',	# Null credential
		'\0\0\0\0\0\0\0\0',	# Null verifier
		'\x00\x00\x27\x10',	# programm 10000
		'\x00\x00\x00\x02',	# version 2
		'\x00\x00\x00\x11',	# UDP = 17
		'\x00\x00\x00\x00'	# port
	);
 n ++;

 # RIP v1 & v2 - some buggy agents answer only on requests coming from 
 # port 520, other agents ignore such requests. So I did a mix: v1 with
 # privileged source port, v2 without. 
 for (v = 2; v >= 1; v --)
 {
  if (v == 1) srcports[n] = 520;
  dstports[n] = 520;
  requests[n] = raw_string(1, v, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 16);
  n ++;
 }

 srcports[n] = 123;	# Or any client port
 dstports[n] = 123;
 requests[n] = '\xe3\x00\x04\x00\x00\x01\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC6\x34\xFF\xE6\x4B\xAE\xAB\x79';
 n ++;

#

 #debug_print('sending ', n, ' UDP requests\n');

 for (j = 0; j < n; j ++)
 {
  if (srcports[j]) sport = srcports[j];
  else sport = rand() % 64512 + 1024;
  ip = forge_ip_packet(ip_v: 4, ip_hl: 5, ip_tos: 0, # Should we try TOS=16?
	ip_ttl: 0x40, ip_p: IPPROTO_UDP, 
	ip_src: this_host(), ip_dst: get_host_ip());
  udp = forge_udp_packet(ip: ip, uh_sport: sport, uh_dport: dstports[j],
	data: requests[j]);
  # No need to filter source & destination port: if we get a UDP packet, the
  # host is alive. But we do not listen for any packet, in case there is a
  # broken filter or IPS that sends fake RST, for example.
  filter = "src host " + get_host_ip() + " and dst host " + this_host() + 
	" and (udp or (icmp and icmp[0]=3 and icmp[1]=3))";
  for (i = 0; i < 3; i ++)	# Try 3 times
  {
   t1 = gettimeofday();
   r = send_packet(udp, pcap_filter: filter, pcap_active: TRUE, pcap_timeout:1);
   if (r)
   {
    t2 = gettimeofday();
    rtt = NULL;
    ipp = get_ip_element(ip: r, element: 'ip_p');
    #debug_print('Host answered to UDP request on port ', dstports[j], ' (protocol=', ipp, ')\n');
    if (ipp == 17)
    {
     udpp = get_udp_element(udp: r, element: 'uh_sport');
     p2 = get_udp_element(udp: r, element: 'uh_dport');
     set_kb_item(name: '/tmp/ping/UDP', value: udpp);
     if (udpp == dstports[j] && p2 == sport) rtt = difftime(t1: t1, t2: t2);
     #if (udpp != dstports[j])
      #debug_print('Host sent an UDP packet from port ', udpp);
    }
    else if (ipp == 1)
    {
      hl = ord(r[0]) & 0xF; hl *= 4;
      pkt = substr(r, hl + 8);
      ipp = get_ip_element(ip: pkt, element: 'ip_p');
      if (ipp == 17)
      {
        rtt = difftime(t1: t1, t2: t2);
      }
    }

    log_live(rtt: rtt, cause:"The remote host replied to a UDP request on port " + dstports[j]);
   }
  }
 }
 ports = NULL; requests = NULL;
 meth_tried += '- UDP ping\n';
}

####

if( test != 0 ) {
	if ( !isnull(meth_tried) )
		log_dead('The remote host did not respond to the following ping methods :\n' + meth_tried);
	else
		log_dead();
}
