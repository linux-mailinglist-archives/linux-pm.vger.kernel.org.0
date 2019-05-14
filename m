Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE91CE5D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfENRyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 13:54:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:60691 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfENRyE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 13:54:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 10:54:02 -0700
X-ExtLoop1: 1
Received: from unknown (HELO technocore.fios-router.home) ([10.254.92.80])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 10:54:01 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH 2/3] Update to pm-graph 5.4
Date:   Tue, 14 May 2019 10:53:58 -0700
Message-Id: <6888d6ca2d850ca7c3b6e59c6889da465e28b1d0.1557855894.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bootgraph:
- dmesg log format has changed, update parser in two places
- fix prints in preparation for upgrade to python3

sleepgraph:
- fix prints in preparation for upgrade to python3
- add new trace events and kprobes to cover freeze more completely
- add new -ftop callgraph trace over suspend_devices_and_enter
- add -wifi option to check if a wifi connection is active
- add -skipkprobe option to suppress unwanted kprobes in dev mode
- add kernel params and sysinfo to the log output
- don't crash if /dev/mem is throwing IO errors, ignore FPDT and DMI
- fix kprobe length calculation when calls are recursive
- add several new kernel issue definitions for USB, ACPI, ATA, etc
- enable turbostat output to be read from stdout instead of from file
- add BIOS call data to the timeline from acpi_ps_execute_method kprobe

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/bootgraph.py  |   8 +-
 tools/power/pm-graph/sleepgraph.py | 491 ++++++++++++++++++++++++++-----------
 2 files changed, 347 insertions(+), 152 deletions(-)

diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index 6dae57041537..d7f4bd152bf1 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -333,9 +333,9 @@ def parseKernelLog():
 			if(not sysvals.stamp['kernel']):
 				sysvals.stamp['kernel'] = sysvals.kernelVersion(msg)
 			continue
-		m = re.match('.* setting system clock to (?P<t>.*) UTC.*', msg)
+		m = re.match('.* setting system clock to (?P<d>[0-9\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
 		if(m):
-			bt = datetime.strptime(m.group('t'), '%Y-%m-%d %H:%M:%S')
+			bt = datetime.strptime(m.group('d')+' '+m.group('t'), '%Y-%m-%d %H:%M:%S')
 			bt = bt - timedelta(seconds=int(ktime))
 			data.boottime = bt.strftime('%Y-%m-%d_%H:%M:%S')
 			sysvals.stamp['time'] = bt.strftime('%B %d %Y, %I:%M:%S %p')
@@ -356,7 +356,7 @@ def parseKernelLog():
 				data.newAction(phase, f, pid, start, ktime, int(r), int(t))
 				del devtemp[f]
 			continue
-		if(re.match('^Freeing unused kernel memory.*', msg)):
+		if(re.match('^Freeing unused kernel .*', msg)):
 			data.tUserMode = ktime
 			data.dmesg['kernel']['end'] = ktime
 			data.dmesg['user']['start'] = ktime
@@ -1016,7 +1016,7 @@ if __name__ == '__main__':
 			updateKernelParams()
 		elif cmd == 'flistall':
 			for f in sysvals.getBootFtraceFilterFunctions():
-				print f
+				print(f)
 		elif cmd == 'checkbl':
 			sysvals.getBootLoader()
 			pprint('Boot Loader: %s\n%s' % (sysvals.bootloader, sysvals.blexec))
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 41d28d63e7c9..ccd0f3917c51 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -17,9 +17,9 @@
 #
 # Links:
 #	 Home Page
-#	   https://01.org/suspendresume
+#	   https://01.org/pm-graph
 #	 Source repo
-#	   git@github.com:01org/pm-graph
+#	   git@github.com:intel/pm-graph
 #
 # Description:
 #	 This tool is designed to assist kernel and OS developers in optimizing
@@ -32,6 +32,7 @@
 #	 viewed in firefox or chrome.
 #
 #	 The following kernel build options are required:
+#		 CONFIG_DEVMEM=y
 #		 CONFIG_PM_DEBUG=y
 #		 CONFIG_PM_SLEEP_DEBUG=y
 #		 CONFIG_FTRACE=y
@@ -75,7 +76,7 @@ def pprint(msg):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.3'
+	version = '5.4'
 	ansi = False
 	rs = 0
 	display = ''
@@ -83,8 +84,9 @@ class SystemValues:
 	sync = False
 	verbose = False
 	testlog = True
-	dmesglog = False
+	dmesglog = True
 	ftracelog = False
+	tstat = False
 	mindevlen = 0.0
 	mincglen = 0.0
 	cgphase = ''
@@ -108,6 +110,8 @@ class SystemValues:
 	pmdpath = '/sys/power/pm_debug_messages'
 	traceevents = [
 		'suspend_resume',
+		'wakeup_source_activate',
+		'wakeup_source_deactivate',
 		'device_pm_callback_end',
 		'device_pm_callback_start'
 	]
@@ -139,6 +143,8 @@ class SystemValues:
 	x2delay = 0
 	skiphtml = False
 	usecallgraph = False
+	ftopfunc = 'suspend_devices_and_enter'
+	ftop = False
 	usetraceevents = False
 	usetracemarkers = True
 	usekprobes = True
@@ -167,6 +173,13 @@ class SystemValues:
 		'acpi_hibernation_leave': {},
 		'acpi_pm_freeze': {},
 		'acpi_pm_thaw': {},
+		'acpi_s2idle_end': {},
+		'acpi_s2idle_sync': {},
+		'acpi_s2idle_begin': {},
+		'acpi_s2idle_prepare': {},
+		'acpi_s2idle_wake': {},
+		'acpi_s2idle_wakeup': {},
+		'acpi_s2idle_restore': {},
 		'hibernate_preallocate_memory': {},
 		'create_basic_memory_bitmaps': {},
 		'swsusp_write': {},
@@ -203,7 +216,11 @@ class SystemValues:
 		'rt_mutex_slowlock': {'ub': 1},
 		# ACPI
 		'acpi_resume_power_resources': {},
-		'acpi_ps_parse_aml': {},
+		'acpi_ps_execute_method': { 'args_x86_64': {
+			'fullpath':'+0(+40(%di)):string',
+		}},
+		# mei_me
+		'mei_reset': {},
 		# filesystem
 		'ext4_sync_fs': {},
 		# 80211
@@ -252,6 +269,7 @@ class SystemValues:
 	timeformat = '%.3f'
 	cmdline = '%s %s' % \
 			(os.path.basename(sys.argv[0]), ' '.join(sys.argv[1:]))
+	kparams = ''
 	sudouser = ''
 	def __init__(self):
 		self.archargs = 'args_'+platform.machine()
@@ -330,6 +348,7 @@ class SystemValues:
 		args['date'] = n.strftime('%y%m%d')
 		args['time'] = n.strftime('%H%M%S')
 		args['hostname'] = args['host'] = self.hostname
+		args['mode'] = self.suspendmode
 		return value.format(**args)
 	def setOutputFile(self):
 		if self.dmesgfile != '':
@@ -341,7 +360,7 @@ class SystemValues:
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
 	def systemInfo(self, info):
-		p = c = m = b = ''
+		p = m = ''
 		if 'baseboard-manufacturer' in info:
 			m = info['baseboard-manufacturer']
 		elif 'system-manufacturer' in info:
@@ -352,12 +371,17 @@ class SystemValues:
 			p = info['baseboard-product-name']
 		if m[:5].lower() == 'intel' and 'baseboard-product-name' in info:
 			p = info['baseboard-product-name']
-		if 'processor-version' in info:
-			c = info['processor-version']
-		if 'bios-version' in info:
-			b = info['bios-version']
-		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | numcpu:%d | memsz:%d | memfr:%d' % \
-			(m, p, c, b, self.cpucount, self.memtotal, self.memfree)
+		c = info['processor-version'] if 'processor-version' in info else ''
+		b = info['bios-version'] if 'bios-version' in info else ''
+		r = info['bios-release-date'] if 'bios-release-date' in info else ''
+		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | biosdate:%s | numcpu:%d | memsz:%d | memfr:%d' % \
+			(m, p, c, b, r, self.cpucount, self.memtotal, self.memfree)
+		try:
+			kcmd = open('/proc/cmdline', 'r').read().strip()
+		except:
+			kcmd = ''
+		if kcmd:
+			self.sysstamp += '\n# kparams | %s' % kcmd
 	def printSystemInfo(self, fatal=False):
 		self.rootCheck(True)
 		out = dmidecode(self.mempath, fatal)
@@ -365,10 +389,10 @@ class SystemValues:
 			return
 		fmt = '%-24s: %s'
 		for name in sorted(out):
-			print fmt % (name, out[name])
-		print fmt % ('cpucount', ('%d' % self.cpucount))
-		print fmt % ('memtotal', ('%d kB' % self.memtotal))
-		print fmt % ('memfree', ('%d kB' % self.memfree))
+			print(fmt % (name, out[name]))
+		print(fmt % ('cpucount', ('%d' % self.cpucount)))
+		print(fmt % ('memtotal', ('%d kB' % self.memtotal)))
+		print(fmt % ('memfree', ('%d kB' % self.memfree)))
 	def cpuInfo(self):
 		self.cpucount = 0
 		fp = open('/proc/cpuinfo', 'r')
@@ -388,7 +412,7 @@ class SystemValues:
 	def initTestOutput(self, name):
 		self.prefix = self.hostname
 		v = open('/proc/version', 'r').read().strip()
-		kver = string.split(v)[2]
+		kver = v.split()[2]
 		fmt = name+'-%m%d%y-%H%M%S'
 		testtime = datetime.now().strftime(fmt)
 		self.teststamp = \
@@ -403,7 +427,7 @@ class SystemValues:
 		self.htmlfile = \
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'.html'
 		if not os.path.isdir(self.testdir):
-			os.mkdir(self.testdir)
+			os.makedirs(self.testdir)
 	def getValueList(self, value):
 		out = []
 		for i in value.split(','):
@@ -414,6 +438,12 @@ class SystemValues:
 		self.devicefilter = self.getValueList(value)
 	def setCallgraphFilter(self, value):
 		self.cgfilter = self.getValueList(value)
+	def skipKprobes(self, value):
+		for k in self.getValueList(value):
+			if k in self.tracefuncs:
+				del self.tracefuncs[k]
+			if k in self.dev_tracefuncs:
+				del self.dev_tracefuncs[k]
 	def setCallgraphBlacklist(self, file):
 		self.cgblacklist = self.listFromFile(file)
 	def rtcWakeAlarmOn(self):
@@ -483,9 +513,9 @@ class SystemValues:
 			if 'func' in self.tracefuncs[i]:
 				i = self.tracefuncs[i]['func']
 			if i in master:
-				print i
+				print(i)
 			else:
-				print self.colorText(i)
+				print(self.colorText(i))
 	def setFtraceFilterFunctions(self, list):
 		master = self.listFromFile(self.tpath+'available_filter_functions')
 		flist = ''
@@ -728,7 +758,10 @@ class SystemValues:
 					cf.append(self.tracefuncs[fn]['func'])
 				else:
 					cf.append(fn)
-			self.setFtraceFilterFunctions(cf)
+			if self.ftop:
+				self.setFtraceFilterFunctions([self.ftopfunc])
+			else:
+				self.setFtraceFilterFunctions(cf)
 		# initialize the kprobe trace
 		elif self.usekprobes:
 			for name in self.tracefuncs:
@@ -788,6 +821,14 @@ class SystemValues:
 			if 'bat' in test:
 				(a1, c1), (a2, c2) = test['bat']
 				fp.write('# battery %s %d %s %d\n' % (a1, c1, a2, c2))
+			if 'wifi' in test:
+				wstr = []
+				for wifi in test['wifi']:
+					tmp = []
+					for key in sorted(wifi):
+						tmp.append('%s:%s' % (key, wifi[key]))
+					wstr.append('|'.join(tmp))
+				fp.write('# wifi %s\n' % (','.join(wstr)))
 			if test['error'] or len(testdata) > 1:
 				fp.write('# enter_sleep_error %s\n' % test['error'])
 		return fp
@@ -852,26 +893,22 @@ class SystemValues:
 			return ''
 		return base64.b64encode(out.encode('zlib'))
 	def haveTurbostat(self):
+		if not self.tstat:
+			return False
 		cmd = self.getExec('turbostat')
 		if not cmd:
 			return False
 		fp = Popen([cmd, '-v'], stdout=PIPE, stderr=PIPE).stderr
 		out = fp.read().strip()
 		fp.close()
-		return re.match('turbostat version [0-8.]* .*', out)
+		return re.match('turbostat version [0-9\.]* .*', out)
 	def turbostat(self):
 		cmd = self.getExec('turbostat')
 		if not cmd:
 			return 'missing turbostat executable'
-		outfile = '/tmp/pm-graph-turbostat.txt'
-		res = call('%s -o %s -q -S echo freeze > %s' % \
-			(cmd, outfile, self.powerfile), shell=True)
-		if res != 0:
-			return 'turbosat returned %d' % res
-		if not os.path.exists(outfile):
-			return 'turbostat output missing'
-		fp = open(outfile, 'r')
 		text = []
+		fullcmd = '%s -q -S echo freeze > %s' % (cmd, self.powerfile)
+		fp = Popen(['sh', '-c', fullcmd], stdout=PIPE, stderr=PIPE).stderr
 		for line in fp:
 			if re.match('[0-9.]* sec', line):
 				continue
@@ -888,6 +925,60 @@ class SystemValues:
 					values.append(line[idx])
 			out.append('%s=%s' % (key, ','.join(values)))
 		return '|'.join(out)
+	def checkWifi(self):
+		out = dict()
+		iwcmd, ifcmd = self.getExec('iwconfig'), self.getExec('ifconfig')
+		if not iwcmd or not ifcmd:
+			return out
+		fp = Popen(iwcmd, stdout=PIPE, stderr=PIPE).stdout
+		for line in fp:
+			m = re.match('(?P<dev>\S*) .* ESSID:(?P<ess>\S*)', line)
+			if not m:
+				continue
+			out['device'] = m.group('dev')
+			if '"' in m.group('ess'):
+				out['essid'] = m.group('ess').strip('"')
+				break
+		fp.close()
+		if 'device' in out:
+			fp = Popen([ifcmd, out['device']], stdout=PIPE, stderr=PIPE).stdout
+			for line in fp:
+				m = re.match('.* inet (?P<ip>[0-9\.]*)', line)
+				if m:
+					out['ip'] = m.group('ip')
+					break
+			fp.close()
+		return out
+	def errorSummary(self, errinfo, msg):
+		found = False
+		for entry in errinfo:
+			if re.match(entry['match'], msg):
+				entry['count'] += 1
+				if self.hostname not in entry['urls']:
+					entry['urls'][self.hostname] = [self.htmlfile]
+				elif self.htmlfile not in entry['urls'][self.hostname]:
+					entry['urls'][self.hostname].append(self.htmlfile)
+				found = True
+				break
+		if found:
+			return
+		arr = msg.split()
+		for j in range(len(arr)):
+			if re.match('^[0-9,\-\.]*$', arr[j]):
+				arr[j] = '[0-9,\-\.]*'
+			else:
+				arr[j] = arr[j]\
+					.replace('\\', '\\\\').replace(']', '\]').replace('[', '\[')\
+					.replace('.', '\.').replace('+', '\+').replace('*', '\*')\
+					.replace('(', '\(').replace(')', '\)')
+		mstr = ' '.join(arr)
+		entry = {
+			'line': msg,
+			'match': mstr,
+			'count': 1,
+			'urls': {self.hostname: [self.htmlfile]}
+		}
+		errinfo.append(entry)
 
 sysvals = SystemValues()
 switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
@@ -982,7 +1073,14 @@ class Data:
 		'ERROR'   : '.*ERROR.*',
 		'WARNING' : '.*WARNING.*',
 		'IRQ'     : '.*genirq: .*',
-		'TASKFAIL': '.*Freezing of tasks failed.*',
+		'TASKFAIL': '.*Freezing of tasks *.*',
+		'ACPI'    : '.*ACPI *(?P<b>[A-Za-z]*) *Error[: ].*',
+		'DEVFAIL' : '.* failed to (?P<b>[a-z]*) async: .*',
+		'DISKFULL': '.*No space left on device.*',
+		'USBERR'  : '.*usb .*device .*, error [0-9-]*',
+		'ATAERR'  : ' *ata[0-9\.]*: .*failed.*',
+		'MEIERR'  : ' *mei.*: .*failed.*',
+		'TPMERR'  : '(?i) *tpm *tpm[0-9]*: .*error.*',
 	}
 	def __init__(self, num):
 		idchar = 'abcdefghij'
@@ -1000,6 +1098,7 @@ class Data:
 		self.outfile = ''
 		self.kerror = False
 		self.battery = 0
+		self.wifi = 0
 		self.turbostat = 0
 		self.mcelog = 0
 		self.enterfail = ''
@@ -1036,35 +1135,21 @@ class Data:
 		if len(plist) < 1:
 			return ''
 		return plist[-1]
-	def errorSummary(self, errinfo, msg):
-		found = False
-		for entry in errinfo:
-			if re.match(entry['match'], msg):
-				entry['count'] += 1
-				if sysvals.hostname not in entry['urls']:
-					entry['urls'][sysvals.hostname] = sysvals.htmlfile
-				found = True
-				break
-		if found:
-			return
-		arr = msg.split()
-		for j in range(len(arr)):
-			if re.match('^[0-9\-\.]*$', arr[j]):
-				arr[j] = '[0-9\-\.]*'
-			else:
-				arr[j] = arr[j]\
-					.replace(']', '\]').replace('[', '\[').replace('.', '\.')\
-					.replace('+', '\+').replace('*', '\*').replace('(', '\(')\
-					.replace(')', '\)')
-		mstr = ' '.join(arr)
-		entry = {
-			'line': msg,
-			'match': mstr,
-			'count': 1,
-			'urls': {sysvals.hostname: sysvals.htmlfile}
-		}
-		errinfo.append(entry)
-	def extractErrorInfo(self, issues=0):
+	def turbostatInfo(self):
+		tp = TestProps()
+		out = {'syslpi':'N/A','pkgpc10':'N/A'}
+		for line in self.dmesgtext:
+			m = re.match(tp.tstatfmt, line)
+			if not m:
+				continue
+			for i in m.group('t').split('|'):
+				if 'SYS%LPI' in i:
+					out['syslpi'] = i.split('=')[-1]+'%'
+				elif 'pc10' in i:
+					out['pkgpc10'] = i.split('=')[-1]+'%'
+			break
+		return out
+	def extractErrorInfo(self):
 		lf = self.dmesgtext
 		if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
 			lf = sysvals.openlog(sysvals.dmesgfile, 'r')
@@ -1082,19 +1167,19 @@ class Data:
 			msg = m.group('msg')
 			for err in self.errlist:
 				if re.match(self.errlist[err], msg):
-					list.append((err, dir, t, i, i))
+					list.append((msg, err, dir, t, i, i))
 					self.kerror = True
-					if not isinstance(issues, int):
-						self.errorSummary(issues, msg)
 					break
-		for e in list:
-			type, dir, t, idx1, idx2 = e
+		msglist = []
+		for msg, type, dir, t, idx1, idx2 in list:
+			msglist.append(msg)
 			sysvals.vprint('kernel %s found in %s at %f' % (type, dir, t))
 			self.errorinfo[dir].append((type, t, idx1, idx2))
 		if self.kerror:
 			sysvals.dmesglog = True
 		if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
 			lf.close()
+		return msglist
 	def setStart(self, time):
 		self.start = time
 	def setEnd(self, time):
@@ -2147,7 +2232,7 @@ class FTraceCallGraph:
 			if(data.dmesg[p]['start'] <= self.start and
 				self.start <= data.dmesg[p]['end']):
 				list = data.dmesg[p]['list']
-				for devname in list:
+				for devname in sorted(list, key=lambda k:list[k]['start']):
 					dev = list[devname]
 					if(pid == dev['pid'] and
 						self.start <= dev['start'] and
@@ -2452,6 +2537,7 @@ class TestProps:
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
 	batteryfmt = '^# battery (?P<a1>\w*) (?P<c1>\d*) (?P<a2>\w*) (?P<c2>\d*)'
+	wififmt    = '^# wifi (?P<w>.*)'
 	tstatfmt   = '^# turbostat (?P<t>\S*)'
 	mcelogfmt  = '^# mcelog (?P<m>\S*)'
 	testerrfmt = '^# enter_sleep_error (?P<e>.*)'
@@ -2479,6 +2565,7 @@ class TestProps:
 		self.mcelog = []
 		self.turbostat = []
 		self.battery = []
+		self.wifi = []
 		self.fwdata = []
 		self.ftrace_line_fmt = self.ftrace_line_fmt_nop
 		self.cgformat = False
@@ -2505,6 +2592,9 @@ class TestProps:
 		elif re.match(self.sysinfofmt, line):
 			self.sysinfo = line
 			return True
+		elif re.match(self.kparamsfmt, line):
+			self.kparams = line
+			return True
 		elif re.match(self.cmdlinefmt, line):
 			self.cmdline = line
 			return True
@@ -2517,6 +2607,9 @@ class TestProps:
 		elif re.match(self.batteryfmt, line):
 			self.battery.append(line)
 			return True
+		elif re.match(self.wififmt, line):
+			self.wifi.append(line)
+			return True
 		elif re.match(self.testerrfmt, line):
 			self.testerror.append(line)
 			return True
@@ -2586,6 +2679,11 @@ class TestProps:
 			m = re.match(self.batteryfmt, self.battery[data.testnumber])
 			if m:
 				data.battery = m.groups()
+		# wifi data
+		if len(self.wifi) > data.testnumber:
+			m = re.match(self.wififmt, self.wifi[data.testnumber])
+			if m:
+				data.wifi = m.group('w')
 		# sleep mode enter errors
 		if len(self.testerror) > data.testnumber:
 			m = re.match(self.testerrfmt, self.testerror[data.testnumber])
@@ -2655,9 +2753,9 @@ class ProcessMonitor:
 #	 Quickly determine if the ftrace log has all of the trace events,
 #	 markers, and/or kprobes required for primary parsing.
 def doesTraceLogHaveTraceEvents():
-	kpcheck = ['_cal: (', '_cpu_down()']
+	kpcheck = ['_cal: (', '_ret: (']
 	techeck = ['suspend_resume', 'device_pm_callback']
-	tmcheck = ['tracing_mark_write']
+	tmcheck = ['SUSPEND START', 'RESUME COMPLETE']
 	sysvals.usekprobes = False
 	fp = sysvals.openlog(sysvals.ftracefile, 'r')
 	for line in fp:
@@ -3042,7 +3140,7 @@ def parseTraceLog(live=False):
 				tp.ktemp[key].append({
 					'pid': pid,
 					'begin': t.time,
-					'end': t.time,
+					'end': -1,
 					'name': displayname,
 					'cdata': kprobedata,
 					'proc': m_proc,
@@ -3053,12 +3151,11 @@ def parseTraceLog(live=False):
 			elif(t.freturn):
 				if(key not in tp.ktemp) or len(tp.ktemp[key]) < 1:
 					continue
-				e = tp.ktemp[key][-1]
-				if e['begin'] < 0.0 or t.time - e['begin'] < 0.000001:
-					tp.ktemp[key].pop()
-				else:
-					e['end'] = t.time
-					e['rdata'] = kprobedata
+				e = next((x for x in reversed(tp.ktemp[key]) if x['end'] < 0), 0)
+				if not e:
+					continue
+				e['end'] = t.time
+				e['rdata'] = kprobedata
 				# end of kernel resume
 				if(phase != 'suspend_prepare' and kprobename in krescalls):
 					if phase in data.dmesg:
@@ -3080,8 +3177,10 @@ def parseTraceLog(live=False):
 			if(res == -1):
 				testrun.ftemp[key][-1].addLine(t)
 	tf.close()
+	if len(testdata) < 1:
+		sysvals.vprint('WARNING: ftrace start marker is missing')
 	if data and not data.devicegroups:
-		sysvals.vprint('WARNING: end marker is missing')
+		sysvals.vprint('WARNING: ftrace end marker is missing')
 		data.handleEndMarker(t.time)
 
 	if sysvals.suspendmode == 'command':
@@ -3130,9 +3229,11 @@ def parseTraceLog(live=False):
 				name, pid = key
 				if name not in sysvals.tracefuncs:
 					continue
+				if pid not in data.devpids:
+					data.devpids.append(pid)
 				for e in tp.ktemp[key]:
 					kb, ke = e['begin'], e['end']
-					if kb == ke or tlb > kb or tle <= kb:
+					if ke - kb < 0.000001 or tlb > kb or tle <= kb:
 						continue
 					color = sysvals.kprobeColor(name)
 					data.newActionGlobal(e['name'], kb, ke, pid, color)
@@ -3144,7 +3245,7 @@ def parseTraceLog(live=False):
 						continue
 					for e in tp.ktemp[key]:
 						kb, ke = e['begin'], e['end']
-						if kb == ke or tlb > kb or tle <= kb:
+						if ke - kb < 0.000001 or tlb > kb or tle <= kb:
 							continue
 						data.addDeviceFunctionCall(e['name'], name, e['proc'], pid, kb,
 							ke, e['cdata'], e['rdata'])
@@ -3168,7 +3269,7 @@ def parseTraceLog(live=False):
 					if not devname:
 						sortkey = '%f%f%d' % (cg.start, cg.end, pid)
 						sortlist[sortkey] = cg
-					elif len(cg.list) > 1000000:
+					elif len(cg.list) > 1000000 and cg.name != sysvals.ftopfunc:
 						sysvals.vprint('WARNING: the callgraph for %s is massive (%d lines)' %\
 							(devname, len(cg.list)))
 			# create blocks for orphan cg data
@@ -3275,7 +3376,7 @@ def loadKernelLog():
 	if data:
 		testruns.append(data)
 	if len(testruns) < 1:
-		pprint('ERROR: dmesg log has no suspend/resume data: %s' \
+		doError('dmesg log has no suspend/resume data: %s' \
 			% sysvals.dmesgfile)
 
 	# fix lines with same timestamp/function with the call and return swapped
@@ -3614,6 +3715,8 @@ def addCallgraphs(sv, hf, data):
 				name += ' '+p
 			if('ftrace' in dev):
 				cg = dev['ftrace']
+				if cg.name == sv.ftopfunc:
+					name = 'top level suspend/resume call'
 				num = callgraphHTML(sv, hf, num, cg,
 					name, color, dev['id'])
 			if('ftraces' in dev):
@@ -3653,9 +3756,10 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 
 	# extract the test data into list
 	list = dict()
-	tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [[], []]
+	tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [dict(), dict()]
 	iMin, iMed, iMax = [0, 0], [0, 0], [0, 0]
 	num = 0
+	useturbo = False
 	lastmode = ''
 	cnt = dict()
 	for data in sorted(testruns, key=lambda v:(v['mode'], v['host'], v['kernel'], v['time'])):
@@ -3666,20 +3770,25 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 			for i in range(2):
 				s = sorted(tMed[i])
 				list[lastmode]['med'][i] = s[int(len(s)/2)]
-				iMed[i] = tMed[i].index(list[lastmode]['med'][i])
+				iMed[i] = tMed[i][list[lastmode]['med'][i]]
 			list[lastmode]['avg'] = [tAvg[0] / num, tAvg[1] / num]
 			list[lastmode]['min'] = tMin
 			list[lastmode]['max'] = tMax
 			list[lastmode]['idx'] = (iMin, iMed, iMax)
-			tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [[], []]
+			tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [dict(), dict()]
 			iMin, iMed, iMax = [0, 0], [0, 0], [0, 0]
 			num = 0
+		pkgpc10 = syslpi = ''
+		if 'pkgpc10' in data and 'syslpi' in data:
+			pkgpc10 = data['pkgpc10']
+			syslpi = data['syslpi']
+			useturbo = True
 		res = data['result']
 		tVal = [float(data['suspend']), float(data['resume'])]
 		list[mode]['data'].append([data['host'], data['kernel'],
 			data['time'], tVal[0], tVal[1], data['url'], res,
 			data['issues'], data['sus_worst'], data['sus_worsttime'],
-			data['res_worst'], data['res_worsttime']])
+			data['res_worst'], data['res_worsttime'], pkgpc10, syslpi])
 		idx = len(list[mode]['data']) - 1
 		if res.startswith('fail in'):
 			res = 'fail'
@@ -3689,7 +3798,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 			cnt[res] += 1
 		if res == 'pass':
 			for i in range(2):
-				tMed[i].append(tVal[i])
+				tMed[i][tVal[i]] = idx
 				tAvg[i] += tVal[i]
 				if tMin[i] == 0 or tVal[i] < tMin[i]:
 					iMin[i] = idx
@@ -3703,7 +3812,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 		for i in range(2):
 			s = sorted(tMed[i])
 			list[lastmode]['med'][i] = s[int(len(s)/2)]
-			iMed[i] = tMed[i].index(list[lastmode]['med'][i])
+			iMed[i] = tMed[i][list[lastmode]['med'][i]]
 		list[lastmode]['avg'] = [tAvg[0] / num, tAvg[1] / num]
 		list[lastmode]['min'] = tMin
 		list[lastmode]['max'] = tMax
@@ -3719,6 +3828,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 	td = '\t<td>{0}</td>\n'
 	tdh = '\t<td{1}>{0}</td>\n'
 	tdlink = '\t<td><a href="{0}">html</a></td>\n'
+	colspan = '14' if useturbo else '12'
 
 	# table header
 	html += '<table>\n<tr>\n' + th.format('#') +\
@@ -3726,12 +3836,13 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 		th.format('Test Time') + th.format('Result') + th.format('Issues') +\
 		th.format('Suspend') + th.format('Resume') +\
 		th.format('Worst Suspend Device') + th.format('SD Time') +\
-		th.format('Worst Resume Device') + th.format('RD Time') +\
-		th.format('Detail') + '</tr>\n'
-
+		th.format('Worst Resume Device') + th.format('RD Time')
+	if useturbo:
+		html += th.format('PkgPC10') + th.format('SysLPI')
+	html += th.format('Detail')+'</tr>\n'
 	# export list into html
 	head = '<tr class="head"><td>{0}</td><td>{1}</td>'+\
-		'<td colspan=12 class="sus">Suspend Avg={2} '+\
+		'<td colspan='+colspan+' class="sus">Suspend Avg={2} '+\
 		'<span class=minval><a href="#s{10}min">Min={3}</a></span> '+\
 		'<span class=medval><a href="#s{10}med">Med={4}</a></span> '+\
 		'<span class=maxval><a href="#s{10}max">Max={5}</a></span> '+\
@@ -3740,7 +3851,8 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 		'<span class=medval><a href="#r{10}med">Med={8}</a></span> '+\
 		'<span class=maxval><a href="#r{10}max">Max={9}</a></span></td>'+\
 		'</tr>\n'
-	headnone = '<tr class="head"><td>{0}</td><td>{1}</td><td colspan=12></td></tr>\n'
+	headnone = '<tr class="head"><td>{0}</td><td>{1}</td><td colspan='+\
+		colspan+'></td></tr>\n'
 	for mode in list:
 		# header line for each suspend mode
 		num = 0
@@ -3787,6 +3899,9 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 			html += td.format('%.3f ms' % d[9])	if d[9] else td.format('')		# sus_worst time
 			html += td.format(d[10])									# res_worst
 			html += td.format('%.3f ms' % d[11]) if d[11] else td.format('')	# res_worst time
+			if useturbo:
+				html += td.format(d[12])								# pkg_pc10
+				html += td.format(d[13])								# syslpi
 			html += tdlink.format(d[5]) if d[5] else td.format('')		# url
 			html += '</tr>\n'
 			num += 1
@@ -3861,8 +3976,10 @@ def createHTMLDeviceSummary(testruns, htmlfile, title):
 	hf.close()
 	return devall
 
-def createHTMLIssuesSummary(issues, htmlfile, title):
+def createHTMLIssuesSummary(testruns, issues, htmlfile, title, extra=''):
+	multihost = len([e for e in issues if len(e['urls']) > 1]) > 0
 	html = summaryCSS('Issues Summary - SleepGraph', False)
+	total = len(testruns)
 
 	# generate the html
 	th = '\t<th>{0}</th>\n'
@@ -3870,27 +3987,36 @@ def createHTMLIssuesSummary(issues, htmlfile, title):
 	tdlink = '<a href="{1}">{0}</a>'
 	subtitle = '%d issues' % len(issues) if len(issues) > 0 else 'no issues'
 	html += '<div class="stamp">%s (%s)</div><table>\n' % (title, subtitle)
-	html += '<tr>\n' + th.format('Count') + th.format('Issue') +\
-		th.format('Hosts') + th.format('First Instance') + '</tr>\n'
+	html += '<tr>\n' + th.format('Issue') + th.format('Count')
+	if multihost:
+		html += th.format('Hosts')
+	html += th.format('Tests') + th.format('Fail Rate') +\
+		th.format('First Instance') + '</tr>\n'
 
 	num = 0
 	for e in sorted(issues, key=lambda v:v['count'], reverse=True):
+		testtotal = 0
 		links = []
 		for host in sorted(e['urls']):
-			links.append(tdlink.format(host, e['urls'][host]))
+			links.append(tdlink.format(host, e['urls'][host][0]))
+			testtotal += len(e['urls'][host])
+		rate = '%d/%d (%.2f%%)' % (testtotal, total, 100*float(testtotal)/float(total))
 		# row classes - alternate row color
 		rcls = ['alt'] if num % 2 == 1 else []
 		html += '<tr class="'+(' '.join(rcls))+'">\n' if len(rcls) > 0 else '<tr>\n'
-		html += td.format('center', e['count'])		# count
 		html += td.format('left', e['line'])		# issue
-		html += td.format('center', len(e['urls']))	# hosts
+		html += td.format('center', e['count'])		# count
+		if multihost:
+			html += td.format('center', len(e['urls']))	# hosts
+		html += td.format('center', testtotal)		# test count
+		html += td.format('center', rate)			# test rate
 		html += td.format('center nowrap', '<br>'.join(links))	# links
 		html += '</tr>\n'
 		num += 1
 
 	# flush the data to file
 	hf = open(htmlfile, 'w')
-	hf.write(html+'</table>\n</body>\n</html>\n')
+	hf.write(html+'</table>\n'+extra+'</body>\n</html>\n')
 	hf.close()
 	return issues
 
@@ -4195,7 +4321,7 @@ def createHTML(testruns, testfail):
 			for word in phase.split('_'):
 				id += word[0]
 			order = '%.2f' % ((p['order'] * pdelta) + pmargin)
-			name = string.replace(phase, '_', ' &nbsp;')
+			name = phase.replace('_', ' &nbsp;')
 			devtl.html += devtl.html_legend.format(order, p['color'], name, id)
 		devtl.html += '</div>\n'
 
@@ -4784,6 +4910,7 @@ def setRuntimeSuspend(before=True):
 def executeSuspend():
 	pm = ProcessMonitor()
 	tp = sysvals.tpath
+	wifi = sysvals.checkWifi()
 	testdata = []
 	battery = True if getBattery() else False
 	# run these commands to prepare the system for suspend
@@ -4857,6 +4984,8 @@ def executeSuspend():
 				else:
 					tdata['error'] = turbo
 			else:
+				if sysvals.haveTurbostat():
+					sysvals.vprint('WARNING: ignoring turbostat in mode "%s"' % mode)
 				pf = open(sysvals.powerfile, 'w')
 				pf.write(mode)
 				# execution will pause here
@@ -4883,6 +5012,8 @@ def executeSuspend():
 		bat2 = getBattery() if battery else False
 		if battery and bat1 and bat2:
 			tdata['bat'] = (bat1, bat2)
+		if 'device' in wifi and 'ip' in wifi:
+			tdata['wifi'] = (wifi, sysvals.checkWifi())
 		testdata.append(tdata)
 	# stop ftrace
 	if(sysvals.usecallgraph or sysvals.usetraceevents):
@@ -4989,7 +5120,7 @@ def deviceInfo(output=''):
 			ms2nice(power['runtime_active_time']), \
 			ms2nice(power['runtime_suspended_time']))
 	for i in sorted(lines):
-		print lines[i]
+		print(lines[i])
 	return res
 
 # Function: devProps
@@ -5122,12 +5253,12 @@ def getModes():
 	modes = []
 	if(os.path.exists(sysvals.powerfile)):
 		fp = open(sysvals.powerfile, 'r')
-		modes = string.split(fp.read())
+		modes = fp.read().split()
 		fp.close()
 	if(os.path.exists(sysvals.mempowerfile)):
 		deep = False
 		fp = open(sysvals.mempowerfile, 'r')
-		for m in string.split(fp.read()):
+		for m in fp.read().split():
 			memmode = m.strip('[]')
 			if memmode == 'deep':
 				deep = True
@@ -5138,7 +5269,7 @@ def getModes():
 			modes.remove('mem')
 	if('disk' in modes and os.path.exists(sysvals.diskpowerfile)):
 		fp = open(sysvals.diskpowerfile, 'r')
-		for m in string.split(fp.read()):
+		for m in fp.read().split():
 			modes.append('disk-%s' % m.strip('[]'))
 		fp.close()
 	return modes
@@ -5201,14 +5332,15 @@ def dmidecode(mempath, fatal=False):
 				continue
 
 	# read in the memory for scanning
-	fp = open(mempath, 'rb')
 	try:
+		fp = open(mempath, 'rb')
 		fp.seek(memaddr)
 		buf = fp.read(memsize)
 	except:
 		if(fatal):
 			doError('DMI table is unreachable, sorry')
 		else:
+			pprint('WARNING: /dev/mem is not readable, ignoring DMI data')
 			return out
 	fp.close()
 
@@ -5231,14 +5363,15 @@ def dmidecode(mempath, fatal=False):
 			return out
 
 	# read in the SM or DMI table
-	fp = open(mempath, 'rb')
 	try:
+		fp = open(mempath, 'rb')
 		fp.seek(base)
 		buf = fp.read(length)
 	except:
 		if(fatal):
 			doError('DMI table is unreachable, sorry')
 		else:
+			pprint('WARNING: /dev/mem is not readable, ignoring DMI data')
 			return out
 	fp.close()
 
@@ -5382,7 +5515,11 @@ def getFPDT(output):
 	i = 0
 	fwData = [0, 0]
 	records = buf[36:]
-	fp = open(sysvals.mempath, 'rb')
+	try:
+		fp = open(sysvals.mempath, 'rb')
+	except:
+		pprint('WARNING: /dev/mem is not readable, ignoring the FPDT data')
+		return False
 	while(i < len(records)):
 		header = struct.unpack('HBB', records[i:i+4])
 		if(header[0] not in rectype):
@@ -5499,13 +5636,14 @@ def statusCheck(probecheck=False):
 	pprint('    is ftrace supported: %s' % res)
 
 	# check if kprobes are available
-	res = sysvals.colorText('NO')
-	sysvals.usekprobes = sysvals.verifyKprobes()
-	if(sysvals.usekprobes):
-		res = 'YES'
-	else:
-		sysvals.usedevsrc = False
-	pprint('    are kprobes supported: %s' % res)
+	if sysvals.usekprobes:
+		res = sysvals.colorText('NO')
+		sysvals.usekprobes = sysvals.verifyKprobes()
+		if(sysvals.usekprobes):
+			res = 'YES'
+		else:
+			sysvals.usedevsrc = False
+		pprint('    are kprobes supported: %s' % res)
 
 	# what data source are we using
 	res = 'DMESG'
@@ -5593,6 +5731,8 @@ def getArgFloat(name, args, min, max, main=True):
 
 def processData(live=False):
 	pprint('PROCESSING DATA')
+	sysvals.vprint('usetraceevents=%s, usetracemarkers=%s, usekprobes=%s' % \
+		(sysvals.usetraceevents, sysvals.usetracemarkers, sysvals.usekprobes))
 	error = ''
 	if(sysvals.usetraceevents):
 		testruns, error = parseTraceLog(live)
@@ -5605,6 +5745,11 @@ def processData(live=False):
 			parseKernelLog(data)
 		if(sysvals.ftracefile and (sysvals.usecallgraph or sysvals.usetraceevents)):
 			appendIncompleteTraceLog(testruns)
+	sysvals.vprint('System Info:')
+	for key in sorted(sysvals.stamp):
+		sysvals.vprint('    %-8s : %s' % (key.upper(), sysvals.stamp[key]))
+	if sysvals.kparams:
+		sysvals.vprint('Kparams:\n    %s' % sysvals.kparams)
 	sysvals.vprint('Command:\n    %s' % sysvals.cmdline)
 	for data in testruns:
 		if data.mcelog:
@@ -5612,12 +5757,24 @@ def processData(live=False):
 			for line in data.mcelog.split('\n'):
 				sysvals.vprint('    %s' % line)
 		if data.turbostat:
-			sysvals.vprint('Turbostat:\n    %s' % data.turbostat.replace('|', ' '))
+			idx, s = 0, 'Turbostat:\n    '
+			for val in data.turbostat.split('|'):
+				idx += len(val) + 1
+				if idx >= 80:
+					idx = 0
+					s += '\n    '
+				s += val + ' '
+			sysvals.vprint(s)
 		if data.battery:
 			a1, c1, a2, c2 = data.battery
 			s = 'Battery:\n    Before - AC: %s, Charge: %d\n     After - AC: %s, Charge: %d' % \
 				(a1, int(c1), a2, int(c2))
 			sysvals.vprint(s)
+		if data.wifi:
+			w = data.wifi.replace('|', ' ').split(',')
+			s = 'Wifi:\n    Before %s\n     After %s' % \
+				(w[0], w[1])
+			sysvals.vprint(s)
 		data.printDetails()
 	if sysvals.cgdump:
 		for data in testruns:
@@ -5641,13 +5798,13 @@ def processData(live=False):
 # Function: rerunTest
 # Description:
 #	 generate an output from an existing set of ftrace/dmesg logs
-def rerunTest():
+def rerunTest(htmlfile=''):
 	if sysvals.ftracefile:
 		doesTraceLogHaveTraceEvents()
 	if not sysvals.dmesgfile and not sysvals.usetraceevents:
 		doError('recreating this html output requires a dmesg file')
-	if sysvals.outdir:
-		sysvals.htmlfile = sysvals.outdir
+	if htmlfile:
+		sysvals.htmlfile = htmlfile
 	else:
 		sysvals.setOutputFile()
 	if os.path.exists(sysvals.htmlfile):
@@ -5673,7 +5830,7 @@ def runTest(n=0):
 	if sysvals.skiphtml:
 		sysvals.sudoUserchown(sysvals.testdir)
 		return
-	if len(testdata) > 0 and not testdata[0]['error']:
+	if not testdata[0]['error']:
 		testruns, stamp = processData(True)
 		for data in testruns:
 			del data
@@ -5709,15 +5866,13 @@ def find_in_html(html, start, end, firstonly=True):
 		return ''
 	return out
 
-def data_from_html(file, outpath, issues):
-	if '<html>' not in file:
-		html = open(file, 'r').read()
-		sysvals.htmlfile = os.path.relpath(file, outpath)
-	else:
-		html = file
+def data_from_html(file, outpath, issues, fulldetail=False):
+	html = open(file, 'r').read()
+	sysvals.htmlfile = os.path.relpath(file, outpath)
 	# extract general info
 	suspend = find_in_html(html, 'Kernel Suspend', 'ms')
 	resume = find_in_html(html, 'Kernel Resume', 'ms')
+	sysinfo = find_in_html(html, '<div class="stamp sysinfo">', '</div>')
 	line = find_in_html(html, '<div class="stamp">', '</div>')
 	stmp = line.split()
 	if not suspend or not resume or len(stmp) != 8:
@@ -5739,13 +5894,18 @@ def data_from_html(file, outpath, issues):
 		result = 'pass'
 	# extract error info
 	ilist = []
+	extra = dict()
 	log = find_in_html(html, '<div id="dmesglog" style="display:none;">',
 		'</div>').strip()
 	if log:
 		d = Data(0)
 		d.end = 999999999
 		d.dmesgtext = log.split('\n')
-		d.extractErrorInfo(issues)
+		msglist = d.extractErrorInfo()
+		for msg in msglist:
+			sysvals.errorSummary(issues, msg)
+		if stmp[2] == 'freeze':
+			extra = d.turbostatInfo()
 		elist = dict()
 		for dir in d.errorinfo:
 			for err in d.errorinfo[dir]:
@@ -5761,14 +5921,15 @@ def data_from_html(file, outpath, issues):
 		if len(match) > 0:
 			match[0]['count'] += 1
 			if sysvals.hostname not in match[0]['urls']:
-				match[0]['urls'][sysvals.hostname] = sysvals.htmlfile
+				match[0]['urls'][sysvals.hostname] = [sysvals.htmlfile]
+			elif sysvals.htmlfile not in match[0]['urls'][sysvals.hostname]:
+				match[0]['urls'][sysvals.hostname].append(sysvals.htmlfile)
 		else:
 			issues.append({
 				'match': issue, 'count': 1, 'line': issue,
-				'urls': {sysvals.hostname: sysvals.htmlfile},
+				'urls': {sysvals.hostname: [sysvals.htmlfile]},
 			})
 		ilist.append(issue)
-
 	# extract device info
 	devices = dict()
 	for line in html.split('\n'):
@@ -5804,6 +5965,7 @@ def data_from_html(file, outpath, issues):
 		'mode': stmp[2],
 		'host': stmp[0],
 		'kernel': stmp[1],
+		'sysinfo': sysinfo,
 		'time': tstr,
 		'result': result,
 		'issues': ' '.join(ilist),
@@ -5816,8 +5978,28 @@ def data_from_html(file, outpath, issues):
 		'res_worsttime': worst['resume']['time'],
 		'url': sysvals.htmlfile,
 	}
+	for key in extra:
+		data[key] = extra[key]
+	if fulldetail:
+		data['funclist'] = find_in_html(html, '<div title="', '" class="traceevent"', False)
 	return data
 
+def genHtml(subdir):
+	for dirname, dirnames, filenames in os.walk(subdir):
+		sysvals.dmesgfile = sysvals.ftracefile = sysvals.htmlfile = ''
+		for filename in filenames:
+			if(re.match('.*_dmesg.txt', filename)):
+				sysvals.dmesgfile = os.path.join(dirname, filename)
+			elif(re.match('.*_ftrace.txt', filename)):
+				sysvals.ftracefile = os.path.join(dirname, filename)
+		sysvals.setOutputFile()
+		if sysvals.ftracefile and sysvals.htmlfile and \
+			not os.path.exists(sysvals.htmlfile):
+			pprint('FTRACE: %s' % sysvals.ftracefile)
+			if sysvals.dmesgfile:
+				pprint('DMESG : %s' % sysvals.dmesgfile)
+			rerunTest()
+
 # Function: runSummary
 # Description:
 #	 create a summary of tests in a sub-directory
@@ -5826,20 +6008,7 @@ def runSummary(subdir, local=True, genhtml=False):
 	outpath = os.path.abspath('.') if local else inpath
 	pprint('Generating a summary of folder:\n   %s' % inpath)
 	if genhtml:
-		for dirname, dirnames, filenames in os.walk(subdir):
-			sysvals.dmesgfile = sysvals.ftracefile = sysvals.htmlfile = ''
-			for filename in filenames:
-				if(re.match('.*_dmesg.txt', filename)):
-					sysvals.dmesgfile = os.path.join(dirname, filename)
-				elif(re.match('.*_ftrace.txt', filename)):
-					sysvals.ftracefile = os.path.join(dirname, filename)
-			sysvals.setOutputFile()
-			if sysvals.ftracefile and sysvals.htmlfile and \
-				not os.path.exists(sysvals.htmlfile):
-				pprint('FTRACE: %s' % sysvals.ftracefile)
-				if sysvals.dmesgfile:
-					pprint('DMESG : %s' % sysvals.dmesgfile)
-				rerunTest()
+		genHtml(subdir)
 	issues = []
 	testruns = []
 	desc = {'host':[],'mode':[],'kernel':[]}
@@ -5863,7 +6032,7 @@ def runSummary(subdir, local=True, genhtml=False):
 	pprint('   summary.html         - tabular list of test data found')
 	createHTMLDeviceSummary(testruns, os.path.join(outpath, 'summary-devices.html'), title)
 	pprint('   summary-devices.html - kernel device list sorted by total execution time')
-	createHTMLIssuesSummary(issues, os.path.join(outpath, 'summary-issues.html'), title)
+	createHTMLIssuesSummary(testruns, issues, os.path.join(outpath, 'summary-issues.html'), title)
 	pprint('   summary-issues.html  - kernel issues found sorted by frequency')
 
 # Function: checkArgBool
@@ -6109,6 +6278,7 @@ def printHelp():
 	'                default: suspend-{date}-{time}\n'\
 	'   -rtcwake t   Wakeup t seconds after suspend, set t to "off" to disable (default: 15)\n'\
 	'   -addlogs     Add the dmesg and ftrace logs to the html output\n'\
+	'   -turbostat   Use turbostat to execute the command in freeze mode (default: disabled)\n'\
 	'   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)\n'\
 	'   -skiphtml    Run the test and capture the trace logs, but skip the timeline (default: disabled)\n'\
 	'   -result fn   Export a results table to a text file for parsing.\n'\
@@ -6130,6 +6300,7 @@ def printHelp():
 	'                be created in a new subdirectory with a summary page.\n'\
 	'  [debug]\n'\
 	'   -f           Use ftrace to create device callgraphs (default: disabled)\n'\
+	'   -ftop        Use ftrace on the top level call: "%s" (default: disabled)\n'\
 	'   -maxdepth N  limit the callgraph data to N call levels (default: 0=all)\n'\
 	'   -expandcg    pre-expand the callgraph data in the html output (default: disabled)\n'\
 	'   -fadd file   Add functions to be graphed in the timeline from a list in a text file\n'\
@@ -6149,6 +6320,7 @@ def printHelp():
 	'   -status      Test to see if the system is enabled to run this tool\n'\
 	'   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table\n'\
 	'   -battery     Print out battery info (if available)\n'\
+	'   -wifi        Print out wifi connection info (if wireless-tools and device exists)\n'\
 	'   -x<mode>     Test xset by toggling the given mode (on/off/standby/suspend)\n'\
 	'   -sysinfo     Print out system info extracted from BIOS\n'\
 	'   -devinfo     Print out the pm settings of all devices which support runtime suspend\n'\
@@ -6158,7 +6330,7 @@ def printHelp():
 	'  [redo]\n'\
 	'   -ftrace ftracefile  Create HTML output using ftrace input (used with -dmesg)\n'\
 	'   -dmesg dmesgfile    Create HTML output using dmesg (used with -ftrace)\n'\
-	'' % (sysvals.title, sysvals.version, sysvals.suspendmode))
+	'' % (sysvals.title, sysvals.version, sysvals.suspendmode, sysvals.ftopfunc))
 	return True
 
 # ----------------- MAIN --------------------
@@ -6168,7 +6340,7 @@ if __name__ == '__main__':
 	cmd = ''
 	simplecmds = ['-sysinfo', '-modes', '-fpdt', '-flist', '-flistall',
 		'-devinfo', '-status', '-battery', '-xon', '-xoff', '-xstandby',
-		'-xsuspend', '-xinit', '-xreset', '-xstat']
+		'-xsuspend', '-xinit', '-xreset', '-xstat', '-wifi']
 	if '-f' in sys.argv:
 		sysvals.cgskip = sysvals.configFile('cgskip.txt')
 	# loop through the command line arguments
@@ -6200,6 +6372,10 @@ if __name__ == '__main__':
 			sysvals.postdelay = getArgInt('-postdelay', args, 0, 60000)
 		elif(arg == '-f'):
 			sysvals.usecallgraph = True
+		elif(arg == '-ftop'):
+			sysvals.usecallgraph = True
+			sysvals.ftop = True
+			sysvals.usekprobes = False
 		elif(arg == '-skiphtml'):
 			sysvals.skiphtml = True
 		elif(arg == '-cgdump'):
@@ -6210,10 +6386,16 @@ if __name__ == '__main__':
 			genhtml = True
 		elif(arg == '-addlogs'):
 			sysvals.dmesglog = sysvals.ftracelog = True
+		elif(arg == '-nologs'):
+			sysvals.dmesglog = sysvals.ftracelog = False
 		elif(arg == '-addlogdmesg'):
 			sysvals.dmesglog = True
 		elif(arg == '-addlogftrace'):
 			sysvals.ftracelog = True
+		elif(arg == '-turbostat'):
+			sysvals.tstat = True
+			if not sysvals.haveTurbostat():
+				doError('Turbostat command not found')
 		elif(arg == '-verbose'):
 			sysvals.verbose = True
 		elif(arg == '-proc'):
@@ -6283,6 +6465,12 @@ if __name__ == '__main__':
 			except:
 				doError('No callgraph functions supplied', True)
 			sysvals.setCallgraphFilter(val)
+		elif(arg == '-skipkprobe'):
+			try:
+				val = args.next()
+			except:
+				doError('No kprobe functions supplied', True)
+			sysvals.skipKprobes(val)
 		elif(arg == '-cgskip'):
 			try:
 				val = args.next()
@@ -6421,7 +6609,7 @@ if __name__ == '__main__':
 		elif(cmd == 'devinfo'):
 			deviceInfo()
 		elif(cmd == 'modes'):
-			print getModes()
+			pprint(getModes())
 		elif(cmd == 'flist'):
 			sysvals.getFtraceFilterFunctions(True)
 		elif(cmd == 'flistall'):
@@ -6433,11 +6621,18 @@ if __name__ == '__main__':
 			ret = displayControl(cmd[1:])
 		elif(cmd == 'xstat'):
 			pprint('Display Status: %s' % displayControl('stat').upper())
+		elif(cmd == 'wifi'):
+			out = sysvals.checkWifi()
+			if 'device' not in out:
+				pprint('WIFI interface not found')
+			else:
+				for key in sorted(out):
+					pprint('%6s: %s' % (key.upper(), out[key]))
 		sys.exit(ret)
 
 	# if instructed, re-analyze existing data files
 	if(sysvals.notestrun):
-		stamp = rerunTest()
+		stamp = rerunTest(sysvals.outdir)
 		sysvals.outputResult(stamp)
 		sys.exit(0)
 
@@ -6474,7 +6669,7 @@ if __name__ == '__main__':
 			s = 'suspend-x%d' % sysvals.multitest['count']
 			sysvals.outdir = datetime.now().strftime(s+'-%y%m%d-%H%M%S')
 		if not os.path.isdir(sysvals.outdir):
-			os.mkdir(sysvals.outdir)
+			os.makedirs(sysvals.outdir)
 		for i in range(sysvals.multitest['count']):
 			if(i != 0):
 				pprint('Waiting %d seconds...' % (sysvals.multitest['delay']))
-- 
2.14.1

