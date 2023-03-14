Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B26B9D33
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 18:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCNRjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNRjl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 13:39:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD840E4
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678815580; x=1710351580;
  h=from:to:cc:subject:date:message-id;
  bh=gIJvc/QUyUniwX7K9GjcSGWWJVFsIeyuYd3va43nW8M=;
  b=CBYwB7TDrh41oFz0LcSmcKrTd7CrRiRSwo8ZYEjWlvwGx1UhjNDkTFQm
   jgW98zRPzogCk6ZJWkqIgT2ikDFL4RfvdGeYOBjneYXv62R8mvYTFmnme
   LJN8hzuIRAnw6FkqV0fggKaEd6F2NLCu0ff5Hj3W2dGooN5ht0/U9kJqm
   9Jz5X+ScKk81LNdkNUo1gUX6UJQdK4YxVS8wuhDA7PZTd1h6uF6/75xmE
   8d++caTCLlq4S+6cesroaw1lqpBsLCvFx1oU9bIXVKKTFVoW7mjJUgywV
   kjXZDjO93Od3zb/9TH3Qwx9frVV32lTcRtpR+xuF9M7iIoRl78R0t5+eC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="325860135"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="325860135"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="681512603"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="681512603"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga007.fm.intel.com with ESMTP; 14 Mar 2023 10:39:39 -0700
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH v2] pm-graph v5.11
Date:   Tue, 14 Mar 2023 10:39:36 -0700
Message-Id: <20230314173936.14518-1-todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

install_latest_from_github.sh:
- Added a new script which allows users to install the latest pm-graph
from the upstream github repo. This is useful if the kernel source version
has regression issues that have already been fixed in github

sleepgraph.py:
- updated all the dmesg suspend/resume PM print formats to be able to
process recent timelines using dmesg only
- added ethtool output to the log for the system's ethernet device id the
ethtool exists. This helps in debugging network issues.
- made the tool more robustly handle events where mangled dmesg or ftrace
outputs do not include all the requisite data. The tool fails gracefully
instead of creating a garbled timeline.

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 tools/power/pm-graph/README                   |  2 +-
 .../pm-graph/install_latest_from_github.sh    | 38 +++++++++++++
 tools/power/pm-graph/sleepgraph.py            | 53 +++++++++++++------
 3 files changed, 75 insertions(+), 18 deletions(-)
 create mode 100755 tools/power/pm-graph/install_latest_from_github.sh

diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
index 3213dbe63b74..047ce1d76467 100644
--- a/tools/power/pm-graph/README
+++ b/tools/power/pm-graph/README
@@ -6,7 +6,7 @@
    |_|                    |___/          |_|
 
    pm-graph: suspend/resume/boot timing analysis tools
-    Version: 5.10
+    Version: 5.11
      Author: Todd Brandt <todd.e.brandt@intel.com>
   Home Page: https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
 
diff --git a/tools/power/pm-graph/install_latest_from_github.sh b/tools/power/pm-graph/install_latest_from_github.sh
new file mode 100755
index 000000000000..eaa332399d36
--- /dev/null
+++ b/tools/power/pm-graph/install_latest_from_github.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Script which clones and installs the latest pm-graph
+# from http://github.com/intel/pm-graph.git
+
+OUT=`mktemp -d 2>/dev/null`
+if [ -z "$OUT" -o ! -e $OUT ]; then
+	echo "ERROR: mktemp failed to create folder"
+	exit
+fi
+
+cleanup() {
+	if [ -e "$OUT" ]; then
+		cd $OUT
+		rm -rf pm-graph
+		cd /tmp
+		rmdir $OUT
+	fi
+}
+
+git clone http://github.com/intel/pm-graph.git $OUT/pm-graph
+if [ ! -e "$OUT/pm-graph/sleepgraph.py" ]; then
+	echo "ERROR: pm-graph github repo failed to clone"
+	cleanup
+	exit
+fi
+
+cd $OUT/pm-graph
+echo "INSTALLING PM-GRAPH"
+sudo make install
+if [ $? -eq 0 ]; then
+	echo "INSTALL SUCCESS"
+	sleepgraph -v
+else
+	echo "INSTALL FAILED"
+fi
+cleanup
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index bf4ac24a1c7a..ab703c9227d5 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -86,7 +86,7 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.10'
+	version = '5.11'
 	ansi = False
 	rs = 0
 	display = ''
@@ -300,6 +300,7 @@ class SystemValues:
 		[0, 'acpidevices', 'sh', '-c', 'ls -l /sys/bus/acpi/devices/*/physical_node'],
 		[0, 's0ix_require', 'cat', '/sys/kernel/debug/pmc_core/substate_requirements'],
 		[0, 's0ix_debug', 'cat', '/sys/kernel/debug/pmc_core/slp_s0_debug_status'],
+		[0, 'ethtool', 'ethtool', '{ethdev}'],
 		[1, 's0ix_residency', 'cat', '/sys/kernel/debug/pmc_core/slp_s0_residency_usec'],
 		[1, 'interrupts', 'cat', '/proc/interrupts'],
 		[1, 'wakeups', 'cat', '/sys/kernel/debug/wakeup_sources'],
@@ -1078,18 +1079,35 @@ class SystemValues:
 				else:
 					out[data[0].strip()] = data[1]
 		return out
+	def cmdinfovar(self, arg):
+		if arg == 'ethdev':
+			try:
+				cmd = [self.getExec('ip'), '-4', '-o', '-br', 'addr']
+				fp = Popen(cmd, stdout=PIPE, stderr=PIPE).stdout
+				info = ascii(fp.read()).strip()
+				fp.close()
+			except:
+				return 'iptoolcrash'
+			for line in info.split('\n'):
+				if line[0] == 'e' and 'UP' in line:
+					return line.split()[0]
+			return 'nodevicefound'
+		return 'unknown'
 	def cmdinfo(self, begin, debug=False):
 		out = []
 		if begin:
 			self.cmd1 = dict()
 		for cargs in self.infocmds:
-			delta, name = cargs[0], cargs[1]
-			cmdline, cmdpath = ' '.join(cargs[2:]), self.getExec(cargs[2])
+			delta, name, args = cargs[0], cargs[1], cargs[2:]
+			for i in range(len(args)):
+				if args[i][0] == '{' and args[i][-1] == '}':
+					args[i] = self.cmdinfovar(args[i][1:-1])
+			cmdline, cmdpath = ' '.join(args[0:]), self.getExec(args[0])
 			if not cmdpath or (begin and not delta):
 				continue
 			self.dlog('[%s]' % cmdline)
 			try:
-				fp = Popen([cmdpath]+cargs[3:], stdout=PIPE, stderr=PIPE).stdout
+				fp = Popen([cmdpath]+args[1:], stdout=PIPE, stderr=PIPE).stdout
 				info = ascii(fp.read()).strip()
 				fp.close()
 			except:
@@ -1452,6 +1470,7 @@ class Data:
 	errlist = {
 		'HWERROR' : r'.*\[ *Hardware Error *\].*',
 		'FWBUG'   : r'.*\[ *Firmware Bug *\].*',
+		'TASKFAIL': r'.*Freezing .*after *.*',
 		'BUG'     : r'(?i).*\bBUG\b.*',
 		'ERROR'   : r'(?i).*\bERROR\b.*',
 		'WARNING' : r'(?i).*\bWARNING\b.*',
@@ -1462,7 +1481,6 @@ class Data:
 		'TIMEOUT' : r'(?i).*\bTIMEOUT\b.*',
 		'ABORT'   : r'(?i).*\bABORT\b.*',
 		'IRQ'     : r'.*\bgenirq: .*',
-		'TASKFAIL': r'.*Freezing .*after *.*',
 		'ACPI'    : r'.*\bACPI *(?P<b>[A-Za-z]*) *Error[: ].*',
 		'DISKFULL': r'.*\bNo space left on device.*',
 		'USBERR'  : r'.*usb .*device .*, error [0-9-]*',
@@ -1602,7 +1620,7 @@ class Data:
 			pend = self.dmesg[phase]['end']
 			if start <= pend:
 				return phase
-		return 'resume_complete'
+		return 'resume_complete' if 'resume_complete' in self.dmesg else ''
 	def sourceDevice(self, phaselist, start, end, pid, type):
 		tgtdev = ''
 		for phase in phaselist:
@@ -1645,6 +1663,8 @@ class Data:
 			else:
 				threadname = '%s-%d' % (proc, pid)
 			tgtphase = self.sourcePhase(start)
+			if not tgtphase:
+				return False
 			self.newAction(tgtphase, threadname, pid, '', start, end, '', ' kth', '')
 			return self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
 		# this should not happen
@@ -1835,9 +1855,9 @@ class Data:
 		hwr = self.hwend - timedelta(microseconds=rtime)
 		self.tLow.append('%.0f'%((hwr - hws).total_seconds() * 1000))
 	def getTimeValues(self):
-		sktime = (self.tSuspended - self.tKernSus) * 1000
-		rktime = (self.tKernRes - self.tResumed) * 1000
-		return (sktime, rktime)
+		s = (self.tSuspended - self.tKernSus) * 1000
+		r = (self.tKernRes - self.tResumed) * 1000
+		return (max(s, 0), max(r, 0))
 	def setPhase(self, phase, ktime, isbegin, order=-1):
 		if(isbegin):
 			# phase start over current phase
@@ -3961,7 +3981,7 @@ def parseKernelLog(data):
 		'suspend_machine': ['PM: suspend-to-idle',
 							'PM: noirq suspend of devices complete after.*',
 							'PM: noirq freeze of devices complete after.*'],
-		 'resume_machine': ['PM: Timekeeping suspended for.*',
+		 'resume_machine': ['[PM: ]*Timekeeping suspended for.*',
 							'ACPI: Low-level resume complete.*',
 							'ACPI: resume from mwait',
 							'Suspended for [0-9\.]* seconds'],
@@ -3979,14 +3999,14 @@ def parseKernelLog(data):
 	# action table (expected events that occur and show up in dmesg)
 	at = {
 		'sync_filesystems': {
-			'smsg': 'PM: Syncing filesystems.*',
-			'emsg': 'PM: Preparing system for mem sleep.*' },
+			'smsg': '.*[Ff]+ilesystems.*',
+			'emsg': 'PM: Preparing system for[a-z]* sleep.*' },
 		'freeze_user_processes': {
-			'smsg': 'Freezing user space processes .*',
+			'smsg': 'Freezing user space processes.*',
 			'emsg': 'Freezing remaining freezable tasks.*' },
 		'freeze_tasks': {
 			'smsg': 'Freezing remaining freezable tasks.*',
-			'emsg': 'PM: Entering (?P<mode>[a-z,A-Z]*) sleep.*' },
+			'emsg': 'PM: Suspending system.*' },
 		'ACPI prepare': {
 			'smsg': 'ACPI: Preparing to enter system sleep state.*',
 			'emsg': 'PM: Saving platform NVS memory.*' },
@@ -4120,10 +4140,9 @@ def parseKernelLog(data):
 			for a in sorted(at):
 				if(re.match(at[a]['smsg'], msg)):
 					if(a not in actions):
-						actions[a] = []
-					actions[a].append({'begin': ktime, 'end': ktime})
+						actions[a] = [{'begin': ktime, 'end': ktime}]
 				if(re.match(at[a]['emsg'], msg)):
-					if(a in actions):
+					if(a in actions and actions[a][-1]['begin'] == actions[a][-1]['end']):
 						actions[a][-1]['end'] = ktime
 			# now look for CPU on/off events
 			if(re.match('Disabling non-boot CPUs .*', msg)):
-- 
2.17.1

