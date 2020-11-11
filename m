Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D892AE67A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 03:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgKKCgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 21:36:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:13282 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732081AbgKKCgU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 21:36:20 -0500
IronPort-SDR: ZjT1CHo0qIoTXvGQHNOuj1/woa7tnjD+HqNYJeu82AeA8Of68KdKorwmQ2TIPgIxwlud+uQEvX
 fv0IRX8qeZGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157091902"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="157091902"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 18:36:19 -0800
IronPort-SDR: lD6gQelJIa1gbbverIvc15KhOy/4u0MxFQ23Nh8f9w+M8Hx2gRfO0YSorIZ3pjuuE+1oepmR4h
 CZO/uQQLGXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="366082701"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2020 18:36:19 -0800
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH] pm-graph v5.8
Date:   Tue, 10 Nov 2020 18:36:17 -0800
Message-Id: <0ee042aef591d6d07d4a8e1c87ac2dd7b3ebcdd3.1605060723.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- if wakeups occur in s2idle: "freeze time: N (-x ms waking y times) ms"
- change FREEZELOOP and FREEZEWAKE to S2LOOP and S2WAKE for brevity
- returns all sysfs vals to their initial state after testing
- use the dmesg log for debugging until the test is completed,
  instrument the executeSuspend process to have a full trace,
  if test completes, formal dmesg log overwrites the debug log
- fix CPU_ON and CPU_OFF devices in the timeline, should include [n]

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/README        |   4 +-
 tools/power/pm-graph/sleepgraph.py | 387 +++++++++++++++++------------
 2 files changed, 227 insertions(+), 164 deletions(-)

diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
index 89d0a7dab4bc..da468bd510ca 100644
--- a/tools/power/pm-graph/README
+++ b/tools/power/pm-graph/README
@@ -6,7 +6,7 @@
    |_|                    |___/          |_|
 
    pm-graph: suspend/resume/boot timing analysis tools
-    Version: 5.7
+    Version: 5.8
      Author: Todd Brandt <todd.e.brandt@intel.com>
   Home Page: https://01.org/pm-graph
 
@@ -61,7 +61,7 @@
        - runs with python2 or python3, choice is made by /usr/bin/python link
        - python
        - python-configparser (for python2 sleepgraph)
-       - python-requests (for googlesheet.py)
+       - python-requests (for stresstester.py)
        - linux-tools-common (for turbostat usage in sleepgraph)
 
        Ubuntu:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 1bc36a1db14f..81f4b8abbdf7 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -81,7 +81,7 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.7'
+	version = '5.8'
 	ansi = False
 	rs = 0
 	display = ''
@@ -92,8 +92,9 @@ class SystemValues:
 	testlog = True
 	dmesglog = True
 	ftracelog = False
+	acpidebug = True
 	tstat = True
-	mindevlen = 0.0
+	mindevlen = 0.0001
 	mincglen = 0.0
 	cgphase = ''
 	cgtest = -1
@@ -115,6 +116,7 @@ class SystemValues:
 	fpdtpath = '/sys/firmware/acpi/tables/FPDT'
 	epath = '/sys/kernel/debug/tracing/events/power/'
 	pmdpath = '/sys/power/pm_debug_messages'
+	acpipath='/sys/module/acpi/parameters/debug_level'
 	traceevents = [
 		'suspend_resume',
 		'wakeup_source_activate',
@@ -162,16 +164,16 @@ class SystemValues:
 	devdump = False
 	mixedphaseheight = True
 	devprops = dict()
+	cfgdef = dict()
 	platinfo = []
 	predelay = 0
 	postdelay = 0
-	pmdebug = ''
 	tmstart = 'SUSPEND START %Y%m%d-%H:%M:%S.%f'
 	tmend = 'RESUME COMPLETE %Y%m%d-%H:%M:%S.%f'
 	tracefuncs = {
 		'sys_sync': {},
 		'ksys_sync': {},
-		'pm_notifier_call_chain_robust': {},
+		'__pm_notifier_call_chain': {},
 		'pm_prepare_console': {},
 		'pm_notifier_call_chain': {},
 		'freeze_processes': {},
@@ -490,9 +492,9 @@ class SystemValues:
 		call('echo 0 > %s/wakealarm' % self.rtcpath, shell=True)
 	def initdmesg(self):
 		# get the latest time stamp from the dmesg log
-		fp = Popen('dmesg', stdout=PIPE).stdout
+		lines = Popen('dmesg', stdout=PIPE).stdout.readlines()
 		ktime = '0'
-		for line in fp:
+		for line in reversed(lines):
 			line = ascii(line).replace('\r\n', '')
 			idx = line.find('[')
 			if idx > 1:
@@ -500,7 +502,7 @@ class SystemValues:
 			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 			if(m):
 				ktime = m.group('ktime')
-		fp.close()
+				break
 		self.dmesgstart = float(ktime)
 	def getdmesg(self, testdata):
 		op = self.writeDatafileHeader(self.dmesgfile, testdata)
@@ -715,8 +717,6 @@ class SystemValues:
 			self.fsetVal('0', 'events/kprobes/enable')
 			self.fsetVal('', 'kprobe_events')
 			self.fsetVal('1024', 'buffer_size_kb')
-		if self.pmdebug:
-			self.setVal(self.pmdebug, self.pmdpath)
 	def setupAllKprobes(self):
 		for name in self.tracefuncs:
 			self.defaultKprobe(name, self.tracefuncs[name])
@@ -740,11 +740,7 @@ class SystemValues:
 		# turn trace off
 		self.fsetVal('0', 'tracing_on')
 		self.cleanupFtrace()
-		# pm debug messages
-		pv = self.getVal(self.pmdpath)
-		if pv != '1':
-			self.setVal('1', self.pmdpath)
-			self.pmdebug = pv
+		self.testVal(self.pmdpath, 'basic', '1')
 		# set the trace clock to global
 		self.fsetVal('global', 'trace_clock')
 		self.fsetVal('nop', 'current_tracer')
@@ -900,6 +896,14 @@ class SystemValues:
 		if isgz:
 			return gzip.open(filename, mode+'t')
 		return open(filename, mode)
+	def putlog(self, filename, text):
+		with self.openlog(filename, 'a') as fp:
+			fp.write(text)
+			fp.close()
+	def dlog(self, text):
+		self.putlog(self.dmesgfile, '# %s\n' % text)
+	def flog(self, text):
+		self.putlog(self.ftracefile, text)
 	def b64unzip(self, data):
 		try:
 			out = codecs.decode(base64.b64decode(data), 'zlib').decode()
@@ -992,9 +996,7 @@ class SystemValues:
 		# add a line for each of these commands with their outputs
 		for name, cmdline, info in cmdafter:
 			footer += '# platform-%s: %s | %s\n' % (name, cmdline, self.b64zip(info))
-
-		with self.openlog(self.ftracefile, 'a') as fp:
-			fp.write(footer)
+		self.flog(footer)
 		return True
 	def commonPrefix(self, list):
 		if len(list) < 2:
@@ -1034,6 +1036,7 @@ class SystemValues:
 			cmdline, cmdpath = ' '.join(cargs[2:]), self.getExec(cargs[2])
 			if not cmdpath or (begin and not delta):
 				continue
+			self.dlog('[%s]' % cmdline)
 			try:
 				fp = Popen([cmdpath]+cargs[3:], stdout=PIPE, stderr=PIPE).stdout
 				info = ascii(fp.read()).strip()
@@ -1060,6 +1063,29 @@ class SystemValues:
 			else:
 				out.append((name, cmdline, '\tnothing' if not info else info))
 		return out
+	def testVal(self, file, fmt='basic', value=''):
+		if file == 'restoreall':
+			for f in self.cfgdef:
+				if os.path.exists(f):
+					fp = open(f, 'w')
+					fp.write(self.cfgdef[f])
+					fp.close()
+			self.cfgdef = dict()
+		elif value and os.path.exists(file):
+			fp = open(file, 'r+')
+			if fmt == 'radio':
+				m = re.match('.*\[(?P<v>.*)\].*', fp.read())
+				if m:
+					self.cfgdef[file] = m.group('v')
+			elif fmt == 'acpi':
+				line = fp.read().strip().split('\n')[-1]
+				m = re.match('.* (?P<v>[0-9A-Fx]*) .*', line)
+				if m:
+					self.cfgdef[file] = m.group('v')
+			else:
+				self.cfgdef[file] = fp.read().strip()
+			fp.write(value)
+			fp.close()
 	def haveTurbostat(self):
 		if not self.tstat:
 			return False
@@ -1201,6 +1227,57 @@ class SystemValues:
 			self.multitest[sz] *= 1440
 		elif unit == 'h':
 			self.multitest[sz] *= 60
+	def displayControl(self, cmd):
+		xset, ret = 'timeout 10 xset -d :0.0 {0}', 0
+		if self.sudouser:
+			xset = 'sudo -u %s %s' % (self.sudouser, xset)
+		if cmd == 'init':
+			ret = call(xset.format('dpms 0 0 0'), shell=True)
+			if not ret:
+				ret = call(xset.format('s off'), shell=True)
+		elif cmd == 'reset':
+			ret = call(xset.format('s reset'), shell=True)
+		elif cmd in ['on', 'off', 'standby', 'suspend']:
+			b4 = self.displayControl('stat')
+			ret = call(xset.format('dpms force %s' % cmd), shell=True)
+			if not ret:
+				curr = self.displayControl('stat')
+				self.vprint('Display Switched: %s -> %s' % (b4, curr))
+				if curr != cmd:
+					self.vprint('WARNING: Display failed to change to %s' % cmd)
+			if ret:
+				self.vprint('WARNING: Display failed to change to %s with xset' % cmd)
+				return ret
+		elif cmd == 'stat':
+			fp = Popen(xset.format('q').split(' '), stdout=PIPE).stdout
+			ret = 'unknown'
+			for line in fp:
+				m = re.match('[\s]*Monitor is (?P<m>.*)', ascii(line))
+				if(m and len(m.group('m')) >= 2):
+					out = m.group('m').lower()
+					ret = out[3:] if out[0:2] == 'in' else out
+					break
+			fp.close()
+		return ret
+	def setRuntimeSuspend(self, before=True):
+		if before:
+			# runtime suspend disable or enable
+			if self.rs > 0:
+				self.rstgt, self.rsval, self.rsdir = 'on', 'auto', 'enabled'
+			else:
+				self.rstgt, self.rsval, self.rsdir = 'auto', 'on', 'disabled'
+			pprint('CONFIGURING RUNTIME SUSPEND...')
+			self.rslist = deviceInfo(self.rstgt)
+			for i in self.rslist:
+				self.setVal(self.rsval, i)
+			pprint('runtime suspend %s on all devices (%d changed)' % (self.rsdir, len(self.rslist)))
+			pprint('waiting 5 seconds...')
+			time.sleep(5)
+		else:
+			# runtime suspend re-enable or re-disable
+			for i in self.rslist:
+				self.setVal(self.rstgt, i)
+			pprint('runtime suspend settings restored on %d devices' % len(self.rslist))
 
 sysvals = SystemValues()
 switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
@@ -1640,15 +1717,20 @@ class Data:
 			if 'resume_machine' in phase and 'suspend_machine' in lp:
 				tS, tR = self.dmesg[lp]['end'], self.dmesg[phase]['start']
 				tL = tR - tS
-				if tL > 0:
-					left = True if tR > tZero else False
-					self.trimTime(tS, tL, left)
-					if 'trying' in self.dmesg[lp] and self.dmesg[lp]['trying'] >= 0.001:
-						tTry = round(self.dmesg[lp]['trying'] * 1000)
-						text = '%.0f (-%.0f waking)' % (tL * 1000, tTry)
+				if tL <= 0:
+					continue
+				left = True if tR > tZero else False
+				self.trimTime(tS, tL, left)
+				if 'waking' in self.dmesg[lp]:
+					tCnt = self.dmesg[lp]['waking'][0]
+					if self.dmesg[lp]['waking'][1] >= 0.001:
+						tTry = '-%.0f' % (round(self.dmesg[lp]['waking'][1] * 1000))
 					else:
-						text = '%.0f' % (tL * 1000)
-					self.tLow.append(text)
+						tTry = '-%.3f' % (self.dmesg[lp]['waking'][1] * 1000)
+					text = '%.0f (%s ms waking %d times)' % (tL * 1000, tTry, tCnt)
+				else:
+					text = '%.0f' % (tL * 1000)
+				self.tLow.append(text)
 			lp = phase
 	def getMemTime(self):
 		if not self.hwstart or not self.hwend:
@@ -1921,7 +2003,7 @@ class Data:
 			for dev in list:
 				length = (list[dev]['end'] - list[dev]['start']) * 1000
 				width = widfmt % (((list[dev]['end']-list[dev]['start'])*100)/tTotal)
-				if width != '0.000000' and length >= mindevlen:
+				if length >= mindevlen:
 					devlist.append(dev)
 			self.tdevlist[phase] = devlist
 	def addHorizontalDivider(self, devname, devend):
@@ -3316,9 +3398,10 @@ def parseTraceLog(live=False):
 							# trim out s2idle loops, track time trying to freeze
 							llp = data.lastPhase(2)
 							if llp.startswith('suspend_machine'):
-								if 'trying' not in data.dmesg[llp]:
-									data.dmesg[llp]['trying'] = 0
-								data.dmesg[llp]['trying'] += \
+								if 'waking' not in data.dmesg[llp]:
+									data.dmesg[llp]['waking'] = [0, 0.0]
+								data.dmesg[llp]['waking'][0] += 1
+								data.dmesg[llp]['waking'][1] += \
 									t.time - data.dmesg[lp]['start']
 							data.currphase = ''
 							del data.dmesg[lp]
@@ -4555,7 +4638,7 @@ def createHTML(testruns, testfail):
 				# draw the devices for this phase
 				phaselist = data.dmesg[b]['list']
 				for d in sorted(data.tdevlist[b]):
-					dname = d if '[' not in d else d.split('[')[0]
+					dname = d if ('[' not in d or 'CPU' in d) else d.split('[')[0]
 					name, dev = dname, phaselist[d]
 					drv = xtraclass = xtrainfo = xtrastyle = ''
 					if 'htmlclass' in dev:
@@ -5194,156 +5277,146 @@ def addScriptCode(hf, testruns):
 	'</script>\n'
 	hf.write(script_code);
 
-def setRuntimeSuspend(before=True):
-	global sysvals
-	sv = sysvals
-	if sv.rs == 0:
-		return
-	if before:
-		# runtime suspend disable or enable
-		if sv.rs > 0:
-			sv.rstgt, sv.rsval, sv.rsdir = 'on', 'auto', 'enabled'
-		else:
-			sv.rstgt, sv.rsval, sv.rsdir = 'auto', 'on', 'disabled'
-		pprint('CONFIGURING RUNTIME SUSPEND...')
-		sv.rslist = deviceInfo(sv.rstgt)
-		for i in sv.rslist:
-			sv.setVal(sv.rsval, i)
-		pprint('runtime suspend %s on all devices (%d changed)' % (sv.rsdir, len(sv.rslist)))
-		pprint('waiting 5 seconds...')
-		time.sleep(5)
-	else:
-		# runtime suspend re-enable or re-disable
-		for i in sv.rslist:
-			sv.setVal(sv.rstgt, i)
-		pprint('runtime suspend settings restored on %d devices' % len(sv.rslist))
-
 # Function: executeSuspend
 # Description:
 #	 Execute system suspend through the sysfs interface, then copy the output
 #	 dmesg and ftrace files to the test output directory.
 def executeSuspend(quiet=False):
-	pm = ProcessMonitor()
-	tp = sysvals.tpath
-	if sysvals.wifi:
-		wifi = sysvals.checkWifi()
+	sv, tp, pm = sysvals, sysvals.tpath, ProcessMonitor()
+	if sv.wifi:
+		wifi = sv.checkWifi()
+		sv.dlog('wifi check, connected device is "%s"' % wifi)
 	testdata = []
 	# run these commands to prepare the system for suspend
-	if sysvals.display:
+	if sv.display:
 		if not quiet:
-			pprint('SET DISPLAY TO %s' % sysvals.display.upper())
-		displayControl(sysvals.display)
+			pprint('SET DISPLAY TO %s' % sv.display.upper())
+		ret = sv.displayControl(sv.display)
+		sv.dlog('xset display %s, ret = %d' % (sv.display, ret))
 		time.sleep(1)
-	if sysvals.sync:
+	if sv.sync:
 		if not quiet:
 			pprint('SYNCING FILESYSTEMS')
+		sv.dlog('syncing filesystems')
 		call('sync', shell=True)
-	# mark the start point in the kernel ring buffer just as we start
-	sysvals.initdmesg()
+	sv.dlog('read dmesg')
+	sv.initdmesg()
 	# start ftrace
-	if(sysvals.usecallgraph or sysvals.usetraceevents):
+	if(sv.usecallgraph or sv.usetraceevents):
 		if not quiet:
 			pprint('START TRACING')
-		sysvals.fsetVal('1', 'tracing_on')
-		if sysvals.useprocmon:
+		sv.dlog('start ftrace tracing')
+		sv.fsetVal('1', 'tracing_on')
+		if sv.useprocmon:
+			sv.dlog('start the process monitor')
 			pm.start()
-	sysvals.cmdinfo(True)
+	sv.dlog('run the cmdinfo list before')
+	sv.cmdinfo(True)
 	# execute however many s/r runs requested
-	for count in range(1,sysvals.execcount+1):
+	for count in range(1,sv.execcount+1):
 		# x2delay in between test runs
-		if(count > 1 and sysvals.x2delay > 0):
-			sysvals.fsetVal('WAIT %d' % sysvals.x2delay, 'trace_marker')
-			time.sleep(sysvals.x2delay/1000.0)
-			sysvals.fsetVal('WAIT END', 'trace_marker')
+		if(count > 1 and sv.x2delay > 0):
+			sv.fsetVal('WAIT %d' % sv.x2delay, 'trace_marker')
+			time.sleep(sv.x2delay/1000.0)
+			sv.fsetVal('WAIT END', 'trace_marker')
 		# start message
-		if sysvals.testcommand != '':
+		if sv.testcommand != '':
 			pprint('COMMAND START')
 		else:
-			if(sysvals.rtcwake):
+			if(sv.rtcwake):
 				pprint('SUSPEND START')
 			else:
 				pprint('SUSPEND START (press a key to resume)')
 		# set rtcwake
-		if(sysvals.rtcwake):
+		if(sv.rtcwake):
 			if not quiet:
-				pprint('will issue an rtcwake in %d seconds' % sysvals.rtcwaketime)
-			sysvals.rtcWakeAlarmOn()
+				pprint('will issue an rtcwake in %d seconds' % sv.rtcwaketime)
+			sv.dlog('enable RTC wake alarm')
+			sv.rtcWakeAlarmOn()
 		# start of suspend trace marker
-		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			sysvals.fsetVal(datetime.now().strftime(sysvals.tmstart), 'trace_marker')
+		if(sv.usecallgraph or sv.usetraceevents):
+			sv.fsetVal(datetime.now().strftime(sv.tmstart), 'trace_marker')
 		# predelay delay
-		if(count == 1 and sysvals.predelay > 0):
-			sysvals.fsetVal('WAIT %d' % sysvals.predelay, 'trace_marker')
-			time.sleep(sysvals.predelay/1000.0)
-			sysvals.fsetVal('WAIT END', 'trace_marker')
+		if(count == 1 and sv.predelay > 0):
+			sv.fsetVal('WAIT %d' % sv.predelay, 'trace_marker')
+			time.sleep(sv.predelay/1000.0)
+			sv.fsetVal('WAIT END', 'trace_marker')
 		# initiate suspend or command
+		sv.dlog('system executing a suspend')
 		tdata = {'error': ''}
-		if sysvals.testcommand != '':
-			res = call(sysvals.testcommand+' 2>&1', shell=True);
+		if sv.testcommand != '':
+			res = call(sv.testcommand+' 2>&1', shell=True);
 			if res != 0:
 				tdata['error'] = 'cmd returned %d' % res
 		else:
-			mode = sysvals.suspendmode
-			if sysvals.memmode and os.path.exists(sysvals.mempowerfile):
+			mode = sv.suspendmode
+			if sv.memmode and os.path.exists(sv.mempowerfile):
 				mode = 'mem'
-				pf = open(sysvals.mempowerfile, 'w')
-				pf.write(sysvals.memmode)
-				pf.close()
-			if sysvals.diskmode and os.path.exists(sysvals.diskpowerfile):
+				sv.testVal(sv.mempowerfile, 'radio', sv.memmode)
+			if sv.diskmode and os.path.exists(sv.diskpowerfile):
 				mode = 'disk'
-				pf = open(sysvals.diskpowerfile, 'w')
-				pf.write(sysvals.diskmode)
-				pf.close()
-			if mode == 'freeze' and sysvals.haveTurbostat():
+				sv.testVal(sv.diskpowerfile, 'radio', sv.diskmode)
+			if sv.acpidebug:
+				sv.testVal(sv.acpipath, 'acpi', '0xe')
+			if mode == 'freeze' and sv.haveTurbostat():
 				# execution will pause here
-				turbo = sysvals.turbostat()
+				turbo = sv.turbostat()
 				if turbo:
 					tdata['turbo'] = turbo
 			else:
-				pf = open(sysvals.powerfile, 'w')
+				pf = open(sv.powerfile, 'w')
 				pf.write(mode)
 				# execution will pause here
 				try:
 					pf.close()
 				except Exception as e:
 					tdata['error'] = str(e)
-		if(sysvals.rtcwake):
-			sysvals.rtcWakeAlarmOff()
+		sv.dlog('system returned from resume')
+		# reset everything
+		sv.testVal('restoreall')
+		if(sv.rtcwake):
+			sv.dlog('disable RTC wake alarm')
+			sv.rtcWakeAlarmOff()
 		# postdelay delay
-		if(count == sysvals.execcount and sysvals.postdelay > 0):
-			sysvals.fsetVal('WAIT %d' % sysvals.postdelay, 'trace_marker')
-			time.sleep(sysvals.postdelay/1000.0)
-			sysvals.fsetVal('WAIT END', 'trace_marker')
+		if(count == sv.execcount and sv.postdelay > 0):
+			sv.fsetVal('WAIT %d' % sv.postdelay, 'trace_marker')
+			time.sleep(sv.postdelay/1000.0)
+			sv.fsetVal('WAIT END', 'trace_marker')
 		# return from suspend
 		pprint('RESUME COMPLETE')
-		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			sysvals.fsetVal(datetime.now().strftime(sysvals.tmend), 'trace_marker')
-		if sysvals.wifi and wifi:
-			tdata['wifi'] = sysvals.pollWifi(wifi)
-		if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
+		if(sv.usecallgraph or sv.usetraceevents):
+			sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
+		if sv.wifi and wifi:
+			tdata['wifi'] = sv.pollWifi(wifi)
+			sv.dlog('wifi check, %s' % tdata['wifi'])
+		if(sv.suspendmode == 'mem' or sv.suspendmode == 'command'):
+			sv.dlog('read the ACPI FPDT')
 			tdata['fw'] = getFPDT(False)
 		testdata.append(tdata)
-	cmdafter = sysvals.cmdinfo(False)
+	sv.dlog('run the cmdinfo list after')
+	cmdafter = sv.cmdinfo(False)
 	# stop ftrace
-	if(sysvals.usecallgraph or sysvals.usetraceevents):
-		if sysvals.useprocmon:
+	if(sv.usecallgraph or sv.usetraceevents):
+		if sv.useprocmon:
+			sv.dlog('stop the process monitor')
 			pm.stop()
-		sysvals.fsetVal('0', 'tracing_on')
+		sv.fsetVal('0', 'tracing_on')
 	# grab a copy of the dmesg output
 	if not quiet:
 		pprint('CAPTURING DMESG')
-	sysvals.getdmesg(testdata)
+	sysvals.dlog('EXECUTION TRACE END')
+	sv.getdmesg(testdata)
 	# grab a copy of the ftrace output
-	if(sysvals.usecallgraph or sysvals.usetraceevents):
+	if(sv.usecallgraph or sv.usetraceevents):
 		if not quiet:
 			pprint('CAPTURING TRACE')
-		op = sysvals.writeDatafileHeader(sysvals.ftracefile, testdata)
+		op = sv.writeDatafileHeader(sv.ftracefile, testdata)
 		fp = open(tp+'trace', 'r')
 		for line in fp:
 			op.write(line)
 		op.close()
-		sysvals.fsetVal('', 'trace')
-		sysvals.platforminfo(cmdafter)
+		sv.fsetVal('', 'trace')
+		sv.platforminfo(cmdafter)
 
 def readFile(file):
 	if os.path.islink(file):
@@ -5586,39 +5659,6 @@ def dmidecode(mempath, fatal=False):
 		count += 1
 	return out
 
-def displayControl(cmd):
-	xset, ret = 'timeout 10 xset -d :0.0 {0}', 0
-	if sysvals.sudouser:
-		xset = 'sudo -u %s %s' % (sysvals.sudouser, xset)
-	if cmd == 'init':
-		ret = call(xset.format('dpms 0 0 0'), shell=True)
-		if not ret:
-			ret = call(xset.format('s off'), shell=True)
-	elif cmd == 'reset':
-		ret = call(xset.format('s reset'), shell=True)
-	elif cmd in ['on', 'off', 'standby', 'suspend']:
-		b4 = displayControl('stat')
-		ret = call(xset.format('dpms force %s' % cmd), shell=True)
-		if not ret:
-			curr = displayControl('stat')
-			sysvals.vprint('Display Switched: %s -> %s' % (b4, curr))
-			if curr != cmd:
-				sysvals.vprint('WARNING: Display failed to change to %s' % cmd)
-		if ret:
-			sysvals.vprint('WARNING: Display failed to change to %s with xset' % cmd)
-			return ret
-	elif cmd == 'stat':
-		fp = Popen(xset.format('q').split(' '), stdout=PIPE).stdout
-		ret = 'unknown'
-		for line in fp:
-			m = re.match('[\s]*Monitor is (?P<m>.*)', ascii(line))
-			if(m and len(m.group('m')) >= 2):
-				out = m.group('m').lower()
-				ret = out[3:] if out[0:2] == 'in' else out
-				break
-		fp.close()
-	return ret
-
 # Function: getFPDT
 # Description:
 #	 Read the acpi bios tables and pull out FPDT, the firmware data
@@ -6001,8 +6041,19 @@ def rerunTest(htmlfile=''):
 #	 execute a suspend/resume, gather the logs, and generate the output
 def runTest(n=0, quiet=False):
 	# prepare for the test
-	sysvals.initFtrace(quiet)
 	sysvals.initTestOutput('suspend')
+	op = sysvals.writeDatafileHeader(sysvals.dmesgfile, [])
+	op.write('# EXECUTION TRACE START\n')
+	op.close()
+	if n <= 1:
+		if sysvals.rs != 0:
+			sysvals.dlog('%sabling runtime suspend' % ('en' if sysvals.rs > 0 else 'dis'))
+			sysvals.setRuntimeSuspend(True)
+		if sysvals.display:
+			ret = sysvals.displayControl('init')
+			sysvals.dlog('xset display init, ret = %d' % ret)
+	sysvals.dlog('initialize ftrace')
+	sysvals.initFtrace(quiet)
 
 	# execute the test
 	executeSuspend(quiet)
@@ -6098,8 +6149,16 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 	if wifi:
 		extra['wifi'] = wifi
 	low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
-	if low and 'waking' in low:
-		issue = 'FREEZEWAKE'
+	for lowstr in ['waking', '+']:
+		if not low:
+			break
+		if lowstr not in low:
+			continue
+		if lowstr == '+':
+			issue = 'S2LOOPx%d' % len(low.split('+'))
+		else:
+			m = re.match('.*waking *(?P<n>[0-9]*) *times.*', low)
+			issue = 'S2WAKEx%s' % m.group('n') if m else 'S2WAKExNaN'
 		match = [i for i in issues if i['match'] == issue]
 		if len(match) > 0:
 			match[0]['count'] += 1
@@ -6605,6 +6664,11 @@ if __name__ == '__main__':
 				val = next(args)
 			except:
 				doError('-info requires one string argument', True)
+		elif(arg == '-desc'):
+			try:
+				val = next(args)
+			except:
+				doError('-desc requires one string argument', True)
 		elif(arg == '-rs'):
 			try:
 				val = next(args)
@@ -6814,9 +6878,9 @@ if __name__ == '__main__':
 			runSummary(sysvals.outdir, True, genhtml)
 		elif(cmd in ['xon', 'xoff', 'xstandby', 'xsuspend', 'xinit', 'xreset']):
 			sysvals.verbose = True
-			ret = displayControl(cmd[1:])
+			ret = sysvals.displayControl(cmd[1:])
 		elif(cmd == 'xstat'):
-			pprint('Display Status: %s' % displayControl('stat').upper())
+			pprint('Display Status: %s' % sysvals.displayControl('stat').upper())
 		elif(cmd == 'wificheck'):
 			dev = sysvals.checkWifi()
 			if dev:
@@ -6854,12 +6918,8 @@ if __name__ == '__main__':
 	if mode.startswith('disk-'):
 		sysvals.diskmode = mode.split('-', 1)[-1]
 		sysvals.suspendmode = 'disk'
-
 	sysvals.systemInfo(dmidecode(sysvals.mempath))
 
-	setRuntimeSuspend(True)
-	if sysvals.display:
-		displayControl('init')
 	failcnt, ret = 0, 0
 	if sysvals.multitest['run']:
 		# run multiple tests in a separate subdirectory
@@ -6900,7 +6960,10 @@ if __name__ == '__main__':
 			sysvals.testdir = sysvals.outdir
 		# run the test in the current directory
 		ret = runTest()
+
+	# reset to default values after testing
 	if sysvals.display:
-		displayControl('reset')
-	setRuntimeSuspend(False)
+		sysvals.displayControl('reset')
+	if sysvals.rs != 0:
+		sysvals.setRuntimeSuspend(False)
 	sys.exit(ret)
-- 
2.25.1

