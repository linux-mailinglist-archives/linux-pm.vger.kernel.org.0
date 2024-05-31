Return-Path: <linux-pm+bounces-8446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BCA8D5DEC
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293C91F2741F
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99673156226;
	Fri, 31 May 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmpWEX3E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E8136E2A
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146798; cv=none; b=qtBYDF1QmXifdNgjJowajePp7jxlSvBQtVLOzEXyXHSduYlU86FVqGC4CrIup+56P5HsqjcxYzny47cja9p5MTf9Q96wCqnS3g8DZ7KId8d4qV/87y9NcL17vp8PB2c/eu39ZgHFRQA/Y0oqj54q0bN08JWtmL79ttIyB+Ov+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146798; c=relaxed/simple;
	bh=v2Hzi1D+3AEA2l61xBfGVuddub72g9BPZVj+SOjSP/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=C1DSvfLAoEoFoCZhv3fP+su2hh77ZhXF3zwVeU74rZkjaPjn7e+c2twXifk0aN31YcgUvvHvXgpX/wrRN1vdPNt/IrhYKWnz8+BE5SO7s6UKbhxxbuMj0eSW9SHXR/a9Cba8sjo+Efw0H4n2EeBHuwCUPKqGifu2pd2HGMvQOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmpWEX3E; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146795; x=1748682795;
  h=from:to:cc:subject:date:message-id;
  bh=v2Hzi1D+3AEA2l61xBfGVuddub72g9BPZVj+SOjSP/8=;
  b=jmpWEX3ENx2dfZATqzrR5rdjudq5UiaJktUFtdV4b+4JPQiStoLs835u
   voLfJuh6PbMkJ2SiMf2WgceSP3FK5geSD+amsImC6an82RN2j43MYnhVS
   2MDRgt8cazH96ZMM94B23AyP+Ea34heAaLWOzU5EkJ+S5uKA2DuX/turt
   w6s8sQZ7dRRepxFs8UZo5t5pzSyy4+FItMLPYUEFDS/nki+MEs43leZCX
   HnVfm7qbkdr+63ogVGJmZHCTn3Az4gmR9C3/a+NWfMSr833+BM1/uXW96
   K+HQqZN4G8uRilXfbPvAlJKhB7CIxMZftw6MDx+HIW5SFtkBMCxHNaLjP
   Q==;
X-CSE-ConnectionGUID: dIfRMMGtTLm0Q5ncXAxRmQ==
X-CSE-MsgGUID: 0MT4rHeVRlugVipCRlFOWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13807214"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13807214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:13:13 -0700
X-CSE-ConnectionGUID: o8i1Ou3nRyuaxRWHpK6ygQ==
X-CSE-MsgGUID: aWesx+WITy6+ympI7NoabA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="73589714"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by orviesa001.jf.intel.com with ESMTP; 31 May 2024 02:13:12 -0700
From: Todd Brandt <todd.e.brandt@intel.com>
To: linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: [PATCH 2/2] pm-graph v5.12, code revamp for python3.12
Date: Fri, 31 May 2024 02:13:10 -0700
Message-Id: <c88b606b38859f977b302e3f9e0ac66648a95ac1.1717146154.git.todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1717146154.git.todd.e.brandt@intel.com>
References: <cover.1717146154.git.todd.e.brandt@intel.com>
In-Reply-To: <cover.1717146154.git.todd.e.brandt@intel.com>
References: <cover.1717146154.git.todd.e.brandt@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

sleepgraph/bootgraph function correctly in python3.12 but include a slew
of deprecation warnings for unsupported regexes. This patch fixes up all
the strings in the code so that it comforms with python3.12 standards.

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 tools/power/pm-graph/bootgraph.py  |   16 +-
 tools/power/pm-graph/sleepgraph.py | 1000 ++++++++++++++--------------
 2 files changed, 508 insertions(+), 508 deletions(-)

diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index f96f50e0c336..8a3ef94fe88f 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -77,12 +77,12 @@ class SystemValues(aslib.SystemValues):
 			fp.close()
 		self.testdir = datetime.now().strftime('boot-%y%m%d-%H%M%S')
 	def kernelVersion(self, msg):
-		m = re.match('^[Ll]inux *[Vv]ersion *(?P<v>\S*) .*', msg)
+		m = re.match(r'^[Ll]inux *[Vv]ersion *(?P<v>\S*) .*', msg)
 		if m:
 			return m.group('v')
 		return 'unknown'
 	def checkFtraceKernelVersion(self):
-		m = re.match('^(?P<x>[0-9]*)\.(?P<y>[0-9]*)\.(?P<z>[0-9]*).*', self.kernel)
+		m = re.match(r'^(?P<x>[0-9]*)\.(?P<y>[0-9]*)\.(?P<z>[0-9]*).*', self.kernel)
 		if m:
 			val = tuple(map(int, m.groups()))
 			if val >= (4, 10, 0):
@@ -324,7 +324,7 @@ def parseKernelLog():
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
-		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+		m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 		if(not m):
 			continue
 		ktime = float(m.group('ktime'))
@@ -332,24 +332,24 @@ def parseKernelLog():
 			break
 		msg = m.group('msg')
 		data.dmesgtext.append(line)
-		if(ktime == 0.0 and re.match('^Linux version .*', msg)):
+		if(ktime == 0.0 and re.match(r'^Linux version .*', msg)):
 			if(not sysvals.stamp['kernel']):
 				sysvals.stamp['kernel'] = sysvals.kernelVersion(msg)
 			continue
-		m = re.match('.* setting system clock to (?P<d>[0-9\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
+		m = re.match(r'.* setting system clock to (?P<d>[0-9\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
 		if(m):
 			bt = datetime.strptime(m.group('d')+' '+m.group('t'), '%Y-%m-%d %H:%M:%S')
 			bt = bt - timedelta(seconds=int(ktime))
 			data.boottime = bt.strftime('%Y-%m-%d_%H:%M:%S')
 			sysvals.stamp['time'] = bt.strftime('%B %d %Y, %I:%M:%S %p')
 			continue
-		m = re.match('^calling *(?P<f>.*)\+.* @ (?P<p>[0-9]*)', msg)
+		m = re.match(r'^calling *(?P<f>.*)\+.* @ (?P<p>[0-9]*)', msg)
 		if(m):
 			func = m.group('f')
 			pid = int(m.group('p'))
 			devtemp[func] = (ktime, pid)
 			continue
-		m = re.match('^initcall *(?P<f>.*)\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
+		m = re.match(r'^initcall *(?P<f>.*)\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
 		if(m):
 			data.valid = True
 			data.end = ktime
@@ -359,7 +359,7 @@ def parseKernelLog():
 				data.newAction(phase, f, pid, start, ktime, int(r), int(t))
 				del devtemp[f]
 			continue
-		if(re.match('^Freeing unused kernel .*', msg)):
+		if(re.match(r'^Freeing unused kernel .*', msg)):
 			data.tUserMode = ktime
 			data.dmesg['kernel']['end'] = ktime
 			data.dmesg['user']['start'] = ktime
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index b709c5f2b6f1..ef87e63c05c7 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -420,11 +420,11 @@ class SystemValues:
 		return value.format(**args)
 	def setOutputFile(self):
 		if self.dmesgfile != '':
-			m = re.match('(?P<name>.*)_dmesg\.txt.*', self.dmesgfile)
+			m = re.match(r'(?P<name>.*)_dmesg\.txt.*', self.dmesgfile)
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
 		if self.ftracefile != '':
-			m = re.match('(?P<name>.*)_ftrace\.txt.*', self.ftracefile)
+			m = re.match(r'(?P<name>.*)_ftrace\.txt.*', self.ftracefile)
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
 	def systemInfo(self, info):
@@ -464,15 +464,15 @@ class SystemValues:
 		if os.path.exists('/proc/cpuinfo'):
 			with open('/proc/cpuinfo', 'r') as fp:
 				for line in fp:
-					if re.match('^processor[ \t]*:[ \t]*[0-9]*', line):
+					if re.match(r'^processor[ \t]*:[ \t]*[0-9]*', line):
 						self.cpucount += 1
 		if os.path.exists('/proc/meminfo'):
 			with open('/proc/meminfo', 'r') as fp:
 				for line in fp:
-					m = re.match('^MemTotal:[ \t]*(?P<sz>[0-9]*) *kB', line)
+					m = re.match(r'^MemTotal:[ \t]*(?P<sz>[0-9]*) *kB', line)
 					if m:
 						self.memtotal = int(m.group('sz'))
-					m = re.match('^MemFree:[ \t]*(?P<sz>[0-9]*) *kB', line)
+					m = re.match(r'^MemFree:[ \t]*(?P<sz>[0-9]*) *kB', line)
 					if m:
 						self.memfree = int(m.group('sz'))
 		if os.path.exists('/etc/os-release'):
@@ -539,7 +539,7 @@ class SystemValues:
 			idx = line.find('[')
 			if idx > 1:
 				line = line[idx:]
-			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+			m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 			if(m):
 				ktime = m.group('ktime')
 				break
@@ -553,7 +553,7 @@ class SystemValues:
 			idx = line.find('[')
 			if idx > 1:
 				line = line[idx:]
-			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+			m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 			if(not m):
 				continue
 			ktime = float(m.group('ktime'))
@@ -636,11 +636,11 @@ class SystemValues:
 		# now process the args
 		for arg in sorted(args):
 			arglist[arg] = ''
-			m = re.match('.* '+arg+'=(?P<arg>.*) ', data);
+			m = re.match(r'.* '+arg+'=(?P<arg>.*) ', data);
 			if m:
 				arglist[arg] = m.group('arg')
 			else:
-				m = re.match('.* '+arg+'=(?P<arg>.*)', data);
+				m = re.match(r'.* '+arg+'=(?P<arg>.*)', data);
 				if m:
 					arglist[arg] = m.group('arg')
 		out = fmt.format(**arglist)
@@ -989,7 +989,7 @@ class SystemValues:
 			m = re.match(tp.ftrace_line_fmt, line)
 			if(not m or 'device_pm_callback_start' not in line):
 				continue
-			m = re.match('.*: (?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*', m.group('msg'));
+			m = re.match(r'.*: (?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*', m.group('msg'));
 			if(not m):
 				continue
 			dev = m.group('d')
@@ -999,7 +999,7 @@ class SystemValues:
 
 		# now get the syspath for each target device
 		for dirname, dirnames, filenames in os.walk('/sys/devices'):
-			if(re.match('.*/power', dirname) and 'async' in filenames):
+			if(re.match(r'.*/power', dirname) and 'async' in filenames):
 				dev = dirname.split('/')[-2]
 				if dev in props and (not props[dev].syspath or len(dirname) < len(props[dev].syspath)):
 					props[dev].syspath = dirname[:-6]
@@ -1143,12 +1143,12 @@ class SystemValues:
 		elif value and os.path.exists(file):
 			fp = open(file, 'r+')
 			if fmt == 'radio':
-				m = re.match('.*\[(?P<v>.*)\].*', fp.read())
+				m = re.match(r'.*\[(?P<v>.*)\].*', fp.read())
 				if m:
 					self.cfgdef[file] = m.group('v')
 			elif fmt == 'acpi':
 				line = fp.read().strip().split('\n')[-1]
-				m = re.match('.* (?P<v>[0-9A-Fx]*) .*', line)
+				m = re.match(r'.* (?P<v>[0-9A-Fx]*) .*', line)
 				if m:
 					self.cfgdef[file] = m.group('v')
 			else:
@@ -1173,7 +1173,7 @@ class SystemValues:
 		fp = Popen([cmd, '-v'], stdout=PIPE, stderr=PIPE).stderr
 		out = ascii(fp.read()).strip()
 		fp.close()
-		if re.match('turbostat version .*', out):
+		if re.match(r'turbostat version .*', out):
 			self.vprint(out)
 			return True
 		return False
@@ -1187,7 +1187,7 @@ class SystemValues:
 			rawout += line
 			if keyline and valline:
 				continue
-			if re.match('(?i)Avg_MHz.*', line):
+			if re.match(r'(?i)Avg_MHz.*', line):
 				keyline = line.strip().split()
 			elif keyline:
 				valline = line.strip().split()
@@ -1204,7 +1204,7 @@ class SystemValues:
 		for key in keyline:
 			idx = keyline.index(key)
 			val = valline[idx]
-			if key == 'SYS%LPI' and not s0ixready and re.match('^[0\.]*$', val):
+			if key == 'SYS%LPI' and not s0ixready and re.match(r'^[0\.]*$', val):
 				continue
 			out.append('%s=%s' % (key, val))
 		return (fp.returncode, '|'.join(out))
@@ -1232,7 +1232,7 @@ class SystemValues:
 		except:
 			return ''
 		for line in reversed(w.split('\n')):
-			m = re.match(' *(?P<dev>.*): (?P<stat>[0-9a-f]*) .*', line)
+			m = re.match(r' *(?P<dev>.*): (?P<stat>[0-9a-f]*) .*', line)
 			if not m or (dev and dev != m.group('dev')):
 				continue
 			return m.group('dev')
@@ -1261,14 +1261,14 @@ class SystemValues:
 			return
 		arr = msg.split()
 		for j in range(len(arr)):
-			if re.match('^[0-9,\-\.]*$', arr[j]):
-				arr[j] = '[0-9,\-\.]*'
+			if re.match(r'^[0-9,\-\.]*$', arr[j]):
+				arr[j] = r'[0-9,\-\.]*'
 			else:
 				arr[j] = arr[j]\
-					.replace('\\', '\\\\').replace(']', '\]').replace('[', '\[')\
-					.replace('.', '\.').replace('+', '\+').replace('*', '\*')\
-					.replace('(', '\(').replace(')', '\)').replace('}', '\}')\
-					.replace('{', '\{')
+					.replace('\\', r'\\\\').replace(']', r'\]').replace('[', r'\[')\
+					.replace('.', r'\.').replace('+', r'\+').replace('*', r'\*')\
+					.replace('(', r'\(').replace(')', r'\)').replace('}', r'\}')\
+					.replace('{', r'\{')
 		mstr = ' *'.join(arr)
 		entry = {
 			'line': msg,
@@ -1340,7 +1340,7 @@ class SystemValues:
 			fp = Popen(xset.format('q').split(' '), stdout=PIPE).stdout
 			ret = 'unknown'
 			for line in fp:
-				m = re.match('[\s]*Monitor is (?P<m>.*)', ascii(line))
+				m = re.match(r'[\s]*Monitor is (?P<m>.*)', ascii(line))
 				if(m and len(m.group('m')) >= 2):
 					out = m.group('m').lower()
 					ret = out[3:] if out[0:2] == 'in' else out
@@ -1566,7 +1566,7 @@ class Data:
 			i += 1
 			if tp.stampInfo(line, sysvals):
 				continue
-			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+			m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 			if not m:
 				continue
 			t = float(m.group('ktime'))
@@ -1574,7 +1574,7 @@ class Data:
 				continue
 			dir = 'suspend' if t < self.tSuspended else 'resume'
 			msg = m.group('msg')
-			if re.match('capability: warning: .*', msg):
+			if re.match(r'capability: warning: .*', msg):
 				continue
 			for err in self.errlist:
 				if re.match(self.errlist[err], msg):
@@ -1679,8 +1679,8 @@ class Data:
 		ubiquitous = False
 		if kprobename in dtf and 'ub' in dtf[kprobename]:
 			ubiquitous = True
-		mc = re.match('\(.*\) *(?P<args>.*)', cdata)
-		mr = re.match('\((?P<caller>\S*).* arg1=(?P<ret>.*)', rdata)
+		mc = re.match(r'\(.*\) *(?P<args>.*)', cdata)
+		mr = re.match(r'\((?P<caller>\S*).* arg1=(?P<ret>.*)', rdata)
 		if mc and mr:
 			c = mr.group('caller').split('+')[0]
 			a = mc.group('args').strip()
@@ -1997,7 +1997,7 @@ class Data:
 		list = self.dmesg[phase]['list']
 		mydev = ''
 		for devname in sorted(list):
-			if name == devname or re.match('^%s\[(?P<num>[0-9]*)\]$' % name, devname):
+			if name == devname or re.match(r'^%s\[(?P<num>[0-9]*)\]$' % name, devname):
 				mydev = devname
 		if mydev:
 			return list[mydev]
@@ -2099,7 +2099,7 @@ class Data:
 			for dev in sorted(list):
 				pdev = list[dev]['par']
 				pid = list[dev]['pid']
-				if(pid < 0 or re.match('[0-9]*-[0-9]*\.[0-9]*[\.0-9]*\:[\.0-9]*$', pdev)):
+				if(pid < 0 or re.match(r'[0-9]*-[0-9]*\.[0-9]*[\.0-9]*\:[\.0-9]*$', pdev)):
 					continue
 				if pdev and pdev not in real and pdev not in rootlist:
 					rootlist.append(pdev)
@@ -2190,26 +2190,26 @@ class Data:
 		if 'resume_complete' in dm:
 			dm['resume_complete']['end'] = time
 	def initcall_debug_call(self, line, quick=False):
-		m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
-			'PM: *calling .* @ (?P<n>.*), parent: (?P<p>.*)', line)
+		m = re.match(r'.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
+			r'PM: *calling .* @ (?P<n>.*), parent: (?P<p>.*)', line)
 		if not m:
-			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
-				'calling .* @ (?P<n>.*), parent: (?P<p>.*)', line)
+			m = re.match(r'.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
+				r'calling .* @ (?P<n>.*), parent: (?P<p>.*)', line)
 		if not m:
-			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) calling  '+\
-				'(?P<f>.*)\+ @ (?P<n>.*), parent: (?P<p>.*)', line)
+			m = re.match(r'.*(\[ *)(?P<t>[0-9\.]*)(\]) calling  '+\
+				r'(?P<f>.*)\+ @ (?P<n>.*), parent: (?P<p>.*)', line)
 		if m:
 			return True if quick else m.group('t', 'f', 'n', 'p')
 		return False if quick else ('', '', '', '')
 	def initcall_debug_return(self, line, quick=False):
-		m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: PM: '+\
-			'.* returned (?P<r>[0-9]*) after (?P<dt>[0-9]*) usecs', line)
+		m = re.match(r'.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: PM: '+\
+			r'.* returned (?P<r>[0-9]*) after (?P<dt>[0-9]*) usecs', line)
 		if not m:
-			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
-				'.* returned (?P<r>[0-9]*) after (?P<dt>[0-9]*) usecs', line)
+			m = re.match(r'.*(\[ *)(?P<t>[0-9\.]*)(\]) .* (?P<f>.*)\: '+\
+				r'.* returned (?P<r>[0-9]*) after (?P<dt>[0-9]*) usecs', line)
 		if not m:
-			m = re.match('.*(\[ *)(?P<t>[0-9\.]*)(\]) call '+\
-				'(?P<f>.*)\+ returned .* after (?P<dt>.*) usecs', line)
+			m = re.match(r'.*(\[ *)(?P<t>[0-9\.]*)(\]) call '+\
+				r'(?P<f>.*)\+ returned .* after (?P<dt>.*) usecs', line)
 		if m:
 			return True if quick else m.group('t', 'f', 'dt')
 		return False if quick else ('', '', '')
@@ -2294,28 +2294,28 @@ class FTraceLine:
 		if not m and not d:
 			return
 		# is this a trace event
-		if(d == 'traceevent' or re.match('^ *\/\* *(?P<msg>.*) \*\/ *$', m)):
+		if(d == 'traceevent' or re.match(r'^ *\/\* *(?P<msg>.*) \*\/ *$', m)):
 			if(d == 'traceevent'):
 				# nop format trace event
 				msg = m
 			else:
 				# function_graph format trace event
-				em = re.match('^ *\/\* *(?P<msg>.*) \*\/ *$', m)
+				em = re.match(r'^ *\/\* *(?P<msg>.*) \*\/ *$', m)
 				msg = em.group('msg')
 
-			emm = re.match('^(?P<call>.*?): (?P<msg>.*)', msg)
+			emm = re.match(r'^(?P<call>.*?): (?P<msg>.*)', msg)
 			if(emm):
 				self.name = emm.group('msg')
 				self.type = emm.group('call')
 			else:
 				self.name = msg
-			km = re.match('^(?P<n>.*)_cal$', self.type)
+			km = re.match(r'^(?P<n>.*)_cal$', self.type)
 			if km:
 				self.fcall = True
 				self.fkprobe = True
 				self.type = km.group('n')
 				return
-			km = re.match('^(?P<n>.*)_ret$', self.type)
+			km = re.match(r'^(?P<n>.*)_ret$', self.type)
 			if km:
 				self.freturn = True
 				self.fkprobe = True
@@ -2327,7 +2327,7 @@ class FTraceLine:
 		if(d):
 			self.length = float(d)/1000000
 		# the indentation determines the depth
-		match = re.match('^(?P<d> *)(?P<o>.*)$', m)
+		match = re.match(r'^(?P<d> *)(?P<o>.*)$', m)
 		if(not match):
 			return
 		self.depth = self.getDepth(match.group('d'))
@@ -2337,7 +2337,7 @@ class FTraceLine:
 			self.freturn = True
 			if(len(m) > 1):
 				# includes comment with function name
-				match = re.match('^} *\/\* *(?P<n>.*) *\*\/$', m)
+				match = re.match(r'^} *\/\* *(?P<n>.*) *\*\/$', m)
 				if(match):
 					self.name = match.group('n').strip()
 		# function call
@@ -2345,13 +2345,13 @@ class FTraceLine:
 			self.fcall = True
 			# function call with children
 			if(m[-1] == '{'):
-				match = re.match('^(?P<n>.*) *\(.*', m)
+				match = re.match(r'^(?P<n>.*) *\(.*', m)
 				if(match):
 					self.name = match.group('n').strip()
 			# function call with no children (leaf)
 			elif(m[-1] == ';'):
 				self.freturn = True
-				match = re.match('^(?P<n>.*) *\(.*', m)
+				match = re.match(r'^(?P<n>.*) *\(.*', m)
 				if(match):
 					self.name = match.group('n').strip()
 			# something else (possibly a trace marker)
@@ -2385,7 +2385,7 @@ class FTraceLine:
 			return False
 		else:
 			if(self.type == 'suspend_resume' and
-				re.match('suspend_enter\[.*\] begin', self.name)):
+				re.match(r'suspend_enter\[.*\] begin', self.name)):
 				return True
 			return False
 	def endMarker(self):
@@ -2398,7 +2398,7 @@ class FTraceLine:
 			return False
 		else:
 			if(self.type == 'suspend_resume' and
-				re.match('thaw_processes\[.*\] end', self.name)):
+				re.match(r'thaw_processes\[.*\] end', self.name)):
 				return True
 			return False
 
@@ -2976,30 +2976,30 @@ class Timeline:
 # Description:
 #	 A list of values describing the properties of these test runs
 class TestProps:
-	stampfmt = '# [a-z]*-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
-				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
-				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
-	wififmt    = '^# wifi *(?P<d>\S*) *(?P<s>\S*) *(?P<t>[0-9\.]+).*'
-	tstatfmt   = '^# turbostat (?P<t>\S*)'
-	testerrfmt = '^# enter_sleep_error (?P<e>.*)'
-	sysinfofmt = '^# sysinfo .*'
-	cmdlinefmt = '^# command \| (?P<cmd>.*)'
-	kparamsfmt = '^# kparams \| (?P<kp>.*)'
-	devpropfmt = '# Device Properties: .*'
-	pinfofmt   = '# platform-(?P<val>[a-z,A-Z,0-9,_]*): (?P<info>.*)'
-	tracertypefmt = '# tracer: (?P<t>.*)'
-	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
-	procexecfmt = 'ps - (?P<ps>.*)$'
-	procmultifmt = '@(?P<n>[0-9]*)\|(?P<ps>.*)$'
+	stampfmt = r'# [a-z]*-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
+				r'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
+				r' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
+	wififmt    = r'^# wifi *(?P<d>\S*) *(?P<s>\S*) *(?P<t>[0-9\.]+).*'
+	tstatfmt   = r'^# turbostat (?P<t>\S*)'
+	testerrfmt = r'^# enter_sleep_error (?P<e>.*)'
+	sysinfofmt = r'^# sysinfo .*'
+	cmdlinefmt = r'^# command \| (?P<cmd>.*)'
+	kparamsfmt = r'^# kparams \| (?P<kp>.*)'
+	devpropfmt = r'# Device Properties: .*'
+	pinfofmt   = r'# platform-(?P<val>[a-z,A-Z,0-9,_]*): (?P<info>.*)'
+	tracertypefmt = r'# tracer: (?P<t>.*)'
+	firmwarefmt = r'# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
+	procexecfmt = r'ps - (?P<ps>.*)$'
+	procmultifmt = r'@(?P<n>[0-9]*)\|(?P<ps>.*)$'
 	ftrace_line_fmt_fg = \
-		'^ *(?P<time>[0-9\.]*) *\| *(?P<cpu>[0-9]*)\)'+\
-		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\|'+\
-		'[ +!#\*@$]*(?P<dur>[0-9\.]*) .*\|  (?P<msg>.*)'
+		r'^ *(?P<time>[0-9\.]*) *\| *(?P<cpu>[0-9]*)\)'+\
+		r' *(?P<proc>.*)-(?P<pid>[0-9]*) *\|'+\
+		r'[ +!#\*@$]*(?P<dur>[0-9\.]*) .*\|  (?P<msg>.*)'
 	ftrace_line_fmt_nop = \
-		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\[(?P<cpu>[0-9]*)\] *'+\
-		'(?P<flags>\S*) *(?P<time>[0-9\.]*): *'+\
-		'(?P<msg>.*)'
-	machinesuspend = 'machine_suspend\[.*'
+		r' *(?P<proc>.*)-(?P<pid>[0-9]*) *\[(?P<cpu>[0-9]*)\] *'+\
+		r'(?P<flags>\S*) *(?P<time>[0-9\.]*): *'+\
+		r'(?P<msg>.*)'
+	machinesuspend = r'machine_suspend\[.*'
 	multiproclist = dict()
 	multiproctime = 0.0
 	multiproccnt = 0
@@ -3081,14 +3081,14 @@ class TestProps:
 		sv.hostname = data.stamp['host']
 		sv.suspendmode = data.stamp['mode']
 		if sv.suspendmode == 'freeze':
-			self.machinesuspend = 'timekeeping_freeze\[.*'
+			self.machinesuspend = r'timekeeping_freeze\[.*'
 		else:
-			self.machinesuspend = 'machine_suspend\[.*'
+			self.machinesuspend = r'machine_suspend\[.*'
 		if sv.suspendmode == 'command' and sv.ftracefile != '':
 			modes = ['on', 'freeze', 'standby', 'mem', 'disk']
 			fp = sv.openlog(sv.ftracefile, 'r')
 			for line in fp:
-				m = re.match('.* machine_suspend\[(?P<mode>.*)\]', line)
+				m = re.match(r'.* machine_suspend\[(?P<mode>.*)\]', line)
 				if m and m.group('mode') in ['1', '2', '3', '4']:
 					sv.suspendmode = modes[int(m.group('mode'))]
 					data.stamp['mode'] = sv.suspendmode
@@ -3401,9 +3401,9 @@ def loadTraceLog():
 			for i in range(len(blk)):
 				if 'SUSPEND START' in blk[i][3]:
 					first.append(i)
-				elif re.match('.* timekeeping_freeze.*begin', blk[i][3]):
+				elif re.match(r'.* timekeeping_freeze.*begin', blk[i][3]):
 					last.append(i)
-				elif re.match('.* timekeeping_freeze.*end', blk[i][3]):
+				elif re.match(r'.* timekeeping_freeze.*end', blk[i][3]):
 					first.append(i)
 				elif 'RESUME COMPLETE' in blk[i][3]:
 					last.append(i)
@@ -3514,28 +3514,28 @@ def parseTraceLog(live=False):
 		if(t.fevent):
 			if(t.type == 'suspend_resume'):
 				# suspend_resume trace events have two types, begin and end
-				if(re.match('(?P<name>.*) begin$', t.name)):
+				if(re.match(r'(?P<name>.*) begin$', t.name)):
 					isbegin = True
-				elif(re.match('(?P<name>.*) end$', t.name)):
+				elif(re.match(r'(?P<name>.*) end$', t.name)):
 					isbegin = False
 				else:
 					continue
 				if '[' in t.name:
-					m = re.match('(?P<name>.*)\[.*', t.name)
+					m = re.match(r'(?P<name>.*)\[.*', t.name)
 				else:
-					m = re.match('(?P<name>.*) .*', t.name)
+					m = re.match(r'(?P<name>.*) .*', t.name)
 				name = m.group('name')
 				# ignore these events
 				if(name.split('[')[0] in tracewatch):
 					continue
 				# -- phase changes --
 				# start of kernel suspend
-				if(re.match('suspend_enter\[.*', t.name)):
+				if(re.match(r'suspend_enter\[.*', t.name)):
 					if(isbegin and data.tKernSus == 0):
 						data.tKernSus = t.time
 					continue
 				# suspend_prepare start
-				elif(re.match('dpm_prepare\[.*', t.name)):
+				elif(re.match(r'dpm_prepare\[.*', t.name)):
 					if isbegin and data.first_suspend_prepare:
 						data.first_suspend_prepare = False
 						if data.tKernSus == 0:
@@ -3544,15 +3544,15 @@ def parseTraceLog(live=False):
 					phase = data.setPhase('suspend_prepare', t.time, isbegin)
 					continue
 				# suspend start
-				elif(re.match('dpm_suspend\[.*', t.name)):
+				elif(re.match(r'dpm_suspend\[.*', t.name)):
 					phase = data.setPhase('suspend', t.time, isbegin)
 					continue
 				# suspend_late start
-				elif(re.match('dpm_suspend_late\[.*', t.name)):
+				elif(re.match(r'dpm_suspend_late\[.*', t.name)):
 					phase = data.setPhase('suspend_late', t.time, isbegin)
 					continue
 				# suspend_noirq start
-				elif(re.match('dpm_suspend_noirq\[.*', t.name)):
+				elif(re.match(r'dpm_suspend_noirq\[.*', t.name)):
 					phase = data.setPhase('suspend_noirq', t.time, isbegin)
 					continue
 				# suspend_machine/resume_machine
@@ -3589,19 +3589,19 @@ def parseTraceLog(live=False):
 						data.tResumed = t.time
 					continue
 				# resume_noirq start
-				elif(re.match('dpm_resume_noirq\[.*', t.name)):
+				elif(re.match(r'dpm_resume_noirq\[.*', t.name)):
 					phase = data.setPhase('resume_noirq', t.time, isbegin)
 					continue
 				# resume_early start
-				elif(re.match('dpm_resume_early\[.*', t.name)):
+				elif(re.match(r'dpm_resume_early\[.*', t.name)):
 					phase = data.setPhase('resume_early', t.time, isbegin)
 					continue
 				# resume start
-				elif(re.match('dpm_resume\[.*', t.name)):
+				elif(re.match(r'dpm_resume\[.*', t.name)):
 					phase = data.setPhase('resume', t.time, isbegin)
 					continue
 				# resume complete start
-				elif(re.match('dpm_complete\[.*', t.name)):
+				elif(re.match(r'dpm_complete\[.*', t.name)):
 					phase = data.setPhase('resume_complete', t.time, isbegin)
 					continue
 				# skip trace events inside devices calls
@@ -3635,7 +3635,7 @@ def parseTraceLog(live=False):
 			elif(t.type == 'device_pm_callback_start'):
 				if phase not in data.dmesg:
 					continue
-				m = re.match('(?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*',\
+				m = re.match(r'(?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*',\
 					t.name);
 				if(not m):
 					continue
@@ -3650,7 +3650,7 @@ def parseTraceLog(live=False):
 			elif(t.type == 'device_pm_callback_end'):
 				if phase not in data.dmesg:
 					continue
-				m = re.match('(?P<drv>.*) (?P<d>.*), err.*', t.name);
+				m = re.match(r'(?P<drv>.*) (?P<d>.*), err.*', t.name);
 				if(not m):
 					continue
 				n = m.group('d')
@@ -3904,24 +3904,24 @@ def loadKernelLog():
 			line = line[idx:]
 		if tp.stampInfo(line, sysvals):
 			continue
-		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+		m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 		if(not m):
 			continue
 		msg = m.group("msg")
-		if re.match('PM: Syncing filesystems.*', msg) or \
-			re.match('PM: suspend entry.*', msg):
+		if re.match(r'PM: Syncing filesystems.*', msg) or \
+			re.match(r'PM: suspend entry.*', msg):
 			if(data):
 				testruns.append(data)
 			data = Data(len(testruns))
 			tp.parseStamp(data, sysvals)
 		if(not data):
 			continue
-		m = re.match('.* *(?P<k>[0-9]\.[0-9]{2}\.[0-9]-.*) .*', msg)
+		m = re.match(r'.* *(?P<k>[0-9]\.[0-9]{2}\.[0-9]-.*) .*', msg)
 		if(m):
 			sysvals.stamp['kernel'] = m.group('k')
-		m = re.match('PM: Preparing system for (?P<m>.*) sleep', msg)
+		m = re.match(r'PM: Preparing system for (?P<m>.*) sleep', msg)
 		if not m:
-			m = re.match('PM: Preparing system for sleep \((?P<m>.*)\)', msg)
+			m = re.match(r'PM: Preparing system for sleep \((?P<m>.*)\)', msg)
 		if m:
 			sysvals.stamp['mode'] = sysvals.suspendmode = m.group('m')
 		data.dmesgtext.append(line)
@@ -3984,7 +3984,7 @@ def parseKernelLog(data):
 		 'resume_machine': ['[PM: ]*Timekeeping suspended for.*',
 							'ACPI: Low-level resume complete.*',
 							'ACPI: resume from mwait',
-							'Suspended for [0-9\.]* seconds'],
+							r'Suspended for [0-9\.]* seconds'],
 		   'resume_noirq': ['PM: resume from suspend-to-idle',
 							'ACPI: Waking up from system sleep state.*'],
 		   'resume_early': ['PM: noirq resume of devices complete after.*',
@@ -3993,7 +3993,7 @@ def parseKernelLog(data):
 							'PM: early restore of devices complete after.*'],
 		'resume_complete': ['PM: resume of devices complete after.*',
 							'PM: restore of devices complete after.*'],
-		    'post_resume': ['.*Restarting tasks \.\.\..*'],
+		    'post_resume': [r'.*Restarting tasks \.\.\..*'],
 	}
 
 	# action table (expected events that occur and show up in dmesg)
@@ -4021,7 +4021,7 @@ def parseKernelLog(data):
 	actions = dict()
 	for line in data.dmesgtext:
 		# parse each dmesg line into the time and message
-		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+		m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 		if(m):
 			val = m.group('ktime')
 			try:
@@ -4145,26 +4145,26 @@ def parseKernelLog(data):
 					if(a in actions and actions[a][-1]['begin'] == actions[a][-1]['end']):
 						actions[a][-1]['end'] = ktime
 			# now look for CPU on/off events
-			if(re.match('Disabling non-boot CPUs .*', msg)):
+			if(re.match(r'Disabling non-boot CPUs .*', msg)):
 				# start of first cpu suspend
 				cpu_start = ktime
-			elif(re.match('Enabling non-boot CPUs .*', msg)):
+			elif(re.match(r'Enabling non-boot CPUs .*', msg)):
 				# start of first cpu resume
 				cpu_start = ktime
-			elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg) \
-				or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
+			elif(re.match(r'smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg) \
+				or re.match(r'psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
 				# end of a cpu suspend, start of the next
-				m = re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
+				m = re.match(r'smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
 				if(not m):
-					m = re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)
+					m = re.match(r'psci: CPU(?P<cpu>[0-9]*) killed.*', msg)
 				cpu = 'CPU'+m.group('cpu')
 				if(cpu not in actions):
 					actions[cpu] = []
 				actions[cpu].append({'begin': cpu_start, 'end': ktime})
 				cpu_start = ktime
-			elif(re.match('CPU(?P<cpu>[0-9]*) is up', msg)):
+			elif(re.match(r'CPU(?P<cpu>[0-9]*) is up', msg)):
 				# end of a cpu resume, start of the next
-				m = re.match('CPU(?P<cpu>[0-9]*) is up', msg)
+				m = re.match(r'CPU(?P<cpu>[0-9]*) is up', msg)
 				cpu = 'CPU'+m.group('cpu')
 				if(cpu not in actions):
 					actions[cpu] = []
@@ -5062,6 +5062,7 @@ def addCSS(hf, sv, testcount=1, kerror=False, extra=''):
 def addScriptCode(hf, testruns):
 	t0 = testruns[0].start * 1000
 	tMax = testruns[-1].end * 1000
+	hf.write('<script type="text/javascript">\n');
 	# create an array in javascript memory with the device details
 	detail = '	var devtable = [];\n'
 	for data in testruns:
@@ -5069,384 +5070,383 @@ def addScriptCode(hf, testruns):
 		detail += '	devtable[%d] = "%s";\n' % (data.testnumber, topo)
 	detail += '	var bounds = [%f,%f];\n' % (t0, tMax)
 	# add the code which will manipulate the data in the browser
-	script_code = \
-	'<script type="text/javascript">\n'+detail+\
-	'	var resolution = -1;\n'\
-	'	var dragval = [0, 0];\n'\
-	'	function redrawTimescale(t0, tMax, tS) {\n'\
-	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;">\';\n'\
-	'		var tTotal = tMax - t0;\n'\
-	'		var list = document.getElementsByClassName("tblock");\n'\
-	'		for (var i = 0; i < list.length; i++) {\n'\
-	'			var timescale = list[i].getElementsByClassName("timescale")[0];\n'\
-	'			var m0 = t0 + (tTotal*parseFloat(list[i].style.left)/100);\n'\
-	'			var mTotal = tTotal*parseFloat(list[i].style.width)/100;\n'\
-	'			var mMax = m0 + mTotal;\n'\
-	'			var html = "";\n'\
-	'			var divTotal = Math.floor(mTotal/tS) + 1;\n'\
-	'			if(divTotal > 1000) continue;\n'\
-	'			var divEdge = (mTotal - tS*(divTotal-1))*100/mTotal;\n'\
-	'			var pos = 0.0, val = 0.0;\n'\
-	'			for (var j = 0; j < divTotal; j++) {\n'\
-	'				var htmlline = "";\n'\
-	'				var mode = list[i].id[5];\n'\
-	'				if(mode == "s") {\n'\
-	'					pos = 100 - (((j)*tS*100)/mTotal) - divEdge;\n'\
-	'					val = (j-divTotal+1)*tS;\n'\
-	'					if(j == divTotal - 1)\n'\
-	'						htmlline = \'<div class="t" style="right:\'+pos+\'%"><cS>S&rarr;</cS></div>\';\n'\
-	'					else\n'\
-	'						htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
-	'				} else {\n'\
-	'					pos = 100 - (((j)*tS*100)/mTotal);\n'\
-	'					val = (j)*tS;\n'\
-	'					htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
-	'					if(j == 0)\n'\
-	'						if(mode == "r")\n'\
-	'							htmlline = rline+"<cS>&larr;R</cS></div>";\n'\
-	'						else\n'\
-	'							htmlline = rline+"<cS>0ms</div>";\n'\
-	'				}\n'\
-	'				html += htmlline;\n'\
-	'			}\n'\
-	'			timescale.innerHTML = html;\n'\
-	'		}\n'\
-	'	}\n'\
-	'	function zoomTimeline() {\n'\
-	'		var dmesg = document.getElementById("dmesg");\n'\
-	'		var zoombox = document.getElementById("dmesgzoombox");\n'\
-	'		var left = zoombox.scrollLeft;\n'\
-	'		var val = parseFloat(dmesg.style.width);\n'\
-	'		var newval = 100;\n'\
-	'		var sh = window.outerWidth / 2;\n'\
-	'		if(this.id == "zoomin") {\n'\
-	'			newval = val * 1.2;\n'\
-	'			if(newval > 910034) newval = 910034;\n'\
-	'			dmesg.style.width = newval+"%";\n'\
-	'			zoombox.scrollLeft = ((left + sh) * newval / val) - sh;\n'\
-	'		} else if (this.id == "zoomout") {\n'\
-	'			newval = val / 1.2;\n'\
-	'			if(newval < 100) newval = 100;\n'\
-	'			dmesg.style.width = newval+"%";\n'\
-	'			zoombox.scrollLeft = ((left + sh) * newval / val) - sh;\n'\
-	'		} else {\n'\
-	'			zoombox.scrollLeft = 0;\n'\
-	'			dmesg.style.width = "100%";\n'\
-	'		}\n'\
-	'		var tS = [10000, 5000, 2000, 1000, 500, 200, 100, 50, 20, 10, 5, 2, 1];\n'\
-	'		var t0 = bounds[0];\n'\
-	'		var tMax = bounds[1];\n'\
-	'		var tTotal = tMax - t0;\n'\
-	'		var wTotal = tTotal * 100.0 / newval;\n'\
-	'		var idx = 7*window.innerWidth/1100;\n'\
-	'		for(var i = 0; (i < tS.length)&&((wTotal / tS[i]) < idx); i++);\n'\
-	'		if(i >= tS.length) i = tS.length - 1;\n'\
-	'		if(tS[i] == resolution) return;\n'\
-	'		resolution = tS[i];\n'\
-	'		redrawTimescale(t0, tMax, tS[i]);\n'\
-	'	}\n'\
-	'	function deviceName(title) {\n'\
-	'		var name = title.slice(0, title.indexOf(" ("));\n'\
-	'		return name;\n'\
-	'	}\n'\
-	'	function deviceHover() {\n'\
-	'		var name = deviceName(this.title);\n'\
-	'		var dmesg = document.getElementById("dmesg");\n'\
-	'		var dev = dmesg.getElementsByClassName("thread");\n'\
-	'		var cpu = -1;\n'\
-	'		if(name.match("CPU_ON\[[0-9]*\]"))\n'\
-	'			cpu = parseInt(name.slice(7));\n'\
-	'		else if(name.match("CPU_OFF\[[0-9]*\]"))\n'\
-	'			cpu = parseInt(name.slice(8));\n'\
-	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dname = deviceName(dev[i].title);\n'\
-	'			var cname = dev[i].className.slice(dev[i].className.indexOf("thread"));\n'\
-	'			if((cpu >= 0 && dname.match("CPU_O[NF]*\\\[*"+cpu+"\\\]")) ||\n'\
-	'				(name == dname))\n'\
-	'			{\n'\
-	'				dev[i].className = "hover "+cname;\n'\
-	'			} else {\n'\
-	'				dev[i].className = cname;\n'\
-	'			}\n'\
-	'		}\n'\
-	'	}\n'\
-	'	function deviceUnhover() {\n'\
-	'		var dmesg = document.getElementById("dmesg");\n'\
-	'		var dev = dmesg.getElementsByClassName("thread");\n'\
-	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dev[i].className = dev[i].className.slice(dev[i].className.indexOf("thread"));\n'\
-	'		}\n'\
-	'	}\n'\
-	'	function deviceTitle(title, total, cpu) {\n'\
-	'		var prefix = "Total";\n'\
-	'		if(total.length > 3) {\n'\
-	'			prefix = "Average";\n'\
-	'			total[1] = (total[1]+total[3])/2;\n'\
-	'			total[2] = (total[2]+total[4])/2;\n'\
-	'		}\n'\
-	'		var devtitle = document.getElementById("devicedetailtitle");\n'\
-	'		var name = deviceName(title);\n'\
-	'		if(cpu >= 0) name = "CPU"+cpu;\n'\
-	'		var driver = "";\n'\
-	'		var tS = "<t2>(</t2>";\n'\
-	'		var tR = "<t2>)</t2>";\n'\
-	'		if(total[1] > 0)\n'\
-	'			tS = "<t2>("+prefix+" Suspend:</t2><t0> "+total[1].toFixed(3)+" ms</t0> ";\n'\
-	'		if(total[2] > 0)\n'\
-	'			tR = " <t2>"+prefix+" Resume:</t2><t0> "+total[2].toFixed(3)+" ms<t2>)</t2></t0>";\n'\
-	'		var s = title.indexOf("{");\n'\
-	'		var e = title.indexOf("}");\n'\
-	'		if((s >= 0) && (e >= 0))\n'\
-	'			driver = title.slice(s+1, e) + " <t1>@</t1> ";\n'\
-	'		if(total[1] > 0 && total[2] > 0)\n'\
-	'			devtitle.innerHTML = "<t0>"+driver+name+"</t0> "+tS+tR;\n'\
-	'		else\n'\
-	'			devtitle.innerHTML = "<t0>"+title+"</t0>";\n'\
-	'		return name;\n'\
-	'	}\n'\
-	'	function deviceDetail() {\n'\
-	'		var devinfo = document.getElementById("devicedetail");\n'\
-	'		devinfo.style.display = "block";\n'\
-	'		var name = deviceName(this.title);\n'\
-	'		var cpu = -1;\n'\
-	'		if(name.match("CPU_ON\[[0-9]*\]"))\n'\
-	'			cpu = parseInt(name.slice(7));\n'\
-	'		else if(name.match("CPU_OFF\[[0-9]*\]"))\n'\
-	'			cpu = parseInt(name.slice(8));\n'\
-	'		var dmesg = document.getElementById("dmesg");\n'\
-	'		var dev = dmesg.getElementsByClassName("thread");\n'\
-	'		var idlist = [];\n'\
-	'		var pdata = [[]];\n'\
-	'		if(document.getElementById("devicedetail1"))\n'\
-	'			pdata = [[], []];\n'\
-	'		var pd = pdata[0];\n'\
-	'		var total = [0.0, 0.0, 0.0];\n'\
-	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dname = deviceName(dev[i].title);\n'\
-	'			if((cpu >= 0 && dname.match("CPU_O[NF]*\\\[*"+cpu+"\\\]")) ||\n'\
-	'				(name == dname))\n'\
-	'			{\n'\
-	'				idlist[idlist.length] = dev[i].id;\n'\
-	'				var tidx = 1;\n'\
-	'				if(dev[i].id[0] == "a") {\n'\
-	'					pd = pdata[0];\n'\
-	'				} else {\n'\
-	'					if(pdata.length == 1) pdata[1] = [];\n'\
-	'					if(total.length == 3) total[3]=total[4]=0.0;\n'\
-	'					pd = pdata[1];\n'\
-	'					tidx = 3;\n'\
-	'				}\n'\
-	'				var info = dev[i].title.split(" ");\n'\
-	'				var pname = info[info.length-1];\n'\
-	'				pd[pname] = parseFloat(info[info.length-3].slice(1));\n'\
-	'				total[0] += pd[pname];\n'\
-	'				if(pname.indexOf("suspend") >= 0)\n'\
-	'					total[tidx] += pd[pname];\n'\
-	'				else\n'\
-	'					total[tidx+1] += pd[pname];\n'\
-	'			}\n'\
-	'		}\n'\
-	'		var devname = deviceTitle(this.title, total, cpu);\n'\
-	'		var left = 0.0;\n'\
-	'		for (var t = 0; t < pdata.length; t++) {\n'\
-	'			pd = pdata[t];\n'\
-	'			devinfo = document.getElementById("devicedetail"+t);\n'\
-	'			var phases = devinfo.getElementsByClassName("phaselet");\n'\
-	'			for (var i = 0; i < phases.length; i++) {\n'\
-	'				if(phases[i].id in pd) {\n'\
-	'					var w = 100.0*pd[phases[i].id]/total[0];\n'\
-	'					var fs = 32;\n'\
-	'					if(w < 8) fs = 4*w | 0;\n'\
-	'					var fs2 = fs*3/4;\n'\
-	'					phases[i].style.width = w+"%";\n'\
-	'					phases[i].style.left = left+"%";\n'\
-	'					phases[i].title = phases[i].id+" "+pd[phases[i].id]+" ms";\n'\
-	'					left += w;\n'\
-	'					var time = "<t4 style=\\"font-size:"+fs+"px\\">"+pd[phases[i].id]+" ms<br></t4>";\n'\
-	'					var pname = "<t3 style=\\"font-size:"+fs2+"px\\">"+phases[i].id.replace(new RegExp("_", "g"), " ")+"</t3>";\n'\
-	'					phases[i].innerHTML = time+pname;\n'\
-	'				} else {\n'\
-	'					phases[i].style.width = "0%";\n'\
-	'					phases[i].style.left = left+"%";\n'\
-	'				}\n'\
-	'			}\n'\
-	'		}\n'\
-	'		if(typeof devstats !== \'undefined\')\n'\
-	'			callDetail(this.id, this.title);\n'\
-	'		var cglist = document.getElementById("callgraphs");\n'\
-	'		if(!cglist) return;\n'\
-	'		var cg = cglist.getElementsByClassName("atop");\n'\
-	'		if(cg.length < 10) return;\n'\
-	'		for (var i = 0; i < cg.length; i++) {\n'\
-	'			cgid = cg[i].id.split("x")[0]\n'\
-	'			if(idlist.indexOf(cgid) >= 0) {\n'\
-	'				cg[i].style.display = "block";\n'\
-	'			} else {\n'\
-	'				cg[i].style.display = "none";\n'\
-	'			}\n'\
-	'		}\n'\
-	'	}\n'\
-	'	function callDetail(devid, devtitle) {\n'\
-	'		if(!(devid in devstats) || devstats[devid].length < 1)\n'\
-	'			return;\n'\
-	'		var list = devstats[devid];\n'\
-	'		var tmp = devtitle.split(" ");\n'\
-	'		var name = tmp[0], phase = tmp[tmp.length-1];\n'\
-	'		var dd = document.getElementById(phase);\n'\
-	'		var total = parseFloat(tmp[1].slice(1));\n'\
-	'		var mlist = [];\n'\
-	'		var maxlen = 0;\n'\
-	'		var info = []\n'\
-	'		for(var i in list) {\n'\
-	'			if(list[i][0] == "@") {\n'\
-	'				info = list[i].split("|");\n'\
-	'				continue;\n'\
-	'			}\n'\
-	'			var tmp = list[i].split("|");\n'\
-	'			var t = parseFloat(tmp[0]), f = tmp[1], c = parseInt(tmp[2]);\n'\
-	'			var p = (t*100.0/total).toFixed(2);\n'\
-	'			mlist[mlist.length] = [f, c, t.toFixed(2), p+"%"];\n'\
-	'			if(f.length > maxlen)\n'\
-	'				maxlen = f.length;\n'\
-	'		}\n'\
-	'		var pad = 5;\n'\
-	'		if(mlist.length == 0) pad = 30;\n'\
-	'		var html = \'<div style="padding-top:\'+pad+\'px"><t3> <b>\'+name+\':</b>\';\n'\
-	'		if(info.length > 2)\n'\
-	'			html += " start=<b>"+info[1]+"</b>, end=<b>"+info[2]+"</b>";\n'\
-	'		if(info.length > 3)\n'\
-	'			html += ", length<i>(w/o overhead)</i>=<b>"+info[3]+" ms</b>";\n'\
-	'		if(info.length > 4)\n'\
-	'			html += ", return=<b>"+info[4]+"</b>";\n'\
-	'		html += "</t3></div>";\n'\
-	'		if(mlist.length > 0) {\n'\
-	'			html += \'<table class=fstat style="padding-top:\'+(maxlen*5)+\'px;"><tr><th>Function</th>\';\n'\
-	'			for(var i in mlist)\n'\
-	'				html += "<td class=vt>"+mlist[i][0]+"</td>";\n'\
-	'			html += "</tr><tr><th>Calls</th>";\n'\
-	'			for(var i in mlist)\n'\
-	'				html += "<td>"+mlist[i][1]+"</td>";\n'\
-	'			html += "</tr><tr><th>Time(ms)</th>";\n'\
-	'			for(var i in mlist)\n'\
-	'				html += "<td>"+mlist[i][2]+"</td>";\n'\
-	'			html += "</tr><tr><th>Percent</th>";\n'\
-	'			for(var i in mlist)\n'\
-	'				html += "<td>"+mlist[i][3]+"</td>";\n'\
-	'			html += "</tr></table>";\n'\
-	'		}\n'\
-	'		dd.innerHTML = html;\n'\
-	'		var height = (maxlen*5)+100;\n'\
-	'		dd.style.height = height+"px";\n'\
-	'		document.getElementById("devicedetail").style.height = height+"px";\n'\
-	'	}\n'\
-	'	function callSelect() {\n'\
-	'		var cglist = document.getElementById("callgraphs");\n'\
-	'		if(!cglist) return;\n'\
-	'		var cg = cglist.getElementsByClassName("atop");\n'\
-	'		for (var i = 0; i < cg.length; i++) {\n'\
-	'			if(this.id == cg[i].id) {\n'\
-	'				cg[i].style.display = "block";\n'\
-	'			} else {\n'\
-	'				cg[i].style.display = "none";\n'\
-	'			}\n'\
-	'		}\n'\
-	'	}\n'\
-	'	function devListWindow(e) {\n'\
-	'		var win = window.open();\n'\
-	'		var html = "<title>"+e.target.innerHTML+"</title>"+\n'\
-	'			"<style type=\\"text/css\\">"+\n'\
-	'			"   ul {list-style-type:circle;padding-left:10px;margin-left:10px;}"+\n'\
-	'			"</style>"\n'\
-	'		var dt = devtable[0];\n'\
-	'		if(e.target.id != "devlist1")\n'\
-	'			dt = devtable[1];\n'\
-	'		win.document.write(html+dt);\n'\
-	'	}\n'\
-	'	function errWindow() {\n'\
-	'		var range = this.id.split("_");\n'\
-	'		var idx1 = parseInt(range[0]);\n'\
-	'		var idx2 = parseInt(range[1]);\n'\
-	'		var win = window.open();\n'\
-	'		var log = document.getElementById("dmesglog");\n'\
-	'		var title = "<title>dmesg log</title>";\n'\
-	'		var text = log.innerHTML.split("\\n");\n'\
-	'		var html = "";\n'\
-	'		for(var i = 0; i < text.length; i++) {\n'\
-	'			if(i == idx1) {\n'\
-	'				html += "<e id=target>"+text[i]+"</e>\\n";\n'\
-	'			} else if(i > idx1 && i <= idx2) {\n'\
-	'				html += "<e>"+text[i]+"</e>\\n";\n'\
-	'			} else {\n'\
-	'				html += text[i]+"\\n";\n'\
-	'			}\n'\
-	'		}\n'\
-	'		win.document.write("<style>e{color:red}</style>"+title+"<pre>"+html+"</pre>");\n'\
-	'		win.location.hash = "#target";\n'\
-	'		win.document.close();\n'\
-	'	}\n'\
-	'	function logWindow(e) {\n'\
-	'		var name = e.target.id.slice(4);\n'\
-	'		var win = window.open();\n'\
-	'		var log = document.getElementById(name+"log");\n'\
-	'		var title = "<title>"+document.title.split(" ")[0]+" "+name+" log</title>";\n'\
-	'		win.document.write(title+"<pre>"+log.innerHTML+"</pre>");\n'\
-	'		win.document.close();\n'\
-	'	}\n'\
-	'	function onMouseDown(e) {\n'\
-	'		dragval[0] = e.clientX;\n'\
-	'		dragval[1] = document.getElementById("dmesgzoombox").scrollLeft;\n'\
-	'		document.onmousemove = onMouseMove;\n'\
-	'	}\n'\
-	'	function onMouseMove(e) {\n'\
-	'		var zoombox = document.getElementById("dmesgzoombox");\n'\
-	'		zoombox.scrollLeft = dragval[1] + dragval[0] - e.clientX;\n'\
-	'	}\n'\
-	'	function onMouseUp(e) {\n'\
-	'		document.onmousemove = null;\n'\
-	'	}\n'\
-	'	function onKeyPress(e) {\n'\
-	'		var c = e.charCode;\n'\
-	'		if(c != 42 && c != 43 && c != 45) return;\n'\
-	'		var click = document.createEvent("Events");\n'\
-	'		click.initEvent("click", true, false);\n'\
-	'		if(c == 43)  \n'\
-	'			document.getElementById("zoomin").dispatchEvent(click);\n'\
-	'		else if(c == 45)\n'\
-	'			document.getElementById("zoomout").dispatchEvent(click);\n'\
-	'		else if(c == 42)\n'\
-	'			document.getElementById("zoomdef").dispatchEvent(click);\n'\
-	'	}\n'\
-	'	window.addEventListener("resize", function () {zoomTimeline();});\n'\
-	'	window.addEventListener("load", function () {\n'\
-	'		var dmesg = document.getElementById("dmesg");\n'\
-	'		dmesg.style.width = "100%"\n'\
-	'		dmesg.onmousedown = onMouseDown;\n'\
-	'		document.onmouseup = onMouseUp;\n'\
-	'		document.onkeypress = onKeyPress;\n'\
-	'		document.getElementById("zoomin").onclick = zoomTimeline;\n'\
-	'		document.getElementById("zoomout").onclick = zoomTimeline;\n'\
-	'		document.getElementById("zoomdef").onclick = zoomTimeline;\n'\
-	'		var list = document.getElementsByClassName("err");\n'\
-	'		for (var i = 0; i < list.length; i++)\n'\
-	'			list[i].onclick = errWindow;\n'\
-	'		var list = document.getElementsByClassName("logbtn");\n'\
-	'		for (var i = 0; i < list.length; i++)\n'\
-	'			list[i].onclick = logWindow;\n'\
-	'		list = document.getElementsByClassName("devlist");\n'\
-	'		for (var i = 0; i < list.length; i++)\n'\
-	'			list[i].onclick = devListWindow;\n'\
-	'		var dev = dmesg.getElementsByClassName("thread");\n'\
-	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dev[i].onclick = deviceDetail;\n'\
-	'			dev[i].onmouseover = deviceHover;\n'\
-	'			dev[i].onmouseout = deviceUnhover;\n'\
-	'		}\n'\
-	'		var dev = dmesg.getElementsByClassName("srccall");\n'\
-	'		for (var i = 0; i < dev.length; i++)\n'\
-	'			dev[i].onclick = callSelect;\n'\
-	'		zoomTimeline();\n'\
-	'	});\n'\
-	'</script>\n'
+	hf.write(detail);
+	script_code = r"""	var resolution = -1;
+	var dragval = [0, 0];
+	function redrawTimescale(t0, tMax, tS) {
+		var rline = '<div class="t" style="left:0;border-left:1px solid black;border-right:0;">';
+		var tTotal = tMax - t0;
+		var list = document.getElementsByClassName("tblock");
+		for (var i = 0; i < list.length; i++) {
+			var timescale = list[i].getElementsByClassName("timescale")[0];
+			var m0 = t0 + (tTotal*parseFloat(list[i].style.left)/100);
+			var mTotal = tTotal*parseFloat(list[i].style.width)/100;
+			var mMax = m0 + mTotal;
+			var html = "";
+			var divTotal = Math.floor(mTotal/tS) + 1;
+			if(divTotal > 1000) continue;
+			var divEdge = (mTotal - tS*(divTotal-1))*100/mTotal;
+			var pos = 0.0, val = 0.0;
+			for (var j = 0; j < divTotal; j++) {
+				var htmlline = "";
+				var mode = list[i].id[5];
+				if(mode == "s") {
+					pos = 100 - (((j)*tS*100)/mTotal) - divEdge;
+					val = (j-divTotal+1)*tS;
+					if(j == divTotal - 1)
+						htmlline = '<div class="t" style="right:'+pos+'%"><cS>S&rarr;</cS></div>';
+					else
+						htmlline = '<div class="t" style="right:'+pos+'%">'+val+'ms</div>';
+				} else {
+					pos = 100 - (((j)*tS*100)/mTotal);
+					val = (j)*tS;
+					htmlline = '<div class="t" style="right:'+pos+'%">'+val+'ms</div>';
+					if(j == 0)
+						if(mode == "r")
+							htmlline = rline+"<cS>&larr;R</cS></div>";
+						else
+							htmlline = rline+"<cS>0ms</div>";
+				}
+				html += htmlline;
+			}
+			timescale.innerHTML = html;
+		}
+	}
+	function zoomTimeline() {
+		var dmesg = document.getElementById("dmesg");
+		var zoombox = document.getElementById("dmesgzoombox");
+		var left = zoombox.scrollLeft;
+		var val = parseFloat(dmesg.style.width);
+		var newval = 100;
+		var sh = window.outerWidth / 2;
+		if(this.id == "zoomin") {
+			newval = val * 1.2;
+			if(newval > 910034) newval = 910034;
+			dmesg.style.width = newval+"%";
+			zoombox.scrollLeft = ((left + sh) * newval / val) - sh;
+		} else if (this.id == "zoomout") {
+			newval = val / 1.2;
+			if(newval < 100) newval = 100;
+			dmesg.style.width = newval+"%";
+			zoombox.scrollLeft = ((left + sh) * newval / val) - sh;
+		} else {
+			zoombox.scrollLeft = 0;
+			dmesg.style.width = "100%";
+		}
+		var tS = [10000, 5000, 2000, 1000, 500, 200, 100, 50, 20, 10, 5, 2, 1];
+		var t0 = bounds[0];
+		var tMax = bounds[1];
+		var tTotal = tMax - t0;
+		var wTotal = tTotal * 100.0 / newval;
+		var idx = 7*window.innerWidth/1100;
+		for(var i = 0; (i < tS.length)&&((wTotal / tS[i]) < idx); i++);
+		if(i >= tS.length) i = tS.length - 1;
+		if(tS[i] == resolution) return;
+		resolution = tS[i];
+		redrawTimescale(t0, tMax, tS[i]);
+	}
+	function deviceName(title) {
+		var name = title.slice(0, title.indexOf(" ("));
+		return name;
+	}
+	function deviceHover() {
+		var name = deviceName(this.title);
+		var dmesg = document.getElementById("dmesg");
+		var dev = dmesg.getElementsByClassName("thread");
+		var cpu = -1;
+		if(name.match("CPU_ON\[[0-9]*\]"))
+			cpu = parseInt(name.slice(7));
+		else if(name.match("CPU_OFF\[[0-9]*\]"))
+			cpu = parseInt(name.slice(8));
+		for (var i = 0; i < dev.length; i++) {
+			dname = deviceName(dev[i].title);
+			var cname = dev[i].className.slice(dev[i].className.indexOf("thread"));
+			if((cpu >= 0 && dname.match("CPU_O[NF]*\\[*"+cpu+"\\]")) ||
+				(name == dname))
+			{
+				dev[i].className = "hover "+cname;
+			} else {
+				dev[i].className = cname;
+			}
+		}
+	}
+	function deviceUnhover() {
+		var dmesg = document.getElementById("dmesg");
+		var dev = dmesg.getElementsByClassName("thread");
+		for (var i = 0; i < dev.length; i++) {
+			dev[i].className = dev[i].className.slice(dev[i].className.indexOf("thread"));
+		}
+	}
+	function deviceTitle(title, total, cpu) {
+		var prefix = "Total";
+		if(total.length > 3) {
+			prefix = "Average";
+			total[1] = (total[1]+total[3])/2;
+			total[2] = (total[2]+total[4])/2;
+		}
+		var devtitle = document.getElementById("devicedetailtitle");
+		var name = deviceName(title);
+		if(cpu >= 0) name = "CPU"+cpu;
+		var driver = "";
+		var tS = "<t2>(</t2>";
+		var tR = "<t2>)</t2>";
+		if(total[1] > 0)
+			tS = "<t2>("+prefix+" Suspend:</t2><t0> "+total[1].toFixed(3)+" ms</t0> ";
+		if(total[2] > 0)
+			tR = " <t2>"+prefix+" Resume:</t2><t0> "+total[2].toFixed(3)+" ms<t2>)</t2></t0>";
+		var s = title.indexOf("{");
+		var e = title.indexOf("}");
+		if((s >= 0) && (e >= 0))
+			driver = title.slice(s+1, e) + " <t1>@</t1> ";
+		if(total[1] > 0 && total[2] > 0)
+			devtitle.innerHTML = "<t0>"+driver+name+"</t0> "+tS+tR;
+		else
+			devtitle.innerHTML = "<t0>"+title+"</t0>";
+		return name;
+	}
+	function deviceDetail() {
+		var devinfo = document.getElementById("devicedetail");
+		devinfo.style.display = "block";
+		var name = deviceName(this.title);
+		var cpu = -1;
+		if(name.match("CPU_ON\[[0-9]*\]"))
+			cpu = parseInt(name.slice(7));
+		else if(name.match("CPU_OFF\[[0-9]*\]"))
+			cpu = parseInt(name.slice(8));
+		var dmesg = document.getElementById("dmesg");
+		var dev = dmesg.getElementsByClassName("thread");
+		var idlist = [];
+		var pdata = [[]];
+		if(document.getElementById("devicedetail1"))
+			pdata = [[], []];
+		var pd = pdata[0];
+		var total = [0.0, 0.0, 0.0];
+		for (var i = 0; i < dev.length; i++) {
+			dname = deviceName(dev[i].title);
+			if((cpu >= 0 && dname.match("CPU_O[NF]*\\[*"+cpu+"\\]")) ||
+				(name == dname))
+			{
+				idlist[idlist.length] = dev[i].id;
+				var tidx = 1;
+				if(dev[i].id[0] == "a") {
+					pd = pdata[0];
+				} else {
+					if(pdata.length == 1) pdata[1] = [];
+					if(total.length == 3) total[3]=total[4]=0.0;
+					pd = pdata[1];
+					tidx = 3;
+				}
+				var info = dev[i].title.split(" ");
+				var pname = info[info.length-1];
+				pd[pname] = parseFloat(info[info.length-3].slice(1));
+				total[0] += pd[pname];
+				if(pname.indexOf("suspend") >= 0)
+					total[tidx] += pd[pname];
+				else
+					total[tidx+1] += pd[pname];
+			}
+		}
+		var devname = deviceTitle(this.title, total, cpu);
+		var left = 0.0;
+		for (var t = 0; t < pdata.length; t++) {
+			pd = pdata[t];
+			devinfo = document.getElementById("devicedetail"+t);
+			var phases = devinfo.getElementsByClassName("phaselet");
+			for (var i = 0; i < phases.length; i++) {
+				if(phases[i].id in pd) {
+					var w = 100.0*pd[phases[i].id]/total[0];
+					var fs = 32;
+					if(w < 8) fs = 4*w | 0;
+					var fs2 = fs*3/4;
+					phases[i].style.width = w+"%";
+					phases[i].style.left = left+"%";
+					phases[i].title = phases[i].id+" "+pd[phases[i].id]+" ms";
+					left += w;
+					var time = "<t4 style=\"font-size:"+fs+"px\">"+pd[phases[i].id]+" ms<br></t4>";
+					var pname = "<t3 style=\"font-size:"+fs2+"px\">"+phases[i].id.replace(new RegExp("_", "g"), " ")+"</t3>";
+					phases[i].innerHTML = time+pname;
+				} else {
+					phases[i].style.width = "0%";
+					phases[i].style.left = left+"%";
+				}
+			}
+		}
+		if(typeof devstats !== 'undefined')
+			callDetail(this.id, this.title);
+		var cglist = document.getElementById("callgraphs");
+		if(!cglist) return;
+		var cg = cglist.getElementsByClassName("atop");
+		if(cg.length < 10) return;
+		for (var i = 0; i < cg.length; i++) {
+			cgid = cg[i].id.split("x")[0]
+			if(idlist.indexOf(cgid) >= 0) {
+				cg[i].style.display = "block";
+			} else {
+				cg[i].style.display = "none";
+			}
+		}
+	}
+	function callDetail(devid, devtitle) {
+		if(!(devid in devstats) || devstats[devid].length < 1)
+			return;
+		var list = devstats[devid];
+		var tmp = devtitle.split(" ");
+		var name = tmp[0], phase = tmp[tmp.length-1];
+		var dd = document.getElementById(phase);
+		var total = parseFloat(tmp[1].slice(1));
+		var mlist = [];
+		var maxlen = 0;
+		var info = []
+		for(var i in list) {
+			if(list[i][0] == "@") {
+				info = list[i].split("|");
+				continue;
+			}
+			var tmp = list[i].split("|");
+			var t = parseFloat(tmp[0]), f = tmp[1], c = parseInt(tmp[2]);
+			var p = (t*100.0/total).toFixed(2);
+			mlist[mlist.length] = [f, c, t.toFixed(2), p+"%"];
+			if(f.length > maxlen)
+				maxlen = f.length;
+		}
+		var pad = 5;
+		if(mlist.length == 0) pad = 30;
+		var html = '<div style="padding-top:'+pad+'px"><t3> <b>'+name+':</b>';
+		if(info.length > 2)
+			html += " start=<b>"+info[1]+"</b>, end=<b>"+info[2]+"</b>";
+		if(info.length > 3)
+			html += ", length<i>(w/o overhead)</i>=<b>"+info[3]+" ms</b>";
+		if(info.length > 4)
+			html += ", return=<b>"+info[4]+"</b>";
+		html += "</t3></div>";
+		if(mlist.length > 0) {
+			html += '<table class=fstat style="padding-top:'+(maxlen*5)+'px;"><tr><th>Function</th>';
+			for(var i in mlist)
+				html += "<td class=vt>"+mlist[i][0]+"</td>";
+			html += "</tr><tr><th>Calls</th>";
+			for(var i in mlist)
+				html += "<td>"+mlist[i][1]+"</td>";
+			html += "</tr><tr><th>Time(ms)</th>";
+			for(var i in mlist)
+				html += "<td>"+mlist[i][2]+"</td>";
+			html += "</tr><tr><th>Percent</th>";
+			for(var i in mlist)
+				html += "<td>"+mlist[i][3]+"</td>";
+			html += "</tr></table>";
+		}
+		dd.innerHTML = html;
+		var height = (maxlen*5)+100;
+		dd.style.height = height+"px";
+		document.getElementById("devicedetail").style.height = height+"px";
+	}
+	function callSelect() {
+		var cglist = document.getElementById("callgraphs");
+		if(!cglist) return;
+		var cg = cglist.getElementsByClassName("atop");
+		for (var i = 0; i < cg.length; i++) {
+			if(this.id == cg[i].id) {
+				cg[i].style.display = "block";
+			} else {
+				cg[i].style.display = "none";
+			}
+		}
+	}
+	function devListWindow(e) {
+		var win = window.open();
+		var html = "<title>"+e.target.innerHTML+"</title>"+
+			"<style type=\"text/css\">"+
+			"   ul {list-style-type:circle;padding-left:10px;margin-left:10px;}"+
+			"</style>"
+		var dt = devtable[0];
+		if(e.target.id != "devlist1")
+			dt = devtable[1];
+		win.document.write(html+dt);
+	}
+	function errWindow() {
+		var range = this.id.split("_");
+		var idx1 = parseInt(range[0]);
+		var idx2 = parseInt(range[1]);
+		var win = window.open();
+		var log = document.getElementById("dmesglog");
+		var title = "<title>dmesg log</title>";
+		var text = log.innerHTML.split("\n");
+		var html = "";
+		for(var i = 0; i < text.length; i++) {
+			if(i == idx1) {
+				html += "<e id=target>"+text[i]+"</e>\n";
+			} else if(i > idx1 && i <= idx2) {
+				html += "<e>"+text[i]+"</e>\n";
+			} else {
+				html += text[i]+"\n";
+			}
+		}
+		win.document.write("<style>e{color:red}</style>"+title+"<pre>"+html+"</pre>");
+		win.location.hash = "#target";
+		win.document.close();
+	}
+	function logWindow(e) {
+		var name = e.target.id.slice(4);
+		var win = window.open();
+		var log = document.getElementById(name+"log");
+		var title = "<title>"+document.title.split(" ")[0]+" "+name+" log</title>";
+		win.document.write(title+"<pre>"+log.innerHTML+"</pre>");
+		win.document.close();
+	}
+	function onMouseDown(e) {
+		dragval[0] = e.clientX;
+		dragval[1] = document.getElementById("dmesgzoombox").scrollLeft;
+		document.onmousemove = onMouseMove;
+	}
+	function onMouseMove(e) {
+		var zoombox = document.getElementById("dmesgzoombox");
+		zoombox.scrollLeft = dragval[1] + dragval[0] - e.clientX;
+	}
+	function onMouseUp(e) {
+		document.onmousemove = null;
+	}
+	function onKeyPress(e) {
+		var c = e.charCode;
+		if(c != 42 && c != 43 && c != 45) return;
+		var click = document.createEvent("Events");
+		click.initEvent("click", true, false);
+		if(c == 43)
+			document.getElementById("zoomin").dispatchEvent(click);
+		else if(c == 45)
+			document.getElementById("zoomout").dispatchEvent(click);
+		else if(c == 42)
+			document.getElementById("zoomdef").dispatchEvent(click);
+	}
+	window.addEventListener("resize", function () {zoomTimeline();});
+	window.addEventListener("load", function () {
+		var dmesg = document.getElementById("dmesg");
+		dmesg.style.width = "100%"
+		dmesg.onmousedown = onMouseDown;
+		document.onmouseup = onMouseUp;
+		document.onkeypress = onKeyPress;
+		document.getElementById("zoomin").onclick = zoomTimeline;
+		document.getElementById("zoomout").onclick = zoomTimeline;
+		document.getElementById("zoomdef").onclick = zoomTimeline;
+		var list = document.getElementsByClassName("err");
+		for (var i = 0; i < list.length; i++)
+			list[i].onclick = errWindow;
+		var list = document.getElementsByClassName("logbtn");
+		for (var i = 0; i < list.length; i++)
+			list[i].onclick = logWindow;
+		list = document.getElementsByClassName("devlist");
+		for (var i = 0; i < list.length; i++)
+			list[i].onclick = devListWindow;
+		var dev = dmesg.getElementsByClassName("thread");
+		for (var i = 0; i < dev.length; i++) {
+			dev[i].onclick = deviceDetail;
+			dev[i].onmouseover = deviceHover;
+			dev[i].onmouseout = deviceUnhover;
+		}
+		var dev = dmesg.getElementsByClassName("srccall");
+		for (var i = 0; i < dev.length; i++)
+			dev[i].onclick = callSelect;
+		zoomTimeline();
+	});
+</script> """
 	hf.write(script_code);
 
 # Function: executeSuspend
@@ -5637,7 +5637,7 @@ def deviceInfo(output=''):
 	tgtval = 'runtime_status'
 	lines = dict()
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
-		if(not re.match('.*/power', dirname) or
+		if(not re.match(r'.*/power', dirname) or
 			'control' not in filenames or
 			tgtval not in filenames):
 			continue
@@ -5731,7 +5731,7 @@ def dmidecode_backup(out, fatal=False):
 	if 'processor-version' not in out and os.path.exists(cpath):
 		with open(cpath, 'r') as fp:
 			for line in fp:
-				m = re.match('^model\s*name\s*\:\s*(?P<c>.*)', line)
+				m = re.match(r'^model\s*name\s*\:\s*(?P<c>.*)', line)
 				if m:
 					out['processor-version'] = m.group('c').strip()
 					break
@@ -6312,7 +6312,7 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 	tstr = dt.strftime('%Y/%m/%d %H:%M:%S')
 	error = find_in_html(html, '<table class="testfail"><tr><td>', '</td>')
 	if error:
-		m = re.match('[a-z0-9]* failed in (?P<p>\S*).*', error)
+		m = re.match(r'[a-z0-9]* failed in (?P<p>\S*).*', error)
 		if m:
 			result = 'fail in %s' % m.group('p')
 		else:
@@ -6350,7 +6350,7 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 			extra['netfix'] = line
 		line = find_in_html(log, '# command ', '\n')
 		if line:
-			m = re.match('.* -m (?P<m>\S*).*', line)
+			m = re.match(r'.* -m (?P<m>\S*).*', line)
 			if m:
 				extra['fullmode'] = m.group('m')
 	low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
@@ -6362,7 +6362,7 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 		if lowstr == '+':
 			issue = 'S2LOOPx%d' % len(low.split('+'))
 		else:
-			m = re.match('.*waking *(?P<n>[0-9]*) *times.*', low)
+			m = re.match(r'.*waking *(?P<n>[0-9]*) *times.*', low)
 			issue = 'S2WAKEx%s' % m.group('n') if m else 'S2WAKExNaN'
 		match = [i for i in issues if i['match'] == issue]
 		if len(match) > 0:
@@ -6380,10 +6380,10 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 	# extract device info
 	devices = dict()
 	for line in html.split('\n'):
-		m = re.match(' *<div id=\"[a,0-9]*\" *title=\"(?P<title>.*)\" class=\"thread.*', line)
+		m = re.match(r' *<div id=\"[a,0-9]*\" *title=\"(?P<title>.*)\" class=\"thread.*', line)
 		if not m or 'thread kth' in line or 'thread sec' in line:
 			continue
-		m = re.match('(?P<n>.*) \((?P<t>[0-9,\.]*) ms\) (?P<p>.*)', m.group('title'))
+		m = re.match(r'(?P<n>.*) \((?P<t>[0-9,\.]*) ms\) (?P<p>.*)', m.group('title'))
 		if not m:
 			continue
 		name, time, phase = m.group('n'), m.group('t'), m.group('p')
@@ -6444,9 +6444,9 @@ def genHtml(subdir, force=False):
 		for filename in filenames:
 			file = os.path.join(dirname, filename)
 			if sysvals.usable(file):
-				if(re.match('.*_dmesg.txt', filename)):
+				if(re.match(r'.*_dmesg.txt', filename)):
 					sysvals.dmesgfile = file
-				elif(re.match('.*_ftrace.txt', filename)):
+				elif(re.match(r'.*_ftrace.txt', filename)):
 					sysvals.ftracefile = file
 		sysvals.setOutputFile()
 		if (sysvals.dmesgfile or sysvals.ftracefile) and sysvals.htmlfile and \
@@ -6469,7 +6469,7 @@ def runSummary(subdir, local=True, genhtml=False):
 	desc = {'host':[],'mode':[],'kernel':[]}
 	for dirname, dirnames, filenames in os.walk(subdir):
 		for filename in filenames:
-			if(not re.match('.*.html', filename)):
+			if(not re.match(r'.*.html', filename)):
 				continue
 			data = data_from_html(os.path.join(dirname, filename), outpath, issues)
 			if(not data):
-- 
2.17.1


