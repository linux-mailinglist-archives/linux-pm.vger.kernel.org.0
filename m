Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92666605B08
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJTJXS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJTJXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 05:23:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8519123457
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666257794; x=1697793794;
  h=from:to:cc:subject:date:message-id;
  bh=TLOweSD2Z6ixnm/XuD8lQQD2srXlsSg6KdzgYwyteBw=;
  b=KZRN9cnSfr3i+NrQQJ84SOHoej6jI9DaPLZtaop8wt5B2hBnG3EfjNZK
   YNo8jcjhg1GDvKt9HAPHPUxlIjQAjCg/zgPVfbHQsFZK9siY+fZoTy8yr
   qw/6s2+rssJYRoWmPNXKt3lD74lKW+AhNEFDlxLMf7fKxXGED54hcs6Ry
   Eb7SVfm0ZnbaQZnN6QKAV4dEJ5ntDY2ZdZzrA51SRsd0cLPEt9QoXwgiX
   pW/hxPLye2RbVHxhIh6Ugr/BNU82tf0ouKsXXUZZvhi/Trb5myXsiIIA7
   +j9YhB4XGbWWnnUl4i7yqoaVOMKps7zpVWIBNHjJi60/DFns80EXhdRdD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="294055450"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="294055450"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 02:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958817275"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="958817275"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2022 02:23:13 -0700
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH] pm-graph v5.10
Date:   Thu, 20 Oct 2022 02:23:10 -0700
Message-Id: <27495a15d5c87c5aa2b1ee663f0fdb3041d18a51.1666254155.git.todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sleepgraph:
- add -wifitrace argument for tracing all the way to wifi reconnect
- include more data in ftrace to mark the end of kernel resume
- add async_synchronize_full to the list of funcs to chart
- add thermal zone info to the log data
- include a check for s0ix support (s2idle is the default mem_sleep)
- if s2idle does not support s0ix, remove the SYS%LPI turbostat var
- fix -dev crash when kprobe caller is just an address (not a symbol)
- fix the cpuexec data in -proc to display in resume
sleepgraph.8:
- add -wifitrace documentation
README:
- change links from 01.org to developer.intel.com

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 tools/power/pm-graph/README        |  12 +-
 tools/power/pm-graph/sleepgraph.8  |   3 +
 tools/power/pm-graph/sleepgraph.py | 225 ++++++++++++++---------------
 3 files changed, 118 insertions(+), 122 deletions(-)

diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
index e6020c0d59ec..3213dbe63b74 100644
--- a/tools/power/pm-graph/README
+++ b/tools/power/pm-graph/README
@@ -6,22 +6,22 @@
    |_|                    |___/          |_|
 
    pm-graph: suspend/resume/boot timing analysis tools
-    Version: 5.9
+    Version: 5.10
      Author: Todd Brandt <todd.e.brandt@intel.com>
-  Home Page: https://01.org/pm-graph
+  Home Page: https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
 
  Report bugs/issues at bugzilla.kernel.org Tools/pm-graph
 	- https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
 
  Full documentation available online & in man pages
 	- Getting Started:
-	  https://01.org/pm-graph/documentation/getting-started
+	  https://www.intel.com/content/www/us/en/developer/articles/technical/usage.html
 
-	- Config File Format:
-	  https://01.org/pm-graph/documentation/3-config-file-format
+	- Feature Summary:
+	  https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/features.html
 
 	- upstream version in git:
-	  https://github.com/intel/pm-graph/
+	  git clone https://github.com/intel/pm-graph/
 
  Table of Contents
 	- Overview
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 5126271de98a..643271b6fc6f 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -78,6 +78,9 @@ This helps maintain the consistency of test data for better comparison.
 If a wifi connection is available, check that it reconnects after resume. Include
 the reconnect time in the total resume time calculation and treat wifi timeouts
 as resume failures.
+.TP
+\fB-wifitrace\fR
+Trace through the wifi reconnect time and include it in the timeline.
 
 .SS "advanced"
 .TP
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 33981adcdd68..cfe343306e08 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -86,7 +86,7 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.9'
+	version = '5.10'
 	ansi = False
 	rs = 0
 	display = ''
@@ -100,6 +100,7 @@ class SystemValues:
 	ftracelog = False
 	acpidebug = True
 	tstat = True
+	wifitrace = False
 	mindevlen = 0.0001
 	mincglen = 0.0
 	cgphase = ''
@@ -124,6 +125,7 @@ class SystemValues:
 	epath = '/sys/kernel/debug/tracing/events/power/'
 	pmdpath = '/sys/power/pm_debug_messages'
 	s0ixpath = '/sys/module/intel_pmc_core/parameters/warn_on_s0ix_failures'
+	s0ixres = '/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us'
 	acpipath='/sys/module/acpi/parameters/debug_level'
 	traceevents = [
 		'suspend_resume',
@@ -180,6 +182,7 @@ class SystemValues:
 	tmstart = 'SUSPEND START %Y%m%d-%H:%M:%S.%f'
 	tmend = 'RESUME COMPLETE %Y%m%d-%H:%M:%S.%f'
 	tracefuncs = {
+		'async_synchronize_full': {},
 		'sys_sync': {},
 		'ksys_sync': {},
 		'__pm_notifier_call_chain': {},
@@ -304,6 +307,7 @@ class SystemValues:
 		[2, 'suspendstats', 'sh', '-c', 'grep -v invalid /sys/power/suspend_stats/*'],
 		[2, 'cpuidle', 'sh', '-c', 'grep -v invalid /sys/devices/system/cpu/cpu*/cpuidle/state*/s2idle/*'],
 		[2, 'battery', 'sh', '-c', 'grep -v invalid /sys/class/power_supply/*/*'],
+		[2, 'thermal', 'sh', '-c', 'grep . /sys/class/thermal/thermal_zone*/temp'],
 	]
 	cgblacklist = []
 	kprobes = dict()
@@ -777,7 +781,7 @@ class SystemValues:
 			return
 		if not quiet:
 			sysvals.printSystemInfo(False)
-			pprint('INITIALIZING FTRACE...')
+			pprint('INITIALIZING FTRACE')
 		# turn trace off
 		self.fsetVal('0', 'tracing_on')
 		self.cleanupFtrace()
@@ -841,7 +845,7 @@ class SystemValues:
 				for name in self.dev_tracefuncs:
 					self.defaultKprobe(name, self.dev_tracefuncs[name])
 			if not quiet:
-				pprint('INITIALIZING KPROBES...')
+				pprint('INITIALIZING KPROBES')
 			self.addKprobes(self.verbose)
 		if(self.usetraceevents):
 			# turn trace events on
@@ -1133,6 +1137,15 @@ class SystemValues:
 				self.cfgdef[file] = fp.read().strip()
 			fp.write(value)
 			fp.close()
+	def s0ixSupport(self):
+		if not os.path.exists(self.s0ixres) or not os.path.exists(self.mempowerfile):
+			return False
+		fp = open(sysvals.mempowerfile, 'r')
+		data = fp.read().strip()
+		fp.close()
+		if '[s2idle]' in data:
+			return True
+		return False
 	def haveTurbostat(self):
 		if not self.tstat:
 			return False
@@ -1146,7 +1159,7 @@ class SystemValues:
 			self.vprint(out)
 			return True
 		return False
-	def turbostat(self):
+	def turbostat(self, s0ixready):
 		cmd = self.getExec('turbostat')
 		rawout = keyline = valline = ''
 		fullcmd = '%s -q -S echo freeze > %s' % (cmd, self.powerfile)
@@ -1173,6 +1186,8 @@ class SystemValues:
 		for key in keyline:
 			idx = keyline.index(key)
 			val = valline[idx]
+			if key == 'SYS%LPI' and not s0ixready and re.match('^[0\.]*$', val):
+				continue
 			out.append('%s=%s' % (key, val))
 		return '|'.join(out)
 	def netfixon(self, net='both'):
@@ -1183,14 +1198,6 @@ class SystemValues:
 		out = ascii(fp.read()).strip()
 		fp.close()
 		return out
-	def wifiRepair(self):
-		out = self.netfixon('wifi')
-		if not out or 'error' in out.lower():
-			return ''
-		m = re.match('WIFI \S* ONLINE (?P<action>\S*)', out)
-		if not m:
-			return 'dead'
-		return m.group('action')
 	def wifiDetails(self, dev):
 		try:
 			info = open('/sys/class/net/%s/device/uevent' % dev, 'r').read().strip()
@@ -1220,11 +1227,6 @@ class SystemValues:
 				return '%s reconnected %.2f' % \
 					(self.wifiDetails(dev), max(0, time.time() - start))
 			time.sleep(0.01)
-		if self.netfix:
-			res = self.wifiRepair()
-			if res:
-				timeout = max(0, time.time() - start)
-				return '%s %s %d' % (self.wifiDetails(dev), res, timeout)
 		return '%s timeout %d' % (self.wifiDetails(dev), timeout)
 	def errorSummary(self, errinfo, msg):
 		found = False
@@ -1346,6 +1348,20 @@ class SystemValues:
 			for i in self.rslist:
 				self.setVal(self.rstgt, i)
 			pprint('runtime suspend settings restored on %d devices' % len(self.rslist))
+	def start(self, pm):
+		if self.useftrace:
+			self.dlog('start ftrace tracing')
+			self.fsetVal('1', 'tracing_on')
+			if self.useprocmon:
+				self.dlog('start the process monitor')
+				pm.start()
+	def stop(self, pm):
+		if self.useftrace:
+			if self.useprocmon:
+				self.dlog('stop the process monitor')
+				pm.stop()
+			self.dlog('stop ftrace tracing')
+			self.fsetVal('0', 'tracing_on')
 
 sysvals = SystemValues()
 switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
@@ -1643,19 +1659,20 @@ class Data:
 		ubiquitous = False
 		if kprobename in dtf and 'ub' in dtf[kprobename]:
 			ubiquitous = True
-		title = cdata+' '+rdata
-		mstr = '\(.*\) *(?P<args>.*) *\((?P<caller>.*)\+.* arg1=(?P<ret>.*)'
-		m = re.match(mstr, title)
-		if m:
-			c = m.group('caller')
-			a = m.group('args').strip()
-			r = m.group('ret')
+		mc = re.match('\(.*\) *(?P<args>.*)', cdata)
+		mr = re.match('\((?P<caller>\S*).* arg1=(?P<ret>.*)', rdata)
+		if mc and mr:
+			c = mr.group('caller').split('+')[0]
+			a = mc.group('args').strip()
+			r = mr.group('ret')
 			if len(r) > 6:
 				r = ''
 			else:
 				r = 'ret=%s ' % r
 			if ubiquitous and c in dtf and 'ub' in dtf[c]:
 				return False
+		else:
+			return False
 		color = sysvals.kprobeColor(kprobename)
 		e = DevFunction(displayname, a, c, r, start, end, ubiquitous, proc, pid, color)
 		tgtdev['src'].append(e)
@@ -1772,6 +1789,14 @@ class Data:
 						e.time = self.trimTimeVal(e.time, t0, dT, left)
 						e.end = self.trimTimeVal(e.end, t0, dT, left)
 						e.length = e.end - e.time
+				if('cpuexec' in d):
+					cpuexec = dict()
+					for e in d['cpuexec']:
+						c0, cN = e
+						c0 = self.trimTimeVal(c0, t0, dT, left)
+						cN = self.trimTimeVal(cN, t0, dT, left)
+						cpuexec[(c0, cN)] = d['cpuexec'][e]
+					d['cpuexec'] = cpuexec
 		for dir in ['suspend', 'resume']:
 			list = []
 			for e in self.errorinfo[dir]:
@@ -2086,75 +2111,43 @@ class Data:
 		return d
 	def addProcessUsageEvent(self, name, times):
 		# get the start and end times for this process
-		maxC = 0
-		tlast = 0
-		start = -1
-		end = -1
+		cpuexec = dict()
+		tlast = start = end = -1
 		for t in sorted(times):
-			if tlast == 0:
+			if tlast < 0:
 				tlast = t
 				continue
-			if name in self.pstl[t]:
-				if start == -1 or tlast < start:
+			if name in self.pstl[t] and self.pstl[t][name] > 0:
+				if start < 0:
 					start = tlast
-				if end == -1 or t > end:
-					end = t
+				end, key = t, (tlast, t)
+				maxj = (t - tlast) * 1024.0
+				cpuexec[key] = min(1.0, float(self.pstl[t][name]) / maxj)
 			tlast = t
-		if start == -1 or end == -1:
-			return 0
+		if start < 0 or end < 0:
+			return
 		# add a new action for this process and get the object
 		out = self.newActionGlobal(name, start, end, -3)
-		if not out:
-			return 0
-		phase, devname = out
-		dev = self.dmesg[phase]['list'][devname]
-		# get the cpu exec data
-		tlast = 0
-		clast = 0
-		cpuexec = dict()
-		for t in sorted(times):
-			if tlast == 0 or t <= start or t > end:
-				tlast = t
-				continue
-			list = self.pstl[t]
-			c = 0
-			if name in list:
-				c = list[name]
-			if c > maxC:
-				maxC = c
-			if c != clast:
-				key = (tlast, t)
-				cpuexec[key] = c
-				tlast = t
-				clast = c
-		dev['cpuexec'] = cpuexec
-		return maxC
+		if out:
+			phase, devname = out
+			dev = self.dmesg[phase]['list'][devname]
+			dev['cpuexec'] = cpuexec
 	def createProcessUsageEvents(self):
-		# get an array of process names
-		proclist = []
-		for t in sorted(self.pstl):
-			pslist = self.pstl[t]
-			for ps in sorted(pslist):
-				if ps not in proclist:
-					proclist.append(ps)
-		# get a list of data points for suspend and resume
-		tsus = []
-		tres = []
+		# get an array of process names and times
+		proclist = {'sus': dict(), 'res': dict()}
+		tdata = {'sus': [], 'res': []}
 		for t in sorted(self.pstl):
-			if t < self.tSuspended:
-				tsus.append(t)
-			else:
-				tres.append(t)
+			dir = 'sus' if t < self.tSuspended else 'res'
+			for ps in sorted(self.pstl[t]):
+				if ps not in proclist[dir]:
+					proclist[dir][ps] = 0
+			tdata[dir].append(t)
 		# process the events for suspend and resume
-		if len(proclist) > 0:
+		if len(proclist['sus']) > 0 or len(proclist['res']) > 0:
 			sysvals.vprint('Process Execution:')
-		for ps in proclist:
-			c = self.addProcessUsageEvent(ps, tsus)
-			if c > 0:
-				sysvals.vprint('%25s (sus): %d' % (ps, c))
-			c = self.addProcessUsageEvent(ps, tres)
-			if c > 0:
-				sysvals.vprint('%25s (res): %d' % (ps, c))
+		for dir in ['sus', 'res']:
+			for ps in sorted(proclist[dir]):
+				self.addProcessUsageEvent(ps, tdata[dir])
 	def handleEndMarker(self, time, msg=''):
 		dm = self.dmesg
 		self.setEnd(time, msg)
@@ -3218,7 +3211,7 @@ class ProcessMonitor:
 #	 markers, and/or kprobes required for primary parsing.
 def doesTraceLogHaveTraceEvents():
 	kpcheck = ['_cal: (', '_ret: (']
-	techeck = ['suspend_resume', 'device_pm_callback']
+	techeck = ['suspend_resume', 'device_pm_callback', 'tracing_mark_write']
 	tmcheck = ['SUSPEND START', 'RESUME COMPLETE']
 	sysvals.usekprobes = False
 	fp = sysvals.openlog(sysvals.ftracefile, 'r')
@@ -3241,7 +3234,7 @@ def doesTraceLogHaveTraceEvents():
 				check.remove(i)
 		tmcheck = check
 	fp.close()
-	sysvals.usetraceevents = True if len(techeck) < 2 else False
+	sysvals.usetraceevents = True if len(techeck) < 3 else False
 	sysvals.usetracemarkers = True if len(tmcheck) == 0 else False
 
 # Function: appendIncompleteTraceLog
@@ -3456,6 +3449,8 @@ def parseTraceLog(live=False):
 			continue
 		# process cpu exec line
 		if t.type == 'tracing_mark_write':
+			if t.name == 'CMD COMPLETE' and data.tKernRes == 0:
+				data.tKernRes = t.time
 			m = re.match(tp.procexecfmt, t.name)
 			if(m):
 				parts, msg = 1, m.group('ps')
@@ -3674,6 +3669,9 @@ def parseTraceLog(live=False):
 				e = next((x for x in reversed(tp.ktemp[key]) if x['end'] < 0), 0)
 				if not e:
 					continue
+				if (t.time - e['begin']) * 1000 < sysvals.mindevlen:
+					tp.ktemp[key].pop()
+					continue
 				e['end'] = t.time
 				e['rdata'] = kprobedata
 				# end of kernel resume
@@ -4213,6 +4211,8 @@ def callgraphHTML(sv, hf, num, cg, title, color, devid):
 			fmt = '<n>(%.3f ms @ '+sv.timeformat+')</n>'
 			flen = fmt % (line.length*1000, line.time)
 		if line.isLeaf():
+			if line.length * 1000 < sv.mincglen:
+				continue
 			hf.write(html_func_leaf.format(line.name, flen))
 		elif line.freturn:
 			hf.write(html_func_end)
@@ -4827,14 +4827,11 @@ def createHTML(testruns, testfail):
 					if('cpuexec' in dev):
 						for t in sorted(dev['cpuexec']):
 							start, end = t
-							j = float(dev['cpuexec'][t]) / 5
-							if j > 1.0:
-								j = 1.0
 							height = '%.3f' % (rowheight/3)
 							top = '%.3f' % (rowtop + devtl.scaleH + 2*rowheight/3)
 							left = '%f' % (((start-m0)*100)/mTotal)
 							width = '%f' % ((end-start)*100/mTotal)
-							color = 'rgba(255, 0, 0, %f)' % j
+							color = 'rgba(255, 0, 0, %f)' % dev['cpuexec'][t]
 							devtl.html += \
 								html_cpuexec.format(left, top, height, width, color)
 					if('src' not in dev):
@@ -5453,17 +5450,9 @@ def executeSuspend(quiet=False):
 		call('sync', shell=True)
 	sv.dlog('read dmesg')
 	sv.initdmesg()
-	# start ftrace
-	if sv.useftrace:
-		if not quiet:
-			pprint('START TRACING')
-		sv.dlog('start ftrace tracing')
-		sv.fsetVal('1', 'tracing_on')
-		if sv.useprocmon:
-			sv.dlog('start the process monitor')
-			pm.start()
-	sv.dlog('run the cmdinfo list before')
+	sv.dlog('cmdinfo before')
 	sv.cmdinfo(True)
+	sv.start(pm)
 	# execute however many s/r runs requested
 	for count in range(1,sv.execcount+1):
 		# x2delay in between test runs
@@ -5500,6 +5489,7 @@ def executeSuspend(quiet=False):
 			if res != 0:
 				tdata['error'] = 'cmd returned %d' % res
 		else:
+			s0ixready = sv.s0ixSupport()
 			mode = sv.suspendmode
 			if sv.memmode and os.path.exists(sv.mempowerfile):
 				mode = 'mem'
@@ -5509,9 +5499,10 @@ def executeSuspend(quiet=False):
 				sv.testVal(sv.diskpowerfile, 'radio', sv.diskmode)
 			if sv.acpidebug:
 				sv.testVal(sv.acpipath, 'acpi', '0xe')
-			if mode == 'freeze' and sv.haveTurbostat():
+			if ((mode == 'freeze') or (sv.memmode == 's2idle')) \
+				and sv.haveTurbostat():
 				# execution will pause here
-				turbo = sv.turbostat()
+				turbo = sv.turbostat(s0ixready)
 				if turbo:
 					tdata['turbo'] = turbo
 			else:
@@ -5522,7 +5513,8 @@ def executeSuspend(quiet=False):
 					pf.close()
 				except Exception as e:
 					tdata['error'] = str(e)
-		sv.dlog('system returned from resume')
+		sv.fsetVal('CMD COMPLETE', 'trace_marker')
+		sv.dlog('system returned')
 		# reset everything
 		sv.testVal('restoreall')
 		if(sv.rtcwake):
@@ -5535,33 +5527,29 @@ def executeSuspend(quiet=False):
 			sv.fsetVal('WAIT END', 'trace_marker')
 		# return from suspend
 		pprint('RESUME COMPLETE')
-		sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
+		if(count < sv.execcount):
+			sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
+		elif(not sv.wifitrace):
+			sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
+			sv.stop(pm)
 		if sv.wifi and wifi:
 			tdata['wifi'] = sv.pollWifi(wifi)
 			sv.dlog('wifi check, %s' % tdata['wifi'])
-			if sv.netfix:
-				netfixout = sv.netfixon('wired')
-		elif sv.netfix:
-			netfixout = sv.netfixon()
-		if sv.netfix and netfixout:
-			tdata['netfix'] = netfixout
+		if(count == sv.execcount and sv.wifitrace):
+			sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
+			sv.stop(pm)
+		if sv.netfix:
+			tdata['netfix'] = sv.netfixon()
 			sv.dlog('netfix, %s' % tdata['netfix'])
 		if(sv.suspendmode == 'mem' or sv.suspendmode == 'command'):
 			sv.dlog('read the ACPI FPDT')
 			tdata['fw'] = getFPDT(False)
 		testdata.append(tdata)
-	sv.dlog('run the cmdinfo list after')
+	sv.dlog('cmdinfo after')
 	cmdafter = sv.cmdinfo(False)
-	# stop ftrace
-	if sv.useftrace:
-		if sv.useprocmon:
-			sv.dlog('stop the process monitor')
-			pm.stop()
-		sv.fsetVal('0', 'tracing_on')
 	# grab a copy of the dmesg output
 	if not quiet:
 		pprint('CAPTURING DMESG')
-	sysvals.dlog('EXECUTION TRACE END')
 	sv.getdmesg(testdata)
 	# grab a copy of the ftrace output
 	if sv.useftrace:
@@ -6350,6 +6338,8 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 		if not m:
 			continue
 		name, time, phase = m.group('n'), m.group('t'), m.group('p')
+		if name == 'async_synchronize_full':
+			continue
 		if ' async' in name or ' sync' in name:
 			name = ' '.join(name.split(' ')[:-1])
 		if phase.startswith('suspend'):
@@ -6701,6 +6691,7 @@ def printHelp():
 	'   -skiphtml    Run the test and capture the trace logs, but skip the timeline (default: disabled)\n'\
 	'   -result fn   Export a results table to a text file for parsing.\n'\
 	'   -wifi        If a wifi connection is available, check that it reconnects after resume.\n'\
+	'   -wifitrace   Trace kernel execution through wifi reconnect.\n'\
 	'   -netfix      Use netfix to reset the network in the event it fails to resume.\n'\
 	'  [testprep]\n'\
 	'   -sync        Sync the filesystems before starting the test\n'\
@@ -6828,6 +6819,8 @@ if __name__ == '__main__':
 			sysvals.sync = True
 		elif(arg == '-wifi'):
 			sysvals.wifi = True
+		elif(arg == '-wifitrace'):
+			sysvals.wifitrace = True
 		elif(arg == '-netfix'):
 			sysvals.netfix = True
 		elif(arg == '-gzip'):
-- 
2.17.1

