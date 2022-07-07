Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3156AEC2
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 00:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiGGWy4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiGGWy4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 18:54:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39861D73
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657234493; x=1688770493;
  h=from:to:cc:subject:date:message-id;
  bh=d0e2IPWvwq7oy6hjonBqJqd1/uRdF7L4yJXoEMry4lg=;
  b=ZKpDB6z6SxcOBSz20tcINMIlwX6g/8Cm52wE/hLGFSEpjWuf0sPAabi0
   mu7tqUrTqUJX2+gphilQh2cT5ilZUHAXK+kPeKiiZIwNsvFskTEw92uko
   vfK0nVBmVpDmD9Ecr5hswU3k/Z9HjCDwlEtwX8+pNm68JPNrgf3rftwBV
   nHYA5ldTtO3VQnGRh0/Bm8lp7g2HoSDjqyRne5WT21Ul1U5gZ9iToRuDs
   nVclOzbB+GtQwpQGi4Y4F7nYc8lHa3mpqDeq2UjwMiunAvMWymyyfYKDJ
   MyUPVsAL4llA6zfkTZt7Pmw13HN8bWwEcX1jYz5pYlvcJGUHFTuJ+eXqT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284879969"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="284879969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 15:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="770584372"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2022 15:54:52 -0700
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH] pm-graph v5.9
Date:   Thu,  7 Jul 2022 15:54:51 -0700
Message-Id: <20220707225451.32738-1-todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bootgraph:
- fix parsing of /proc/version to be much more flexible
- check kernel version to disallow ftrace on anything older than 4.10
sleepgraph:
- include fix to bugzilla 212761 in case it regresses
- fix for -proc bug: https://github.com/intel/pm-graph/pull/20
- add -debugtiming arg to get timestamps on prints
- allow use of the netfix tool hosted in the github repo
- read s0ix data from pmc_core for better debug
- include more system data in the output log
- Do a better job testing input files useability
- flag more error data from dmesg in the timeline
- pre-parse the trace log to fix any ordering issues
- add new parser to process dmesg only timelines
- remove superflous sleep(5) in multitest mode
config/custom-timeline-functions.cfg:
- change some names to keep up to date
README:
- new version, small wording changes

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 tools/power/pm-graph/README                   |   6 +-
 tools/power/pm-graph/bootgraph.py             |  20 +-
 .../config/custom-timeline-functions.cfg      |   2 +-
 tools/power/pm-graph/sleepgraph.py            | 518 ++++++++++++------
 4 files changed, 360 insertions(+), 186 deletions(-)

diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
index da468bd510ca..e6020c0d59ec 100644
--- a/tools/power/pm-graph/README
+++ b/tools/power/pm-graph/README
@@ -6,7 +6,7 @@
    |_|                    |___/          |_|
 
    pm-graph: suspend/resume/boot timing analysis tools
-    Version: 5.8
+    Version: 5.9
      Author: Todd Brandt <todd.e.brandt@intel.com>
   Home Page: https://01.org/pm-graph
 
@@ -97,8 +97,8 @@
         (kernel/pre-3.15/enable_trace_events_suspend_resume.patch)
         (kernel/pre-3.15/enable_trace_events_device_pm_callback.patch)
 
-	If you're using a kernel older than 3.15.0, the following
-        additional kernel parameters are required:
+	If you're using bootgraph, or sleepgraph with a kernel older than 3.15.0,
+		the following additional kernel parameters are required:
         (e.g. in file /etc/default/grub)
         GRUB_CMDLINE_LINUX_DEFAULT="... initcall_debug log_buf_len=32M ..."
 
diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index 2823cd3122f7..f96f50e0c336 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -69,22 +69,24 @@ class SystemValues(aslib.SystemValues):
 	bootloader = 'grub'
 	blexec = []
 	def __init__(self):
-		self.hostname = platform.node()
+		self.kernel, self.hostname = 'unknown', platform.node()
 		self.testtime = datetime.now().strftime('%Y-%m-%d_%H:%M:%S')
 		if os.path.exists('/proc/version'):
 			fp = open('/proc/version', 'r')
-			val = fp.read().strip()
+			self.kernel = self.kernelVersion(fp.read().strip())
 			fp.close()
-			self.kernel = self.kernelVersion(val)
-		else:
-			self.kernel = 'unknown'
 		self.testdir = datetime.now().strftime('boot-%y%m%d-%H%M%S')
 	def kernelVersion(self, msg):
-		return msg.split()[2]
+		m = re.match('^[Ll]inux *[Vv]ersion *(?P<v>\S*) .*', msg)
+		if m:
+			return m.group('v')
+		return 'unknown'
 	def checkFtraceKernelVersion(self):
-		val = tuple(map(int, self.kernel.split('-')[0].split('.')))
-		if val >= (4, 10, 0):
-			return True
+		m = re.match('^(?P<x>[0-9]*)\.(?P<y>[0-9]*)\.(?P<z>[0-9]*).*', self.kernel)
+		if m:
+			val = tuple(map(int, m.groups()))
+			if val >= (4, 10, 0):
+				return True
 		return False
 	def kernelParams(self):
 		cmdline = 'initcall_debug log_buf_len=32M'
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 962e5768681c..4f80ad7d7275 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -125,7 +125,7 @@ acpi_suspend_begin:
 suspend_console:
 acpi_pm_prepare:
 syscore_suspend:
-arch_thaw_secondary_cpus_end:
+arch_enable_nonboot_cpus_end:
 syscore_resume:
 acpi_pm_finish:
 resume_console:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index ffd50953a024..33981adcdd68 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -66,8 +66,13 @@ from threading import Thread
 from subprocess import call, Popen, PIPE
 import base64
 
+debugtiming = False
+mystarttime = time.time()
 def pprint(msg):
-	print(msg)
+	if debugtiming:
+		print('[%09.3f] %s' % (time.time()-mystarttime, msg))
+	else:
+		print(msg)
 	sys.stdout.flush()
 
 def ascii(text):
@@ -81,13 +86,14 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.8'
+	version = '5.9'
 	ansi = False
 	rs = 0
 	display = ''
 	gzip = False
 	sync = False
 	wifi = False
+	netfix = False
 	verbose = False
 	testlog = True
 	dmesglog = True
@@ -108,6 +114,7 @@ class SystemValues:
 	cpucount = 0
 	memtotal = 204800
 	memfree = 204800
+	osversion = ''
 	srgap = 0
 	cgexp = False
 	testdir = ''
@@ -116,6 +123,7 @@ class SystemValues:
 	fpdtpath = '/sys/firmware/acpi/tables/FPDT'
 	epath = '/sys/kernel/debug/tracing/events/power/'
 	pmdpath = '/sys/power/pm_debug_messages'
+	s0ixpath = '/sys/module/intel_pmc_core/parameters/warn_on_s0ix_failures'
 	acpipath='/sys/module/acpi/parameters/debug_level'
 	traceevents = [
 		'suspend_resume',
@@ -156,6 +164,7 @@ class SystemValues:
 	ftop = False
 	usetraceevents = False
 	usetracemarkers = True
+	useftrace = True
 	usekprobes = True
 	usedevsrc = False
 	useprocmon = False
@@ -279,10 +288,16 @@ class SystemValues:
 		'intel_fbdev_set_suspend': {},
 	}
 	infocmds = [
+		[0, 'sysinfo', 'uname', '-a'],
+		[0, 'cpuinfo', 'head', '-7', '/proc/cpuinfo'],
 		[0, 'kparams', 'cat', '/proc/cmdline'],
 		[0, 'mcelog', 'mcelog'],
 		[0, 'pcidevices', 'lspci', '-tv'],
-		[0, 'usbdevices', 'lsusb', '-t'],
+		[0, 'usbdevices', 'lsusb', '-tv'],
+		[0, 'acpidevices', 'sh', '-c', 'ls -l /sys/bus/acpi/devices/*/physical_node'],
+		[0, 's0ix_require', 'cat', '/sys/kernel/debug/pmc_core/substate_requirements'],
+		[0, 's0ix_debug', 'cat', '/sys/kernel/debug/pmc_core/slp_s0_debug_status'],
+		[1, 's0ix_residency', 'cat', '/sys/kernel/debug/pmc_core/slp_s0_residency_usec'],
 		[1, 'interrupts', 'cat', '/proc/interrupts'],
 		[1, 'wakeups', 'cat', '/sys/kernel/debug/wakeup_sources'],
 		[2, 'gpecounts', 'sh', '-c', 'grep -v invalid /sys/firmware/acpi/interrupts/*'],
@@ -358,8 +373,19 @@ class SystemValues:
 			self.outputResult({'error':msg})
 			sys.exit(1)
 		return False
-	def usable(self, file):
-		return (os.path.exists(file) and os.path.getsize(file) > 0)
+	def usable(self, file, ishtml=False):
+		if not os.path.exists(file) or os.path.getsize(file) < 1:
+			return False
+		if ishtml:
+			try:
+				fp = open(file, 'r')
+				res = fp.read(1000)
+				fp.close()
+			except:
+				return False
+			if '<html>' not in res:
+				return False
+		return True
 	def getExec(self, cmd):
 		try:
 			fp = Popen(['which', cmd], stdout=PIPE, stderr=PIPE).stdout
@@ -413,12 +439,16 @@ class SystemValues:
 		r = info['bios-release-date'] if 'bios-release-date' in info else ''
 		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | biosdate:%s | numcpu:%d | memsz:%d | memfr:%d' % \
 			(m, p, c, b, r, self.cpucount, self.memtotal, self.memfree)
+		if self.osversion:
+			self.sysstamp += ' | os:%s' % self.osversion
 	def printSystemInfo(self, fatal=False):
 		self.rootCheck(True)
 		out = dmidecode(self.mempath, fatal)
 		if len(out) < 1:
 			return
 		fmt = '%-24s: %s'
+		if self.osversion:
+			print(fmt % ('os-version', self.osversion))
 		for name in sorted(out):
 			print(fmt % (name, out[name]))
 		print(fmt % ('cpucount', ('%d' % self.cpucount)))
@@ -426,20 +456,25 @@ class SystemValues:
 		print(fmt % ('memfree', ('%d kB' % self.memfree)))
 	def cpuInfo(self):
 		self.cpucount = 0
-		fp = open('/proc/cpuinfo', 'r')
-		for line in fp:
-			if re.match('^processor[ \t]*:[ \t]*[0-9]*', line):
-				self.cpucount += 1
-		fp.close()
-		fp = open('/proc/meminfo', 'r')
-		for line in fp:
-			m = re.match('^MemTotal:[ \t]*(?P<sz>[0-9]*) *kB', line)
-			if m:
-				self.memtotal = int(m.group('sz'))
-			m = re.match('^MemFree:[ \t]*(?P<sz>[0-9]*) *kB', line)
-			if m:
-				self.memfree = int(m.group('sz'))
-		fp.close()
+		if os.path.exists('/proc/cpuinfo'):
+			with open('/proc/cpuinfo', 'r') as fp:
+				for line in fp:
+					if re.match('^processor[ \t]*:[ \t]*[0-9]*', line):
+						self.cpucount += 1
+		if os.path.exists('/proc/meminfo'):
+			with open('/proc/meminfo', 'r') as fp:
+				for line in fp:
+					m = re.match('^MemTotal:[ \t]*(?P<sz>[0-9]*) *kB', line)
+					if m:
+						self.memtotal = int(m.group('sz'))
+					m = re.match('^MemFree:[ \t]*(?P<sz>[0-9]*) *kB', line)
+					if m:
+						self.memfree = int(m.group('sz'))
+		if os.path.exists('/etc/os-release'):
+			with open('/etc/os-release', 'r') as fp:
+				for line in fp:
+					if line.startswith('PRETTY_NAME='):
+						self.osversion = line[12:].strip().replace('"', '')
 	def initTestOutput(self, name):
 		self.prefix = self.hostname
 		v = open('/proc/version', 'r').read().strip()
@@ -698,6 +733,8 @@ class SystemValues:
 			return False
 		return True
 	def fsetVal(self, val, path):
+		if not self.useftrace:
+			return False
 		return self.setVal(val, self.tpath+path)
 	def getVal(self, file):
 		res = ''
@@ -711,9 +748,11 @@ class SystemValues:
 			pass
 		return res
 	def fgetVal(self, path):
+		if not self.useftrace:
+			return ''
 		return self.getVal(self.tpath+path)
 	def cleanupFtrace(self):
-		if(self.usecallgraph or self.usetraceevents or self.usedevsrc):
+		if self.useftrace:
 			self.fsetVal('0', 'events/kprobes/enable')
 			self.fsetVal('', 'kprobe_events')
 			self.fsetVal('1024', 'buffer_size_kb')
@@ -734,13 +773,14 @@ class SystemValues:
 				return True
 		return False
 	def initFtrace(self, quiet=False):
+		if not self.useftrace:
+			return
 		if not quiet:
 			sysvals.printSystemInfo(False)
 			pprint('INITIALIZING FTRACE...')
 		# turn trace off
 		self.fsetVal('0', 'tracing_on')
 		self.cleanupFtrace()
-		self.testVal(self.pmdpath, 'basic', '1')
 		# set the trace clock to global
 		self.fsetVal('global', 'trace_clock')
 		self.fsetVal('nop', 'current_tracer')
@@ -766,6 +806,10 @@ class SystemValues:
 			# set trace type
 			self.fsetVal('function_graph', 'current_tracer')
 			self.fsetVal('', 'set_ftrace_filter')
+			# temporary hack to fix https://bugzilla.kernel.org/show_bug.cgi?id=212761
+			fp = open(self.tpath+'set_ftrace_notrace', 'w')
+			fp.write('native_queued_spin_lock_slowpath\ndev_driver_string')
+			fp.close()
 			# set trace format options
 			self.fsetVal('print-parent', 'trace_options')
 			self.fsetVal('funcgraph-abstime', 'trace_options')
@@ -846,6 +890,8 @@ class SystemValues:
 				fp.write('# turbostat %s\n' % test['turbo'])
 			if 'wifi' in test:
 				fp.write('# wifi %s\n' % test['wifi'])
+			if 'netfix' in test:
+				fp.write('# netfix %s\n' % test['netfix'])
 			if test['error'] or len(testdata) > 1:
 				fp.write('# enter_sleep_error %s\n' % test['error'])
 		return fp
@@ -865,6 +911,8 @@ class SystemValues:
 			fp.write('error%s: %s\n' % (n, testdata['error']))
 		else:
 			fp.write('result%s: pass\n' % n)
+		if 'mode' in testdata:
+			fp.write('mode%s: %s\n' % (n, testdata['mode']))
 		for v in ['suspend', 'resume', 'boot', 'lastinit']:
 			if v in testdata:
 				fp.write('%s%s: %.3f\n' % (v, n, testdata[v]))
@@ -901,6 +949,8 @@ class SystemValues:
 			fp.write(text)
 			fp.close()
 	def dlog(self, text):
+		if not self.dmesgfile:
+			return
 		self.putlog(self.dmesgfile, '# %s\n' % text)
 	def flog(self, text):
 		self.putlog(self.ftracefile, text)
@@ -954,34 +1004,31 @@ class SystemValues:
 			dirname = props[dev].syspath
 			if not dirname or not os.path.exists(dirname):
 				continue
-			with open(dirname+'/power/async') as fp:
-				text = fp.read()
-				props[dev].isasync = False
-				if 'enabled' in text:
+			props[dev].isasync = False
+			if os.path.exists(dirname+'/power/async'):
+				fp = open(dirname+'/power/async')
+				if 'enabled' in fp.read():
 					props[dev].isasync = True
+				fp.close()
 			fields = os.listdir(dirname)
-			if 'product' in fields:
-				with open(dirname+'/product', 'rb') as fp:
-					props[dev].altname = ascii(fp.read())
-			elif 'name' in fields:
-				with open(dirname+'/name', 'rb') as fp:
-					props[dev].altname = ascii(fp.read())
-			elif 'model' in fields:
-				with open(dirname+'/model', 'rb') as fp:
-					props[dev].altname = ascii(fp.read())
-			elif 'description' in fields:
-				with open(dirname+'/description', 'rb') as fp:
-					props[dev].altname = ascii(fp.read())
-			elif 'id' in fields:
-				with open(dirname+'/id', 'rb') as fp:
-					props[dev].altname = ascii(fp.read())
-			elif 'idVendor' in fields and 'idProduct' in fields:
-				idv, idp = '', ''
-				with open(dirname+'/idVendor', 'rb') as fp:
-					idv = ascii(fp.read()).strip()
-				with open(dirname+'/idProduct', 'rb') as fp:
-					idp = ascii(fp.read()).strip()
-				props[dev].altname = '%s:%s' % (idv, idp)
+			for file in ['product', 'name', 'model', 'description', 'id', 'idVendor']:
+				if file not in fields:
+					continue
+				try:
+					with open(os.path.join(dirname, file), 'rb') as fp:
+						props[dev].altname = ascii(fp.read())
+				except:
+					continue
+				if file == 'idVendor':
+					idv, idp = props[dev].altname.strip(), ''
+					try:
+						with open(os.path.join(dirname, 'idProduct'), 'rb') as fp:
+							idp = ascii(fp.read()).strip()
+					except:
+						props[dev].altname = ''
+						break
+					props[dev].altname = '%s:%s' % (idv, idp)
+				break
 			if props[dev].altname:
 				out = props[dev].altname.strip().replace('\n', ' ')\
 					.replace(',', ' ').replace(';', ' ')
@@ -1047,7 +1094,7 @@ class SystemValues:
 				self.cmd1[name] = self.dictify(info, delta)
 			elif not debug and delta and name in self.cmd1:
 				before, after = self.cmd1[name], self.dictify(info, delta)
-				dinfo = ('\t%s\n' % before['@']) if '@' in before else ''
+				dinfo = ('\t%s\n' % before['@']) if '@' in before and len(before) > 1 else ''
 				prefix = self.commonPrefix(list(before.keys()))
 				for key in sorted(before):
 					if key in after and before[key] != after[key]:
@@ -1128,6 +1175,22 @@ class SystemValues:
 			val = valline[idx]
 			out.append('%s=%s' % (key, val))
 		return '|'.join(out)
+	def netfixon(self, net='both'):
+		cmd = self.getExec('netfix')
+		if not cmd:
+			return ''
+		fp = Popen([cmd, '-s', net, 'on'], stdout=PIPE, stderr=PIPE).stdout
+		out = ascii(fp.read()).strip()
+		fp.close()
+		return out
+	def wifiRepair(self):
+		out = self.netfixon('wifi')
+		if not out or 'error' in out.lower():
+			return ''
+		m = re.match('WIFI \S* ONLINE (?P<action>\S*)', out)
+		if not m:
+			return 'dead'
+		return m.group('action')
 	def wifiDetails(self, dev):
 		try:
 			info = open('/sys/class/net/%s/device/uevent' % dev, 'r').read().strip()
@@ -1144,12 +1207,12 @@ class SystemValues:
 		except:
 			return ''
 		for line in reversed(w.split('\n')):
-			m = re.match(' *(?P<dev>.*): (?P<stat>[0-9a-f]*) .*', w.split('\n')[-1])
+			m = re.match(' *(?P<dev>.*): (?P<stat>[0-9a-f]*) .*', line)
 			if not m or (dev and dev != m.group('dev')):
 				continue
 			return m.group('dev')
 		return ''
-	def pollWifi(self, dev, timeout=60):
+	def pollWifi(self, dev, timeout=10):
 		start = time.time()
 		while (time.time() - start) < timeout:
 			w = self.checkWifi(dev)
@@ -1157,6 +1220,11 @@ class SystemValues:
 				return '%s reconnected %.2f' % \
 					(self.wifiDetails(dev), max(0, time.time() - start))
 			time.sleep(0.01)
+		if self.netfix:
+			res = self.wifiRepair()
+			if res:
+				timeout = max(0, time.time() - start)
+				return '%s %s %d' % (self.wifiDetails(dev), res, timeout)
 		return '%s timeout %d' % (self.wifiDetails(dev), timeout)
 	def errorSummary(self, errinfo, msg):
 		found = False
@@ -1283,10 +1351,10 @@ sysvals = SystemValues()
 switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
 switchoff = ['disable', 'off', 'false', '0']
 suspendmodename = {
-	'freeze': 'Freeze (S0)',
-	'standby': 'Standby (S1)',
-	'mem': 'Suspend (S3)',
-	'disk': 'Hibernate (S4)'
+	'standby': 'standby (S1)',
+	'freeze': 'freeze (S2idle)',
+	'mem': 'suspend (S3)',
+	'disk': 'hibernate (S4)'
 }
 
 # Class: DevProps
@@ -1376,6 +1444,7 @@ class Data:
 		'INVALID' : r'(?i).*\bINVALID\b.*',
 		'CRASH'   : r'(?i).*\bCRASHED\b.*',
 		'TIMEOUT' : r'(?i).*\bTIMEOUT\b.*',
+		'ABORT'   : r'(?i).*\bABORT\b.*',
 		'IRQ'     : r'.*\bgenirq: .*',
 		'TASKFAIL': r'.*Freezing of tasks *.*',
 		'ACPI'    : r'.*\bACPI *(?P<b>[A-Za-z]*) *Error[: ].*',
@@ -1724,9 +1793,9 @@ class Data:
 				if 'waking' in self.dmesg[lp]:
 					tCnt = self.dmesg[lp]['waking'][0]
 					if self.dmesg[lp]['waking'][1] >= 0.001:
-						tTry = '-%.0f' % (round(self.dmesg[lp]['waking'][1] * 1000))
+						tTry = '%.0f' % (round(self.dmesg[lp]['waking'][1] * 1000))
 					else:
-						tTry = '-%.3f' % (self.dmesg[lp]['waking'][1] * 1000)
+						tTry = '%.3f' % (self.dmesg[lp]['waking'][1] * 1000)
 					text = '%.0f (%s ms waking %d times)' % (tL * 1000, tTry, tCnt)
 				else:
 					text = '%.0f' % (tL * 1000)
@@ -2107,6 +2176,30 @@ class Data:
 		# set resume complete to end at end marker
 		if 'resume_complete' in dm:
 			dm['resume_complete']['end'] = time
+	def initcall_debug_call(self, line, quick=False):
+		m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
+			'PM: *calling .* @ (?P<n>.*), parent: (?P<p>.*)', line)
+		if not m:
+			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
+				'calling .* @ (?P<n>.*), parent: (?P<p>.*)', line)
+		if not m:
+			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) calling  '+\
+				'(?P<f>.*)\+ @ (?P<n>.*), parent: (?P<p>.*)', line)
+		if m:
+			return True if quick else m.group('t', 'f', 'n', 'p')
+		return False if quick else ('', '', '', '')
+	def initcall_debug_return(self, line, quick=False):
+		m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: PM: '+\
+			'.* returned (?P<r>[0-9]*) after (?P<dt>[0-9]*) usecs', line)
+		if not m:
+			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
+				'.* returned (?P<r>[0-9]*) after (?P<dt>[0-9]*) usecs', line)
+		if not m:
+			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) call '+\
+				'(?P<f>.*)\+ returned .* after (?P<dt>.*) usecs', line)
+		if m:
+			return True if quick else m.group('t', 'f', 'dt')
+		return False if quick else ('', '', '')
 	def debugPrint(self):
 		for p in self.sortedPhases():
 			list = self.dmesg[p]['list']
@@ -2880,10 +2973,11 @@ class TestProps:
 	cmdlinefmt = '^# command \| (?P<cmd>.*)'
 	kparamsfmt = '^# kparams \| (?P<kp>.*)'
 	devpropfmt = '# Device Properties: .*'
-	pinfofmt   = '# platform-(?P<val>[a-z,A-Z,0-9]*): (?P<info>.*)'
+	pinfofmt   = '# platform-(?P<val>[a-z,A-Z,0-9,_]*): (?P<info>.*)'
 	tracertypefmt = '# tracer: (?P<t>.*)'
 	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
 	procexecfmt = 'ps - (?P<ps>.*)$'
+	procmultifmt = '@(?P<n>[0-9]*)\|(?P<ps>.*)$'
 	ftrace_line_fmt_fg = \
 		'^ *(?P<time>[0-9\.]*) *\| *(?P<cpu>[0-9]*)\)'+\
 		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\|'+\
@@ -2893,6 +2987,9 @@ class TestProps:
 		'(?P<flags>\S*) *(?P<time>[0-9\.]*): *'+\
 		'(?P<msg>.*)'
 	machinesuspend = 'machine_suspend\[.*'
+	multiproclist = dict()
+	multiproctime = 0.0
+	multiproccnt = 0
 	def __init__(self):
 		self.stamp = ''
 		self.sysinfo = ''
@@ -3063,6 +3160,7 @@ class TestRun:
 		self.ttemp = dict()
 
 class ProcessMonitor:
+	maxchars = 512
 	def __init__(self):
 		self.proclist = dict()
 		self.running = False
@@ -3088,19 +3186,23 @@ class ProcessMonitor:
 			if ujiff > 0 or kjiff > 0:
 				running[pid] = ujiff + kjiff
 		process.wait()
-		out = ''
+		out = ['']
 		for pid in running:
 			jiffies = running[pid]
 			val = self.proclist[pid]
-			if out:
-				out += ','
-			out += '%s-%s %d' % (val['name'], pid, jiffies)
-		return 'ps - '+out
+			if len(out[-1]) > self.maxchars:
+				out.append('')
+			elif len(out[-1]) > 0:
+				out[-1] += ','
+			out[-1] += '%s-%s %d' % (val['name'], pid, jiffies)
+		if len(out) > 1:
+			for line in out:
+				sysvals.fsetVal('ps - @%d|%s' % (len(out), line), 'trace_marker')
+		else:
+			sysvals.fsetVal('ps - %s' % out[0], 'trace_marker')
 	def processMonitor(self, tid):
 		while self.running:
-			out = self.procstat()
-			if out:
-				sysvals.fsetVal(out, 'trace_marker')
+			self.procstat()
 	def start(self):
 		self.thread = Thread(target=self.processMonitor, args=(0,))
 		self.running = True
@@ -3144,7 +3246,6 @@ def doesTraceLogHaveTraceEvents():
 
 # Function: appendIncompleteTraceLog
 # Description:
-#	 [deprecated for kernel 3.15 or newer]
 #	 Adds callgraph data which lacks trace event data. This is only
 #	 for timelines generated from 3.15 or older
 # Arguments:
@@ -3246,6 +3347,61 @@ def appendIncompleteTraceLog(testruns):
 								dev['ftrace'] = cg
 						break
 
+# Function: loadTraceLog
+# Description:
+#	 load the ftrace file into memory and fix up any ordering issues
+# Output:
+#	 TestProps instance and an array of lines in proper order
+def loadTraceLog():
+	tp, data, lines, trace = TestProps(), dict(), [], []
+	tf = sysvals.openlog(sysvals.ftracefile, 'r')
+	for line in tf:
+		# remove any latent carriage returns
+		line = line.replace('\r\n', '')
+		if tp.stampInfo(line, sysvals):
+			continue
+		# ignore all other commented lines
+		if line[0] == '#':
+			continue
+		# ftrace line: parse only valid lines
+		m = re.match(tp.ftrace_line_fmt, line)
+		if(not m):
+			continue
+		dur = m.group('dur') if tp.cgformat else 'traceevent'
+		info = (m.group('time'), m.group('proc'), m.group('pid'),
+			m.group('msg'), dur)
+		# group the data by timestamp
+		t = float(info[0])
+		if t in data:
+			data[t].append(info)
+		else:
+			data[t] = [info]
+		# we only care about trace event ordering
+		if (info[3].startswith('suspend_resume:') or \
+			info[3].startswith('tracing_mark_write:')) and t not in trace:
+				trace.append(t)
+	tf.close()
+	for t in sorted(data):
+		first, last, blk = [], [], data[t]
+		if len(blk) > 1 and t in trace:
+			# move certain lines to the start or end of a timestamp block
+			for i in range(len(blk)):
+				if 'SUSPEND START' in blk[i][3]:
+					first.append(i)
+				elif re.match('.* timekeeping_freeze.*begin', blk[i][3]):
+					last.append(i)
+				elif re.match('.* timekeeping_freeze.*end', blk[i][3]):
+					first.append(i)
+				elif 'RESUME COMPLETE' in blk[i][3]:
+					last.append(i)
+			if len(first) == 1 and len(last) == 0:
+				blk.insert(0, blk.pop(first[0]))
+			elif len(last) == 1 and len(first) == 0:
+				blk.append(blk.pop(last[0]))
+		for info in blk:
+			lines.append(info)
+	return (tp, lines)
+
 # Function: parseTraceLog
 # Description:
 #	 Analyze an ftrace log output file generated from this app during
@@ -3271,32 +3427,12 @@ def parseTraceLog(live=False):
 
 	# extract the callgraph and traceevent data
 	s2idle_enter = hwsus = False
-	tp = TestProps()
 	testruns, testdata = [], []
 	testrun, data, limbo = 0, 0, True
-	tf = sysvals.openlog(sysvals.ftracefile, 'r')
 	phase = 'suspend_prepare'
-	for line in tf:
-		# remove any latent carriage returns
-		line = line.replace('\r\n', '')
-		if tp.stampInfo(line, sysvals):
-			continue
-		# ignore all other commented lines
-		if line[0] == '#':
-			continue
-		# ftrace line: parse only valid lines
-		m = re.match(tp.ftrace_line_fmt, line)
-		if(not m):
-			continue
+	tp, tf = loadTraceLog()
+	for m_time, m_proc, m_pid, m_msg, m_param3 in tf:
 		# gather the basic message data from the line
-		m_time = m.group('time')
-		m_proc = m.group('proc')
-		m_pid = m.group('pid')
-		m_msg = m.group('msg')
-		if(tp.cgformat):
-			m_param3 = m.group('dur')
-		else:
-			m_param3 = 'traceevent'
 		if(m_time and m_pid and m_msg):
 			t = FTraceLine(m_time, m_msg, m_param3)
 			pid = int(m_pid)
@@ -3322,14 +3458,29 @@ def parseTraceLog(live=False):
 		if t.type == 'tracing_mark_write':
 			m = re.match(tp.procexecfmt, t.name)
 			if(m):
-				proclist = dict()
-				for ps in m.group('ps').split(','):
+				parts, msg = 1, m.group('ps')
+				m = re.match(tp.procmultifmt, msg)
+				if(m):
+					parts, msg = int(m.group('n')), m.group('ps')
+					if tp.multiproccnt == 0:
+						tp.multiproctime = t.time
+						tp.multiproclist = dict()
+					proclist = tp.multiproclist
+					tp.multiproccnt += 1
+				else:
+					proclist = dict()
+					tp.multiproccnt = 0
+				for ps in msg.split(','):
 					val = ps.split()
-					if not val:
+					if not val or len(val) != 2:
 						continue
 					name = val[0].replace('--', '-')
 					proclist[name] = int(val[1])
-				data.pstl[t.time] = proclist
+				if parts == 1:
+					data.pstl[t.time] = proclist
+				elif parts == tp.multiproccnt:
+					data.pstl[tp.multiproctime] = proclist
+					tp.multiproccnt = 0
 				continue
 		# find the end of resume
 		if(t.endMarker()):
@@ -3545,7 +3696,6 @@ def parseTraceLog(live=False):
 				testrun.ftemp[key].append(FTraceCallGraph(pid, sysvals))
 			if(res == -1):
 				testrun.ftemp[key][-1].addLine(t)
-	tf.close()
 	if len(testdata) < 1:
 		sysvals.vprint('WARNING: ftrace start marker is missing')
 	if data and not data.devicegroups:
@@ -3667,7 +3817,13 @@ def parseTraceLog(live=False):
 			if p not in data.dmesg:
 				if not terr:
 					ph = p if 'machine' in p else lp
-					terr = '%s%s failed in %s phase' % (sysvals.suspendmode, tn, ph)
+					if p == 'suspend_machine':
+						sm = sysvals.suspendmode
+						if sm in suspendmodename:
+							sm = suspendmodename[sm]
+						terr = 'test%s did not enter %s power mode' % (tn, sm)
+					else:
+						terr = '%s%s failed in %s phase' % (sysvals.suspendmode, tn, ph)
 					pprint('TEST%s FAILED: %s' % (tn, terr))
 					error.append(terr)
 					if data.tSuspended == 0:
@@ -3708,9 +3864,7 @@ def parseTraceLog(live=False):
 
 # Function: loadKernelLog
 # Description:
-#	 [deprecated for kernel 3.15.0 or newer]
 #	 load the dmesg file into memory and fix up any ordering issues
-#	 The dmesg filename is taken from sysvals
 # Output:
 #	 An array of empty Data objects with only their dmesgtext attributes set
 def loadKernelLog():
@@ -3736,7 +3890,8 @@ def loadKernelLog():
 		if(not m):
 			continue
 		msg = m.group("msg")
-		if(re.match('PM: Syncing filesystems.*', msg)):
+		if re.match('PM: Syncing filesystems.*', msg) or \
+			re.match('PM: suspend entry.*', msg):
 			if(data):
 				testruns.append(data)
 			data = Data(len(testruns))
@@ -3747,11 +3902,17 @@ def loadKernelLog():
 		if(m):
 			sysvals.stamp['kernel'] = m.group('k')
 		m = re.match('PM: Preparing system for (?P<m>.*) sleep', msg)
-		if(m):
+		if not m:
+			m = re.match('PM: Preparing system for sleep \((?P<m>.*)\)', msg)
+		if m:
 			sysvals.stamp['mode'] = sysvals.suspendmode = m.group('m')
 		data.dmesgtext.append(line)
 	lf.close()
 
+	if sysvals.suspendmode == 's2idle':
+		sysvals.suspendmode = 'freeze'
+	elif sysvals.suspendmode == 'deep':
+		sysvals.suspendmode = 'mem'
 	if data:
 		testruns.append(data)
 	if len(testruns) < 1:
@@ -3762,12 +3923,9 @@ def loadKernelLog():
 	for data in testruns:
 		last = ''
 		for line in data.dmesgtext:
-			mc = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) calling  '+\
-				'(?P<f>.*)\+ @ .*, parent: .*', line)
-			mr = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) call '+\
-				'(?P<f>.*)\+ returned .* after (?P<dt>.*) usecs', last)
-			if(mc and mr and (mc.group('t') == mr.group('t')) and
-				(mc.group('f') == mr.group('f'))):
+			ct, cf, n, p = data.initcall_debug_call(line)
+			rt, rf, l = data.initcall_debug_return(last)
+			if ct and rt and ct == rt and cf == rf:
 				i = data.dmesgtext.index(last)
 				j = data.dmesgtext.index(line)
 				data.dmesgtext[i] = line
@@ -3777,7 +3935,6 @@ def loadKernelLog():
 
 # Function: parseKernelLog
 # Description:
-#	 [deprecated for kernel 3.15.0 or newer]
 #	 Analyse a dmesg log output file generated from this app during
 #	 the execution phase. Create a set of device structures in memory
 #	 for subsequent formatting in the html output file
@@ -3796,30 +3953,30 @@ def parseKernelLog(data):
 
 	# dmesg phase match table
 	dm = {
-		'suspend_prepare': ['PM: Syncing filesystems.*'],
-		        'suspend': ['PM: Entering [a-z]* sleep.*', 'Suspending console.*'],
-		   'suspend_late': ['PM: suspend of devices complete after.*'],
-		  'suspend_noirq': ['PM: late suspend of devices complete after.*'],
-		'suspend_machine': ['PM: noirq suspend of devices complete after.*'],
-		 'resume_machine': ['ACPI: Low-level resume complete.*'],
-		   'resume_noirq': ['ACPI: Waking up from system sleep state.*'],
-		   'resume_early': ['PM: noirq resume of devices complete after.*'],
-		         'resume': ['PM: early resume of devices complete after.*'],
-		'resume_complete': ['PM: resume of devices complete after.*'],
+		'suspend_prepare': ['PM: Syncing filesystems.*', 'PM: suspend entry.*'],
+		        'suspend': ['PM: Entering [a-z]* sleep.*', 'Suspending console.*',
+		                    'PM: Suspending system .*'],
+		   'suspend_late': ['PM: suspend of devices complete after.*',
+							'PM: freeze of devices complete after.*'],
+		  'suspend_noirq': ['PM: late suspend of devices complete after.*',
+							'PM: late freeze of devices complete after.*'],
+		'suspend_machine': ['PM: suspend-to-idle',
+							'PM: noirq suspend of devices complete after.*',
+							'PM: noirq freeze of devices complete after.*'],
+		 'resume_machine': ['PM: Timekeeping suspended for.*',
+							'ACPI: Low-level resume complete.*',
+							'ACPI: resume from mwait',
+							'Suspended for [0-9\.]* seconds'],
+		   'resume_noirq': ['PM: resume from suspend-to-idle',
+							'ACPI: Waking up from system sleep state.*'],
+		   'resume_early': ['PM: noirq resume of devices complete after.*',
+							'PM: noirq restore of devices complete after.*'],
+		         'resume': ['PM: early resume of devices complete after.*',
+							'PM: early restore of devices complete after.*'],
+		'resume_complete': ['PM: resume of devices complete after.*',
+							'PM: restore of devices complete after.*'],
 		    'post_resume': ['.*Restarting tasks \.\.\..*'],
 	}
-	if(sysvals.suspendmode == 'standby'):
-		dm['resume_machine'] = ['PM: Restoring platform NVS memory']
-	elif(sysvals.suspendmode == 'disk'):
-		dm['suspend_late'] = ['PM: freeze of devices complete after.*']
-		dm['suspend_noirq'] = ['PM: late freeze of devices complete after.*']
-		dm['suspend_machine'] = ['PM: noirq freeze of devices complete after.*']
-		dm['resume_machine'] = ['PM: Restoring platform NVS memory']
-		dm['resume_early'] = ['PM: noirq restore of devices complete after.*']
-		dm['resume'] = ['PM: early restore of devices complete after.*']
-		dm['resume_complete'] = ['PM: restore of devices complete after.*']
-	elif(sysvals.suspendmode == 'freeze'):
-		dm['resume_machine'] = ['ACPI: resume from mwait']
 
 	# action table (expected events that occur and show up in dmesg)
 	at = {
@@ -3867,12 +4024,13 @@ def parseKernelLog(data):
 			for s in dm[p]:
 				if(re.match(s, msg)):
 					phasechange, phase = True, p
+					dm[p] = [s]
 					break
 
 		# hack for determining resume_machine end for freeze
 		if(not sysvals.usetraceevents and sysvals.suspendmode == 'freeze' \
 			and phase == 'resume_machine' and \
-			re.match('calling  (?P<f>.*)\+ @ .*, parent: .*', msg)):
+			data.initcall_debug_call(line, True)):
 			data.setPhase(phase, ktime, False)
 			phase = 'resume_noirq'
 			data.setPhase(phase, ktime, True)
@@ -3945,26 +4103,18 @@ def parseKernelLog(data):
 		# -- device callbacks --
 		if(phase in data.sortedPhases()):
 			# device init call
-			if(re.match('calling  (?P<f>.*)\+ @ .*, parent: .*', msg)):
-				sm = re.match('calling  (?P<f>.*)\+ @ '+\
-					'(?P<n>.*), parent: (?P<p>.*)', msg);
-				f = sm.group('f')
-				n = sm.group('n')
-				p = sm.group('p')
-				if(f and n and p):
-					data.newAction(phase, f, int(n), p, ktime, -1, '')
-			# device init return
-			elif(re.match('call (?P<f>.*)\+ returned .* after '+\
-				'(?P<t>.*) usecs', msg)):
-				sm = re.match('call (?P<f>.*)\+ returned .* after '+\
-					'(?P<t>.*) usecs(?P<a>.*)', msg);
-				f = sm.group('f')
-				t = sm.group('t')
-				list = data.dmesg[phase]['list']
-				if(f in list):
-					dev = list[f]
-					dev['length'] = int(t)
-					dev['end'] = ktime
+			t, f, n, p = data.initcall_debug_call(line)
+			if t and f and n and p:
+				data.newAction(phase, f, int(n), p, ktime, -1, '')
+			else:
+				# device init return
+				t, f, l = data.initcall_debug_return(line)
+				if t and f and l:
+					list = data.dmesg[phase]['list']
+					if(f in list):
+						dev = list[f]
+						dev['length'] = int(l)
+						dev['end'] = ktime
 
 		# if trace events are not available, these are better than nothing
 		if(not sysvals.usetraceevents):
@@ -4006,6 +4156,8 @@ def parseKernelLog(data):
 	# fill in any missing phases
 	phasedef = data.phasedef
 	terr, lp = '', 'suspend_prepare'
+	if lp not in data.dmesg:
+		doError('dmesg log format has changed, could not find start of suspend')
 	for p in sorted(phasedef, key=lambda k:phasedef[k]['order']):
 		if p not in data.dmesg:
 			if not terr:
@@ -5302,7 +5454,7 @@ def executeSuspend(quiet=False):
 	sv.dlog('read dmesg')
 	sv.initdmesg()
 	# start ftrace
-	if(sv.usecallgraph or sv.usetraceevents):
+	if sv.useftrace:
 		if not quiet:
 			pprint('START TRACING')
 		sv.dlog('start ftrace tracing')
@@ -5334,8 +5486,7 @@ def executeSuspend(quiet=False):
 			sv.dlog('enable RTC wake alarm')
 			sv.rtcWakeAlarmOn()
 		# start of suspend trace marker
-		if(sv.usecallgraph or sv.usetraceevents):
-			sv.fsetVal(datetime.now().strftime(sv.tmstart), 'trace_marker')
+		sv.fsetVal(datetime.now().strftime(sv.tmstart), 'trace_marker')
 		# predelay delay
 		if(count == 1 and sv.predelay > 0):
 			sv.fsetVal('WAIT %d' % sv.predelay, 'trace_marker')
@@ -5384,11 +5535,17 @@ def executeSuspend(quiet=False):
 			sv.fsetVal('WAIT END', 'trace_marker')
 		# return from suspend
 		pprint('RESUME COMPLETE')
-		if(sv.usecallgraph or sv.usetraceevents):
-			sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
+		sv.fsetVal(datetime.now().strftime(sv.tmend), 'trace_marker')
 		if sv.wifi and wifi:
 			tdata['wifi'] = sv.pollWifi(wifi)
 			sv.dlog('wifi check, %s' % tdata['wifi'])
+			if sv.netfix:
+				netfixout = sv.netfixon('wired')
+		elif sv.netfix:
+			netfixout = sv.netfixon()
+		if sv.netfix and netfixout:
+			tdata['netfix'] = netfixout
+			sv.dlog('netfix, %s' % tdata['netfix'])
 		if(sv.suspendmode == 'mem' or sv.suspendmode == 'command'):
 			sv.dlog('read the ACPI FPDT')
 			tdata['fw'] = getFPDT(False)
@@ -5396,7 +5553,7 @@ def executeSuspend(quiet=False):
 	sv.dlog('run the cmdinfo list after')
 	cmdafter = sv.cmdinfo(False)
 	# stop ftrace
-	if(sv.usecallgraph or sv.usetraceevents):
+	if sv.useftrace:
 		if sv.useprocmon:
 			sv.dlog('stop the process monitor')
 			pm.stop()
@@ -5407,7 +5564,7 @@ def executeSuspend(quiet=False):
 	sysvals.dlog('EXECUTION TRACE END')
 	sv.getdmesg(testdata)
 	# grab a copy of the ftrace output
-	if(sv.usecallgraph or sv.usetraceevents):
+	if sv.useftrace:
 		if not quiet:
 			pprint('CAPTURING TRACE')
 		op = sv.writeDatafileHeader(sv.ftracefile, testdata)
@@ -5838,13 +5995,19 @@ def statusCheck(probecheck=False):
 			pprint('      please choose one with -m')
 
 	# check if ftrace is available
-	res = sysvals.colorText('NO')
-	ftgood = sysvals.verifyFtrace()
-	if(ftgood):
-		res = 'YES'
-	elif(sysvals.usecallgraph):
-		status = 'ftrace is not properly supported'
-	pprint('    is ftrace supported: %s' % res)
+	if sysvals.useftrace:
+		res = sysvals.colorText('NO')
+		sysvals.useftrace = sysvals.verifyFtrace()
+		efmt = '"{0}" uses ftrace, and it is not properly supported'
+		if sysvals.useftrace:
+			res = 'YES'
+		elif sysvals.usecallgraph:
+			status = efmt.format('-f')
+		elif sysvals.usedevsrc:
+			status = efmt.format('-dev')
+		elif sysvals.useprocmon:
+			status = efmt.format('-proc')
+		pprint('    is ftrace supported: %s' % res)
 
 	# check if kprobes are available
 	if sysvals.usekprobes:
@@ -5857,8 +6020,8 @@ def statusCheck(probecheck=False):
 		pprint('    are kprobes supported: %s' % res)
 
 	# what data source are we using
-	res = 'DMESG'
-	if(ftgood):
+	res = 'DMESG (very limited, ftrace is preferred)'
+	if sysvals.useftrace:
 		sysvals.usetraceevents = True
 		for e in sysvals.traceevents:
 			if not os.path.exists(sysvals.epath+e):
@@ -5879,7 +6042,7 @@ def statusCheck(probecheck=False):
 	pprint('    optional commands this tool may use for info:')
 	no = sysvals.colorText('MISSING')
 	yes = sysvals.colorText('FOUND', 32)
-	for c in ['turbostat', 'mcelog', 'lspci', 'lsusb']:
+	for c in ['turbostat', 'mcelog', 'lspci', 'lsusb', 'netfix']:
 		if c == 'turbostat':
 			res = yes if sysvals.haveTurbostat() else no
 		else:
@@ -5971,7 +6134,7 @@ def processData(live=False, quiet=False):
 	if not sysvals.stamp:
 		pprint('ERROR: data does not include the expected stamp')
 		return (testruns, {'error': 'timeline generation failed'})
-	shown = ['bios', 'biosdate', 'cpu', 'host', 'kernel', 'man', 'memfr',
+	shown = ['os', 'bios', 'biosdate', 'cpu', 'host', 'kernel', 'man', 'memfr',
 			'memsz', 'mode', 'numcpu', 'plat', 'time', 'wifi']
 	sysvals.vprint('System Info:')
 	for key in sorted(sysvals.stamp):
@@ -6052,6 +6215,8 @@ def runTest(n=0, quiet=False):
 		if sysvals.display:
 			ret = sysvals.displayControl('init')
 			sysvals.dlog('xset display init, ret = %d' % ret)
+	sysvals.testVal(sysvals.pmdpath, 'basic', '1')
+	sysvals.testVal(sysvals.s0ixpath, 'basic', 'Y')
 	sysvals.dlog('initialize ftrace')
 	sysvals.initFtrace(quiet)
 
@@ -6145,9 +6310,12 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 				elist[err[0]] += 1
 		for i in elist:
 			ilist.append('%sx%d' % (i, elist[i]) if elist[i] > 1 else i)
-	wifi = find_in_html(html, 'Wifi Resume: ', '</td>')
-	if wifi:
-		extra['wifi'] = wifi
+		line = find_in_html(log, '# wifi ', '\n')
+		if line:
+			extra['wifi'] = line
+		line = find_in_html(log, '# netfix ', '\n')
+		if line:
+			extra['netfix'] = line
 	low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
 	for lowstr in ['waking', '+']:
 		if not low:
@@ -6243,7 +6411,7 @@ def genHtml(subdir, force=False):
 					sysvals.ftracefile = file
 		sysvals.setOutputFile()
 		if (sysvals.dmesgfile or sysvals.ftracefile) and sysvals.htmlfile and \
-			(force or not sysvals.usable(sysvals.htmlfile)):
+			(force or not sysvals.usable(sysvals.htmlfile, True)):
 			pprint('FTRACE: %s' % sysvals.ftracefile)
 			if sysvals.dmesgfile:
 				pprint('DMESG : %s' % sysvals.dmesgfile)
@@ -6533,6 +6701,7 @@ def printHelp():
 	'   -skiphtml    Run the test and capture the trace logs, but skip the timeline (default: disabled)\n'\
 	'   -result fn   Export a results table to a text file for parsing.\n'\
 	'   -wifi        If a wifi connection is available, check that it reconnects after resume.\n'\
+	'   -netfix      Use netfix to reset the network in the event it fails to resume.\n'\
 	'  [testprep]\n'\
 	'   -sync        Sync the filesystems before starting the test\n'\
 	'   -rs on/off   Enable/disable runtime suspend for all devices, restore all after test\n'\
@@ -6615,6 +6784,8 @@ if __name__ == '__main__':
 		elif(arg == '-v'):
 			pprint("Version %s" % sysvals.version)
 			sys.exit(0)
+		elif(arg == '-debugtiming'):
+			debugtiming = True
 		elif(arg == '-x2'):
 			sysvals.execcount = 2
 		elif(arg == '-x2delay'):
@@ -6657,6 +6828,8 @@ if __name__ == '__main__':
 			sysvals.sync = True
 		elif(arg == '-wifi'):
 			sysvals.wifi = True
+		elif(arg == '-netfix'):
+			sysvals.netfix = True
 		elif(arg == '-gzip'):
 			sysvals.gzip = True
 		elif(arg == '-info'):
@@ -6819,7 +6992,7 @@ if __name__ == '__main__':
 			sysvals.outdir = val
 			sysvals.notestrun = True
 			if(os.path.isdir(val) == False):
-				doError('%s is not accessible' % val)
+				doError('%s is not accesible' % val)
 		elif(arg == '-filter'):
 			try:
 				val = next(args)
@@ -6942,12 +7115,11 @@ if __name__ == '__main__':
 				time.sleep(sysvals.multitest['delay'])
 			fmt = 'suspend-%y%m%d-%H%M%S'
 			sysvals.testdir = os.path.join(sysvals.outdir, datetime.now().strftime(fmt))
-			ret = runTest(i+1, True)
+			ret = runTest(i+1, not sysvals.verbose)
 			failcnt = 0 if not ret else failcnt + 1
 			if sysvals.maxfail > 0 and failcnt >= sysvals.maxfail:
 				pprint('Maximum fail count of %d reached, aborting multitest' % (sysvals.maxfail))
 				break
-			time.sleep(5)
 			sysvals.resetlog()
 			sysvals.multistat(False, i, finish)
 			if 'time' in sysvals.multitest and datetime.now() >= finish:
-- 
2.17.1

