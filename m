Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BD9CC70
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfHZJTx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:19:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57511 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:19:53 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 21d99ebfc18f9d70; Mon, 26 Aug 2019 11:19:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        todd.e.brandt@intel.com
Subject: Re: [PATCH] pm-graph v5.5
Date:   Mon, 26 Aug 2019 11:19:49 +0200
Message-ID: <2198448.ccSuLOR8Uu@kreacher>
In-Reply-To: <0edc10b74082f8b0a2913a8474a83a210bae6a47.1565644024.git.todd.e.brandt@linux.intel.com>
References: <0edc10b74082f8b0a2913a8474a83a210bae6a47.1565644024.git.todd.e.brandt@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, August 12, 2019 11:08:44 PM CEST Todd Brandt wrote:
> Upgrade bootgraph/sleepgraph to be able to run on python2 and python3.
> Both now simply require python, the system can choose which to use.
> 
> bootgraph python3 update:
> - add floor function to handle integer arithmetic
> - change argument loop to use next() instead of args.next()
> - open dmesg log and popen in binary, use decode(ascii, ignore)
> - sort all html data to allow diff between python versions
> - change exception handler to use python3 as instead of comma
> 
> sleepgraph python3 update:
> - import configparser not ConfigParser (p2 needs python-configparser)
> - add floor function to handle integer arithmetic
> - change argument loop to use next() instead of args.next()
> - handle popen output in binary, use decode(ascii, ignore)
> - sort all html/output data to allow diff between python versions
> - force gzip open to use text mode, same for file open
> - ensure no binary data is written to logs (ascii convert devprops info)
> - use codecs library to handle zlib encoding for mcelog data
> - remove all uses of python3.7 keyword "async" as members or vars
> - assume all FPDT and DMI data is in binary string form
> 
> sleepgraph:
> - turbostat will be used by default if it's found & the mode is freeze
> - a new option "-noturbostat" will disable its use
> - fix bug where two callgraphs with the same start time overwrite.
> - fix s2idle processing where two suspend/resume_machines occur back2back
> - update getexec function to use which first (assuming PATH exists)
> - new platforminfo data in log with: lspci, gpe counts, /proc/interrupts
> - new data is zipped, b64 encoded, and tacked on the end of ftrace
> 
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> ---
>  tools/power/pm-graph/README        |   6 +-
>  tools/power/pm-graph/bootgraph.py  |  59 ++-
>  tools/power/pm-graph/sleepgraph.8  |   8 +-
>  tools/power/pm-graph/sleepgraph.py | 610 ++++++++++++++++-------------
>  4 files changed, 387 insertions(+), 296 deletions(-)
> 
> diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
> index 58a5591e3951..96259f6e5715 100644
> --- a/tools/power/pm-graph/README
> +++ b/tools/power/pm-graph/README
> @@ -1,7 +1,7 @@
>                       p m - g r a p h
>  
>     pm-graph: suspend/resume/boot timing analysis tools
> -    Version: 5.4
> +    Version: 5.5
>       Author: Todd Brandt <todd.e.brandt@intel.com>
>    Home Page: https://01.org/pm-graph
>  
> @@ -18,6 +18,10 @@
>  	- upstream version in git:
>  	  https://github.com/intel/pm-graph/
>  
> + Requirements:
> +	- runs with python2 or python3, choice is made by /usr/bin/python link
> +	- python2 now requires python-configparser be installed
> +
>   Table of Contents
>  	- Overview
>  	- Setup
> diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
> index 666bcbda648d..d3b99a1e92d6 100755
> --- a/tools/power/pm-graph/bootgraph.py
> +++ b/tools/power/pm-graph/bootgraph.py
> @@ -1,9 +1,18 @@
> -#!/usr/bin/python2
> +#!/usr/bin/python
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  # Tool for analyzing boot timing
>  # Copyright (c) 2013, Intel Corporation.
>  #
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms and conditions of the GNU General Public License,
> +# version 2, as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
>  # Authors:
>  #	 Todd Brandt <todd.e.brandt@linux.intel.com>
>  #
> @@ -81,7 +90,7 @@ class SystemValues(aslib.SystemValues):
>  		cmdline = 'initcall_debug log_buf_len=32M'
>  		if self.useftrace:
>  			if self.cpucount > 0:
> -				bs = min(self.memtotal / 2, 2*1024*1024) / self.cpucount
> +				bs = min(self.memtotal // 2, 2*1024*1024) // self.cpucount
>  			else:
>  				bs = 131072
>  			cmdline += ' trace_buf_size=%dK trace_clock=global '\
> @@ -137,13 +146,13 @@ class SystemValues(aslib.SystemValues):
>  			if arg in ['-h', '-v', '-cronjob', '-reboot', '-verbose']:
>  				continue
>  			elif arg in ['-o', '-dmesg', '-ftrace', '-func']:
> -				args.next()
> +				next(args)
>  				continue
>  			elif arg == '-result':
> -				cmdline += ' %s "%s"' % (arg, os.path.abspath(args.next()))
> +				cmdline += ' %s "%s"' % (arg, os.path.abspath(next(args)))
>  				continue
>  			elif arg == '-cgskip':
> -				file = self.configFile(args.next())
> +				file = self.configFile(next(args))
>  				cmdline += ' %s "%s"' % (arg, os.path.abspath(file))
>  				continue
>  			cmdline += ' '+arg
> @@ -292,11 +301,11 @@ def parseKernelLog():
>  	tp = aslib.TestProps()
>  	devtemp = dict()
>  	if(sysvals.dmesgfile):
> -		lf = open(sysvals.dmesgfile, 'r')
> +		lf = open(sysvals.dmesgfile, 'rb')
>  	else:
>  		lf = Popen('dmesg', stdout=PIPE).stdout
>  	for line in lf:
> -		line = line.replace('\r\n', '')
> +		line = aslib.ascii(line).replace('\r\n', '')
>  		# grab the stamp and sysinfo
>  		if re.match(tp.stampfmt, line):
>  			tp.stamp = line
> @@ -649,7 +658,7 @@ def createBootGraph(data):
>  		statinfo += '\t"%s": [\n\t\t"%s",\n' % (n, devstats[n]['info'])
>  		if 'fstat' in devstats[n]:
>  			funcs = devstats[n]['fstat']
> -			for f in sorted(funcs, key=funcs.get, reverse=True):
> +			for f in sorted(funcs, key=lambda k:(funcs[k], k), reverse=True):
>  				if funcs[f][0] < 0.01 and len(funcs) > 10:
>  					break
>  				statinfo += '\t\t"%f|%s|%d",\n' % (funcs[f][0], f, funcs[f][1])
> @@ -729,7 +738,7 @@ def updateCron(restore=False):
>  		op.write('@reboot python %s\n' % sysvals.cronjobCmdString())
>  		op.close()
>  		res = call([cmd, cronfile])
> -	except Exception, e:
> +	except Exception as e:
>  		pprint('Exception: %s' % str(e))
>  		shutil.move(backfile, cronfile)
>  		res = -1
> @@ -745,7 +754,7 @@ def updateGrub(restore=False):
>  		try:
>  			call(sysvals.blexec, stderr=PIPE, stdout=PIPE,
>  				env={'PATH': '.:/sbin:/usr/sbin:/usr/bin:/sbin:/bin'})
> -		except Exception, e:
> +		except Exception as e:
>  			pprint('Exception: %s\n' % str(e))
>  		return
>  	# extract the option and create a grub config without it
> @@ -792,7 +801,7 @@ def updateGrub(restore=False):
>  		op.close()
>  		res = call(sysvals.blexec)
>  		os.remove(grubfile)
> -	except Exception, e:
> +	except Exception as e:
>  		pprint('Exception: %s' % str(e))
>  		res = -1
>  	# cleanup
> @@ -866,6 +875,7 @@ def printHelp():
>  	'Other commands:\n'\
>  	'  -flistall     Print all functions capable of being captured in ftrace\n'\
>  	'  -sysinfo      Print out system info extracted from BIOS\n'\
> +	'  -which exec   Print an executable path, should function even without PATH\n'\
>  	' [redo]\n'\
>  	'  -dmesg file   Create HTML output using dmesg input (used with -ftrace)\n'\
>  	'  -ftrace file  Create HTML output using ftrace input (used with -dmesg)\n'\
> @@ -907,13 +917,13 @@ if __name__ == '__main__':
>  			sysvals.mincglen = aslib.getArgFloat('-mincg', args, 0.0, 10000.0)
>  		elif(arg == '-cgfilter'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No callgraph functions supplied', True)
>  			sysvals.setCallgraphFilter(val)
>  		elif(arg == '-cgskip'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No file supplied', True)
>  			if val.lower() in switchoff:
> @@ -924,7 +934,7 @@ if __name__ == '__main__':
>  					doError('%s does not exist' % cgskip)
>  		elif(arg == '-bl'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No boot loader name supplied', True)
>  			if val.lower() not in ['grub']:
> @@ -937,7 +947,7 @@ if __name__ == '__main__':
>  			sysvals.max_graph_depth = aslib.getArgInt('-maxdepth', args, 0, 1000)
>  		elif(arg == '-func'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No filter functions supplied', True)
>  			sysvals.useftrace = True
> @@ -946,7 +956,7 @@ if __name__ == '__main__':
>  			sysvals.setGraphFilter(val)
>  		elif(arg == '-ftrace'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No ftrace file supplied', True)
>  			if(os.path.exists(val) == False):
> @@ -959,7 +969,7 @@ if __name__ == '__main__':
>  			sysvals.cgexp = True
>  		elif(arg == '-dmesg'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No dmesg file supplied', True)
>  			if(os.path.exists(val) == False):
> @@ -968,13 +978,13 @@ if __name__ == '__main__':
>  			sysvals.dmesgfile = val
>  		elif(arg == '-o'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No subdirectory name supplied', True)
>  			sysvals.testdir = sysvals.setOutputFolder(val)
>  		elif(arg == '-result'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No result file supplied', True)
>  			sysvals.result = val
> @@ -986,6 +996,17 @@ if __name__ == '__main__':
>  		# remaining options are only for cron job use
>  		elif(arg == '-cronjob'):
>  			sysvals.iscronjob = True
> +		elif(arg == '-which'):
> +			try:
> +				val = next(args)
> +			except:
> +				doError('No executable supplied', True)
> +			out = sysvals.getExec(val)
> +			if not out:
> +				print('%s not found' % val)
> +				sys.exit(1)
> +			print(out)
> +			sys.exit(0)
>  		else:
>  			doError('Invalid argument: '+arg, True)
>  
> diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
> index 9648be644d5f..43aee64316df 100644
> --- a/tools/power/pm-graph/sleepgraph.8
> +++ b/tools/power/pm-graph/sleepgraph.8
> @@ -53,10 +53,10 @@ disable rtcwake and require a user keypress to resume.
>  Add the dmesg and ftrace logs to the html output. They will be viewable by
>  clicking buttons in the timeline.
>  .TP
> -\fB-turbostat\fR
> -Use turbostat to execute the command in freeze mode (default: disabled). This
> -will provide turbostat output in the log which will tell you which actual
> -power modes were entered.
> +\fB-noturbostat\fR
> +By default, if turbostat is found and the requested mode is freeze, sleepgraph
> +will execute the suspend via turbostat and collect data in the timeline log.
> +This option disables the use of turbostat.
>  .TP
>  \fB-result \fIfile\fR
>  Export a results table to a text file for parsing.
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
> index 4f46a7a1feb6..1794c79a7d1b 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -1,9 +1,18 @@
> -#!/usr/bin/python2
> +#!/usr/bin/python
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  # Tool for analyzing suspend/resume timing
>  # Copyright (c) 2013, Intel Corporation.
>  #
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms and conditions of the GNU General Public License,
> +# version 2, as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
>  # Authors:
>  #	 Todd Brandt <todd.e.brandt@linux.intel.com>
>  #
> @@ -48,9 +57,10 @@ import string
>  import re
>  import platform
>  import signal
> +import codecs
>  from datetime import datetime
>  import struct
> -import ConfigParser
> +import configparser
>  import gzip
>  from threading import Thread
>  from subprocess import call, Popen, PIPE
> @@ -60,6 +70,9 @@ def pprint(msg):
>  	print(msg)
>  	sys.stdout.flush()
>  
> +def ascii(text):
> +	return text.decode('ascii', 'ignore')
> +
>  # ----------------- CLASSES --------------------
>  
>  # Class: SystemValues
> @@ -68,7 +81,7 @@ def pprint(msg):
>  #	 store system values and test parameters
>  class SystemValues:
>  	title = 'SleepGraph'
> -	version = '5.4'
> +	version = '5.5'
>  	ansi = False
>  	rs = 0
>  	display = ''
> @@ -78,7 +91,7 @@ class SystemValues:
>  	testlog = True
>  	dmesglog = True
>  	ftracelog = False
> -	tstat = False
> +	tstat = True
>  	mindevlen = 0.0
>  	mincglen = 0.0
>  	cgphase = ''
> @@ -147,6 +160,7 @@ class SystemValues:
>  	devdump = False
>  	mixedphaseheight = True
>  	devprops = dict()
> +	platinfo = []
>  	predelay = 0
>  	postdelay = 0
>  	pmdebug = ''
> @@ -323,13 +337,20 @@ class SystemValues:
>  			sys.exit(1)
>  		return False
>  	def getExec(self, cmd):
> -		dirlist = ['/sbin', '/bin', '/usr/sbin', '/usr/bin',
> -			'/usr/local/sbin', '/usr/local/bin']
> -		for path in dirlist:
> +		try:
> +			fp = Popen(['which', cmd], stdout=PIPE, stderr=PIPE).stdout
> +			out = ascii(fp.read()).strip()
> +			fp.close()
> +		except:
> +			out = ''
> +		if out:
> +			return out
> +		for path in ['/sbin', '/bin', '/usr/sbin', '/usr/bin',
> +			'/usr/local/sbin', '/usr/local/bin']:
>  			cmdfull = os.path.join(path, cmd)
>  			if os.path.exists(cmdfull):
>  				return cmdfull
> -		return ''
> +		return out
>  	def setPrecision(self, num):
>  		if num < 0 or num > 6:
>  			return
> @@ -455,7 +476,7 @@ class SystemValues:
>  		fp = Popen('dmesg', stdout=PIPE).stdout
>  		ktime = '0'
>  		for line in fp:
> -			line = line.replace('\r\n', '')
> +			line = ascii(line).replace('\r\n', '')
>  			idx = line.find('[')
>  			if idx > 1:
>  				line = line[idx:]
> @@ -469,7 +490,7 @@ class SystemValues:
>  		# store all new dmesg lines since initdmesg was called
>  		fp = Popen('dmesg', stdout=PIPE).stdout
>  		for line in fp:
> -			line = line.replace('\r\n', '')
> +			line = ascii(line).replace('\r\n', '')
>  			idx = line.find('[')
>  			if idx > 1:
>  				line = line[idx:]
> @@ -501,7 +522,7 @@ class SystemValues:
>  			call('cat '+self.tpath+'available_filter_functions', shell=True)
>  			return
>  		master = self.listFromFile(self.tpath+'available_filter_functions')
> -		for i in self.tracefuncs:
> +		for i in sorted(self.tracefuncs):
>  			if 'func' in self.tracefuncs[i]:
>  				i = self.tracefuncs[i]['func']
>  			if i in master:
> @@ -628,7 +649,7 @@ class SystemValues:
>  		self.fsetVal(kprobeevents, 'kprobe_events')
>  		if output:
>  			check = self.fgetVal('kprobe_events')
> -			linesack = (len(check.split('\n')) - 1) / 2
> +			linesack = (len(check.split('\n')) - 1) // 2
>  			pprint('    kprobe functions enabled: %d/%d' % (linesack, linesout))
>  		self.fsetVal('1', 'events/kprobes/enable')
>  	def testKprobe(self, kname, kprobe):
> @@ -650,7 +671,7 @@ class SystemValues:
>  		if not os.path.exists(file):
>  			return False
>  		try:
> -			fp = open(file, mode, 0)
> +			fp = open(file, mode)
>  			fp.write(val)
>  			fp.flush()
>  			fp.close()
> @@ -719,7 +740,7 @@ class SystemValues:
>  			tgtsize = min(self.memfree, bmax)
>  		else:
>  			tgtsize = 65536
> -		while not self.fsetVal('%d' % (tgtsize / cpus), 'buffer_size_kb'):
> +		while not self.fsetVal('%d' % (tgtsize // cpus), 'buffer_size_kb'):
>  			# if the size failed to set, lower it and keep trying
>  			tgtsize -= 65536
>  			if tgtsize < 65536:
> @@ -863,14 +884,23 @@ class SystemValues:
>  		isgz = self.gzip
>  		if mode == 'r':
>  			try:
> -				with gzip.open(filename, mode+'b') as fp:
> +				with gzip.open(filename, mode+'t') as fp:
>  					test = fp.read(64)
>  				isgz = True
>  			except:
>  				isgz = False
>  		if isgz:
> -			return gzip.open(filename, mode+'b')
> +			return gzip.open(filename, mode+'t')
>  		return open(filename, mode)
> +	def b64unzip(self, data):
> +		try:
> +			out = codecs.decode(base64.b64decode(data), 'zlib').decode()
> +		except:
> +			out = data
> +		return out
> +	def b64zip(self, data):
> +		out = base64.b64encode(codecs.encode(data.encode(), 'zlib')).decode()
> +		return out
>  	def mcelog(self, clear=False):
>  		cmd = self.getExec('mcelog')
>  		if not cmd:
> @@ -878,12 +908,124 @@ class SystemValues:
>  		if clear:
>  			call(cmd+' > /dev/null 2>&1', shell=True)
>  			return ''
> -		fp = Popen([cmd], stdout=PIPE, stderr=PIPE).stdout
> -		out = fp.read().strip()
> -		fp.close()
> +		try:
> +			fp = Popen([cmd], stdout=PIPE, stderr=PIPE).stdout
> +			out = ascii(fp.read()).strip()
> +			fp.close()
> +		except:
> +			return ''
>  		if not out:
>  			return ''
> -		return base64.b64encode(out.encode('zlib'))
> +		return self.b64zip(out)
> +	def platforminfo(self):
> +		# add platform info on to a completed ftrace file
> +		if not os.path.exists(self.ftracefile):
> +			return False
> +		footer = '#\n'
> +
> +		# add test command string line if need be
> +		if self.suspendmode == 'command' and self.testcommand:
> +			footer += '# platform-testcmd: %s\n' % (self.testcommand)
> +
> +		# get a list of target devices from the ftrace file
> +		props = dict()
> +		tp = TestProps()
> +		tf = self.openlog(self.ftracefile, 'r')
> +		for line in tf:
> +			# determine the trace data type (required for further parsing)
> +			m = re.match(tp.tracertypefmt, line)
> +			if(m):
> +				tp.setTracerType(m.group('t'))
> +				continue
> +			# parse only valid lines, if this is not one move on
> +			m = re.match(tp.ftrace_line_fmt, line)
> +			if(not m or 'device_pm_callback_start' not in line):
> +				continue
> +			m = re.match('.*: (?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*', m.group('msg'));
> +			if(not m):
> +				continue
> +			dev = m.group('d')
> +			if dev not in props:
> +				props[dev] = DevProps()
> +		tf.close()
> +
> +		# now get the syspath for each target device
> +		for dirname, dirnames, filenames in os.walk('/sys/devices'):
> +			if(re.match('.*/power', dirname) and 'async' in filenames):
> +				dev = dirname.split('/')[-2]
> +				if dev in props and (not props[dev].syspath or len(dirname) < len(props[dev].syspath)):
> +					props[dev].syspath = dirname[:-6]
> +
> +		# now fill in the properties for our target devices
> +		for dev in sorted(props):
> +			dirname = props[dev].syspath
> +			if not dirname or not os.path.exists(dirname):
> +				continue
> +			with open(dirname+'/power/async') as fp:
> +				text = fp.read()
> +				props[dev].isasync = False
> +				if 'enabled' in text:
> +					props[dev].isasync = True
> +			fields = os.listdir(dirname)
> +			if 'product' in fields:
> +				with open(dirname+'/product', 'rb') as fp:
> +					props[dev].altname = ascii(fp.read())
> +			elif 'name' in fields:
> +				with open(dirname+'/name', 'rb') as fp:
> +					props[dev].altname = ascii(fp.read())
> +			elif 'model' in fields:
> +				with open(dirname+'/model', 'rb') as fp:
> +					props[dev].altname = ascii(fp.read())
> +			elif 'description' in fields:
> +				with open(dirname+'/description', 'rb') as fp:
> +					props[dev].altname = ascii(fp.read())
> +			elif 'id' in fields:
> +				with open(dirname+'/id', 'rb') as fp:
> +					props[dev].altname = ascii(fp.read())
> +			elif 'idVendor' in fields and 'idProduct' in fields:
> +				idv, idp = '', ''
> +				with open(dirname+'/idVendor', 'rb') as fp:
> +					idv = ascii(fp.read()).strip()
> +				with open(dirname+'/idProduct', 'rb') as fp:
> +					idp = ascii(fp.read()).strip()
> +				props[dev].altname = '%s:%s' % (idv, idp)
> +			if props[dev].altname:
> +				out = props[dev].altname.strip().replace('\n', ' ')\
> +					.replace(',', ' ').replace(';', ' ')
> +				props[dev].altname = out
> +
> +		# add a devinfo line to the bottom of ftrace
> +		out = ''
> +		for dev in sorted(props):
> +			out += props[dev].out(dev)
> +		footer += '# platform-devinfo: %s\n' % self.b64zip(out)
> +
> +		# add a line for each of these commands with their outputs
> +		cmds = [
> +			['pcidevices', 'lspci', '-tv'],
> +			['interrupts', 'cat', '/proc/interrupts'],
> +			['gpecounts', 'sh', '-c', 'grep -v invalid /sys/firmware/acpi/interrupts/gpe*'],
> +		]
> +		for cargs in cmds:
> +			name = cargs[0]
> +			cmdline = ' '.join(cargs[1:])
> +			cmdpath = self.getExec(cargs[1])
> +			if not cmdpath:
> +				continue
> +			cmd = [cmdpath] + cargs[2:]
> +			try:
> +				fp = Popen(cmd, stdout=PIPE, stderr=PIPE).stdout
> +				info = ascii(fp.read()).strip()
> +				fp.close()
> +			except:
> +				continue
> +			if not info:
> +				continue
> +			footer += '# platform-%s: %s | %s\n' % (name, cmdline, self.b64zip(info))
> +
> +		with self.openlog(self.ftracefile, 'a') as fp:
> +			fp.write(footer)
> +		return True
>  	def haveTurbostat(self):
>  		if not self.tstat:
>  			return False
> @@ -891,31 +1033,40 @@ class SystemValues:
>  		if not cmd:
>  			return False
>  		fp = Popen([cmd, '-v'], stdout=PIPE, stderr=PIPE).stderr
> -		out = fp.read().strip()
> +		out = ascii(fp.read()).strip()
>  		fp.close()
> -		return re.match('turbostat version [0-9\.]* .*', out)
> +		if re.match('turbostat version [0-9\.]* .*', out):
> +			sysvals.vprint(out)
> +			return True
> +		return False
>  	def turbostat(self):
>  		cmd = self.getExec('turbostat')
> -		if not cmd:
> -			return 'missing turbostat executable'
> -		text = []
> +		rawout = keyline = valline = ''
>  		fullcmd = '%s -q -S echo freeze > %s' % (cmd, self.powerfile)
>  		fp = Popen(['sh', '-c', fullcmd], stdout=PIPE, stderr=PIPE).stderr
>  		for line in fp:
> -			if re.match('[0-9.]* sec', line):
> +			line = ascii(line)
> +			rawout += line
> +			if keyline and valline:
>  				continue
> -			text.append(line.split())
> +			if re.match('(?i)Avg_MHz.*', line):
> +				keyline = line.strip().split()
> +			elif keyline:
> +				valline = line.strip().split()
>  		fp.close()
> -		if len(text) < 2:
> -			return 'turbostat output format error'
> +		if not keyline or not valline or len(keyline) != len(valline):
> +			errmsg = 'unrecognized turbostat output:\n'+rawout.strip()
> +			sysvals.vprint(errmsg)
> +			if not sysvals.verbose:
> +				pprint(errmsg)
> +			return ''
> +		if sysvals.verbose:
> +			pprint(rawout.strip())
>  		out = []
> -		for key in text[0]:
> -			values = []
> -			idx = text[0].index(key)
> -			for line in text[1:]:
> -				if len(line) > idx:
> -					values.append(line[idx])
> -			out.append('%s=%s' % (key, ','.join(values)))
> +		for key in keyline:
> +			idx = keyline.index(key)
> +			val = valline[idx]
> +			out.append('%s=%s' % (key, val))
>  		return '|'.join(out)
>  	def checkWifi(self):
>  		out = dict()
> @@ -924,7 +1075,7 @@ class SystemValues:
>  			return out
>  		fp = Popen(iwcmd, stdout=PIPE, stderr=PIPE).stdout
>  		for line in fp:
> -			m = re.match('(?P<dev>\S*) .* ESSID:(?P<ess>\S*)', line)
> +			m = re.match('(?P<dev>\S*) .* ESSID:(?P<ess>\S*)', ascii(line))
>  			if not m:
>  				continue
>  			out['device'] = m.group('dev')
> @@ -935,7 +1086,7 @@ class SystemValues:
>  		if 'device' in out:
>  			fp = Popen([ifcmd, out['device']], stdout=PIPE, stderr=PIPE).stdout
>  			for line in fp:
> -				m = re.match('.* inet (?P<ip>[0-9\.]*)', line)
> +				m = re.match('.* inet (?P<ip>[0-9\.]*)', ascii(line))
>  				if m:
>  					out['ip'] = m.group('ip')
>  					break
> @@ -990,13 +1141,13 @@ class DevProps:
>  	def __init__(self):
>  		self.syspath = ''
>  		self.altname = ''
> -		self.async = True
> +		self.isasync = True
>  		self.xtraclass = ''
>  		self.xtrainfo = ''
>  	def out(self, dev):
> -		return '%s,%s,%d;' % (dev, self.altname, self.async)
> +		return '%s,%s,%d;' % (dev, self.altname, self.isasync)
>  	def debug(self, dev):
> -		pprint('%s:\n\taltname = %s\n\t  async = %s' % (dev, self.altname, self.async))
> +		pprint('%s:\n\taltname = %s\n\t  async = %s' % (dev, self.altname, self.isasync))
>  	def altName(self, dev):
>  		if not self.altname or self.altname == dev:
>  			return dev
> @@ -1004,13 +1155,13 @@ class DevProps:
>  	def xtraClass(self):
>  		if self.xtraclass:
>  			return ' '+self.xtraclass
> -		if not self.async:
> +		if not self.isasync:
>  			return ' sync'
>  		return ''
>  	def xtraInfo(self):
>  		if self.xtraclass:
>  			return ' '+self.xtraclass
> -		if self.async:
> +		if self.isasync:
>  			return ' async_device'
>  		return ' sync_device'
>  
> @@ -1108,7 +1259,7 @@ class Data:
>  		return sorted(self.dmesg, key=lambda k:self.dmesg[k]['order'])
>  	def initDevicegroups(self):
>  		# called when phases are all finished being added
> -		for phase in self.dmesg.keys():
> +		for phase in sorted(self.dmesg.keys()):
>  			if '*' in phase:
>  				p = phase.split('*')
>  				pnew = '%s%d' % (p[0], len(p))
> @@ -1430,16 +1581,7 @@ class Data:
>  		return phase
>  	def sortedDevices(self, phase):
>  		list = self.dmesg[phase]['list']
> -		slist = []
> -		tmp = dict()
> -		for devname in list:
> -			dev = list[devname]
> -			if dev['length'] == 0:
> -				continue
> -			tmp[dev['start']] = devname
> -		for t in sorted(tmp):
> -			slist.append(tmp[t])
> -		return slist
> +		return sorted(list, key=lambda k:list[k]['start'])
>  	def fixupInitcalls(self, phase):
>  		# if any calls never returned, clip them at system resume end
>  		phaselist = self.dmesg[phase]['list']
> @@ -1576,7 +1718,7 @@ class Data:
>  				maxname = '%d' % self.maxDeviceNameSize(phase)
>  				fmt = '%3d) %'+maxname+'s - %f - %f'
>  				c = 1
> -				for name in devlist:
> +				for name in sorted(devlist):
>  					s = devlist[name]['start']
>  					e = devlist[name]['end']
>  					sysvals.vprint(fmt % (c, name, s, e))
> @@ -1588,7 +1730,7 @@ class Data:
>  		devlist = []
>  		for phase in self.sortedPhases():
>  			list = self.deviceChildren(devname, phase)
> -			for dev in list:
> +			for dev in sorted(list):
>  				if dev not in devlist:
>  					devlist.append(dev)
>  		return devlist
> @@ -1628,16 +1770,16 @@ class Data:
>  	def rootDeviceList(self):
>  		# list of devices graphed
>  		real = []
> -		for phase in self.dmesg:
> +		for phase in self.sortedPhases():
>  			list = self.dmesg[phase]['list']
> -			for dev in list:
> +			for dev in sorted(list):
>  				if list[dev]['pid'] >= 0 and dev not in real:
>  					real.append(dev)
>  		# list of top-most root devices
>  		rootlist = []
> -		for phase in self.dmesg:
> +		for phase in self.sortedPhases():
>  			list = self.dmesg[phase]['list']
> -			for dev in list:
> +			for dev in sorted(list):
>  				pdev = list[dev]['par']
>  				pid = list[dev]['pid']
>  				if(pid < 0 or re.match('[0-9]*-[0-9]*\.[0-9]*[\.0-9]*\:[\.0-9]*$', pdev)):
> @@ -1718,9 +1860,9 @@ class Data:
>  	def createProcessUsageEvents(self):
>  		# get an array of process names
>  		proclist = []
> -		for t in self.pstl:
> +		for t in sorted(self.pstl):
>  			pslist = self.pstl[t]
> -			for ps in pslist:
> +			for ps in sorted(pslist):
>  				if ps not in proclist:
>  					proclist.append(ps)
>  		# get a list of data points for suspend and resume
> @@ -1765,7 +1907,7 @@ class Data:
>  	def debugPrint(self):
>  		for p in self.sortedPhases():
>  			list = self.dmesg[p]['list']
> -			for devname in list:
> +			for devname in sorted(list):
>  				dev = list[devname]
>  				if 'ftrace' in dev:
>  					dev['ftrace'].debugPrint(' [%s]' % devname)
> @@ -2466,7 +2608,7 @@ class Timeline:
>  		# if there is 1 line per row, draw them the standard way
>  		for t, p in standardphases:
>  			for i in sorted(self.rowheight[t][p]):
> -				self.rowheight[t][p][i] = self.bodyH/len(self.rowlines[t][p])
> +				self.rowheight[t][p][i] = float(self.bodyH)/len(self.rowlines[t][p])
>  	def createZoomBox(self, mode='command', testcount=1):
>  		# Create bounding box, add buttons
>  		html_zoombox = '<center><button id="zoomin">ZOOM IN +</button><button id="zoomout">ZOOM OUT -</button><button id="zoomdef">ZOOM 1:1</button></center>\n'
> @@ -2537,6 +2679,7 @@ class TestProps:
>  	cmdlinefmt = '^# command \| (?P<cmd>.*)'
>  	kparamsfmt = '^# kparams \| (?P<kp>.*)'
>  	devpropfmt = '# Device Properties: .*'
> +	pinfofmt   = '# platform-(?P<val>[a-z,A-Z,0-9]*): (?P<info>.*)'
>  	tracertypefmt = '# tracer: (?P<t>.*)'
>  	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
>  	procexecfmt = 'ps - (?P<ps>.*)$'
> @@ -2571,12 +2714,6 @@ class TestProps:
>  			self.ftrace_line_fmt = self.ftrace_line_fmt_nop
>  		else:
>  			doError('Invalid tracer format: [%s]' % tracer)
> -	def decode(self, data):
> -		try:
> -			out = base64.b64decode(data).decode('zlib')
> -		except:
> -			out = data
> -		return out
>  	def stampInfo(self, line):
>  		if re.match(self.stampfmt, line):
>  			self.stamp = line
> @@ -2660,7 +2797,7 @@ class TestProps:
>  		if len(self.mcelog) > data.testnumber:
>  			m = re.match(self.mcelogfmt, self.mcelog[data.testnumber])
>  			if m:
> -				data.mcelog = self.decode(m.group('m'))
> +				data.mcelog = sv.b64unzip(m.group('m'))
>  		# turbostat data
>  		if len(self.turbostat) > data.testnumber:
>  			m = re.match(self.tstatfmt, self.turbostat[data.testnumber])
> @@ -2681,6 +2818,46 @@ class TestProps:
>  			m = re.match(self.testerrfmt, self.testerror[data.testnumber])
>  			if m:
>  				data.enterfail = m.group('e')
> +	def devprops(self, data):
> +		props = dict()
> +		devlist = data.split(';')
> +		for dev in devlist:
> +			f = dev.split(',')
> +			if len(f) < 3:
> +				continue
> +			dev = f[0]
> +			props[dev] = DevProps()
> +			props[dev].altname = f[1]
> +			if int(f[2]):
> +				props[dev].isasync = True
> +			else:
> +				props[dev].isasync = False
> +		return props
> +	def parseDevprops(self, line, sv):
> +		idx = line.index(': ') + 2
> +		if idx >= len(line):
> +			return
> +		props = self.devprops(line[idx:])
> +		if sv.suspendmode == 'command' and 'testcommandstring' in props:
> +			sv.testcommand = props['testcommandstring'].altname
> +		sv.devprops = props
> +	def parsePlatformInfo(self, line, sv):
> +		m = re.match(self.pinfofmt, line)
> +		if not m:
> +			return
> +		name, info = m.group('val'), m.group('info')
> +		if name == 'devinfo':
> +			sv.devprops = self.devprops(sv.b64unzip(info))
> +			return
> +		elif name == 'testcmd':
> +			sv.testcommand = info
> +			return
> +		field = info.split('|')
> +		if len(field) < 2:
> +			return
> +		cmdline = field[0].strip()
> +		output = sv.b64unzip(field[1].strip())
> +		sv.platinfo.append([name, cmdline, output])
>  
>  # Class: TestRun
>  # Description:
> @@ -2701,7 +2878,7 @@ class ProcessMonitor:
>  		process = Popen(c, shell=True, stdout=PIPE)
>  		running = dict()
>  		for line in process.stdout:
> -			data = line.split()
> +			data = ascii(line).split()
>  			pid = data[0]
>  			name = re.sub('[()]', '', data[1])
>  			user = int(data[13])
> @@ -2805,7 +2982,11 @@ def appendIncompleteTraceLog(testruns):
>  			continue
>  		# device properties line
>  		if(re.match(tp.devpropfmt, line)):
> -			devProps(line)
> +			tp.parseDevprops(line, sysvals)
> +			continue
> +		# platform info line
> +		if(re.match(tp.pinfofmt, line)):
> +			tp.parsePlatformInfo(line, sysvals)
>  			continue
>  		# parse only valid lines, if this is not one move on
>  		m = re.match(tp.ftrace_line_fmt, line)
> @@ -2902,7 +3083,7 @@ def parseTraceLog(live=False):
>  		sysvals.setupAllKprobes()
>  	ksuscalls = ['pm_prepare_console']
>  	krescalls = ['pm_restore_console']
> -	tracewatch = []
> +	tracewatch = ['irq_wakeup']
>  	if sysvals.usekprobes:
>  		tracewatch += ['sync_filesystems', 'freeze_processes', 'syscore_suspend',
>  			'syscore_resume', 'resume_console', 'thaw_processes', 'CPU_ON',
> @@ -2928,7 +3109,11 @@ def parseTraceLog(live=False):
>  			continue
>  		# device properties line
>  		if(re.match(tp.devpropfmt, line)):
> -			devProps(line)
> +			tp.parseDevprops(line, sysvals)
> +			continue
> +		# platform info line
> +		if(re.match(tp.pinfofmt, line)):
> +			tp.parsePlatformInfo(line, sysvals)
>  			continue
>  		# ignore all other commented lines
>  		if line[0] == '#':
> @@ -3001,16 +3186,11 @@ def parseTraceLog(live=False):
>  					isbegin = False
>  				else:
>  					continue
> -				m = re.match('(?P<name>.*)\[(?P<val>[0-9]*)\] .*', t.name)
> -				if(m):
> -					val = m.group('val')
> -					if val == '0':
> -						name = m.group('name')
> -					else:
> -						name = m.group('name')+'['+val+']'
> +				if '[' in t.name:
> +					m = re.match('(?P<name>.*)\[.*', t.name)
>  				else:
>  					m = re.match('(?P<name>.*) .*', t.name)
> -					name = m.group('name')
> +				name = m.group('name')
>  				# ignore these events
>  				if(name.split('[')[0] in tracewatch):
>  					continue
> @@ -3045,6 +3225,8 @@ def parseTraceLog(live=False):
>  				elif(re.match('machine_suspend\[.*', t.name)):
>  					if(isbegin):
>  						lp = data.lastPhase()
> +						if lp == 'resume_machine':
> +							data.dmesg[lp]['end'] = t.time
>  						phase = data.setPhase('suspend_machine', data.dmesg[lp]['end'], True)
>  						data.setPhase(phase, t.time, False)
>  						if data.tSuspended == 0:
> @@ -3213,11 +3395,11 @@ def parseTraceLog(live=False):
>  		# add the traceevent data to the device hierarchy
>  		if(sysvals.usetraceevents):
>  			# add actual trace funcs
> -			for name in test.ttemp:
> +			for name in sorted(test.ttemp):
>  				for event in test.ttemp[name]:
>  					data.newActionGlobal(name, event['begin'], event['end'], event['pid'])
>  			# add the kprobe based virtual tracefuncs as actual devices
> -			for key in tp.ktemp:
> +			for key in sorted(tp.ktemp):
>  				name, pid = key
>  				if name not in sysvals.tracefuncs:
>  					continue
> @@ -3231,7 +3413,7 @@ def parseTraceLog(live=False):
>  					data.newActionGlobal(e['name'], kb, ke, pid, color)
>  			# add config base kprobes and dev kprobes
>  			if sysvals.usedevsrc:
> -				for key in tp.ktemp:
> +				for key in sorted(tp.ktemp):
>  					name, pid = key
>  					if name in sysvals.tracefuncs or name not in sysvals.dev_tracefuncs:
>  						continue
> @@ -3244,7 +3426,7 @@ def parseTraceLog(live=False):
>  		if sysvals.usecallgraph:
>  			# add the callgraph data to the device hierarchy
>  			sortlist = dict()
> -			for key in test.ftemp:
> +			for key in sorted(test.ftemp):
>  				proc, pid = key
>  				for cg in test.ftemp[key]:
>  					if len(cg.list) < 1 or cg.invalid or (cg.end - cg.start == 0):
> @@ -3582,7 +3764,7 @@ def parseKernelLog(data):
>  		# if trace events are not available, these are better than nothing
>  		if(not sysvals.usetraceevents):
>  			# look for known actions
> -			for a in at:
> +			for a in sorted(at):
>  				if(re.match(at[a]['smsg'], msg)):
>  					if(a not in actions):
>  						actions[a] = []
> @@ -3641,7 +3823,7 @@ def parseKernelLog(data):
>  		data.tResumed = data.tSuspended
>  
>  	# fill in any actions we've found
> -	for name in actions:
> +	for name in sorted(actions):
>  		for event in actions[name]:
>  			data.newActionGlobal(name, event['begin'], event['end'])
>  
> @@ -3761,7 +3943,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
>  		if lastmode and lastmode != mode and num > 0:
>  			for i in range(2):
>  				s = sorted(tMed[i])
> -				list[lastmode]['med'][i] = s[int(len(s)/2)]
> +				list[lastmode]['med'][i] = s[int(len(s)//2)]
>  				iMed[i] = tMed[i][list[lastmode]['med'][i]]
>  			list[lastmode]['avg'] = [tAvg[0] / num, tAvg[1] / num]
>  			list[lastmode]['min'] = tMin
> @@ -3803,7 +3985,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
>  	if lastmode and num > 0:
>  		for i in range(2):
>  			s = sorted(tMed[i])
> -			list[lastmode]['med'][i] = s[int(len(s)/2)]
> +			list[lastmode]['med'][i] = s[int(len(s)//2)]
>  			iMed[i] = tMed[i][list[lastmode]['med'][i]]
>  		list[lastmode]['avg'] = [tAvg[0] / num, tAvg[1] / num]
>  		list[lastmode]['min'] = tMin
> @@ -3845,7 +4027,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
>  		'</tr>\n'
>  	headnone = '<tr class="head"><td>{0}</td><td>{1}</td><td colspan='+\
>  		colspan+'></td></tr>\n'
> -	for mode in list:
> +	for mode in sorted(list):
>  		# header line for each suspend mode
>  		num = 0
>  		tAvg, tMin, tMax, tMed = list[mode]['avg'], list[mode]['min'],\
> @@ -3944,7 +4126,8 @@ def createHTMLDeviceSummary(testruns, htmlfile, title):
>  			th.format('Average Time') + th.format('Count') +\
>  			th.format('Worst Time') + th.format('Host (worst time)') +\
>  			th.format('Link (worst time)') + '</tr>\n'
> -		for name in sorted(devlist, key=lambda k:devlist[k]['worst'], reverse=True):
> +		for name in sorted(devlist, key=lambda k:(devlist[k]['worst'], \
> +			devlist[k]['total'], devlist[k]['name']), reverse=True):
>  			data = devall[type][name]
>  			data['average'] = data['total'] / data['count']
>  			if data['average'] < limit:
> @@ -4085,7 +4268,7 @@ def createHTML(testruns, testfail):
>  		if(tTotal == 0):
>  			doError('No timeline data')
>  		if(len(data.tLow) > 0):
> -			low_time = '|'.join(data.tLow)
> +			low_time = '+'.join(data.tLow)
>  		if sysvals.suspendmode == 'command':
>  			run_time = '%.0f'%((data.end-data.start)*1000)
>  			if sysvals.testcommand:
> @@ -4151,7 +4334,7 @@ def createHTML(testruns, testfail):
>  		for group in data.devicegroups:
>  			devlist = []
>  			for phase in group:
> -				for devname in data.tdevlist[phase]:
> +				for devname in sorted(data.tdevlist[phase]):
>  					d = DevItem(data.testnumber, phase, data.dmesg[phase]['list'][devname])
>  					devlist.append(d)
>  					if d.isa('kth'):
> @@ -4230,7 +4413,7 @@ def createHTML(testruns, testfail):
>  			for b in phases[dir]:
>  				# draw the devices for this phase
>  				phaselist = data.dmesg[b]['list']
> -				for d in data.tdevlist[b]:
> +				for d in sorted(data.tdevlist[b]):
>  					name = d
>  					drv = ''
>  					dev = phaselist[d]
> @@ -4971,13 +5154,9 @@ def executeSuspend():
>  			if mode == 'freeze' and sysvals.haveTurbostat():
>  				# execution will pause here
>  				turbo = sysvals.turbostat()
> -				if '|' in turbo:
> +				if turbo:
>  					tdata['turbo'] = turbo
> -				else:
> -					tdata['error'] = turbo
>  			else:
> -				if sysvals.haveTurbostat():
> -					sysvals.vprint('WARNING: ignoring turbostat in mode "%s"' % mode)
>  				pf = open(sysvals.powerfile, 'w')
>  				pf.write(mode)
>  				# execution will pause here
> @@ -5024,7 +5203,7 @@ def executeSuspend():
>  			op.write(line)
>  		op.close()
>  		sysvals.fsetVal('', 'trace')
> -		devProps()
> +		sysvals.platforminfo()
>  	return testdata
>  
>  def readFile(file):
> @@ -5040,9 +5219,9 @@ def readFile(file):
>  #	 The time string, e.g. "1901m16s"
>  def ms2nice(val):
>  	val = int(val)
> -	h = val / 3600000
> -	m = (val / 60000) % 60
> -	s = (val / 1000) % 60
> +	h = val // 3600000
> +	m = (val // 60000) % 60
> +	s = (val // 1000) % 60
>  	if h > 0:
>  		return '%d:%02d:%02d' % (h, m, s)
>  	if m > 0:
> @@ -5115,127 +5294,6 @@ def deviceInfo(output=''):
>  		print(lines[i])
>  	return res
>  
> -# Function: devProps
> -# Description:
> -#	 Retrieve a list of properties for all devices in the trace log
> -def devProps(data=0):
> -	props = dict()
> -
> -	if data:
> -		idx = data.index(': ') + 2
> -		if idx >= len(data):
> -			return
> -		devlist = data[idx:].split(';')
> -		for dev in devlist:
> -			f = dev.split(',')
> -			if len(f) < 3:
> -				continue
> -			dev = f[0]
> -			props[dev] = DevProps()
> -			props[dev].altname = f[1]
> -			if int(f[2]):
> -				props[dev].async = True
> -			else:
> -				props[dev].async = False
> -			sysvals.devprops = props
> -		if sysvals.suspendmode == 'command' and 'testcommandstring' in props:
> -			sysvals.testcommand = props['testcommandstring'].altname
> -		return
> -
> -	if(os.path.exists(sysvals.ftracefile) == False):
> -		doError('%s does not exist' % sysvals.ftracefile)
> -
> -	# first get the list of devices we need properties for
> -	msghead = 'Additional data added by AnalyzeSuspend'
> -	alreadystamped = False
> -	tp = TestProps()
> -	tf = sysvals.openlog(sysvals.ftracefile, 'r')
> -	for line in tf:
> -		if msghead in line:
> -			alreadystamped = True
> -			continue
> -		# determine the trace data type (required for further parsing)
> -		m = re.match(tp.tracertypefmt, line)
> -		if(m):
> -			tp.setTracerType(m.group('t'))
> -			continue
> -		# parse only valid lines, if this is not one move on
> -		m = re.match(tp.ftrace_line_fmt, line)
> -		if(not m or 'device_pm_callback_start' not in line):
> -			continue
> -		m = re.match('.*: (?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*', m.group('msg'));
> -		if(not m):
> -			continue
> -		dev = m.group('d')
> -		if dev not in props:
> -			props[dev] = DevProps()
> -	tf.close()
> -
> -	if not alreadystamped and sysvals.suspendmode == 'command':
> -		out = '#\n# '+msghead+'\n# Device Properties: '
> -		out += 'testcommandstring,%s,0;' % (sysvals.testcommand)
> -		with sysvals.openlog(sysvals.ftracefile, 'a') as fp:
> -			fp.write(out+'\n')
> -		sysvals.devprops = props
> -		return
> -
> -	# now get the syspath for each of our target devices
> -	for dirname, dirnames, filenames in os.walk('/sys/devices'):
> -		if(re.match('.*/power', dirname) and 'async' in filenames):
> -			dev = dirname.split('/')[-2]
> -			if dev in props and (not props[dev].syspath or len(dirname) < len(props[dev].syspath)):
> -				props[dev].syspath = dirname[:-6]
> -
> -	# now fill in the properties for our target devices
> -	for dev in props:
> -		dirname = props[dev].syspath
> -		if not dirname or not os.path.exists(dirname):
> -			continue
> -		with open(dirname+'/power/async') as fp:
> -			text = fp.read()
> -			props[dev].async = False
> -			if 'enabled' in text:
> -				props[dev].async = True
> -		fields = os.listdir(dirname)
> -		if 'product' in fields:
> -			with open(dirname+'/product') as fp:
> -				props[dev].altname = fp.read()
> -		elif 'name' in fields:
> -			with open(dirname+'/name') as fp:
> -				props[dev].altname = fp.read()
> -		elif 'model' in fields:
> -			with open(dirname+'/model') as fp:
> -				props[dev].altname = fp.read()
> -		elif 'description' in fields:
> -			with open(dirname+'/description') as fp:
> -				props[dev].altname = fp.read()
> -		elif 'id' in fields:
> -			with open(dirname+'/id') as fp:
> -				props[dev].altname = fp.read()
> -		elif 'idVendor' in fields and 'idProduct' in fields:
> -			idv, idp = '', ''
> -			with open(dirname+'/idVendor') as fp:
> -				idv = fp.read().strip()
> -			with open(dirname+'/idProduct') as fp:
> -				idp = fp.read().strip()
> -			props[dev].altname = '%s:%s' % (idv, idp)
> -
> -		if props[dev].altname:
> -			out = props[dev].altname.strip().replace('\n', ' ')
> -			out = out.replace(',', ' ')
> -			out = out.replace(';', ' ')
> -			props[dev].altname = out
> -
> -	# and now write the data to the ftrace file
> -	if not alreadystamped:
> -		out = '#\n# '+msghead+'\n# Device Properties: '
> -		for dev in sorted(props):
> -			out += props[dev].out(dev)
> -		with sysvals.openlog(sysvals.ftracefile, 'a') as fp:
> -			fp.write(out+'\n')
> -
> -	sysvals.devprops = props
> -
>  # Function: getModes
>  # Description:
>  #	 Determine the supported power modes on this system
> @@ -5339,11 +5397,11 @@ def dmidecode(mempath, fatal=False):
>  	# search for either an SM table or DMI table
>  	i = base = length = num = 0
>  	while(i < memsize):
> -		if buf[i:i+4] == '_SM_' and i < memsize - 16:
> +		if buf[i:i+4] == b'_SM_' and i < memsize - 16:
>  			length = struct.unpack('H', buf[i+22:i+24])[0]
>  			base, num = struct.unpack('IH', buf[i+24:i+30])
>  			break
> -		elif buf[i:i+5] == '_DMI_':
> +		elif buf[i:i+5] == b'_DMI_':
>  			length = struct.unpack('H', buf[i+6:i+8])[0]
>  			base, num = struct.unpack('IH', buf[i+8:i+14])
>  			break
> @@ -5376,15 +5434,15 @@ def dmidecode(mempath, fatal=False):
>  			if 0 == struct.unpack('H', buf[n:n+2])[0]:
>  				break
>  			n += 1
> -		data = buf[i+size:n+2].split('\0')
> +		data = buf[i+size:n+2].split(b'\0')
>  		for name in info:
>  			itype, idxadr = info[name]
>  			if itype == type:
> -				idx = struct.unpack('B', buf[i+idxadr])[0]
> +				idx = struct.unpack('B', buf[i+idxadr:i+idxadr+1])[0]
>  				if idx > 0 and idx < len(data) - 1:
> -					s = data[idx-1].strip()
> -					if s and s.lower() != 'to be filled by o.e.m.':
> -						out[name] = data[idx-1]
> +					s = data[idx-1].decode('utf-8')
> +					if s.strip() and s.strip().lower() != 'to be filled by o.e.m.':
> +						out[name] = s
>  		i = n + 2
>  		count += 1
>  	return out
> @@ -5409,7 +5467,7 @@ def getBattery():
>  	return (ac, charge)
>  
>  def displayControl(cmd):
> -	xset, ret = 'xset -d :0.0 {0}', 0
> +	xset, ret = 'timeout 10 xset -d :0.0 {0}', 0
>  	if sysvals.sudouser:
>  		xset = 'sudo -u %s %s' % (sysvals.sudouser, xset)
>  	if cmd == 'init':
> @@ -5433,7 +5491,7 @@ def displayControl(cmd):
>  		fp = Popen(xset.format('q').split(' '), stdout=PIPE).stdout
>  		ret = 'unknown'
>  		for line in fp:
> -			m = re.match('[\s]*Monitor is (?P<m>.*)', line)
> +			m = re.match('[\s]*Monitor is (?P<m>.*)', ascii(line))
>  			if(m and len(m.group('m')) >= 2):
>  				out = m.group('m').lower()
>  				ret = out[3:] if out[0:2] == 'in' else out
> @@ -5495,10 +5553,11 @@ def getFPDT(output):
>  		'               OEM Revision : %u\n'\
>  		'                 Creator ID : %s\n'\
>  		'           Creator Revision : 0x%x\n'\
> -		'' % (table[0], table[0], table[1], table[2], table[3],
> -			table[4], table[5], table[6], table[7], table[8]))
> +		'' % (ascii(table[0]), ascii(table[0]), table[1], table[2],
> +			table[3], ascii(table[4]), ascii(table[5]), table[6],
> +			ascii(table[7]), table[8]))
>  
> -	if(table[0] != 'FPDT'):
> +	if(table[0] != b'FPDT'):
>  		if(output):
>  			doError('Invalid FPDT table')
>  		return False
> @@ -5530,8 +5589,8 @@ def getFPDT(output):
>  			return [0, 0]
>  		rechead = struct.unpack('4sI', first)
>  		recdata = fp.read(rechead[1]-8)
> -		if(rechead[0] == 'FBPT'):
> -			record = struct.unpack('HBBIQQQQQ', recdata)
> +		if(rechead[0] == b'FBPT'):
> +			record = struct.unpack('HBBIQQQQQ', recdata[:48])
>  			if(output):
>  				pprint('%s (%s)\n'\
>  				'                  Reset END : %u ns\n'\
> @@ -5539,11 +5598,11 @@ def getFPDT(output):
>  				' OS Loader StartImage Start : %u ns\n'\
>  				'     ExitBootServices Entry : %u ns\n'\
>  				'      ExitBootServices Exit : %u ns'\
> -				'' % (rectype[header[0]], rechead[0], record[4], record[5],
> +				'' % (rectype[header[0]], ascii(rechead[0]), record[4], record[5],
>  					record[6], record[7], record[8]))
> -		elif(rechead[0] == 'S3PT'):
> +		elif(rechead[0] == b'S3PT'):
>  			if(output):
> -				pprint('%s (%s)' % (rectype[header[0]], rechead[0]))
> +				pprint('%s (%s)' % (rectype[header[0]], ascii(rechead[0])))
>  			j = 0
>  			while(j < len(recdata)):
>  				prechead = struct.unpack('HBB', recdata[j:j+4])
> @@ -5689,7 +5748,7 @@ def doError(msg, help=False):
>  def getArgInt(name, args, min, max, main=True):
>  	if main:
>  		try:
> -			arg = args.next()
> +			arg = next(args)
>  		except:
>  			doError(name+': no argument supplied', True)
>  	else:
> @@ -5708,7 +5767,7 @@ def getArgInt(name, args, min, max, main=True):
>  def getArgFloat(name, args, min, max, main=True):
>  	if main:
>  		try:
> -			arg = args.next()
> +			arg = next(args)
>  		except:
>  			doError(name+': no argument supplied', True)
>  	else:
> @@ -5737,9 +5796,12 @@ def processData(live=False):
>  			parseKernelLog(data)
>  		if(sysvals.ftracefile and (sysvals.usecallgraph or sysvals.usetraceevents)):
>  			appendIncompleteTraceLog(testruns)
> +	shown = ['bios', 'biosdate', 'cpu', 'host', 'kernel', 'man', 'memfr',
> +			'memsz', 'mode', 'numcpu', 'plat', 'time']
>  	sysvals.vprint('System Info:')
>  	for key in sorted(sysvals.stamp):
> -		sysvals.vprint('    %-8s : %s' % (key.upper(), sysvals.stamp[key]))
> +		if key in shown:
> +			sysvals.vprint('    %-8s : %s' % (key.upper(), sysvals.stamp[key]))
>  	if sysvals.kparams:
>  		sysvals.vprint('Kparams:\n    %s' % sysvals.kparams)
>  	sysvals.vprint('Command:\n    %s' % sysvals.cmdline)
> @@ -5768,6 +5830,12 @@ def processData(live=False):
>  				(w[0], w[1])
>  			sysvals.vprint(s)
>  		data.printDetails()
> +		if len(sysvals.platinfo) > 0:
> +			sysvals.vprint('\nPlatform Info:')
> +			for info in sysvals.platinfo:
> +				sysvals.vprint(info[0]+' - '+info[1])
> +				sysvals.vprint(info[2])
> +			sysvals.vprint('')
>  	if sysvals.cgdump:
>  		for data in testruns:
>  			data.debugPrint()
> @@ -5951,7 +6019,7 @@ def data_from_html(file, outpath, issues, fulldetail=False):
>  		worst[d] = {'name':'', 'time': 0.0}
>  		dev = devices[d] if d in devices else 0
>  		if dev and len(dev.keys()) > 0:
> -			n = sorted(dev, key=dev.get, reverse=True)[0]
> +			n = sorted(dev, key=lambda k:(dev[k], k), reverse=True)[0]
>  			worst[d]['name'], worst[d]['time'] = n, dev[n]
>  	data = {
>  		'mode': stmp[2],
> @@ -5976,7 +6044,7 @@ def data_from_html(file, outpath, issues, fulldetail=False):
>  		data['funclist'] = find_in_html(html, '<div title="', '" class="traceevent"', False)
>  	return data
>  
> -def genHtml(subdir):
> +def genHtml(subdir, force=False):
>  	for dirname, dirnames, filenames in os.walk(subdir):
>  		sysvals.dmesgfile = sysvals.ftracefile = sysvals.htmlfile = ''
>  		for filename in filenames:
> @@ -5986,7 +6054,7 @@ def genHtml(subdir):
>  				sysvals.ftracefile = os.path.join(dirname, filename)
>  		sysvals.setOutputFile()
>  		if sysvals.ftracefile and sysvals.htmlfile and \
> -			not os.path.exists(sysvals.htmlfile):
> +			(force or not os.path.exists(sysvals.htmlfile)):
>  			pprint('FTRACE: %s' % sysvals.ftracefile)
>  			if sysvals.dmesgfile:
>  				pprint('DMESG : %s' % sysvals.dmesgfile)
> @@ -6042,7 +6110,7 @@ def checkArgBool(name, value):
>  # Description:
>  #	 Configure the script via the info in a config file
>  def configFromFile(file):
> -	Config = ConfigParser.ConfigParser()
> +	Config = configparser.ConfigParser()
>  
>  	Config.read(file)
>  	sections = Config.sections()
> @@ -6270,7 +6338,7 @@ def printHelp():
>  	'                default: suspend-{date}-{time}\n'\
>  	'   -rtcwake t   Wakeup t seconds after suspend, set t to "off" to disable (default: 15)\n'\
>  	'   -addlogs     Add the dmesg and ftrace logs to the html output\n'\
> -	'   -turbostat   Use turbostat to execute the command in freeze mode (default: disabled)\n'\
> +	'   -noturbostat Dont use turbostat in freeze mode (default: disabled)\n'\
>  	'   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)\n'\
>  	'   -skiphtml    Run the test and capture the trace logs, but skip the timeline (default: disabled)\n'\
>  	'   -result fn   Export a results table to a text file for parsing.\n'\
> @@ -6340,7 +6408,7 @@ if __name__ == '__main__':
>  	for arg in args:
>  		if(arg == '-m'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No mode supplied', True)
>  			if val == 'command' and not sysvals.testcommand:
> @@ -6384,10 +6452,8 @@ if __name__ == '__main__':
>  			sysvals.dmesglog = True
>  		elif(arg == '-addlogftrace'):
>  			sysvals.ftracelog = True
> -		elif(arg == '-turbostat'):
> -			sysvals.tstat = True
> -			if not sysvals.haveTurbostat():
> -				doError('Turbostat command not found')
> +		elif(arg == '-noturbostat'):
> +			sysvals.tstat = False
>  		elif(arg == '-verbose'):
>  			sysvals.verbose = True
>  		elif(arg == '-proc'):
> @@ -6400,7 +6466,7 @@ if __name__ == '__main__':
>  			sysvals.gzip = True
>  		elif(arg == '-rs'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('-rs requires "enable" or "disable"', True)
>  			if val.lower() in switchvalues:
> @@ -6412,7 +6478,7 @@ if __name__ == '__main__':
>  				doError('invalid option: %s, use "enable/disable" or "on/off"' % val, True)
>  		elif(arg == '-display'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('-display requires an mode value', True)
>  			disopt = ['on', 'off', 'standby', 'suspend']
> @@ -6423,7 +6489,7 @@ if __name__ == '__main__':
>  			sysvals.max_graph_depth = getArgInt('-maxdepth', args, 0, 1000)
>  		elif(arg == '-rtcwake'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No rtcwake time supplied', True)
>  			if val.lower() in switchoff:
> @@ -6443,7 +6509,7 @@ if __name__ == '__main__':
>  			sysvals.cgtest = getArgInt('-cgtest', args, 0, 1)
>  		elif(arg == '-cgphase'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No phase name supplied', True)
>  			d = Data(0)
> @@ -6453,19 +6519,19 @@ if __name__ == '__main__':
>  			sysvals.cgphase = val
>  		elif(arg == '-cgfilter'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No callgraph functions supplied', True)
>  			sysvals.setCallgraphFilter(val)
>  		elif(arg == '-skipkprobe'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No kprobe functions supplied', True)
>  			sysvals.skipKprobes(val)
>  		elif(arg == '-cgskip'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No file supplied', True)
>  			if val.lower() in switchoff:
> @@ -6480,7 +6546,7 @@ if __name__ == '__main__':
>  			sysvals.callloopmaxlen = getArgFloat('-callloop-maxlen', args, 0.0, 1.0)
>  		elif(arg == '-cmd'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No command string supplied', True)
>  			sysvals.testcommand = val
> @@ -6495,13 +6561,13 @@ if __name__ == '__main__':
>  			sysvals.multitest['delay'] = getArgInt('-multi n d (delay between tests)', args, 0, 3600)
>  		elif(arg == '-o'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No subdirectory name supplied', True)
>  			sysvals.outdir = sysvals.setOutputFolder(val)
>  		elif(arg == '-config'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No text file supplied', True)
>  			file = sysvals.configFile(val)
> @@ -6510,7 +6576,7 @@ if __name__ == '__main__':
>  			configFromFile(file)
>  		elif(arg == '-fadd'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No text file supplied', True)
>  			file = sysvals.configFile(val)
> @@ -6519,7 +6585,7 @@ if __name__ == '__main__':
>  			sysvals.addFtraceFilterFunctions(file)
>  		elif(arg == '-dmesg'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No dmesg file supplied', True)
>  			sysvals.notestrun = True
> @@ -6528,7 +6594,7 @@ if __name__ == '__main__':
>  				doError('%s does not exist' % sysvals.dmesgfile)
>  		elif(arg == '-ftrace'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No ftrace file supplied', True)
>  			sysvals.notestrun = True
> @@ -6537,7 +6603,7 @@ if __name__ == '__main__':
>  				doError('%s does not exist' % sysvals.ftracefile)
>  		elif(arg == '-summary'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No directory supplied', True)
>  			cmd = 'summary'
> @@ -6547,13 +6613,13 @@ if __name__ == '__main__':
>  				doError('%s is not accesible' % val)
>  		elif(arg == '-filter'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No devnames supplied', True)
>  			sysvals.setDeviceFilter(val)
>  		elif(arg == '-result'):
>  			try:
> -				val = args.next()
> +				val = next(args)
>  			except:
>  				doError('No result file supplied', True)
>  			sysvals.result = val
> 

Applied, thanks!




