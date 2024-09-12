Return-Path: <linux-pm+bounces-14062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF779760E5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 08:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2BC1F28AF9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 06:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5074188CDA;
	Thu, 12 Sep 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHDYm+Do"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB5188927;
	Thu, 12 Sep 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120800; cv=none; b=k9R+WNzVJZMVouS9JGxcOm4saMMD2lnzx9bUMZktrny+NKMhRi1ukjO+mdZEJYpR4Ph7IDG9Fa/m2iEuIkqAtOQPXiGi4H8byBWC0lz0YKxEdvBtMpAu78FDsSSgmEPROulaN//PsnrNfd/kbdTtD7DuBKyB2biw4+IY4sDl58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120800; c=relaxed/simple;
	bh=kDc26LncpItQVSUCay91B1CnZTcq7smBU80m468Q75A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Qe5AzS8M/VrWbiEN1+FfyM1uT9B9uxunkmoiEQ40FJgstJcYsz7mgfsMjJM0hUuhVfIG3HqFbAOQtGAL8yuzJ8XOsCXF8cgSone6Wpdjb6gjUHoLe4rg7VBiZ+dj8CurC2wXz80MKzoN8P0g+CZvf8qkg7GN6IxCbWCcow3qjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHDYm+Do; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726120798; x=1757656798;
  h=from:to:cc:subject:date:message-id;
  bh=kDc26LncpItQVSUCay91B1CnZTcq7smBU80m468Q75A=;
  b=FHDYm+Do2d8NUO/PoOESj6sGypXDEffDyshfXyMuXdI28f4IfLJ2qsxo
   vM8SpmRUrqb048QAIKYXZA86LCZ9tQYqVNj9XdEpv5dU/xorlTA/iRiyK
   Lk71PJx3tetweQ6/RMltGU5ULJj7NgfyeaTO5S5/9oXog8aTRQEIX2k5N
   kKRjXtAvXy9uaZ8/MXqnDeb7kmfIPGU5KR4yCWb03gkkD0Y9CxRBlLkRp
   Oyyr7Jks1PazE/OMS7WeGBV6LYXJG6rFd3qKvERc/mjn+safJSCusvZpQ
   05TWCo6Wi7ohDqyWCYn4fanpFCl7XQWosqavcjsDETSs/N+1ufikrOXyS
   A==;
X-CSE-ConnectionGUID: vZTBUaJ+TRqmLeI9fdZp3w==
X-CSE-MsgGUID: kb37VT47Tqm8P3cWY1c9dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42429016"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="42429016"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 22:59:58 -0700
X-CSE-ConnectionGUID: 9L5PCn+7QkOehr1FAStDiA==
X-CSE-MsgGUID: lVkgrwA9SQCPBexlgazZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="67904713"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2024 22:59:57 -0700
From: Todd Brandt <todd.e.brandt@intel.com>
To: linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org,
	todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: [PATCH] pm-graph v5.13
Date: Wed, 11 Sep 2024 22:59:56 -0700
Message-Id: <20240912055956.30108-1-todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

- fix link to pm-graph homepage and in comments
- add usleep_range kprobe to -dev mode
- add SIGUSR1 and SIGUSR2 to list of captured signals
- kill -s USR1 causes sleepgraph to print out stack trace
- kill -s USR2 prints stack trace and exits
- stack trace is also printed to -result file
- add legacy support for /sys/kernel/debug/tracing/
- allow multiple instances of trace funcs in the same phase
- update javascript to draw device detail for multiple trace func instances
- add -debugtiming option to print out timestamps on all outputs

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 tools/power/pm-graph/sleepgraph.8  |  3 ++
 tools/power/pm-graph/sleepgraph.py | 59 ++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 643271b6fc6f..491ca21dccdb 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -81,6 +81,9 @@ as resume failures.
 .TP
 \fB-wifitrace\fR
 Trace through the wifi reconnect time and include it in the timeline.
+.TP
+\fB-debugtiming\fR
+Add timestamp to each printed output line, accurate to the millisecond.
 
 .SS "advanced"
 .TP
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index ef87e63c05c7..918eae58b0b4 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -18,7 +18,7 @@
 #
 # Links:
 #	 Home Page
-#	   https://01.org/pm-graph
+#	   https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
 #	 Source repo
 #	   git@github.com:intel/pm-graph
 #
@@ -65,6 +65,7 @@ import gzip
 from threading import Thread
 from subprocess import call, Popen, PIPE
 import base64
+import traceback
 
 debugtiming = False
 mystarttime = time.time()
@@ -86,7 +87,7 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.12'
+	version = '5.13'
 	ansi = False
 	rs = 0
 	display = ''
@@ -236,7 +237,11 @@ class SystemValues:
 		'msleep': { 'args_x86_64': {'time':'%di:s32'}, 'ub': 1 },
 		'schedule_timeout': { 'args_x86_64': {'timeout':'%di:s32'}, 'ub': 1 },
 		'udelay': { 'func':'__const_udelay', 'args_x86_64': {'loops':'%di:s32'}, 'ub': 1 },
-		'usleep_range': { 'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'}, 'ub': 1 },
+		'usleep_range': {
+			'func':'usleep_range_state',
+			'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'},
+			'ub': 1
+		},
 		'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath', 'ub': 1 },
 		'acpi_os_stall': {'ub': 1},
 		'rt_mutex_slowlock': {'ub': 1},
@@ -342,15 +347,21 @@ class SystemValues:
 		if self.verbose or msg.startswith('WARNING:'):
 			pprint(msg)
 	def signalHandler(self, signum, frame):
-		if not self.result:
-			return
 		signame = self.signames[signum] if signum in self.signames else 'UNKNOWN'
-		msg = 'Signal %s caused a tool exit, line %d' % (signame, frame.f_lineno)
+		if signame in ['SIGUSR1', 'SIGUSR2', 'SIGSEGV']:
+			traceback.print_stack()
+			stack = traceback.format_list(traceback.extract_stack())
+			self.outputResult({'stack':stack})
+			if signame == 'SIGUSR1':
+				return
+		msg = '%s caused a tool exit, line %d' % (signame, frame.f_lineno)
+		pprint(msg)
 		self.outputResult({'error':msg})
+		os.kill(os.getpid(), signal.SIGKILL)
 		sys.exit(3)
 	def signalHandlerInit(self):
 		capture = ['BUS', 'SYS', 'XCPU', 'XFSZ', 'PWR', 'HUP', 'INT', 'QUIT',
-			'ILL', 'ABRT', 'FPE', 'SEGV', 'TERM']
+			'ILL', 'ABRT', 'FPE', 'SEGV', 'TERM', 'USR1', 'USR2']
 		self.signames = dict()
 		for i in capture:
 			s = 'SIG'+i
@@ -859,6 +870,11 @@ class SystemValues:
 		# files needed for any trace data
 		files = ['buffer_size_kb', 'current_tracer', 'trace', 'trace_clock',
 				 'trace_marker', 'trace_options', 'tracing_on']
+		# legacy check for old systems
+		if not os.path.exists(self.tpath+'trace'):
+			self.tpath = '/sys/kernel/debug/tracing/'
+		if not os.path.exists(self.epath):
+			self.epath = '/sys/kernel/debug/tracing/events/power/'
 		# files needed for callgraph trace data
 		tp = self.tpath
 		if(self.usecallgraph):
@@ -911,6 +927,13 @@ class SystemValues:
 		if num > 0:
 			n = '%d' % num
 		fp = open(self.result, 'a')
+		if 'stack' in testdata:
+			fp.write('Printing stack trace:\n')
+			for line in testdata['stack']:
+				fp.write(line)
+			fp.close()
+			self.sudoUserchown(self.result)
+			return
 		if 'error' in testdata:
 			fp.write('result%s: fail\n' % n)
 			fp.write('error%s: %s\n' % (n, testdata['error']))
@@ -1980,7 +2003,7 @@ class Data:
 		length = -1.0
 		if(start >= 0 and end >= 0):
 			length = end - start
-		if pid == -2 or name not in sysvals.tracefuncs.keys():
+		if pid >= -2:
 			i = 2
 			origname = name
 			while(name in list):
@@ -2753,7 +2776,8 @@ class Timeline:
 	def createHeader(self, sv, stamp):
 		if(not stamp['time']):
 			return
-		self.html += '<div class="version"><a href="https://01.org/pm-graph">%s v%s</a></div>' \
+		self.html += '<div class="version"><a href="https://www.intel.com/content/www/'+\
+			'us/en/developer/topic-technology/open/pm-graph/overview.html">%s v%s</a></div>' \
 			% (sv.title, sv.version)
 		if sv.logmsg and sv.testlog:
 			self.html += '<button id="showtest" class="logbtn btnfmt">log</button>'
@@ -5238,12 +5262,16 @@ def addScriptCode(hf, testruns):
 				}
 				var info = dev[i].title.split(" ");
 				var pname = info[info.length-1];
-				pd[pname] = parseFloat(info[info.length-3].slice(1));
-				total[0] += pd[pname];
+				var length = parseFloat(info[info.length-3].slice(1));
+				if (pname in pd)
+					pd[pname] += length;
+				else
+					pd[pname] = length;
+				total[0] += length;
 				if(pname.indexOf("suspend") >= 0)
-					total[tidx] += pd[pname];
+					total[tidx] += length;
 				else
-					total[tidx+1] += pd[pname];
+					total[tidx+1] += length;
 			}
 		}
 		var devname = deviceTitle(this.title, total, cpu);
@@ -5262,7 +5290,7 @@ def addScriptCode(hf, testruns):
 					phases[i].style.left = left+"%";
 					phases[i].title = phases[i].id+" "+pd[phases[i].id]+" ms";
 					left += w;
-					var time = "<t4 style=\"font-size:"+fs+"px\">"+pd[phases[i].id]+" ms<br></t4>";
+					var time = "<t4 style=\"font-size:"+fs+"px\">"+pd[phases[i].id].toFixed(3)+" ms<br></t4>";
 					var pname = "<t3 style=\"font-size:"+fs2+"px\">"+phases[i].id.replace(new RegExp("_", "g"), " ")+"</t3>";
 					phases[i].innerHTML = time+pname;
 				} else {
@@ -6742,6 +6770,7 @@ def printHelp():
 	'   -wifi        If a wifi connection is available, check that it reconnects after resume.\n'\
 	'   -wifitrace   Trace kernel execution through wifi reconnect.\n'\
 	'   -netfix      Use netfix to reset the network in the event it fails to resume.\n'\
+	'   -debugtiming Add timestamp to each printed line\n'\
 	'  [testprep]\n'\
 	'   -sync        Sync the filesystems before starting the test\n'\
 	'   -rs on/off   Enable/disable runtime suspend for all devices, restore all after test\n'\
@@ -7047,7 +7076,6 @@ if __name__ == '__main__':
 			except:
 				doError('No result file supplied', True)
 			sysvals.result = val
-			sysvals.signalHandlerInit()
 		else:
 			doError('Invalid argument: '+arg, True)
 
@@ -7057,6 +7085,7 @@ if __name__ == '__main__':
 	if(sysvals.usecallgraph and sysvals.useprocmon):
 		doError('-proc is not compatible with -f')
 
+	sysvals.signalHandlerInit()
 	if sysvals.usecallgraph and sysvals.cgskip:
 		sysvals.vprint('Using cgskip file: %s' % sysvals.cgskip)
 		sysvals.setCallgraphBlacklist(sysvals.cgskip)
-- 
2.17.1


