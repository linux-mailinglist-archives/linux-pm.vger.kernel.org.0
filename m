Return-Path: <linux-pm+bounces-8445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979448D5DEB
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DABA281A96
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610F155CBC;
	Fri, 31 May 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CakZuOPy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065578C7E
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146796; cv=none; b=ZktJ4P9KE+0CIpE8knBdfpNa9CVsMoBW/+Z5yzlzyzlE99jFk65M5U6t5cGNtHO2yi2Qu0NEzyFujdF263W0+0RgUJgpTyWUzR2S33RB6pD+tCJduzukuEUu6C95RzN3Kl9AvhvpE4NFWeSS4uv6PRG+pwSGwQAbPCgskbWxFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146796; c=relaxed/simple;
	bh=T3tO1t51MjJCG4OKnSotrlo7xUx0C9wxXpOpZsRQquo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=HKrPvWxnl7cfsNm0IMdYWHkwzLjjh9nCg8f9ZhrbnAMacue3r+LvSp5hUgGjWaFXY2rhm0obPLlMciqWBjwaj7AfzfDrJKAwMBC42E/anz8w8EKwl4nvFXMLxsdCIRZAyRpOogGqPFPja1W6fIGx3wWEhL5JWvlIvnV6RicrtZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CakZuOPy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146795; x=1748682795;
  h=from:to:cc:subject:date:message-id;
  bh=T3tO1t51MjJCG4OKnSotrlo7xUx0C9wxXpOpZsRQquo=;
  b=CakZuOPyW1zhqbr72PQE3rVV0UA45sOcrIvxgnxHwl/jQrI7kp3voZFv
   HKC1sq3O2EBvYuNraGHVkShLv/axJFl00Uj7ud2zFJuvZPihW3e0Gf3cM
   4XDMAX3YISKTDBQUfG3yj3eJpDCcdfkGyLpWEgBT+RFoMptsAfw6ouFQ4
   ViIhde03Zo0mtBW/7rGsbsPiJvEIFCqD0XJ9oepJvCjCsNf2684ub1SY1
   p6mojrkVN5jrUiyij9wVcecMeTkR6m1Rk/4CxFI3HTGkVOx6YXvu9m1m0
   TPWnNVUG1EsA77UXYvSUK7UtpjI/Yrmy3XyA8k1bc/3vz+DjvTW/aNDca
   Q==;
X-CSE-ConnectionGUID: zQyJ8nizTNKoNWsdDZlOfA==
X-CSE-MsgGUID: FBRiI0ntSdGoQBJe3aiboA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13807212"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13807212"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:13:13 -0700
X-CSE-ConnectionGUID: EGt1tt5ERmK6E50PQmPj+A==
X-CSE-MsgGUID: zX0w0cpcT7yWX6dDQjCk2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="73589711"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by orviesa001.jf.intel.com with ESMTP; 31 May 2024 02:13:12 -0700
From: Todd Brandt <todd.e.brandt@intel.com>
To: linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: [PATCH 1/2] pm-graph v5.12, fixes
Date: Fri, 31 May 2024 02:13:09 -0700
Message-Id: <3d5c6c492cee09096f238bbf20514a305b174412.1717146154.git.todd.e.brandt@intel.com>
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

- fix S3 suspend fail double run by using fp.flush to /sys/power/state
- when running turbostat print the return value
- handle case where html files have binary data
- max issues in summary-issues is now 100 (in case there are thousands)
- add backup to dmidecode, use /sys/class/dmi/id/ in case /dev/mem fails
- update summary page to use full mode (disk-platform instead of disk)

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 tools/power/pm-graph/sleepgraph.py | 102 ++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 40ad221e8881..b709c5f2b6f1 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -86,7 +86,7 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.11'
+	version = '5.12'
 	ansi = False
 	rs = 0
 	display = ''
@@ -1181,8 +1181,8 @@ class SystemValues:
 		cmd = self.getExec('turbostat')
 		rawout = keyline = valline = ''
 		fullcmd = '%s -q -S echo freeze > %s' % (cmd, self.powerfile)
-		fp = Popen(['sh', '-c', fullcmd], stdout=PIPE, stderr=PIPE).stderr
-		for line in fp:
+		fp = Popen(['sh', '-c', fullcmd], stdout=PIPE, stderr=PIPE)
+		for line in fp.stderr:
 			line = ascii(line)
 			rawout += line
 			if keyline and valline:
@@ -1191,13 +1191,13 @@ class SystemValues:
 				keyline = line.strip().split()
 			elif keyline:
 				valline = line.strip().split()
-		fp.close()
+		fp.wait()
 		if not keyline or not valline or len(keyline) != len(valline):
 			errmsg = 'unrecognized turbostat output:\n'+rawout.strip()
 			self.vprint(errmsg)
 			if not self.verbose:
 				pprint(errmsg)
-			return ''
+			return (fp.returncode, '')
 		if self.verbose:
 			pprint(rawout.strip())
 		out = []
@@ -1207,7 +1207,7 @@ class SystemValues:
 			if key == 'SYS%LPI' and not s0ixready and re.match('^[0\.]*$', val):
 				continue
 			out.append('%s=%s' % (key, val))
-		return '|'.join(out)
+		return (fp.returncode, '|'.join(out))
 	def netfixon(self, net='both'):
 		cmd = self.getExec('netfix')
 		if not cmd:
@@ -4343,7 +4343,8 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 		list[mode]['data'].append([data['host'], data['kernel'],
 			data['time'], tVal[0], tVal[1], data['url'], res,
 			data['issues'], data['sus_worst'], data['sus_worsttime'],
-			data['res_worst'], data['res_worsttime'], pkgpc10, syslpi, wifi])
+			data['res_worst'], data['res_worsttime'], pkgpc10, syslpi, wifi,
+			(data['fullmode'] if 'fullmode' in data else mode)])
 		idx = len(list[mode]['data']) - 1
 		if res.startswith('fail in'):
 			res = 'fail'
@@ -4449,7 +4450,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 				elif idx == iMed[i]:
 					tHigh[i] = ' id="%smed" class=medval title="Median"' % tag
 			html += td.format("%d" % (list[mode]['data'].index(d) + 1)) # row
-			html += td.format(mode)										# mode
+			html += td.format(d[15])									# mode
 			html += td.format(d[0])										# host
 			html += td.format(d[1])										# kernel
 			html += td.format(d[2])										# time
@@ -5524,7 +5525,9 @@ def executeSuspend(quiet=False):
 			if ((mode == 'freeze') or (sv.memmode == 's2idle')) \
 				and sv.haveTurbostat():
 				# execution will pause here
-				turbo = sv.turbostat(s0ixready)
+				retval, turbo = sv.turbostat(s0ixready)
+				if retval != 0:
+					tdata['error'] ='turbostat returned %d' % retval
 				if turbo:
 					tdata['turbo'] = turbo
 			else:
@@ -5532,6 +5535,7 @@ def executeSuspend(quiet=False):
 				pf.write(mode)
 				# execution will pause here
 				try:
+					pf.flush()
 					pf.close()
 				except Exception as e:
 					tdata['error'] = str(e)
@@ -5702,6 +5706,40 @@ def getModes():
 		fp.close()
 	return modes
 
+def dmidecode_backup(out, fatal=False):
+	cpath, spath, info = '/proc/cpuinfo', '/sys/class/dmi/id', {
+		'bios-vendor': 'bios_vendor',
+		'bios-version': 'bios_version',
+		'bios-release-date': 'bios_date',
+		'system-manufacturer': 'sys_vendor',
+		'system-product-name': 'product_name',
+		'system-version': 'product_version',
+		'system-serial-number': 'product_serial',
+		'baseboard-manufacturer': 'board_vendor',
+		'baseboard-product-name': 'board_name',
+		'baseboard-version': 'board_version',
+		'baseboard-serial-number': 'board_serial',
+		'chassis-manufacturer': 'chassis_vendor',
+		'chassis-version': 'chassis_version',
+		'chassis-serial-number': 'chassis_serial',
+	}
+	for key in info:
+		if key not in out:
+			val = sysvals.getVal(os.path.join(spath, info[key])).strip()
+			if val and val.lower() != 'to be filled by o.e.m.':
+				out[key] = val
+	if 'processor-version' not in out and os.path.exists(cpath):
+		with open(cpath, 'r') as fp:
+			for line in fp:
+				m = re.match('^model\s*name\s*\:\s*(?P<c>.*)', line)
+				if m:
+					out['processor-version'] = m.group('c').strip()
+					break
+	if fatal and len(out) < 1:
+		doError('dmidecode failed to get info from %s or %s' % \
+			(sysvals.mempath, spath))
+	return out
+
 # Function: dmidecode
 # Description:
 #	 Read the bios tables and pull out system info
@@ -5712,6 +5750,8 @@ def getModes():
 #	 A dict object with all available key/values
 def dmidecode(mempath, fatal=False):
 	out = dict()
+	if(not (os.path.exists(mempath) and os.access(mempath, os.R_OK))):
+		return dmidecode_backup(out, fatal)
 
 	# the list of values to retrieve, with hardcoded (type, idx)
 	info = {
@@ -5727,24 +5767,14 @@ def dmidecode(mempath, fatal=False):
 		'baseboard-version': (2, 6),
 		'baseboard-serial-number': (2, 7),
 		'chassis-manufacturer': (3, 4),
-		'chassis-type': (3, 5),
 		'chassis-version': (3, 6),
 		'chassis-serial-number': (3, 7),
 		'processor-manufacturer': (4, 7),
 		'processor-version': (4, 16),
 	}
-	if(not os.path.exists(mempath)):
-		if(fatal):
-			doError('file does not exist: %s' % mempath)
-		return out
-	if(not os.access(mempath, os.R_OK)):
-		if(fatal):
-			doError('file is not readable: %s' % mempath)
-		return out
 
 	# by default use legacy scan, but try to use EFI first
-	memaddr = 0xf0000
-	memsize = 0x10000
+	memaddr, memsize = 0xf0000, 0x10000
 	for ep in ['/sys/firmware/efi/systab', '/proc/efi/systab']:
 		if not os.path.exists(ep) or not os.access(ep, os.R_OK):
 			continue
@@ -5765,11 +5795,7 @@ def dmidecode(mempath, fatal=False):
 		fp.seek(memaddr)
 		buf = fp.read(memsize)
 	except:
-		if(fatal):
-			doError('DMI table is unreachable, sorry')
-		else:
-			pprint('WARNING: /dev/mem is not readable, ignoring DMI data')
-			return out
+		return dmidecode_backup(out, fatal)
 	fp.close()
 
 	# search for either an SM table or DMI table
@@ -5785,10 +5811,7 @@ def dmidecode(mempath, fatal=False):
 			break
 		i += 16
 	if base == 0 and length == 0 and num == 0:
-		if(fatal):
-			doError('Neither SMBIOS nor DMI were found')
-		else:
-			return out
+		return dmidecode_backup(out, fatal)
 
 	# read in the SM or DMI table
 	try:
@@ -5796,11 +5819,7 @@ def dmidecode(mempath, fatal=False):
 		fp.seek(base)
 		buf = fp.read(length)
 	except:
-		if(fatal):
-			doError('DMI table is unreachable, sorry')
-		else:
-			pprint('WARNING: /dev/mem is not readable, ignoring DMI data')
-			return out
+		return dmidecode_backup(out, fatal)
 	fp.close()
 
 	# scan the table for the values we want
@@ -6272,7 +6291,10 @@ def find_in_html(html, start, end, firstonly=True):
 	return out
 
 def data_from_html(file, outpath, issues, fulldetail=False):
-	html = open(file, 'r').read()
+	try:
+		html = open(file, 'r').read()
+	except:
+		html = ascii(open(file, 'rb').read())
 	sysvals.htmlfile = os.path.relpath(file, outpath)
 	# extract general info
 	suspend = find_in_html(html, 'Kernel Suspend', 'ms')
@@ -6307,8 +6329,9 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 		d.end = 999999999
 		d.dmesgtext = log.split('\n')
 		tp = d.extractErrorInfo()
-		for msg in tp.msglist:
-			sysvals.errorSummary(issues, msg)
+		if len(issues) < 100:
+			for msg in tp.msglist:
+				sysvals.errorSummary(issues, msg)
 		if stmp[2] == 'freeze':
 			extra = d.turbostatInfo()
 		elist = dict()
@@ -6325,6 +6348,11 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 		line = find_in_html(log, '# netfix ', '\n')
 		if line:
 			extra['netfix'] = line
+		line = find_in_html(log, '# command ', '\n')
+		if line:
+			m = re.match('.* -m (?P<m>\S*).*', line)
+			if m:
+				extra['fullmode'] = m.group('m')
 	low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
 	for lowstr in ['waking', '+']:
 		if not low:
-- 
2.17.1


