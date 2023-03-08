Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A598A6B0260
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 10:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCHJG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCHJGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 04:06:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516F301A4
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678266334; x=1709802334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0UAyCkAkCV57REmEVDwlB6K1AifPydmHD27DGfLP2NM=;
  b=lX4Bug/RhIl8D5GH+4JvYLOakox7lJJw+/eKEiOXtnArpHQ+xBGxxc29
   mtvArfnWfnwQpLpvFWdKUjJBmL/OY+aKapeNpiDrl91a8J+0M4egG5Kj9
   s2lD7CQVAU4PAg8EiN0+MgITxPEtsLLsm2rBEKsKv+8fsWuSSuL3Jkez2
   E/hxzwrRJ8G+AF8UKWNIuCC+lY1Ck+dFeA+Vs5vc/Zkap2dM+qm9tRwbi
   tartnsEnsOeoOX31Ss+0nMGzu+ViDQbaQReKiDOcEkrTuWYJ79rzrA0I/
   Nn9YUodjzF/ViFeqohrbXqCBu9RMyBb5x5ALE91VhF4pGrwg8BnTOnEYv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422374983"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="422374983"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 01:04:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679266103"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="679266103"
Received: from jafage-mobl1.amr.corp.intel.com (HELO technocore.fios-router.home) ([10.209.104.253])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 01:04:35 -0800
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH] pm-graph v5.11
Date:   Wed,  8 Mar 2023 01:04:34 -0800
Message-Id: <20230308090434.82331-1-todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sleepgraph:
- BUGFIX: any binary data that shows up in ftrace is now filtered out
- update the dmesg string formatting for dmesg only timelines
- add ethtool data for ethernet device to the log (if ethtool installed)

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/README        |  2 +-
 tools/power/pm-graph/sleepgraph.py | 58 +++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 21 deletions(-)

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
 
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 82c09cd25cc2..ab703c9227d5 100755
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
@@ -5556,9 +5575,8 @@ def executeSuspend(quiet=False):
 		if not quiet:
 			pprint('CAPTURING TRACE')
 		op = sv.writeDatafileHeader(sv.ftracefile, testdata)
-		fp = open(tp+'trace', 'r')
-		for line in fp:
-			op.write(line)
+		fp = open(tp+'trace', 'rb')
+		op.write(ascii(fp.read()))
 		op.close()
 		sv.fsetVal('', 'trace')
 		sv.platforminfo(cmdafter)
-- 
2.34.1

