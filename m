Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE01CE5B
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfENRyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 13:54:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:60691 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfENRyD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 13:54:03 -0400
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
Subject: [PATCH 1/3] Update to pm-graph 5.3
Date:   Tue, 14 May 2019 10:53:57 -0700
Message-Id: <e6c346334a21d2141db932a1e6e268cec587db75.1557855894.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sleepgraph:
- add support for parsing kernel issues from timeline dmesg logs
- with -summary, generate a summary-issues.html for kernel issues found
- with -summary, generate a summary-devices.html for device callback times
- when recreating a timeline, use -o to set the output html filename
- capture mcelog data when hardware errors occur and store in log
- add -turbostat option to capture power data during freeze

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/sleepgraph.py | 496 ++++++++++++++++++++++++++++---------
 1 file changed, 379 insertions(+), 117 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 52618f3444d4..41d28d63e7c9 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -61,6 +61,7 @@ import ConfigParser
 import gzip
 from threading import Thread
 from subprocess import call, Popen, PIPE
+import base64
 
 def pprint(msg):
 	print(msg)
@@ -74,7 +75,7 @@ def pprint(msg):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.2'
+	version = '5.3'
 	ansi = False
 	rs = 0
 	display = ''
@@ -199,6 +200,7 @@ class SystemValues:
 		'usleep_range': { 'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'}, 'ub': 1 },
 		'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath', 'ub': 1 },
 		'acpi_os_stall': {'ub': 1},
+		'rt_mutex_slowlock': {'ub': 1},
 		# ACPI
 		'acpi_resume_power_resources': {},
 		'acpi_ps_parse_aml': {},
@@ -344,10 +346,12 @@ class SystemValues:
 			m = info['baseboard-manufacturer']
 		elif 'system-manufacturer' in info:
 			m = info['system-manufacturer']
-		if 'baseboard-product-name' in info:
-			p = info['baseboard-product-name']
-		elif 'system-product-name' in info:
+		if 'system-product-name' in info:
 			p = info['system-product-name']
+		elif 'baseboard-product-name' in info:
+			p = info['baseboard-product-name']
+		if m[:5].lower() == 'intel' and 'baseboard-product-name' in info:
+			p = info['baseboard-product-name']
 		if 'processor-version' in info:
 			c = info['processor-version']
 		if 'bios-version' in info:
@@ -688,7 +692,8 @@ class SystemValues:
 		if self.bufsize > 0:
 			tgtsize = self.bufsize
 		elif self.usecallgraph or self.usedevsrc:
-			bmax = (1*1024*1024) if self.suspendmode == 'disk' else (3*1024*1024)
+			bmax = (1*1024*1024) if self.suspendmode in ['disk', 'command'] \
+				else (3*1024*1024)
 			tgtsize = min(self.memfree, bmax)
 		else:
 			tgtsize = 65536
@@ -776,6 +781,10 @@ class SystemValues:
 				fw = test['fw']
 				if(fw):
 					fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
+			if 'mcelog' in test:
+				fp.write('# mcelog %s\n' % test['mcelog'])
+			if 'turbo' in test:
+				fp.write('# turbostat %s\n' % test['turbo'])
 			if 'bat' in test:
 				(a1, c1), (a2, c2) = test['bat']
 				fp.write('# battery %s %d %s %d\n' % (a1, c1, a2, c2))
@@ -829,6 +838,56 @@ class SystemValues:
 		if isgz:
 			return gzip.open(filename, mode+'b')
 		return open(filename, mode)
+	def mcelog(self, clear=False):
+		cmd = self.getExec('mcelog')
+		if not cmd:
+			return ''
+		if clear:
+			call(cmd+' > /dev/null 2>&1', shell=True)
+			return ''
+		fp = Popen([cmd], stdout=PIPE, stderr=PIPE).stdout
+		out = fp.read().strip()
+		fp.close()
+		if not out:
+			return ''
+		return base64.b64encode(out.encode('zlib'))
+	def haveTurbostat(self):
+		cmd = self.getExec('turbostat')
+		if not cmd:
+			return False
+		fp = Popen([cmd, '-v'], stdout=PIPE, stderr=PIPE).stderr
+		out = fp.read().strip()
+		fp.close()
+		return re.match('turbostat version [0-8.]* .*', out)
+	def turbostat(self):
+		cmd = self.getExec('turbostat')
+		if not cmd:
+			return 'missing turbostat executable'
+		outfile = '/tmp/pm-graph-turbostat.txt'
+		res = call('%s -o %s -q -S echo freeze > %s' % \
+			(cmd, outfile, self.powerfile), shell=True)
+		if res != 0:
+			return 'turbosat returned %d' % res
+		if not os.path.exists(outfile):
+			return 'turbostat output missing'
+		fp = open(outfile, 'r')
+		text = []
+		for line in fp:
+			if re.match('[0-9.]* sec', line):
+				continue
+			text.append(line.split())
+		fp.close()
+		if len(text) < 2:
+			return 'turbostat output format error'
+		out = []
+		for key in text[0]:
+			values = []
+			idx = text[0].index(key)
+			for line in text[1:]:
+				if len(line) > idx:
+					values.append(line[idx])
+			out.append('%s=%s' % (key, ','.join(values)))
+		return '|'.join(out)
 
 sysvals = SystemValues()
 switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
@@ -941,6 +1000,8 @@ class Data:
 		self.outfile = ''
 		self.kerror = False
 		self.battery = 0
+		self.turbostat = 0
+		self.mcelog = 0
 		self.enterfail = ''
 		self.currphase = ''
 		self.pstl = dict()    # process timeline
@@ -975,8 +1036,38 @@ class Data:
 		if len(plist) < 1:
 			return ''
 		return plist[-1]
-	def extractErrorInfo(self):
-		lf = sysvals.openlog(sysvals.dmesgfile, 'r')
+	def errorSummary(self, errinfo, msg):
+		found = False
+		for entry in errinfo:
+			if re.match(entry['match'], msg):
+				entry['count'] += 1
+				if sysvals.hostname not in entry['urls']:
+					entry['urls'][sysvals.hostname] = sysvals.htmlfile
+				found = True
+				break
+		if found:
+			return
+		arr = msg.split()
+		for j in range(len(arr)):
+			if re.match('^[0-9\-\.]*$', arr[j]):
+				arr[j] = '[0-9\-\.]*'
+			else:
+				arr[j] = arr[j]\
+					.replace(']', '\]').replace('[', '\[').replace('.', '\.')\
+					.replace('+', '\+').replace('*', '\*').replace('(', '\(')\
+					.replace(')', '\)')
+		mstr = ' '.join(arr)
+		entry = {
+			'line': msg,
+			'match': mstr,
+			'count': 1,
+			'urls': {sysvals.hostname: sysvals.htmlfile}
+		}
+		errinfo.append(entry)
+	def extractErrorInfo(self, issues=0):
+		lf = self.dmesgtext
+		if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
+			lf = sysvals.openlog(sysvals.dmesgfile, 'r')
 		i = 0
 		list = []
 		for line in lf:
@@ -993,6 +1084,8 @@ class Data:
 				if re.match(self.errlist[err], msg):
 					list.append((err, dir, t, i, i))
 					self.kerror = True
+					if not isinstance(issues, int):
+						self.errorSummary(issues, msg)
 					break
 		for e in list:
 			type, dir, t, idx1, idx2 = e
@@ -1000,7 +1093,8 @@ class Data:
 			self.errorinfo[dir].append((type, t, idx1, idx2))
 		if self.kerror:
 			sysvals.dmesglog = True
-		lf.close()
+		if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
+			lf.close()
 	def setStart(self, time):
 		self.start = time
 	def setEnd(self, time):
@@ -2358,6 +2452,8 @@ class TestProps:
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
 	batteryfmt = '^# battery (?P<a1>\w*) (?P<c1>\d*) (?P<a2>\w*) (?P<c2>\d*)'
+	tstatfmt   = '^# turbostat (?P<t>\S*)'
+	mcelogfmt  = '^# mcelog (?P<m>\S*)'
 	testerrfmt = '^# enter_sleep_error (?P<e>.*)'
 	sysinfofmt = '^# sysinfo .*'
 	cmdlinefmt = '^# command \| (?P<cmd>.*)'
@@ -2380,6 +2476,8 @@ class TestProps:
 		self.cmdline = ''
 		self.kparams = ''
 		self.testerror = []
+		self.mcelog = []
+		self.turbostat = []
 		self.battery = []
 		self.fwdata = []
 		self.ftrace_line_fmt = self.ftrace_line_fmt_nop
@@ -2394,6 +2492,38 @@ class TestProps:
 			self.ftrace_line_fmt = self.ftrace_line_fmt_nop
 		else:
 			doError('Invalid tracer format: [%s]' % tracer)
+	def decode(self, data):
+		try:
+			out = base64.b64decode(data).decode('zlib')
+		except:
+			out = data
+		return out
+	def stampInfo(self, line):
+		if re.match(self.stampfmt, line):
+			self.stamp = line
+			return True
+		elif re.match(self.sysinfofmt, line):
+			self.sysinfo = line
+			return True
+		elif re.match(self.cmdlinefmt, line):
+			self.cmdline = line
+			return True
+		elif re.match(self.mcelogfmt, line):
+			self.mcelog.append(line)
+			return True
+		elif re.match(self.tstatfmt, line):
+			self.turbostat.append(line)
+			return True
+		elif re.match(self.batteryfmt, line):
+			self.battery.append(line)
+			return True
+		elif re.match(self.testerrfmt, line):
+			self.testerror.append(line)
+			return True
+		elif re.match(self.firmwarefmt, line):
+			self.fwdata.append(line)
+			return True
+		return False
 	def parseStamp(self, data, sv):
 		# global test data
 		m = re.match(self.stampfmt, self.stamp)
@@ -2436,9 +2566,21 @@ class TestProps:
 			sv.stamp = data.stamp
 		# firmware data
 		if sv.suspendmode == 'mem' and len(self.fwdata) > data.testnumber:
-			data.fwSuspend, data.fwResume = self.fwdata[data.testnumber]
-			if(data.fwSuspend > 0 or data.fwResume > 0):
-				data.fwValid = True
+			m = re.match(self.firmwarefmt, self.fwdata[data.testnumber])
+			if m:
+				data.fwSuspend, data.fwResume = int(m.group('s')), int(m.group('r'))
+				if(data.fwSuspend > 0 or data.fwResume > 0):
+					data.fwValid = True
+		# mcelog data
+		if len(self.mcelog) > data.testnumber:
+			m = re.match(self.mcelogfmt, self.mcelog[data.testnumber])
+			if m:
+				data.mcelog = self.decode(m.group('m'))
+		# turbostat data
+		if len(self.turbostat) > data.testnumber:
+			m = re.match(self.tstatfmt, self.turbostat[data.testnumber])
+			if m:
+				data.turbostat = m.group('t')
 		# battery data
 		if len(self.battery) > data.testnumber:
 			m = re.match(self.batteryfmt, self.battery[data.testnumber])
@@ -2564,21 +2706,7 @@ def appendIncompleteTraceLog(testruns):
 	for line in tf:
 		# remove any latent carriage returns
 		line = line.replace('\r\n', '')
-		# grab the stamp and sysinfo
-		if re.match(tp.stampfmt, line):
-			tp.stamp = line
-			continue
-		elif re.match(tp.sysinfofmt, line):
-			tp.sysinfo = line
-			continue
-		elif re.match(tp.cmdlinefmt, line):
-			tp.cmdline = line
-			continue
-		elif re.match(tp.batteryfmt, line):
-			tp.battery.append(line)
-			continue
-		elif re.match(tp.testerrfmt, line):
-			tp.testerror.append(line)
+		if tp.stampInfo(line):
 			continue
 		# determine the trace data type (required for further parsing)
 		m = re.match(tp.tracertypefmt, line)
@@ -2701,26 +2829,7 @@ def parseTraceLog(live=False):
 	for line in tf:
 		# remove any latent carriage returns
 		line = line.replace('\r\n', '')
-		# stamp and sysinfo lines
-		if re.match(tp.stampfmt, line):
-			tp.stamp = line
-			continue
-		elif re.match(tp.sysinfofmt, line):
-			tp.sysinfo = line
-			continue
-		elif re.match(tp.cmdlinefmt, line):
-			tp.cmdline = line
-			continue
-		elif re.match(tp.batteryfmt, line):
-			tp.battery.append(line)
-			continue
-		elif re.match(tp.testerrfmt, line):
-			tp.testerror.append(line)
-			continue
-		# firmware line: pull out any firmware data
-		m = re.match(tp.firmwarefmt, line)
-		if(m):
-			tp.fwdata.append((int(m.group('s')), int(m.group('r'))))
+		if tp.stampInfo(line):
 			continue
 		# tracer type line: determine the trace data type
 		m = re.match(tp.tracertypefmt, line)
@@ -3141,25 +3250,7 @@ def loadKernelLog():
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
-		# grab the stamp and sysinfo
-		if re.match(tp.stampfmt, line):
-			tp.stamp = line
-			continue
-		elif re.match(tp.sysinfofmt, line):
-			tp.sysinfo = line
-			continue
-		elif re.match(tp.cmdlinefmt, line):
-			tp.cmdline = line
-			continue
-		elif re.match(tp.batteryfmt, line):
-			tp.battery.append(line)
-			continue
-		elif re.match(tp.testerrfmt, line):
-			tp.testerror.append(line)
-			continue
-		m = re.match(tp.firmwarefmt, line)
-		if(m):
-			tp.fwdata.append((int(m.group('s')), int(m.group('r'))))
+		if tp.stampInfo(line):
 			continue
 		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 		if(not m):
@@ -3531,22 +3622,16 @@ def addCallgraphs(sv, hf, data):
 						name+' &rarr; '+cg.name, color, dev['id'])
 	hf.write('\n\n    </section>\n')
 
-# Function: createHTMLSummarySimple
-# Description:
-#	 Create summary html file for a series of tests
-# Arguments:
-#	 testruns: array of Data objects from parseTraceLog
-def createHTMLSummarySimple(testruns, htmlfile, title):
-	# write the html header first (html head, css code, up to body start)
-	html = '<!DOCTYPE html>\n<html>\n<head>\n\
+def summaryCSS(title, center=True):
+	tdcenter = 'text-align:center;' if center else ''
+	out = '<!DOCTYPE html>\n<html>\n<head>\n\
 	<meta http-equiv="content-type" content="text/html; charset=UTF-8">\n\
-	<title>SleepGraph Summary</title>\n\
+	<title>'+title+'</title>\n\
 	<style type=\'text/css\'>\n\
 		.stamp {width: 100%;text-align:center;background:#888;line-height:30px;color:white;font: 25px Arial;}\n\
-		table {width:100%;border-collapse: collapse;}\n\
-		.summary {border:1px solid;}\n\
+		table {width:100%;border-collapse: collapse;border:1px solid;}\n\
 		th {border: 1px solid black;background:#222;color:white;}\n\
-		td {font: 14px "Times New Roman";text-align: center;}\n\
+		td {font: 14px "Times New Roman";'+tdcenter+'}\n\
 		tr.head td {border: 1px solid black;background:#aaa;}\n\
 		tr.alt {background-color:#ddd;}\n\
 		tr.notice {color:red;}\n\
@@ -3555,6 +3640,16 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 		.maxval {background-color:#FFBBBB;}\n\
 		.head a {color:#000;text-decoration: none;}\n\
 	</style>\n</head>\n<body>\n'
+	return out
+
+# Function: createHTMLSummarySimple
+# Description:
+#	 Create summary html file for a series of tests
+# Arguments:
+#	 testruns: array of Data objects from parseTraceLog
+def createHTMLSummarySimple(testruns, htmlfile, title):
+	# write the html header first (html head, css code, up to body start)
+	html = summaryCSS('Summary - SleepGraph')
 
 	# extract the test data into list
 	list = dict()
@@ -3579,17 +3674,20 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 			tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [[], []]
 			iMin, iMed, iMax = [0, 0], [0, 0], [0, 0]
 			num = 0
+		res = data['result']
 		tVal = [float(data['suspend']), float(data['resume'])]
 		list[mode]['data'].append([data['host'], data['kernel'],
-			data['time'], tVal[0], tVal[1], data['url'], data['result'],
+			data['time'], tVal[0], tVal[1], data['url'], res,
 			data['issues'], data['sus_worst'], data['sus_worsttime'],
 			data['res_worst'], data['res_worsttime']])
 		idx = len(list[mode]['data']) - 1
-		if data['result'] not in cnt:
-			cnt[data['result']] = 1
+		if res.startswith('fail in'):
+			res = 'fail'
+		if res not in cnt:
+			cnt[res] = 1
 		else:
-			cnt[data['result']] += 1
-		if data['result'] == 'pass':
+			cnt[res] += 1
+		if res == 'pass':
 			for i in range(2):
 				tMed[i].append(tVal[i])
 				tAvg[i] += tVal[i]
@@ -3623,7 +3721,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 	tdlink = '\t<td><a href="{0}">html</a></td>\n'
 
 	# table header
-	html += '<table class="summary">\n<tr>\n' + th.format('#') +\
+	html += '<table>\n<tr>\n' + th.format('#') +\
 		th.format('Mode') + th.format('Host') + th.format('Kernel') +\
 		th.format('Test Time') + th.format('Result') + th.format('Issues') +\
 		th.format('Suspend') + th.format('Resume') +\
@@ -3698,6 +3796,104 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 	hf.write(html+'</table>\n</body>\n</html>\n')
 	hf.close()
 
+def createHTMLDeviceSummary(testruns, htmlfile, title):
+	html = summaryCSS('Device Summary - SleepGraph', False)
+
+	# create global device list from all tests
+	devall = dict()
+	for data in testruns:
+		host, url, devlist = data['host'], data['url'], data['devlist']
+		for type in devlist:
+			if type not in devall:
+				devall[type] = dict()
+			mdevlist, devlist = devall[type], data['devlist'][type]
+			for name in devlist:
+				length = devlist[name]
+				if name not in mdevlist:
+					mdevlist[name] = {'name': name, 'host': host,
+						'worst': length, 'total': length, 'count': 1,
+						'url': url}
+				else:
+					if length > mdevlist[name]['worst']:
+						mdevlist[name]['worst'] = length
+						mdevlist[name]['url'] = url
+						mdevlist[name]['host'] = host
+					mdevlist[name]['total'] += length
+					mdevlist[name]['count'] += 1
+
+	# generate the html
+	th = '\t<th>{0}</th>\n'
+	td = '\t<td align=center>{0}</td>\n'
+	tdr = '\t<td align=right>{0}</td>\n'
+	tdlink = '\t<td align=center><a href="{0}">html</a></td>\n'
+	limit = 1
+	for type in sorted(devall, reverse=True):
+		num = 0
+		devlist = devall[type]
+		# table header
+		html += '<div class="stamp">%s (%s devices > %d ms)</div><table>\n' % \
+			(title, type.upper(), limit)
+		html += '<tr>\n' + '<th align=right>Device Name</th>' +\
+			th.format('Average Time') + th.format('Count') +\
+			th.format('Worst Time') + th.format('Host (worst time)') +\
+			th.format('Link (worst time)') + '</tr>\n'
+		for name in sorted(devlist, key=lambda k:devlist[k]['worst'], reverse=True):
+			data = devall[type][name]
+			data['average'] = data['total'] / data['count']
+			if data['average'] < limit:
+				continue
+			# row classes - alternate row color
+			rcls = ['alt'] if num % 2 == 1 else []
+			html += '<tr class="'+(' '.join(rcls))+'">\n' if len(rcls) > 0 else '<tr>\n'
+			html += tdr.format(data['name'])				# name
+			html += td.format('%.3f ms' % data['average'])	# average
+			html += td.format(data['count'])				# count
+			html += td.format('%.3f ms' % data['worst'])	# worst
+			html += td.format(data['host'])					# host
+			html += tdlink.format(data['url'])				# url
+			html += '</tr>\n'
+			num += 1
+		html += '</table>\n'
+
+	# flush the data to file
+	hf = open(htmlfile, 'w')
+	hf.write(html+'</body>\n</html>\n')
+	hf.close()
+	return devall
+
+def createHTMLIssuesSummary(issues, htmlfile, title):
+	html = summaryCSS('Issues Summary - SleepGraph', False)
+
+	# generate the html
+	th = '\t<th>{0}</th>\n'
+	td = '\t<td align={0}>{1}</td>\n'
+	tdlink = '<a href="{1}">{0}</a>'
+	subtitle = '%d issues' % len(issues) if len(issues) > 0 else 'no issues'
+	html += '<div class="stamp">%s (%s)</div><table>\n' % (title, subtitle)
+	html += '<tr>\n' + th.format('Count') + th.format('Issue') +\
+		th.format('Hosts') + th.format('First Instance') + '</tr>\n'
+
+	num = 0
+	for e in sorted(issues, key=lambda v:v['count'], reverse=True):
+		links = []
+		for host in sorted(e['urls']):
+			links.append(tdlink.format(host, e['urls'][host]))
+		# row classes - alternate row color
+		rcls = ['alt'] if num % 2 == 1 else []
+		html += '<tr class="'+(' '.join(rcls))+'">\n' if len(rcls) > 0 else '<tr>\n'
+		html += td.format('center', e['count'])		# count
+		html += td.format('left', e['line'])		# issue
+		html += td.format('center', len(e['urls']))	# hosts
+		html += td.format('center nowrap', '<br>'.join(links))	# links
+		html += '</tr>\n'
+		num += 1
+
+	# flush the data to file
+	hf = open(htmlfile, 'w')
+	hf.write(html+'</table>\n</body>\n</html>\n')
+	hf.close()
+	return issues
+
 def ordinal(value):
 	suffix = 'th'
 	if value < 10 or value > 19:
@@ -4621,6 +4817,7 @@ def executeSuspend():
 				pprint('SUSPEND START')
 			else:
 				pprint('SUSPEND START (press a key to resume)')
+		sysvals.mcelog(True)
 		bat1 = getBattery() if battery else False
 		# set rtcwake
 		if(sysvals.rtcwake):
@@ -4652,13 +4849,21 @@ def executeSuspend():
 				pf = open(sysvals.diskpowerfile, 'w')
 				pf.write(sysvals.diskmode)
 				pf.close()
-			pf = open(sysvals.powerfile, 'w')
-			pf.write(mode)
-			# execution will pause here
-			try:
-				pf.close()
-			except Exception as e:
-				tdata['error'] = str(e)
+			if mode == 'freeze' and sysvals.haveTurbostat():
+				# execution will pause here
+				turbo = sysvals.turbostat()
+				if '|' in turbo:
+					tdata['turbo'] = turbo
+				else:
+					tdata['error'] = turbo
+			else:
+				pf = open(sysvals.powerfile, 'w')
+				pf.write(mode)
+				# execution will pause here
+				try:
+					pf.close()
+				except Exception as e:
+					tdata['error'] = str(e)
 		if(sysvals.rtcwake):
 			sysvals.rtcWakeAlarmOff()
 		# postdelay delay
@@ -4672,6 +4877,9 @@ def executeSuspend():
 			sysvals.fsetVal('RESUME COMPLETE', 'trace_marker')
 		if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
 			tdata['fw'] = getFPDT(False)
+		mcelog = sysvals.mcelog()
+		if mcelog:
+			tdata['mcelog'] = mcelog
 		bat2 = getBattery() if battery else False
 		if battery and bat1 and bat2:
 			tdata['bat'] = (bat1, bat2)
@@ -4694,6 +4902,7 @@ def executeSuspend():
 		op.close()
 		sysvals.fsetVal('', 'trace')
 		devProps()
+	return testdata
 
 def readFile(file):
 	if os.path.islink(file):
@@ -5398,6 +5607,12 @@ def processData(live=False):
 			appendIncompleteTraceLog(testruns)
 	sysvals.vprint('Command:\n    %s' % sysvals.cmdline)
 	for data in testruns:
+		if data.mcelog:
+			sysvals.vprint('MCELOG Data:')
+			for line in data.mcelog.split('\n'):
+				sysvals.vprint('    %s' % line)
+		if data.turbostat:
+			sysvals.vprint('Turbostat:\n    %s' % data.turbostat.replace('|', ' '))
 		if data.battery:
 			a1, c1, a2, c2 = data.battery
 			s = 'Battery:\n    Before - AC: %s, Charge: %d\n     After - AC: %s, Charge: %d' % \
@@ -5431,7 +5646,10 @@ def rerunTest():
 		doesTraceLogHaveTraceEvents()
 	if not sysvals.dmesgfile and not sysvals.usetraceevents:
 		doError('recreating this html output requires a dmesg file')
-	sysvals.setOutputFile()
+	if sysvals.outdir:
+		sysvals.htmlfile = sysvals.outdir
+	else:
+		sysvals.setOutputFile()
 	if os.path.exists(sysvals.htmlfile):
 		if not os.path.isfile(sysvals.htmlfile):
 			doError('a directory already exists with this name: %s' % sysvals.htmlfile)
@@ -5450,14 +5668,18 @@ def runTest(n=0):
 	sysvals.initTestOutput('suspend')
 
 	# execute the test
-	executeSuspend()
+	testdata = executeSuspend()
 	sysvals.cleanupFtrace()
 	if sysvals.skiphtml:
 		sysvals.sudoUserchown(sysvals.testdir)
 		return
-	testruns, stamp = processData(True)
-	for data in testruns:
-		del data
+	if len(testdata) > 0 and not testdata[0]['error']:
+		testruns, stamp = processData(True)
+		for data in testruns:
+			del data
+	else:
+		stamp = testdata[0]
+
 	sysvals.sudoUserchown(sysvals.testdir)
 	sysvals.outputResult(stamp, n)
 	if 'error' in stamp:
@@ -5487,8 +5709,13 @@ def find_in_html(html, start, end, firstonly=True):
 		return ''
 	return out
 
-def data_from_html(file, outpath, devlist=False):
-	html = open(file, 'r').read()
+def data_from_html(file, outpath, issues):
+	if '<html>' not in file:
+		html = open(file, 'r').read()
+		sysvals.htmlfile = os.path.relpath(file, outpath)
+	else:
+		html = file
+	# extract general info
 	suspend = find_in_html(html, 'Kernel Suspend', 'ms')
 	resume = find_in_html(html, 'Kernel Resume', 'ms')
 	line = find_in_html(html, '<div class="stamp">', '</div>')
@@ -5499,6 +5726,7 @@ def data_from_html(file, outpath, devlist=False):
 		dt = datetime.strptime(' '.join(stmp[3:]), '%B %d %Y, %I:%M:%S %p')
 	except:
 		return False
+	sysvals.hostname = stmp[0]
 	tstr = dt.strftime('%Y/%m/%d %H:%M:%S')
 	error = find_in_html(html, '<table class="testfail"><tr><td>', '</td>')
 	if error:
@@ -5509,13 +5737,39 @@ def data_from_html(file, outpath, devlist=False):
 			result = 'fail'
 	else:
 		result = 'pass'
+	# extract error info
 	ilist = []
-	e = find_in_html(html, 'class="err"[\w=":;\.%\- ]*>', '&rarr;</div>', False)
-	for i in list(set(e)):
-		ilist.append('%sx%d' % (i, e.count(i)) if e.count(i) > 1 else i)
+	log = find_in_html(html, '<div id="dmesglog" style="display:none;">',
+		'</div>').strip()
+	if log:
+		d = Data(0)
+		d.end = 999999999
+		d.dmesgtext = log.split('\n')
+		d.extractErrorInfo(issues)
+		elist = dict()
+		for dir in d.errorinfo:
+			for err in d.errorinfo[dir]:
+				if err[0] not in elist:
+					elist[err[0]] = 0
+				elist[err[0]] += 1
+		for i in elist:
+			ilist.append('%sx%d' % (i, elist[i]) if elist[i] > 1 else i)
 	low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
 	if low and '|' in low:
-		ilist.append('FREEZEx%d' % len(low.split('|')))
+		issue = 'FREEZEx%d' % len(low.split('|'))
+		match = [i for i in issues if i['match'] == issue]
+		if len(match) > 0:
+			match[0]['count'] += 1
+			if sysvals.hostname not in match[0]['urls']:
+				match[0]['urls'][sysvals.hostname] = sysvals.htmlfile
+		else:
+			issues.append({
+				'match': issue, 'count': 1, 'line': issue,
+				'urls': {sysvals.hostname: sysvals.htmlfile},
+			})
+		ilist.append(issue)
+
+	# extract device info
 	devices = dict()
 	for line in html.split('\n'):
 		m = re.match(' *<div id=\"[a,0-9]*\" *title=\"(?P<title>.*)\" class=\"thread.*', line)
@@ -5527,19 +5781,23 @@ def data_from_html(file, outpath, devlist=False):
 		name, time, phase = m.group('n'), m.group('t'), m.group('p')
 		if ' async' in name or ' sync' in name:
 			name = ' '.join(name.split(' ')[:-1])
-		d = phase.split('_')[0]
+		if phase.startswith('suspend'):
+			d = 'suspend'
+		elif phase.startswith('resume'):
+			d = 'resume'
+		else:
+			continue
 		if d not in devices:
 			devices[d] = dict()
 		if name not in devices[d]:
 			devices[d][name] = 0.0
 		devices[d][name] += float(time)
-	worst  = {'suspend': {'name':'', 'time': 0.0},
-		'resume': {'name':'', 'time': 0.0}}
-	for d in devices:
-		if d not in worst:
-			worst[d] = dict()
-		dev = devices[d]
-		if len(dev.keys()) > 0:
+	# create worst device info
+	worst = dict()
+	for d in ['suspend', 'resume']:
+		worst[d] = {'name':'', 'time': 0.0}
+		dev = devices[d] if d in devices else 0
+		if dev and len(dev.keys()) > 0:
 			n = sorted(dev, key=dev.get, reverse=True)[0]
 			worst[d]['name'], worst[d]['time'] = n, dev[n]
 	data = {
@@ -5551,14 +5809,13 @@ def data_from_html(file, outpath, devlist=False):
 		'issues': ' '.join(ilist),
 		'suspend': suspend,
 		'resume': resume,
+		'devlist': devices,
 		'sus_worst': worst['suspend']['name'],
 		'sus_worsttime': worst['suspend']['time'],
 		'res_worst': worst['resume']['name'],
 		'res_worsttime': worst['resume']['time'],
-		'url': os.path.relpath(file, outpath),
+		'url': sysvals.htmlfile,
 	}
-	if devlist:
-		data['devlist'] = devices
 	return data
 
 # Function: runSummary
@@ -5567,7 +5824,7 @@ def data_from_html(file, outpath, devlist=False):
 def runSummary(subdir, local=True, genhtml=False):
 	inpath = os.path.abspath(subdir)
 	outpath = os.path.abspath('.') if local else inpath
-	pprint('Generating a summary of folder "%s"' % inpath)
+	pprint('Generating a summary of folder:\n   %s' % inpath)
 	if genhtml:
 		for dirname, dirnames, filenames in os.walk(subdir):
 			sysvals.dmesgfile = sysvals.ftracefile = sysvals.htmlfile = ''
@@ -5583,26 +5840,31 @@ def runSummary(subdir, local=True, genhtml=False):
 				if sysvals.dmesgfile:
 					pprint('DMESG : %s' % sysvals.dmesgfile)
 				rerunTest()
+	issues = []
 	testruns = []
 	desc = {'host':[],'mode':[],'kernel':[]}
 	for dirname, dirnames, filenames in os.walk(subdir):
 		for filename in filenames:
 			if(not re.match('.*.html', filename)):
 				continue
-			data = data_from_html(os.path.join(dirname, filename), outpath)
+			data = data_from_html(os.path.join(dirname, filename), outpath, issues)
 			if(not data):
 				continue
 			testruns.append(data)
 			for key in desc:
 				if data[key] not in desc[key]:
 					desc[key].append(data[key])
-	outfile = os.path.join(outpath, 'summary.html')
-	pprint('Summary file: %s' % outfile)
+	pprint('Summary files:')
 	if len(desc['host']) == len(desc['mode']) == len(desc['kernel']) == 1:
 		title = '%s %s %s' % (desc['host'][0], desc['kernel'][0], desc['mode'][0])
 	else:
 		title = inpath
-	createHTMLSummarySimple(testruns, outfile, title)
+	createHTMLSummarySimple(testruns, os.path.join(outpath, 'summary.html'), title)
+	pprint('   summary.html         - tabular list of test data found')
+	createHTMLDeviceSummary(testruns, os.path.join(outpath, 'summary-devices.html'), title)
+	pprint('   summary-devices.html - kernel device list sorted by total execution time')
+	createHTMLIssuesSummary(issues, os.path.join(outpath, 'summary-issues.html'), title)
+	pprint('   summary-issues.html  - kernel issues found sorted by frequency')
 
 # Function: checkArgBool
 # Description:
-- 
2.14.1

