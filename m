Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A262B1A282A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgDHR61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 13:58:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:42218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgDHR61 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 13:58:27 -0400
IronPort-SDR: z0v4zJ81oLWf9WP9mNKNIPEah8f7KBnI0oxrGXgD5tdgh3cwfbLXRc6rQJCvQl8qwnmU5Y36k0
 GkEatFZ+0SkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 10:58:22 -0700
IronPort-SDR: LDviwsPUonr3NTD+Rl9j9691IS34u1WU4JzRFtd1FCH8DZezkMSTz//zEV5puYycmEF+WrcCl9
 7lEVKKL4XDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="251633973"
Received: from krjarman-mobl.amr.corp.intel.com (HELO technocore.fios-router.home) ([10.251.7.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2020 10:58:21 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
        len.brown@intel.com
Subject: [PATCH] pm-graph v5.6
Date:   Wed,  8 Apr 2020 10:58:19 -0700
Message-Id: <0e9a2f5f4f6d0e93de661ae3464568d7dff0f5c9.1586368480.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sleepgraph:
- force usage of python3 instead of using system default
- fix bugzilla 204773 (https://bugzilla.kernel.org/show_bug.cgi?id=204773)
- fix issue of platform info not being reset in -multi (logs fill up)
- change -ftop call to "pm_suspend", this is one level below state_store
- add -wificheck command to read out the current wifi device details
- change -wifi behavior to poll /proc/net/wireless for wifi connect
- add wifi reconnect time to timeline, include time in summary column
- add "fail on wifi_resume" to timeline and summary when wifi fails
- add a set of commands to collect data before/after suspend in the log
- add "-cmdinfo" command which prints out all the data collected
- check for cmd info tools at start, print found/missing in green/red
- fix kernel suspend time calculation: tool used to look for start of
    pm_suspend_console, but the order has changed. latest kernel starts
    with ksys_sync, use this instead
- include time spent in mem/disk in the header (same as freeze/standby)
- ignore turbostat 32-bit capability warnings
- print to result.txt when -skiphtml is used, just say result: pass
- don't exit on SIGTSTP, it's a ctrl-Z and the tool may come back
- -multi argument supports duration as well as count: hours, minutes, seconds
- update the -multi status output to be more informative
- -maxfail sets maximum consecutive fails before a -multi run is aborted
- in -summary, ignore dmesg/ftrace/html files that are 0 size

bootgraph:
- force usage of python3 instead of using system default

README:
- add endurance testing instructions

Makefile:
- remove pycache on uninstall
---
 tools/power/pm-graph/Makefile      |   4 +
 tools/power/pm-graph/README        | 124 ++++-
 tools/power/pm-graph/bootgraph.py  |   2 +-
 tools/power/pm-graph/sleepgraph.8  |  65 ++-
 tools/power/pm-graph/sleepgraph.py | 795 ++++++++++++++++-------------
 5 files changed, 619 insertions(+), 371 deletions(-)

diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-graph/Makefile
index 845541544570..b5310832c19c 100644
--- a/tools/power/pm-graph/Makefile
+++ b/tools/power/pm-graph/Makefile
@@ -41,6 +41,10 @@ uninstall :
 	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/config ] ; then \
 		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/config; \
 	fi;
+	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__/*
+	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__ ] ; then \
+		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__; \
+	fi;
 	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/*
 	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph ] ; then \
 		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph; \
diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
index 96259f6e5715..afe6beb40ad9 100644
--- a/tools/power/pm-graph/README
+++ b/tools/power/pm-graph/README
@@ -1,7 +1,12 @@
-                     p m - g r a p h
+                                                _
+    _ __  _ __ ___         __ _ _ __ __ _ _ __ | |__
+   | '_ \| '_ ` _ \ _____ / _` | '__/ _` | '_ \| '_ \
+   | |_) | | | | | |_____| (_| | | | (_| | |_) | | | |
+   | .__/|_| |_| |_|      \__, |_|  \__,_| .__/|_| |_|
+   |_|                    |___/          |_|
 
    pm-graph: suspend/resume/boot timing analysis tools
-    Version: 5.5
+    Version: 5.6
      Author: Todd Brandt <todd.e.brandt@intel.com>
   Home Page: https://01.org/pm-graph
 
@@ -18,10 +23,6 @@
 	- upstream version in git:
 	  https://github.com/intel/pm-graph/
 
- Requirements:
-	- runs with python2 or python3, choice is made by /usr/bin/python link
-	- python2 now requires python-configparser be installed
-
  Table of Contents
 	- Overview
 	- Setup
@@ -29,6 +30,8 @@
 		- Basic Usage
 		- Dev Mode Usage
 		- Proc Mode Usage
+	- Endurance Testing
+		- Usage Examples
 	- Configuration Files
 		- Usage Examples
 		- Config File Options
@@ -54,15 +57,18 @@
 |                            SETUP                               |
 ------------------------------------------------------------------
 
-    These packages are required to execute the scripts
+    Package Requirements
+       - runs with python2 or python3, choice is made by /usr/bin/python link
        - python
-       - python-requests
+       - python-configparser (for python2 sleepgraph)
+       - python-requests (for googlesheet.py)
+       - linux-tools-common (for turbostat usage in sleepgraph)
 
        Ubuntu:
-          sudo apt-get install python python-requests
+          sudo apt-get install python python-configparser python-requests linux-tools-common
 
        Fedora:
-          sudo dnf install python python-requests
+          sudo dnf install python python-configparser python-requests linux-tools-common
 
     The tools can most easily be installed via git clone and make install
 
@@ -190,6 +196,104 @@ _______________
 
  %> sudo ./sleepgraph.py -config config/suspend-proc.cfg
 
+------------------------------------------------------------------
+|                     ENDURANCE TESTING                          |
+------------------------------------------------------------------
+
+ The best way to gauge the health of a system is to run a series of
+ suspend/resumes over an extended period and analyze the behavior. This can be
+ accomplished with sleepgraph's -multi argument. You specify two numbers: the
+ number of tests to run OR the duration in days, hours, or minutes, and the
+ delay in seconds between them. For instance, -multi 20 5: execute 20 tests with
+ a 5 second delay between each, or -multi 24h 0: execute tests over a 24 hour
+ period with no delay between tests. You can include any other options you like
+ to generate the data you want. It's most useful to collect dev mode timelines
+ as the kprobes don't alter the performance much and you get more insight.
+
+ On completion, the output folder contains a series of folders for the
+ individual test data and a set of summary pages in the root. The summary.html
+ file is a tabular list of the tests with relevant info and links. The
+ summary-issue.html and summary-devices.html files include data taken from
+ all tests on kernel issues and device performance. The folder looks like this:
+
+  suspend-xN-{date}-{time}:
+	summary.html
+	summary-issues.html
+	summary-devices.html
+	suspend-{date}-{time} (1)
+	suspend-{date}-{time} (2)
+	...
+
+ These are the relevant arguments to use for testing:
+
+  -m mode
+	Mode to initiate for suspend e.g. mem, freeze, standby (default: mem).
+
+  -rtcwake t
+	Use rtcwake to autoresume after t seconds (default: 15).
+
+  -gzip (optional)
+	Gzip the trace and dmesg logs to save space. The tool can also read in
+	gzipped logs for processing. This reduces the multitest folder size.
+
+  -dev (optional)
+	Add kernel source calls and threads to the timeline (default: disabled).
+
+  -multi n d
+	Execute n consecutive tests at d seconds intervals. The outputs will be
+	created in a new subdirectory: suspend-xN-{date}-{time}. When the multitest
+	run is done, the -summary command is called automatically to create summary
+	html files for all the data (unless you use -skiphtml). -skiphtml will
+	speed up the testing by not creating timelines or summary html files. You
+	can then run the tool again at a later time with -summary and -genhtml to
+	create the timelines.
+
+  -skiphtml (optional)
+	Run the test and capture the trace logs, but skip the timeline and summary
+	html generation. This can greatly speed up overall testing. You can then
+	copy the data to a faster host machine and run -summary -genhtml to
+	generate the timelines and summary.
+
+ These are the relevant commands to use after testing is complete:
+
+  -summary indir
+	Generate or regenerate the summary for a -multi test run. Creates three
+	files: summary.html, summary-issues.html, and summary-devices.html in the
+	current folder. summary.html is a table of tests with relevant info sorted
+	by kernel/host/mode, and links to the test html files. summary-issues.html
+	is a list of kernel issues found in dmesg from all the tests.
+	summary-devices.html is a list of devices and times from all the tests.
+
+  -genhtml
+	Used  with -summary to regenerate any missing html timelines from their
+	dmesg and ftrace logs. This will require a significant amount of time if
+	there are thousands of tests.
+
+Usage Examples
+_______________
+
+ A multitest is initiated like this:
+
+  %> sudo ./sleepgraph.py -m mem -rtcwake 10 -dev -gzip -multi 2000 0
+
+	or you can skip timeline generation in order to speed things up
+
+  %> sudo ./sleepgraph.py -m mem -rtcwake 10 -dev -gzip -multi 2000 0 -skiphtml
+
+ The tool will produce an output folder with all the test subfolders inside.
+ Each test subfolder contains the dmesg/ftrace logs and/or the html timeline
+ depending on whether you used the -skiphtml option. The root folder contains
+ the summary.html files.
+
+ The summary for an existing multitest is generated like this:
+
+  %> cd suspend-x2000-{date}-{time}
+  %> sleepgraph.py -summary .
+
+	or if you need to generate the html timelines you can use -genhtml
+
+  %> cd suspend-xN-{date}-{time}
+  %> sleepgraph.py -summary . -genhtml
 
 ------------------------------------------------------------------
 |                    CONFIGURATION FILES                         |
diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index d3b99a1e92d6..2823cd3122f7 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Tool for analyzing boot timing
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 43aee64316df..5126271de98a 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -74,8 +74,10 @@ after the test is complete.
 Switch the display to the requested mode for the test using the xset command.
 This helps maintain the consistency of test data for better comparison.
 .TP
-\fB-skiphtml\fR
-Run the test and capture the trace logs, but skip the timeline generation.
+\fB-wifi\fR
+If a wifi connection is available, check that it reconnects after resume. Include
+the reconnect time in the total resume time calculation and treat wifi timeouts
+as resume failures.
 
 .SS "advanced"
 .TP
@@ -117,8 +119,24 @@ Include \fIt\fR ms delay before 1st suspend (default: 0 ms).
 Include \fIt\fR ms delay after last resume (default: 0 ms).
 .TP
 \fB-multi \fIn d\fR
-Execute \fIn\fR consecutive tests at \fId\fR seconds intervals. The outputs will
-be created in a new subdirectory with a summary page: suspend-xN-{date}-{time}.
+Used for endurance testing. If \fIn\fR is entirely numeric, it's treated as a count:
+Execute \fIn\fR consecutive tests at \fId\fR second intervals.
+If \fIn\fR is an integer followed by a "d", "h", or "m", it's treated as a duration:
+Execute tests continuously over \fIn\fR days, hours, or minutes at \fId\fR second intervals.
+The outputs will be created in a new subdirectory, for count: suspend-{date}-{time}-xN,
+for duration: suspend-{date}-{time}-Nm. When the multitest run is done, the \fI-summary\fR
+command is called automatically to create summary html files for all the data (unless you
+use \fI-skiphtml\fR). \fI-skiphtml\fR will speed up the testing by not creating timelines
+or summary html files. You can then run the tool again at a later time with \fI-summary\fR
+and \fI-genhtml\fR to create the timelines.
+.TP
+\fB-maxfail \fIn\fR
+Abort a -multi run after \fIn\fR consecutive fails. 0 means never abort (default = 0).
+.TP
+\fB-skiphtml\fR
+Run the test and capture the trace logs, but skip the timeline generation.
+You can generate the html timelines later with \fI-dmesg\fR & \fI-ftrace\fR, or
+by running \fI-summary\fR and \fI-genhtml\fR.
 
 .SS "ftrace debug"
 .TP
@@ -173,11 +191,20 @@ Set trace buffer size to N kilo-bytes (default: all of free memory up to 3GB)
 .SH COMMANDS
 .TP
 \fB-summary \fIindir\fR
-Create a summary page of all tests in \fIindir\fR. Creates summary.html
-in the current folder. The output page is a table of tests with
-suspend and resume values sorted by suspend mode, host, and kernel.
-Includes test averages by mode and links to the test html files.
-Use -genhtml to include tests with missing html.
+Create a set of summary pages for all tests in \fIindir\fR recursively.
+Creates summary.html, summary-issues.html, and summary-devices.html in the current folder.
+summary.html is a table of tests with relevant info sorted by kernel/host/mode,
+and links to the test html files. It identifies the minimum, maximum, and median
+suspend and resume times for you with highlights and links in the header.
+summary-issues.html is a list of kernel issues found in dmesg from all the tests.
+summary-devices.html is a list of devices and times from all the tests.
+
+Use \fI-genhtml\fR to regenerate any tests with missing html.
+.TP
+\fB-genhtml\fR
+Used with \fI-summary\fR to regenerate any missing html timelines from their
+dmesg and ftrace logs. This will require a significant amount of time if there
+are thousands of tests.
 .TP
 \fB-modes\fR
 List available suspend modes.
@@ -189,10 +216,7 @@ with any options you intend to use to see if they will work.
 \fB-fpdt\fR
 Print out the contents of the ACPI Firmware Performance Data Table.
 .TP
-\fB-battery\fR
-Print out battery status and current charge.
-.TP
-\fB-wifi\fR
+\fB-wificheck\fR
 Print out wifi status and connection details.
 .TP
 \fB-xon/-xoff/-xstandby/-xsuspend\fR
@@ -208,6 +232,9 @@ Print out system info extracted from BIOS. Reads /dev/mem directly instead of go
 \fB-devinfo\fR
 Print out the pm settings of all devices which support runtime suspend.
 .TP
+\fB-cmdinfo\fR
+Print out all the platform data collected from the system that makes it into the logs.
+.TP
 \fB-flist\fR
 Print the list of ftrace functions currently being captured. Functions
 that are not available as symbols in the current kernel are shown in red.
@@ -272,14 +299,20 @@ Run two suspends back to back, include a 500ms delay before, after, and in betwe
 .IP
 \f(CW$ sudo sleepgraph -m mem -rtcwake 15 -x2 -predelay 500 -x2delay 500 -postdelay 500\fR
 .PP
+Execute a suspend using a custom command.
+.IP
+\f(CW$ sudo sleepgraph -cmd "echo mem > /sys/power/state" -rtcwake 15\fR
+.PP
+
+.SS "endurance testing using -multi"
+.PP
 Do a batch run of 10 freezes with 30 seconds delay between runs.
 .IP
 \f(CW$ sudo sleepgraph -m freeze -rtcwake 15 -multi 10 30\fR
 .PP
-Execute a suspend using a custom command.
+Do a batch run of freezes for 24 hours.
 .IP
-\f(CW$ sudo sleepgraph -cmd "echo mem > /sys/power/state" -rtcwake 15\fR
-.PP
+\f(CW$ sudo sleepgraph -m freeze -rtcwake 15 -multi 24h 0\fR
 
 .SS "adding callgraph data"
 Add device callgraphs. Limit the trace depth and only show callgraphs 10ms or larger.
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index f7d1c1f62f86..9b0404d10768 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Tool for analyzing suspend/resume timing
@@ -58,7 +58,7 @@ import re
 import platform
 import signal
 import codecs
-from datetime import datetime
+from datetime import datetime, timedelta
 import struct
 import configparser
 import gzip
@@ -81,12 +81,13 @@ def ascii(text):
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '5.5'
+	version = '5.6'
 	ansi = False
 	rs = 0
 	display = ''
 	gzip = False
 	sync = False
+	wifi = False
 	verbose = False
 	testlog = True
 	dmesglog = True
@@ -97,7 +98,8 @@ class SystemValues:
 	cgphase = ''
 	cgtest = -1
 	cgskip = ''
-	multitest = {'run': False, 'count': 0, 'delay': 0}
+	maxfail = 0
+	multitest = {'run': False, 'count': 1000000, 'delay': 0}
 	max_graph_depth = 0
 	callloopmaxgap = 0.0001
 	callloopmaxlen = 0.005
@@ -148,7 +150,7 @@ class SystemValues:
 	x2delay = 0
 	skiphtml = False
 	usecallgraph = False
-	ftopfunc = 'suspend_devices_and_enter'
+	ftopfunc = 'pm_suspend'
 	ftop = False
 	usetraceevents = False
 	usetracemarkers = True
@@ -164,6 +166,8 @@ class SystemValues:
 	predelay = 0
 	postdelay = 0
 	pmdebug = ''
+	tmstart = 'SUSPEND START %Y%m%d-%H:%M:%S.%f'
+	tmend = 'RESUME COMPLETE %Y%m%d-%H:%M:%S.%f'
 	tracefuncs = {
 		'sys_sync': {},
 		'ksys_sync': {},
@@ -183,9 +187,11 @@ class SystemValues:
 		'acpi_s2idle_sync': {},
 		'acpi_s2idle_begin': {},
 		'acpi_s2idle_prepare': {},
+		'acpi_s2idle_prepare_late': {},
 		'acpi_s2idle_wake': {},
 		'acpi_s2idle_wakeup': {},
 		'acpi_s2idle_restore': {},
+		'acpi_s2idle_restore_early': {},
 		'hibernate_preallocate_memory': {},
 		'create_basic_memory_bitmaps': {},
 		'swsusp_write': {},
@@ -270,12 +276,23 @@ class SystemValues:
 		'intel_opregion_init': {},
 		'intel_fbdev_set_suspend': {},
 	}
+	infocmds = [
+		[0, 'kparams', 'cat', '/proc/cmdline'],
+		[0, 'mcelog', 'mcelog'],
+		[0, 'pcidevices', 'lspci', '-tv'],
+		[0, 'usbdevices', 'lsusb', '-t'],
+		[1, 'interrupts', 'cat', '/proc/interrupts'],
+		[1, 'wakeups', 'cat', '/sys/kernel/debug/wakeup_sources'],
+		[2, 'gpecounts', 'sh', '-c', 'grep -v invalid /sys/firmware/acpi/interrupts/*'],
+		[2, 'suspendstats', 'sh', '-c', 'grep -v invalid /sys/power/suspend_stats/*'],
+		[2, 'cpuidle', 'sh', '-c', 'grep -v invalid /sys/devices/system/cpu/cpu*/cpuidle/state*/s2idle/*'],
+		[2, 'battery', 'sh', '-c', 'grep -v invalid /sys/class/power_supply/*/*'],
+	]
 	cgblacklist = []
 	kprobes = dict()
 	timeformat = '%.3f'
 	cmdline = '%s %s' % \
 			(os.path.basename(sys.argv[0]), ' '.join(sys.argv[1:]))
-	kparams = ''
 	sudouser = ''
 	def __init__(self):
 		self.archargs = 'args_'+platform.machine()
@@ -295,6 +312,9 @@ class SystemValues:
 		if os.getuid() == 0 and 'SUDO_USER' in os.environ and \
 			os.environ['SUDO_USER']:
 			self.sudouser = os.environ['SUDO_USER']
+	def resetlog(self):
+		self.logmsg = ''
+		self.platinfo = []
 	def vprint(self, msg):
 		self.logmsg += msg+'\n'
 		if self.verbose or msg.startswith('WARNING:'):
@@ -304,11 +324,11 @@ class SystemValues:
 			return
 		signame = self.signames[signum] if signum in self.signames else 'UNKNOWN'
 		msg = 'Signal %s caused a tool exit, line %d' % (signame, frame.f_lineno)
-		sysvals.outputResult({'error':msg})
+		self.outputResult({'error':msg})
 		sys.exit(3)
 	def signalHandlerInit(self):
 		capture = ['BUS', 'SYS', 'XCPU', 'XFSZ', 'PWR', 'HUP', 'INT', 'QUIT',
-			'ILL', 'ABRT', 'FPE', 'SEGV', 'TERM', 'TSTP']
+			'ILL', 'ABRT', 'FPE', 'SEGV', 'TERM']
 		self.signames = dict()
 		for i in capture:
 			s = 'SIG'+i
@@ -336,6 +356,8 @@ class SystemValues:
 			self.outputResult({'error':msg})
 			sys.exit(1)
 		return False
+	def usable(self, file):
+		return (os.path.exists(file) and os.path.getsize(file) > 0)
 	def getExec(self, cmd):
 		try:
 			fp = Popen(['which', cmd], stdout=PIPE, stderr=PIPE).stdout
@@ -389,12 +411,6 @@ class SystemValues:
 		r = info['bios-release-date'] if 'bios-release-date' in info else ''
 		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | biosdate:%s | numcpu:%d | memsz:%d | memfr:%d' % \
 			(m, p, c, b, r, self.cpucount, self.memtotal, self.memfree)
-		try:
-			kcmd = open('/proc/cmdline', 'r').read().strip()
-		except:
-			kcmd = ''
-		if kcmd:
-			self.sysstamp += '\n# kparams | %s' % kcmd
 	def printSystemInfo(self, fatal=False):
 		self.rootCheck(True)
 		out = dmidecode(self.mempath, fatal)
@@ -441,6 +457,7 @@ class SystemValues:
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'.html'
 		if not os.path.isdir(self.testdir):
 			os.makedirs(self.testdir)
+		self.sudoUserchown(self.testdir)
 	def getValueList(self, value):
 		out = []
 		for i in value.split(','):
@@ -486,7 +503,7 @@ class SystemValues:
 		fp.close()
 		self.dmesgstart = float(ktime)
 	def getdmesg(self, testdata):
-		op = self.writeDatafileHeader(sysvals.dmesgfile, testdata)
+		op = self.writeDatafileHeader(self.dmesgfile, testdata)
 		# store all new dmesg lines since initdmesg was called
 		fp = Popen('dmesg', stdout=PIPE).stdout
 		for line in fp:
@@ -716,9 +733,10 @@ class SystemValues:
 			if name == f:
 				return True
 		return False
-	def initFtrace(self):
-		self.printSystemInfo(False)
-		pprint('INITIALIZING FTRACE...')
+	def initFtrace(self, quiet=False):
+		if not quiet:
+			sysvals.printSystemInfo(False)
+			pprint('INITIALIZING FTRACE...')
 		# turn trace off
 		self.fsetVal('0', 'tracing_on')
 		self.cleanupFtrace()
@@ -746,7 +764,7 @@ class SystemValues:
 			if tgtsize < 65536:
 				tgtsize = int(self.fgetVal('buffer_size_kb')) * cpus
 				break
-		pprint('Setting trace buffers to %d kB (%d kB per cpu)' % (tgtsize, tgtsize/cpus))
+		self.vprint('Setting trace buffers to %d kB (%d kB per cpu)' % (tgtsize, tgtsize/cpus))
 		# initialize the callgraph trace
 		if(self.usecallgraph):
 			# set trace type
@@ -782,7 +800,8 @@ class SystemValues:
 			if self.usedevsrc:
 				for name in self.dev_tracefuncs:
 					self.defaultKprobe(name, self.dev_tracefuncs[name])
-			pprint('INITIALIZING KPROBES...')
+			if not quiet:
+				pprint('INITIALIZING KPROBES...')
 			self.addKprobes(self.verbose)
 		if(self.usetraceevents):
 			# turn trace events on
@@ -827,21 +846,10 @@ class SystemValues:
 				fw = test['fw']
 				if(fw):
 					fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
-			if 'mcelog' in test:
-				fp.write('# mcelog %s\n' % test['mcelog'])
 			if 'turbo' in test:
 				fp.write('# turbostat %s\n' % test['turbo'])
-			if 'bat' in test:
-				(a1, c1), (a2, c2) = test['bat']
-				fp.write('# battery %s %d %s %d\n' % (a1, c1, a2, c2))
 			if 'wifi' in test:
-				wstr = []
-				for wifi in test['wifi']:
-					tmp = []
-					for key in sorted(wifi):
-						tmp.append('%s:%s' % (key, wifi[key]))
-					wstr.append('|'.join(tmp))
-				fp.write('# wifi %s\n' % (','.join(wstr)))
+				fp.write('# wifi %s\n' % test['wifi'])
 			if test['error'] or len(testdata) > 1:
 				fp.write('# enter_sleep_error %s\n' % test['error'])
 		return fp
@@ -901,23 +909,7 @@ class SystemValues:
 	def b64zip(self, data):
 		out = base64.b64encode(codecs.encode(data.encode(), 'zlib')).decode()
 		return out
-	def mcelog(self, clear=False):
-		cmd = self.getExec('mcelog')
-		if not cmd:
-			return ''
-		if clear:
-			call(cmd+' > /dev/null 2>&1', shell=True)
-			return ''
-		try:
-			fp = Popen([cmd], stdout=PIPE, stderr=PIPE).stdout
-			out = ascii(fp.read()).strip()
-			fp.close()
-		except:
-			return ''
-		if not out:
-			return ''
-		return self.b64zip(out)
-	def platforminfo(self):
+	def platforminfo(self, cmdafter):
 		# add platform info on to a completed ftrace file
 		if not os.path.exists(self.ftracefile):
 			return False
@@ -1001,31 +993,76 @@ class SystemValues:
 		footer += '# platform-devinfo: %s\n' % self.b64zip(out)
 
 		# add a line for each of these commands with their outputs
-		cmds = [
-			['pcidevices', 'lspci', '-tv'],
-			['interrupts', 'cat', '/proc/interrupts'],
-			['gpecounts', 'sh', '-c', 'grep -v invalid /sys/firmware/acpi/interrupts/gpe*'],
-		]
-		for cargs in cmds:
-			name = cargs[0]
-			cmdline = ' '.join(cargs[1:])
-			cmdpath = self.getExec(cargs[1])
-			if not cmdpath:
+		for name, cmdline, info in cmdafter:
+			footer += '# platform-%s: %s | %s\n' % (name, cmdline, self.b64zip(info))
+
+		with self.openlog(self.ftracefile, 'a') as fp:
+			fp.write(footer)
+		return True
+	def commonPrefix(self, list):
+		if len(list) < 2:
+			return ''
+		prefix = list[0]
+		for s in list[1:]:
+			while s[:len(prefix)] != prefix and prefix:
+				prefix = prefix[:len(prefix)-1]
+			if not prefix:
+				break
+		if '/' in prefix and prefix[-1] != '/':
+			prefix = prefix[0:prefix.rfind('/')+1]
+		return prefix
+	def dictify(self, text, format):
+		out = dict()
+		header = True if format == 1 else False
+		delim = ' ' if format == 1 else ':'
+		for line in text.split('\n'):
+			if header:
+				header, out['@'] = False, line
+				continue
+			line = line.strip()
+			if delim in line:
+				data = line.split(delim, 1)
+				num = re.search(r'[\d]+', data[1])
+				if format == 2 and num:
+					out[data[0].strip()] = num.group()
+				else:
+					out[data[0].strip()] = data[1]
+		return out
+	def cmdinfo(self, begin, debug=False):
+		out = []
+		if begin:
+			self.cmd1 = dict()
+		for cargs in self.infocmds:
+			delta, name = cargs[0], cargs[1]
+			cmdline, cmdpath = ' '.join(cargs[2:]), self.getExec(cargs[2])
+			if not cmdpath or (begin and not delta):
 				continue
-			cmd = [cmdpath] + cargs[2:]
 			try:
-				fp = Popen(cmd, stdout=PIPE, stderr=PIPE).stdout
+				fp = Popen([cmdpath]+cargs[3:], stdout=PIPE, stderr=PIPE).stdout
 				info = ascii(fp.read()).strip()
 				fp.close()
 			except:
 				continue
-			if not info:
-				continue
-			footer += '# platform-%s: %s | %s\n' % (name, cmdline, self.b64zip(info))
-
-		with self.openlog(self.ftracefile, 'a') as fp:
-			fp.write(footer)
-		return True
+			if not debug and begin:
+				self.cmd1[name] = self.dictify(info, delta)
+			elif not debug and delta and name in self.cmd1:
+				before, after = self.cmd1[name], self.dictify(info, delta)
+				dinfo = ('\t%s\n' % before['@']) if '@' in before else ''
+				prefix = self.commonPrefix(list(before.keys()))
+				for key in sorted(before):
+					if key in after and before[key] != after[key]:
+						title = key.replace(prefix, '')
+						if delta == 2:
+							dinfo += '\t%s : %s -> %s\n' % \
+								(title, before[key].strip(), after[key].strip())
+						else:
+							dinfo += '%10s (start) : %s\n%10s (after) : %s\n' % \
+								(title, before[key], title, after[key])
+				dinfo = '\tnothing changed' if not dinfo else dinfo.rstrip()
+				out.append((name, cmdline, dinfo))
+			else:
+				out.append((name, cmdline, '\tnothing' if not info else info))
+		return out
 	def haveTurbostat(self):
 		if not self.tstat:
 			return False
@@ -1035,8 +1072,8 @@ class SystemValues:
 		fp = Popen([cmd, '-v'], stdout=PIPE, stderr=PIPE).stderr
 		out = ascii(fp.read()).strip()
 		fp.close()
-		if re.match('turbostat version [0-9\.]* .*', out):
-			sysvals.vprint(out)
+		if re.match('turbostat version .*', out):
+			self.vprint(out)
 			return True
 		return False
 	def turbostat(self):
@@ -1056,11 +1093,11 @@ class SystemValues:
 		fp.close()
 		if not keyline or not valline or len(keyline) != len(valline):
 			errmsg = 'unrecognized turbostat output:\n'+rawout.strip()
-			sysvals.vprint(errmsg)
-			if not sysvals.verbose:
+			self.vprint(errmsg)
+			if not self.verbose:
 				pprint(errmsg)
 			return ''
-		if sysvals.verbose:
+		if self.verbose:
 			pprint(rawout.strip())
 		out = []
 		for key in keyline:
@@ -1068,30 +1105,36 @@ class SystemValues:
 			val = valline[idx]
 			out.append('%s=%s' % (key, val))
 		return '|'.join(out)
-	def checkWifi(self):
-		out = dict()
-		iwcmd, ifcmd = self.getExec('iwconfig'), self.getExec('ifconfig')
-		if not iwcmd or not ifcmd:
-			return out
-		fp = Popen(iwcmd, stdout=PIPE, stderr=PIPE).stdout
-		for line in fp:
-			m = re.match('(?P<dev>\S*) .* ESSID:(?P<ess>\S*)', ascii(line))
-			if not m:
+	def wifiDetails(self, dev):
+		try:
+			info = open('/sys/class/net/%s/device/uevent' % dev, 'r').read().strip()
+		except:
+			return dev
+		vals = [dev]
+		for prop in info.split('\n'):
+			if prop.startswith('DRIVER=') or prop.startswith('PCI_ID='):
+				vals.append(prop.split('=')[-1])
+		return ':'.join(vals)
+	def checkWifi(self, dev=''):
+		try:
+			w = open('/proc/net/wireless', 'r').read().strip()
+		except:
+			return ''
+		for line in reversed(w.split('\n')):
+			m = re.match(' *(?P<dev>.*): (?P<stat>[0-9a-f]*) .*', w.split('\n')[-1])
+			if not m or (dev and dev != m.group('dev')):
 				continue
-			out['device'] = m.group('dev')
-			if '"' in m.group('ess'):
-				out['essid'] = m.group('ess').strip('"')
-				break
-		fp.close()
-		if 'device' in out:
-			fp = Popen([ifcmd, out['device']], stdout=PIPE, stderr=PIPE).stdout
-			for line in fp:
-				m = re.match('.* inet (?P<ip>[0-9\.]*)', ascii(line))
-				if m:
-					out['ip'] = m.group('ip')
-					break
-			fp.close()
-		return out
+			return m.group('dev')
+		return ''
+	def pollWifi(self, dev, timeout=60):
+		start = time.time()
+		while (time.time() - start) < timeout:
+			w = self.checkWifi(dev)
+			if w:
+				return '%s reconnected %.2f' % \
+					(self.wifiDetails(dev), max(0, time.time() - start))
+			time.sleep(0.01)
+		return '%s timeout %d' % (self.wifiDetails(dev), timeout)
 	def errorSummary(self, errinfo, msg):
 		found = False
 		for entry in errinfo:
@@ -1113,8 +1156,9 @@ class SystemValues:
 				arr[j] = arr[j]\
 					.replace('\\', '\\\\').replace(']', '\]').replace('[', '\[')\
 					.replace('.', '\.').replace('+', '\+').replace('*', '\*')\
-					.replace('(', '\(').replace(')', '\)')
-		mstr = ' '.join(arr)
+					.replace('(', '\(').replace(')', '\)').replace('}', '\}')\
+					.replace('{', '\{')
+		mstr = ' *'.join(arr)
 		entry = {
 			'line': msg,
 			'match': mstr,
@@ -1122,6 +1166,44 @@ class SystemValues:
 			'urls': {self.hostname: [self.htmlfile]}
 		}
 		errinfo.append(entry)
+	def multistat(self, start, idx, finish):
+		if 'time' in self.multitest:
+			id = '%d Duration=%dmin' % (idx+1, self.multitest['time'])
+		else:
+			id = '%d/%d' % (idx+1, self.multitest['count'])
+		t = time.time()
+		if 'start' not in self.multitest:
+			self.multitest['start'] = self.multitest['last'] = t
+			self.multitest['total'] = 0.0
+			pprint('TEST (%s) START' % id)
+			return
+		dt = t - self.multitest['last']
+		if not start:
+			if idx == 0 and self.multitest['delay'] > 0:
+				self.multitest['total'] += self.multitest['delay']
+			pprint('TEST (%s) COMPLETE -- Duration %.1fs' % (id, dt))
+			return
+		self.multitest['total'] += dt
+		self.multitest['last'] = t
+		avg = self.multitest['total'] / idx
+		if 'time' in self.multitest:
+			left = finish - datetime.now()
+			left -= timedelta(microseconds=left.microseconds)
+		else:
+			left = timedelta(seconds=((self.multitest['count'] - idx) * int(avg)))
+		pprint('TEST (%s) START - Avg Duration %.1fs, Time left %s' % \
+			(id, avg, str(left)))
+	def multiinit(self, c, d):
+		sz, unit = 'count', 'm'
+		if c.endswith('d') or c.endswith('h') or c.endswith('m'):
+			sz, unit, c = 'time', c[-1], c[:-1]
+		self.multitest['run'] = True
+		self.multitest[sz] = getArgInt('multi: n d (exec count)', c, 1, 1000000, False)
+		self.multitest['delay'] = getArgInt('multi: n d (delay between tests)', d, 0, 3600, False)
+		if unit == 'd':
+			self.multitest[sz] *= 1440
+		elif unit == 'h':
+			self.multitest[sz] *= 60
 
 sysvals = SystemValues()
 switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
@@ -1210,25 +1292,30 @@ class Data:
 		'resume_complete': {'order': 9, 'color': '#FFFFCC'},
 	}
 	errlist = {
-		'HWERROR' : '.*\[ *Hardware Error *\].*',
-		'FWBUG'   : '.*\[ *Firmware Bug *\].*',
-		'BUG'     : '.*BUG.*',
-		'ERROR'   : '.*ERROR.*',
-		'WARNING' : '.*WARNING.*',
-		'IRQ'     : '.*genirq: .*',
-		'TASKFAIL': '.*Freezing of tasks *.*',
-		'ACPI'    : '.*ACPI *(?P<b>[A-Za-z]*) *Error[: ].*',
-		'DEVFAIL' : '.* failed to (?P<b>[a-z]*) async: .*',
-		'DISKFULL': '.*No space left on device.*',
-		'USBERR'  : '.*usb .*device .*, error [0-9-]*',
-		'ATAERR'  : ' *ata[0-9\.]*: .*failed.*',
-		'MEIERR'  : ' *mei.*: .*failed.*',
-		'TPMERR'  : '(?i) *tpm *tpm[0-9]*: .*error.*',
+		'HWERROR' : r'.*\[ *Hardware Error *\].*',
+		'FWBUG'   : r'.*\[ *Firmware Bug *\].*',
+		'BUG'     : r'(?i).*\bBUG\b.*',
+		'ERROR'   : r'(?i).*\bERROR\b.*',
+		'WARNING' : r'(?i).*\bWARNING\b.*',
+		'FAULT'   : r'(?i).*\bFAULT\b.*',
+		'FAIL'    : r'(?i).*\bFAILED\b.*',
+		'INVALID' : r'(?i).*\bINVALID\b.*',
+		'CRASH'   : r'(?i).*\bCRASHED\b.*',
+		'IRQ'     : r'.*\bgenirq: .*',
+		'TASKFAIL': r'.*Freezing of tasks *.*',
+		'ACPI'    : r'.*\bACPI *(?P<b>[A-Za-z]*) *Error[: ].*',
+		'DISKFULL': r'.*\bNo space left on device.*',
+		'USBERR'  : r'.*usb .*device .*, error [0-9-]*',
+		'ATAERR'  : r' *ata[0-9\.]*: .*failed.*',
+		'MEIERR'  : r' *mei.*: .*failed.*',
+		'TPMERR'  : r'(?i) *tpm *tpm[0-9]*: .*error.*',
 	}
 	def __init__(self, num):
 		idchar = 'abcdefghij'
 		self.start = 0.0 # test start
 		self.end = 0.0   # test end
+		self.hwstart = 0 # rtc test start
+		self.hwend = 0   # rtc test end
 		self.tSuspended = 0.0 # low-level suspend start
 		self.tResumed = 0.0   # low-level resume start
 		self.tKernSus = 0.0   # kernel level suspend start
@@ -1240,10 +1327,8 @@ class Data:
 		self.stamp = 0
 		self.outfile = ''
 		self.kerror = False
-		self.battery = 0
-		self.wifi = 0
+		self.wifi = dict()
 		self.turbostat = 0
-		self.mcelog = 0
 		self.enterfail = ''
 		self.currphase = ''
 		self.pstl = dict()    # process timeline
@@ -1308,6 +1393,8 @@ class Data:
 				continue
 			dir = 'suspend' if t < self.tSuspended else 'resume'
 			msg = m.group('msg')
+			if re.match('capability: warning: .*', msg):
+				continue
 			for err in self.errlist:
 				if re.match(self.errlist[err], msg):
 					list.append((msg, err, dir, t, i, i))
@@ -1316,17 +1403,26 @@ class Data:
 		msglist = []
 		for msg, type, dir, t, idx1, idx2 in list:
 			msglist.append(msg)
-			sysvals.vprint('kernel %s found in %s at %f' % (type, dir, t))
 			self.errorinfo[dir].append((type, t, idx1, idx2))
 		if self.kerror:
 			sysvals.dmesglog = True
 		if len(self.dmesgtext) < 1 and sysvals.dmesgfile:
 			lf.close()
 		return msglist
-	def setStart(self, time):
+	def setStart(self, time, msg=''):
 		self.start = time
-	def setEnd(self, time):
+		if msg:
+			try:
+				self.hwstart = datetime.strptime(msg, sysvals.tmstart)
+			except:
+				self.hwstart = 0
+	def setEnd(self, time, msg=''):
 		self.end = time
+		if msg:
+			try:
+				self.hwend = datetime.strptime(msg, sysvals.tmend)
+			except:
+				self.hwend = 0
 	def isTraceEventOutsideDeviceCalls(self, pid, time):
 		for phase in self.sortedPhases():
 			list = self.dmesg[phase]['list']
@@ -1546,6 +1642,14 @@ class Data:
 					self.trimTime(tS, tL, left)
 					self.tLow.append('%.0f'%(tL*1000))
 			lp = phase
+	def getMemTime(self):
+		if not self.hwstart or not self.hwend:
+			return
+		stime = (self.tSuspended - self.start) * 1000000
+		rtime = (self.end - self.tResumed) * 1000000
+		hws = self.hwstart + timedelta(microseconds=stime)
+		hwr = self.hwend - timedelta(microseconds=rtime)
+		self.tLow.append('%.0f'%((hwr - hws).total_seconds() * 1000))
 	def getTimeValues(self):
 		sktime = (self.tSuspended - self.tKernSus) * 1000
 		rktime = (self.tKernRes - self.tResumed) * 1000
@@ -1883,9 +1987,9 @@ class Data:
 			c = self.addProcessUsageEvent(ps, tres)
 			if c > 0:
 				sysvals.vprint('%25s (res): %d' % (ps, c))
-	def handleEndMarker(self, time):
+	def handleEndMarker(self, time, msg=''):
 		dm = self.dmesg
-		self.setEnd(time)
+		self.setEnd(time, msg)
 		self.initDevicegroups()
 		# give suspend_prepare an end if needed
 		if 'suspend_prepare' in dm and dm['suspend_prepare']['end'] < 0:
@@ -2071,7 +2175,7 @@ class FTraceLine:
 		if not self.fevent:
 			return False
 		if sysvals.usetracemarkers:
-			if(self.name == 'SUSPEND START'):
+			if(self.name.startswith('SUSPEND START')):
 				return True
 			return False
 		else:
@@ -2084,7 +2188,7 @@ class FTraceLine:
 		if not self.fevent:
 			return False
 		if sysvals.usetracemarkers:
-			if(self.name == 'RESUME COMPLETE'):
+			if(self.name.startswith('RESUME COMPLETE')):
 				return True
 			return False
 		else:
@@ -2444,7 +2548,7 @@ class Timeline:
 	def createHeader(self, sv, stamp):
 		if(not stamp['time']):
 			return
-		self.html += '<div class="version"><a href="https://01.org/suspendresume">%s v%s</a></div>' \
+		self.html += '<div class="version"><a href="https://01.org/pm-graph">%s v%s</a></div>' \
 			% (sv.title, sv.version)
 		if sv.logmsg and sv.testlog:
 			self.html += '<button id="showtest" class="logbtn btnfmt">log</button>'
@@ -2670,14 +2774,11 @@ class TestProps:
 	stampfmt = '# [a-z]*-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
-	batteryfmt = '^# battery (?P<a1>\w*) (?P<c1>\d*) (?P<a2>\w*) (?P<c2>\d*)'
-	wififmt    = '^# wifi (?P<w>.*)'
+	wififmt    = '^# wifi *(?P<d>\S*) *(?P<s>\S*) *(?P<t>[0-9\.]+).*'
 	tstatfmt   = '^# turbostat (?P<t>\S*)'
-	mcelogfmt  = '^# mcelog (?P<m>\S*)'
 	testerrfmt = '^# enter_sleep_error (?P<e>.*)'
 	sysinfofmt = '^# sysinfo .*'
 	cmdlinefmt = '^# command \| (?P<cmd>.*)'
-	kparamsfmt = '^# kparams \| (?P<kp>.*)'
 	devpropfmt = '# Device Properties: .*'
 	pinfofmt   = '# platform-(?P<val>[a-z,A-Z,0-9]*): (?P<info>.*)'
 	tracertypefmt = '# tracer: (?P<t>.*)'
@@ -2695,11 +2796,8 @@ class TestProps:
 		self.stamp = ''
 		self.sysinfo = ''
 		self.cmdline = ''
-		self.kparams = ''
 		self.testerror = []
-		self.mcelog = []
 		self.turbostat = []
-		self.battery = []
 		self.wifi = []
 		self.fwdata = []
 		self.ftrace_line_fmt = self.ftrace_line_fmt_nop
@@ -2721,21 +2819,12 @@ class TestProps:
 		elif re.match(self.sysinfofmt, line):
 			self.sysinfo = line
 			return True
-		elif re.match(self.kparamsfmt, line):
-			self.kparams = line
-			return True
 		elif re.match(self.cmdlinefmt, line):
 			self.cmdline = line
 			return True
-		elif re.match(self.mcelogfmt, line):
-			self.mcelog.append(line)
-			return True
 		elif re.match(self.tstatfmt, line):
 			self.turbostat.append(line)
 			return True
-		elif re.match(self.batteryfmt, line):
-			self.battery.append(line)
-			return True
 		elif re.match(self.wififmt, line):
 			self.wifi.append(line)
 			return True
@@ -2749,6 +2838,8 @@ class TestProps:
 	def parseStamp(self, data, sv):
 		# global test data
 		m = re.match(self.stampfmt, self.stamp)
+		if not self.stamp or not m:
+			doError('data does not include the expected stamp')
 		data.stamp = {'time': '', 'host': '', 'mode': ''}
 		dt = datetime(int(m.group('y'))+2000, int(m.group('m')),
 			int(m.group('d')), int(m.group('H')), int(m.group('M')),
@@ -2780,10 +2871,6 @@ class TestProps:
 		m = re.match(self.cmdlinefmt, self.cmdline)
 		if m:
 			sv.cmdline = m.group('cmd')
-		if self.kparams:
-			m = re.match(self.kparamsfmt, self.kparams)
-			if m:
-				sv.kparams = m.group('kp')
 		if not sv.stamp:
 			sv.stamp = data.stamp
 		# firmware data
@@ -2793,26 +2880,18 @@ class TestProps:
 				data.fwSuspend, data.fwResume = int(m.group('s')), int(m.group('r'))
 				if(data.fwSuspend > 0 or data.fwResume > 0):
 					data.fwValid = True
-		# mcelog data
-		if len(self.mcelog) > data.testnumber:
-			m = re.match(self.mcelogfmt, self.mcelog[data.testnumber])
-			if m:
-				data.mcelog = sv.b64unzip(m.group('m'))
 		# turbostat data
 		if len(self.turbostat) > data.testnumber:
 			m = re.match(self.tstatfmt, self.turbostat[data.testnumber])
 			if m:
 				data.turbostat = m.group('t')
-		# battery data
-		if len(self.battery) > data.testnumber:
-			m = re.match(self.batteryfmt, self.battery[data.testnumber])
-			if m:
-				data.battery = m.groups()
 		# wifi data
 		if len(self.wifi) > data.testnumber:
 			m = re.match(self.wififmt, self.wifi[data.testnumber])
 			if m:
-				data.wifi = m.group('w')
+				data.wifi = {'dev': m.group('d'), 'stat': m.group('s'),
+					'time': float(m.group('t'))}
+				data.stamp['wifi'] = m.group('d')
 		# sleep mode enter errors
 		if len(self.testerror) > data.testnumber:
 			m = re.match(self.testerrfmt, self.testerror[data.testnumber])
@@ -3012,13 +3091,13 @@ def appendIncompleteTraceLog(testruns):
 		if(t.startMarker()):
 			data = testrun[testidx].data
 			tp.parseStamp(data, sysvals)
-			data.setStart(t.time)
+			data.setStart(t.time, t.name)
 			continue
 		if(not data):
 			continue
 		# find the end of resume
 		if(t.endMarker()):
-			data.setEnd(t.time)
+			data.setEnd(t.time, t.name)
 			testidx += 1
 			if(testidx >= testcnt):
 				break
@@ -3081,7 +3160,7 @@ def parseTraceLog(live=False):
 		doError('%s does not exist' % sysvals.ftracefile)
 	if not live:
 		sysvals.setupAllKprobes()
-	ksuscalls = ['pm_prepare_console']
+	ksuscalls = ['ksys_sync', 'pm_prepare_console']
 	krescalls = ['pm_restore_console']
 	tracewatch = ['irq_wakeup']
 	if sysvals.usekprobes:
@@ -3094,7 +3173,7 @@ def parseTraceLog(live=False):
 	testruns = []
 	testdata = []
 	testrun = 0
-	data = 0
+	data, limbo = 0, True
 	tf = sysvals.openlog(sysvals.ftracefile, 'r')
 	phase = 'suspend_prepare'
 	for line in tf:
@@ -3141,16 +3220,16 @@ def parseTraceLog(live=False):
 			continue
 		# find the start of suspend
 		if(t.startMarker()):
-			data = Data(len(testdata))
+			data, limbo = Data(len(testdata)), False
 			testdata.append(data)
 			testrun = TestRun(data)
 			testruns.append(testrun)
 			tp.parseStamp(data, sysvals)
-			data.setStart(t.time)
+			data.setStart(t.time, t.name)
 			data.first_suspend_prepare = True
 			phase = data.setPhase('suspend_prepare', t.time, True)
 			continue
-		if(not data):
+		if(not data or limbo):
 			continue
 		# process cpu exec line
 		if t.type == 'tracing_mark_write':
@@ -3167,14 +3246,16 @@ def parseTraceLog(live=False):
 				continue
 		# find the end of resume
 		if(t.endMarker()):
-			data.handleEndMarker(t.time)
+			if data.tKernRes == 0:
+				data.tKernRes = t.time
+			data.handleEndMarker(t.time, t.name)
 			if(not sysvals.usetracemarkers):
 				# no trace markers? then quit and be sure to finish recording
 				# the event we used to trigger resume end
 				if('thaw_processes' in testrun.ttemp and len(testrun.ttemp['thaw_processes']) > 0):
 					# if an entry exists, assume this is its end
 					testrun.ttemp['thaw_processes'][-1]['end'] = t.time
-				break
+			limbo = True
 			continue
 		# trace event processing
 		if(t.fevent):
@@ -3197,7 +3278,7 @@ def parseTraceLog(live=False):
 				# -- phase changes --
 				# start of kernel suspend
 				if(re.match('suspend_enter\[.*', t.name)):
-					if(isbegin):
+					if(isbegin and data.tKernSus == 0):
 						data.tKernSus = t.time
 					continue
 				# suspend_prepare start
@@ -3225,7 +3306,7 @@ def parseTraceLog(live=False):
 				elif(re.match('machine_suspend\[.*', t.name)):
 					if(isbegin):
 						lp = data.lastPhase()
-						if lp == 'resume_machine':
+						if lp.startswith('resume_machine'):
 							data.dmesg[lp]['end'] = t.time
 						phase = data.setPhase('suspend_machine', data.dmesg[lp]['end'], True)
 						data.setPhase(phase, t.time, False)
@@ -3320,7 +3401,8 @@ def parseTraceLog(live=False):
 					'proc': m_proc,
 				})
 				# start of kernel resume
-				if(phase == 'suspend_prepare' and kprobename in ksuscalls):
+				if(data.tKernSus == 0 and phase == 'suspend_prepare' \
+					and kprobename in ksuscalls):
 					data.tKernSus = t.time
 			elif(t.freturn):
 				if(key not in tp.ktemp) or len(tp.ktemp[key]) < 1:
@@ -3355,7 +3437,7 @@ def parseTraceLog(live=False):
 		sysvals.vprint('WARNING: ftrace start marker is missing')
 	if data and not data.devicegroups:
 		sysvals.vprint('WARNING: ftrace end marker is missing')
-		data.handleEndMarker(t.time)
+		data.handleEndMarker(t.time, t.name)
 
 	if sysvals.suspendmode == 'command':
 		for test in testruns:
@@ -3476,6 +3558,10 @@ def parseTraceLog(live=False):
 					data.fwValid = False
 				sysvals.vprint('WARNING: phase "%s" is missing!' % p)
 			lp = p
+		if not terr and 'dev' in data.wifi and data.wifi['stat'] == 'timeout':
+			terr = '%s%s failed in wifi_resume <i>(%s %.0fs timeout)</i>' % \
+				(sysvals.suspendmode, tn, data.wifi['dev'], data.wifi['time'])
+			error.append(terr)
 		if not terr and data.enterfail:
 			pprint('test%s FAILED: enter %s failed with %s' % (tn, sysvals.suspendmode, data.enterfail))
 			terr = 'test%s failed to enter %s mode' % (tn, sysvals.suspendmode)
@@ -3933,7 +4019,7 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 	tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [dict(), dict()]
 	iMin, iMed, iMax = [0, 0], [0, 0], [0, 0]
 	num = 0
-	useturbo = False
+	useturbo = usewifi = False
 	lastmode = ''
 	cnt = dict()
 	for data in sorted(testruns, key=lambda v:(v['mode'], v['host'], v['kernel'], v['time'])):
@@ -3952,17 +4038,17 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 			tAvg, tMin, tMax, tMed = [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [dict(), dict()]
 			iMin, iMed, iMax = [0, 0], [0, 0], [0, 0]
 			num = 0
-		pkgpc10 = syslpi = ''
+		pkgpc10 = syslpi = wifi = ''
 		if 'pkgpc10' in data and 'syslpi' in data:
-			pkgpc10 = data['pkgpc10']
-			syslpi = data['syslpi']
-			useturbo = True
+			pkgpc10, syslpi, useturbo = data['pkgpc10'], data['syslpi'], True
+		if 'wifi' in data:
+			wifi, usewifi = data['wifi'], True
 		res = data['result']
 		tVal = [float(data['suspend']), float(data['resume'])]
 		list[mode]['data'].append([data['host'], data['kernel'],
 			data['time'], tVal[0], tVal[1], data['url'], res,
 			data['issues'], data['sus_worst'], data['sus_worsttime'],
-			data['res_worst'], data['res_worsttime'], pkgpc10, syslpi])
+			data['res_worst'], data['res_worsttime'], pkgpc10, syslpi, wifi])
 		idx = len(list[mode]['data']) - 1
 		if res.startswith('fail in'):
 			res = 'fail'
@@ -4002,7 +4088,12 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 	td = '\t<td>{0}</td>\n'
 	tdh = '\t<td{1}>{0}</td>\n'
 	tdlink = '\t<td><a href="{0}">html</a></td>\n'
-	colspan = '14' if useturbo else '12'
+	cols = 12
+	if useturbo:
+		cols += 2
+	if usewifi:
+		cols += 1
+	colspan = '%d' % cols
 
 	# table header
 	html += '<table>\n<tr>\n' + th.format('#') +\
@@ -4013,6 +4104,8 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 		th.format('Worst Resume Device') + th.format('RD Time')
 	if useturbo:
 		html += th.format('PkgPC10') + th.format('SysLPI')
+	if usewifi:
+		html += th.format('Wifi')
 	html += th.format('Detail')+'</tr>\n'
 	# export list into html
 	head = '<tr class="head"><td>{0}</td><td>{1}</td>'+\
@@ -4076,6 +4169,8 @@ def createHTMLSummarySimple(testruns, htmlfile, title):
 			if useturbo:
 				html += td.format(d[12])								# pkg_pc10
 				html += td.format(d[13])								# syslpi
+			if usewifi:
+				html += td.format(d[14])								# wifi
 			html += tdlink.format(d[5]) if d[5] else td.format('')		# url
 			html += '</tr>\n'
 			num += 1
@@ -4224,6 +4319,8 @@ def createHTML(testruns, testfail):
 			kerror = True
 		if(sysvals.suspendmode in ['freeze', 'standby']):
 			data.trimFreezeTime(testruns[-1].tSuspended)
+		else:
+			data.getMemTime()
 
 	# html function templates
 	html_error = '<div id="{1}" title="kernel error/warning" class="err" style="right:{0}%">{2}&rarr;</div>\n'
@@ -4242,13 +4339,10 @@ def createHTML(testruns, testfail):
 		'<td class="green">Execution Time: <b>{0} ms</b></td>'\
 		'<td class="yellow">Command: <b>{1}</b></td>'\
 		'</tr>\n</table>\n'
-	html_timegroups = '<table class="time2">\n<tr>'\
-		'<td class="green" title="time from kernel enter_state({5}) to firmware mode [kernel time only]">{4}Kernel Suspend: {0} ms</td>'\
-		'<td class="purple">{4}Firmware Suspend: {1} ms</td>'\
-		'<td class="purple">{4}Firmware Resume: {2} ms</td>'\
-		'<td class="yellow" title="time from firmware mode to return from kernel enter_state({5}) [kernel time only]">{4}Kernel Resume: {3} ms</td>'\
-		'</tr>\n</table>\n'
 	html_fail = '<table class="testfail"><tr><td>{0}</td></tr></table>\n'
+	html_kdesc = '<td class="{3}" title="time spent in kernel execution">{0}Kernel {2}: {1} ms</td>'
+	html_fwdesc = '<td class="{3}" title="time spent in firmware">{0}Firmware {2}: {1} ms</td>'
+	html_wifdesc = '<td class="yellow" title="time for wifi to reconnect after resume complete ({2})">{0}Wifi Resume: {1}</td>'
 
 	# html format variables
 	scaleH = 20
@@ -4264,13 +4358,10 @@ def createHTML(testruns, testfail):
 	# Generate the header for this timeline
 	for data in testruns:
 		tTotal = data.end - data.start
-		sktime, rktime = data.getTimeValues()
 		if(tTotal == 0):
 			doError('No timeline data')
-		if(len(data.tLow) > 0):
-			low_time = '+'.join(data.tLow)
 		if sysvals.suspendmode == 'command':
-			run_time = '%.0f'%((data.end-data.start)*1000)
+			run_time = '%.0f' % (tTotal * 1000)
 			if sysvals.testcommand:
 				testdesc = sysvals.testcommand
 			else:
@@ -4279,43 +4370,55 @@ def createHTML(testruns, testfail):
 				testdesc = ordinal(data.testnumber+1)+' '+testdesc
 			thtml = html_timetotal3.format(run_time, testdesc)
 			devtl.html += thtml
-		elif data.fwValid:
-			suspend_time = '%.0f'%(sktime + (data.fwSuspend/1000000.0))
-			resume_time = '%.0f'%(rktime + (data.fwResume/1000000.0))
-			testdesc1 = 'Total'
-			testdesc2 = ''
-			stitle = 'time from kernel enter_state(%s) to low-power mode [kernel & firmware time]' % sysvals.suspendmode
-			rtitle = 'time from low-power mode to return from kernel enter_state(%s) [firmware & kernel time]' % sysvals.suspendmode
-			if(len(testruns) > 1):
-				testdesc1 = testdesc2 = ordinal(data.testnumber+1)
-				testdesc2 += ' '
-			if(len(data.tLow) == 0):
-				thtml = html_timetotal.format(suspend_time, \
-					resume_time, testdesc1, stitle, rtitle)
-			else:
-				thtml = html_timetotal2.format(suspend_time, low_time, \
-					resume_time, testdesc1, stitle, rtitle)
-			devtl.html += thtml
+			continue
+		# typical full suspend/resume header
+		stot, rtot = sktime, rktime = data.getTimeValues()
+		ssrc, rsrc, testdesc, testdesc2 = ['kernel'], ['kernel'], 'Kernel', ''
+		if data.fwValid:
+			stot += (data.fwSuspend/1000000.0)
+			rtot += (data.fwResume/1000000.0)
+			ssrc.append('firmware')
+			rsrc.append('firmware')
+			testdesc = 'Total'
+		if 'time' in data.wifi and data.wifi['stat'] != 'timeout':
+			rtot += data.end - data.tKernRes + (data.wifi['time'] * 1000.0)
+			rsrc.append('wifi')
+			testdesc = 'Total'
+		suspend_time, resume_time = '%.3f' % stot, '%.3f' % rtot
+		stitle = 'time from kernel suspend start to %s mode [%s time]' % \
+			(sysvals.suspendmode, ' & '.join(ssrc))
+		rtitle = 'time from %s mode to kernel resume complete [%s time]' % \
+			(sysvals.suspendmode, ' & '.join(rsrc))
+		if(len(testruns) > 1):
+			testdesc = testdesc2 = ordinal(data.testnumber+1)
+			testdesc2 += ' '
+		if(len(data.tLow) == 0):
+			thtml = html_timetotal.format(suspend_time, \
+				resume_time, testdesc, stitle, rtitle)
+		else:
+			low_time = '+'.join(data.tLow)
+			thtml = html_timetotal2.format(suspend_time, low_time, \
+				resume_time, testdesc, stitle, rtitle)
+		devtl.html += thtml
+		if not data.fwValid and 'dev' not in data.wifi:
+			continue
+		# extra detail when the times come from multiple sources
+		thtml = '<table class="time2">\n<tr>'
+		thtml += html_kdesc.format(testdesc2, '%.3f'%sktime, 'Suspend', 'green')
+		if data.fwValid:
 			sftime = '%.3f'%(data.fwSuspend / 1000000.0)
 			rftime = '%.3f'%(data.fwResume / 1000000.0)
-			devtl.html += html_timegroups.format('%.3f'%sktime, \
-				sftime, rftime, '%.3f'%rktime, testdesc2, sysvals.suspendmode)
-		else:
-			suspend_time = '%.3f' % sktime
-			resume_time = '%.3f' % rktime
-			testdesc = 'Kernel'
-			stitle = 'time from kernel enter_state(%s) to firmware mode [kernel time only]' % sysvals.suspendmode
-			rtitle = 'time from firmware mode to return from kernel enter_state(%s) [kernel time only]' % sysvals.suspendmode
-			if(len(testruns) > 1):
-				testdesc = ordinal(data.testnumber+1)+' '+testdesc
-			if(len(data.tLow) == 0):
-				thtml = html_timetotal.format(suspend_time, \
-					resume_time, testdesc, stitle, rtitle)
+			thtml += html_fwdesc.format(testdesc2, sftime, 'Suspend', 'green')
+			thtml += html_fwdesc.format(testdesc2, rftime, 'Resume', 'yellow')
+		thtml += html_kdesc.format(testdesc2, '%.3f'%rktime, 'Resume', 'yellow')
+		if 'time' in data.wifi:
+			if data.wifi['stat'] != 'timeout':
+				wtime = '%.0f ms'%(data.end - data.tKernRes + (data.wifi['time'] * 1000.0))
 			else:
-				thtml = html_timetotal2.format(suspend_time, low_time, \
-					resume_time, testdesc, stitle, rtitle)
-			devtl.html += thtml
-
+				wtime = 'TIMEOUT'
+			thtml += html_wifdesc.format(testdesc2, wtime, data.wifi['dev'])
+		thtml += '</tr>\n</table>\n'
+		devtl.html += thtml
 	if testfail:
 		devtl.html += html_fail.format(testfail)
 
@@ -5082,28 +5185,32 @@ def setRuntimeSuspend(before=True):
 # Description:
 #	 Execute system suspend through the sysfs interface, then copy the output
 #	 dmesg and ftrace files to the test output directory.
-def executeSuspend():
+def executeSuspend(quiet=False):
 	pm = ProcessMonitor()
 	tp = sysvals.tpath
-	wifi = sysvals.checkWifi()
+	if sysvals.wifi:
+		wifi = sysvals.checkWifi()
 	testdata = []
-	battery = True if getBattery() else False
 	# run these commands to prepare the system for suspend
 	if sysvals.display:
-		pprint('SET DISPLAY TO %s' % sysvals.display.upper())
+		if not quiet:
+			pprint('SET DISPLAY TO %s' % sysvals.display.upper())
 		displayControl(sysvals.display)
 		time.sleep(1)
 	if sysvals.sync:
-		pprint('SYNCING FILESYSTEMS')
+		if not quiet:
+			pprint('SYNCING FILESYSTEMS')
 		call('sync', shell=True)
 	# mark the start point in the kernel ring buffer just as we start
 	sysvals.initdmesg()
 	# start ftrace
 	if(sysvals.usecallgraph or sysvals.usetraceevents):
-		pprint('START TRACING')
+		if not quiet:
+			pprint('START TRACING')
 		sysvals.fsetVal('1', 'tracing_on')
 		if sysvals.useprocmon:
 			pm.start()
+	sysvals.cmdinfo(True)
 	# execute however many s/r runs requested
 	for count in range(1,sysvals.execcount+1):
 		# x2delay in between test runs
@@ -5119,15 +5226,14 @@ def executeSuspend():
 				pprint('SUSPEND START')
 			else:
 				pprint('SUSPEND START (press a key to resume)')
-		sysvals.mcelog(True)
-		bat1 = getBattery() if battery else False
 		# set rtcwake
 		if(sysvals.rtcwake):
-			pprint('will issue an rtcwake in %d seconds' % sysvals.rtcwaketime)
+			if not quiet:
+				pprint('will issue an rtcwake in %d seconds' % sysvals.rtcwaketime)
 			sysvals.rtcWakeAlarmOn()
 		# start of suspend trace marker
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			sysvals.fsetVal('SUSPEND START', 'trace_marker')
+			sysvals.fsetVal(datetime.now().strftime(sysvals.tmstart), 'trace_marker')
 		# predelay delay
 		if(count == 1 and sysvals.predelay > 0):
 			sysvals.fsetVal('WAIT %d' % sysvals.predelay, 'trace_marker')
@@ -5174,37 +5280,33 @@ def executeSuspend():
 		# return from suspend
 		pprint('RESUME COMPLETE')
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			sysvals.fsetVal('RESUME COMPLETE', 'trace_marker')
+			sysvals.fsetVal(datetime.now().strftime(sysvals.tmend), 'trace_marker')
+		if sysvals.wifi and wifi:
+			tdata['wifi'] = sysvals.pollWifi(wifi)
 		if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
 			tdata['fw'] = getFPDT(False)
-		mcelog = sysvals.mcelog()
-		if mcelog:
-			tdata['mcelog'] = mcelog
-		bat2 = getBattery() if battery else False
-		if battery and bat1 and bat2:
-			tdata['bat'] = (bat1, bat2)
-		if 'device' in wifi and 'ip' in wifi:
-			tdata['wifi'] = (wifi, sysvals.checkWifi())
 		testdata.append(tdata)
+	cmdafter = sysvals.cmdinfo(False)
 	# stop ftrace
 	if(sysvals.usecallgraph or sysvals.usetraceevents):
 		if sysvals.useprocmon:
 			pm.stop()
 		sysvals.fsetVal('0', 'tracing_on')
 	# grab a copy of the dmesg output
-	pprint('CAPTURING DMESG')
+	if not quiet:
+		pprint('CAPTURING DMESG')
 	sysvals.getdmesg(testdata)
 	# grab a copy of the ftrace output
 	if(sysvals.usecallgraph or sysvals.usetraceevents):
-		pprint('CAPTURING TRACE')
+		if not quiet:
+			pprint('CAPTURING TRACE')
 		op = sysvals.writeDatafileHeader(sysvals.ftracefile, testdata)
 		fp = open(tp+'trace', 'r')
 		for line in fp:
 			op.write(line)
 		op.close()
 		sysvals.fsetVal('', 'trace')
-		sysvals.platforminfo()
-	return testdata
+		sysvals.platforminfo(cmdafter)
 
 def readFile(file):
 	if os.path.islink(file):
@@ -5447,25 +5549,6 @@ def dmidecode(mempath, fatal=False):
 		count += 1
 	return out
 
-def getBattery():
-	p, charge, bat = '/sys/class/power_supply', 0, {}
-	if not os.path.exists(p):
-		return False
-	for d in os.listdir(p):
-		type = sysvals.getVal(os.path.join(p, d, 'type')).strip().lower()
-		if type != 'battery':
-			continue
-		for v in ['status', 'energy_now', 'capacity_now']:
-			bat[v] = sysvals.getVal(os.path.join(p, d, v)).strip().lower()
-		break
-	if 'status' not in bat:
-		return False
-	ac = False if 'discharging' in bat['status'] else True
-	for v in ['energy_now', 'capacity_now']:
-		if v in bat and bat[v]:
-			charge = int(bat[v])
-	return (ac, charge)
-
 def displayControl(cmd):
 	xset, ret = 'timeout 10 xset -d :0.0 {0}', 0
 	if sysvals.sudouser:
@@ -5715,6 +5798,17 @@ def statusCheck(probecheck=False):
 		status = 'rtcwake is not properly supported'
 	pprint('    is rtcwake supported: %s' % res)
 
+	# check info commands
+	pprint('    optional commands this tool may use for info:')
+	no = sysvals.colorText('MISSING')
+	yes = sysvals.colorText('FOUND', 32)
+	for c in ['turbostat', 'mcelog', 'lspci', 'lsusb']:
+		if c == 'turbostat':
+			res = yes if sysvals.haveTurbostat() else no
+		else:
+			res = yes if sysvals.getExec(c) else no
+		pprint('        %s: %s' % (c, res))
+
 	if not probecheck:
 		return status
 
@@ -5780,8 +5874,9 @@ def getArgFloat(name, args, min, max, main=True):
 		doError(name+': value should be between %f and %f' % (min, max), True)
 	return val
 
-def processData(live=False):
-	pprint('PROCESSING DATA')
+def processData(live=False, quiet=False):
+	if not quiet:
+		pprint('PROCESSING DATA')
 	sysvals.vprint('usetraceevents=%s, usetracemarkers=%s, usekprobes=%s' % \
 		(sysvals.usetraceevents, sysvals.usetracemarkers, sysvals.usekprobes))
 	error = ''
@@ -5796,20 +5891,17 @@ def processData(live=False):
 			parseKernelLog(data)
 		if(sysvals.ftracefile and (sysvals.usecallgraph or sysvals.usetraceevents)):
 			appendIncompleteTraceLog(testruns)
+	if not sysvals.stamp:
+		pprint('ERROR: data does not include the expected stamp')
+		return (testruns, {'error': 'timeline generation failed'})
 	shown = ['bios', 'biosdate', 'cpu', 'host', 'kernel', 'man', 'memfr',
-			'memsz', 'mode', 'numcpu', 'plat', 'time']
+			'memsz', 'mode', 'numcpu', 'plat', 'time', 'wifi']
 	sysvals.vprint('System Info:')
 	for key in sorted(sysvals.stamp):
 		if key in shown:
 			sysvals.vprint('    %-8s : %s' % (key.upper(), sysvals.stamp[key]))
-	if sysvals.kparams:
-		sysvals.vprint('Kparams:\n    %s' % sysvals.kparams)
 	sysvals.vprint('Command:\n    %s' % sysvals.cmdline)
 	for data in testruns:
-		if data.mcelog:
-			sysvals.vprint('MCELOG Data:')
-			for line in data.mcelog.split('\n'):
-				sysvals.vprint('    %s' % line)
 		if data.turbostat:
 			idx, s = 0, 'Turbostat:\n    '
 			for val in data.turbostat.split('|'):
@@ -5819,23 +5911,13 @@ def processData(live=False):
 					s += '\n    '
 				s += val + ' '
 			sysvals.vprint(s)
-		if data.battery:
-			a1, c1, a2, c2 = data.battery
-			s = 'Battery:\n    Before - AC: %s, Charge: %d\n     After - AC: %s, Charge: %d' % \
-				(a1, int(c1), a2, int(c2))
-			sysvals.vprint(s)
-		if data.wifi:
-			w = data.wifi.replace('|', ' ').split(',')
-			s = 'Wifi:\n    Before %s\n     After %s' % \
-				(w[0], w[1])
-			sysvals.vprint(s)
 		data.printDetails()
-		if len(sysvals.platinfo) > 0:
-			sysvals.vprint('\nPlatform Info:')
-			for info in sysvals.platinfo:
-				sysvals.vprint(info[0]+' - '+info[1])
-				sysvals.vprint(info[2])
-			sysvals.vprint('')
+	if len(sysvals.platinfo) > 0:
+		sysvals.vprint('\nPlatform Info:')
+		for info in sysvals.platinfo:
+			sysvals.vprint('[%s - %s]' % (info[0], info[1]))
+			sysvals.vprint(info[2])
+		sysvals.vprint('')
 	if sysvals.cgdump:
 		for data in testruns:
 			data.debugPrint()
@@ -5845,7 +5927,8 @@ def processData(live=False):
 		return (testruns, {'error': 'timeline generation failed'})
 	sysvals.vprint('Creating the html timeline (%s)...' % sysvals.htmlfile)
 	createHTML(testruns, error)
-	pprint('DONE')
+	if not quiet:
+		pprint('DONE')
 	data = testruns[0]
 	stamp = data.stamp
 	stamp['suspend'], stamp['resume'] = data.getTimeValues()
@@ -5872,31 +5955,28 @@ def rerunTest(htmlfile=''):
 			doError('a directory already exists with this name: %s' % sysvals.htmlfile)
 		elif not os.access(sysvals.htmlfile, os.W_OK):
 			doError('missing permission to write to %s' % sysvals.htmlfile)
-	testruns, stamp = processData(False)
-	sysvals.logmsg = ''
+	testruns, stamp = processData()
+	sysvals.resetlog()
 	return stamp
 
 # Function: runTest
 # Description:
 #	 execute a suspend/resume, gather the logs, and generate the output
-def runTest(n=0):
+def runTest(n=0, quiet=False):
 	# prepare for the test
-	sysvals.initFtrace()
+	sysvals.initFtrace(quiet)
 	sysvals.initTestOutput('suspend')
 
 	# execute the test
-	testdata = executeSuspend()
+	executeSuspend(quiet)
 	sysvals.cleanupFtrace()
 	if sysvals.skiphtml:
+		sysvals.outputResult({}, n)
 		sysvals.sudoUserchown(sysvals.testdir)
 		return
-	if not testdata[0]['error']:
-		testruns, stamp = processData(True)
-		for data in testruns:
-			del data
-	else:
-		stamp = testdata[0]
-
+	testruns, stamp = processData(True, quiet)
+	for data in testruns:
+		del data
 	sysvals.sudoUserchown(sysvals.testdir)
 	sysvals.outputResult(stamp, n)
 	if 'error' in stamp:
@@ -5904,13 +5984,14 @@ def runTest(n=0):
 	return 0
 
 def find_in_html(html, start, end, firstonly=True):
-	n, out = 0, []
-	while n < len(html):
-		m = re.search(start, html[n:])
+	n, cnt, out = 0, len(html), []
+	while n < cnt:
+		e = cnt if (n + 10000 > cnt or n == 0) else n + 10000
+		m = re.search(start, html[n:e])
 		if not m:
 			break
 		i = m.end()
-		m = re.search(end, html[n+i:])
+		m = re.search(end, html[n+i:e])
 		if not m:
 			break
 		j = m.start()
@@ -5945,7 +6026,7 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 	tstr = dt.strftime('%Y/%m/%d %H:%M:%S')
 	error = find_in_html(html, '<table class="testfail"><tr><td>', '</td>')
 	if error:
-		m = re.match('[a-z]* failed in (?P<p>[a-z0-9_]*) phase', error)
+		m = re.match('[a-z0-9]* failed in (?P<p>\S*).*', error)
 		if m:
 			result = 'fail in %s' % m.group('p')
 		else:
@@ -5974,6 +6055,9 @@ def data_from_html(file, outpath, issues, fulldetail=False):
 				elist[err[0]] += 1
 		for i in elist:
 			ilist.append('%sx%d' % (i, elist[i]) if elist[i] > 1 else i)
+	wifi = find_in_html(html, 'Wifi Resume: ', '</td>')
+	if wifi:
+		extra['wifi'] = wifi
 	low = find_in_html(html, 'freeze time: <b>', ' ms</b>')
 	if low and '|' in low:
 		issue = 'FREEZEx%d' % len(low.split('|'))
@@ -6048,13 +6132,15 @@ def genHtml(subdir, force=False):
 	for dirname, dirnames, filenames in os.walk(subdir):
 		sysvals.dmesgfile = sysvals.ftracefile = sysvals.htmlfile = ''
 		for filename in filenames:
-			if(re.match('.*_dmesg.txt', filename)):
-				sysvals.dmesgfile = os.path.join(dirname, filename)
-			elif(re.match('.*_ftrace.txt', filename)):
-				sysvals.ftracefile = os.path.join(dirname, filename)
+			file = os.path.join(dirname, filename)
+			if sysvals.usable(file):
+				if(re.match('.*_dmesg.txt', filename)):
+					sysvals.dmesgfile = file
+				elif(re.match('.*_ftrace.txt', filename)):
+					sysvals.ftracefile = file
 		sysvals.setOutputFile()
-		if sysvals.ftracefile and sysvals.htmlfile and \
-			(force or not os.path.exists(sysvals.htmlfile)):
+		if (sysvals.dmesgfile or sysvals.ftracefile) and sysvals.htmlfile and \
+			(force or not sysvals.usable(sysvals.htmlfile)):
 			pprint('FTRACE: %s' % sysvals.ftracefile)
 			if sysvals.dmesgfile:
 				pprint('DMESG : %s' % sysvals.dmesgfile)
@@ -6169,9 +6255,9 @@ def configFromFile(file):
 				sysvals.cgtest = getArgInt('cgtest', value, 0, 1, False)
 			elif(option == 'cgphase'):
 				d = Data(0)
-				if value not in d.sortedPhases():
+				if value not in d.phasedef:
 					doError('invalid phase --> (%s: %s), valid phases are %s'\
-						% (option, value, d.sortedPhases()), True)
+						% (option, value, d.phasedef.keys()), True)
 				sysvals.cgphase = value
 			elif(option == 'fadd'):
 				file = sysvals.configFile(value)
@@ -6184,9 +6270,7 @@ def configFromFile(file):
 				nums = value.split()
 				if len(nums) != 2:
 					doError('multi requires 2 integers (exec_count and delay)', True)
-				sysvals.multitest['run'] = True
-				sysvals.multitest['count'] = getArgInt('multi: n d (exec count)', nums[0], 2, 1000000, False)
-				sysvals.multitest['delay'] = getArgInt('multi: n d (delay between tests)', nums[1], 0, 3600, False)
+				sysvals.multiinit(nums[0], nums[1])
 			elif(option == 'devicefilter'):
 				sysvals.setDeviceFilter(value)
 			elif(option == 'expandcg'):
@@ -6342,6 +6426,7 @@ def printHelp():
 	'   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)\n'\
 	'   -skiphtml    Run the test and capture the trace logs, but skip the timeline (default: disabled)\n'\
 	'   -result fn   Export a results table to a text file for parsing.\n'\
+	'   -wifi        If a wifi connection is available, check that it reconnects after resume.\n'\
 	'  [testprep]\n'\
 	'   -sync        Sync the filesystems before starting the test\n'\
 	'   -rs on/off   Enable/disable runtime suspend for all devices, restore all after test\n'\
@@ -6356,8 +6441,10 @@ def printHelp():
 	'   -predelay t  Include t ms delay before 1st suspend (default: 0 ms)\n'\
 	'   -postdelay t Include t ms delay after last resume (default: 0 ms)\n'\
 	'   -mindev ms   Discard all device blocks shorter than ms milliseconds (e.g. 0.001 for us)\n'\
-	'   -multi n d   Execute <n> consecutive tests at <d> seconds intervals. The outputs will\n'\
-	'                be created in a new subdirectory with a summary page.\n'\
+	'   -multi n d   Execute <n> consecutive tests at <d> seconds intervals. If <n> is followed\n'\
+	'                by a "d", "h", or "m" execute for <n> days, hours, or mins instead.\n'\
+	'                The outputs will be created in a new subdirectory with a summary page.\n'\
+	'   -maxfail n   Abort a -multi run after n consecutive fails (default is 0 = never abort)\n'\
 	'  [debug]\n'\
 	'   -f           Use ftrace to create device callgraphs (default: disabled)\n'\
 	'   -ftop        Use ftrace on the top level call: "%s" (default: disabled)\n'\
@@ -6379,11 +6466,11 @@ def printHelp():
 	'   -modes       List available suspend modes\n'\
 	'   -status      Test to see if the system is enabled to run this tool\n'\
 	'   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table\n'\
-	'   -battery     Print out battery info (if available)\n'\
-	'   -wifi        Print out wifi connection info (if wireless-tools and device exists)\n'\
+	'   -wificheck   Print out wifi connection info\n'\
 	'   -x<mode>     Test xset by toggling the given mode (on/off/standby/suspend)\n'\
 	'   -sysinfo     Print out system info extracted from BIOS\n'\
 	'   -devinfo     Print out the pm settings of all devices which support runtime suspend\n'\
+	'   -cmdinfo     Print out all the platform info collected before and after suspend/resume\n'\
 	'   -flist       Print the list of functions currently being captured in ftrace\n'\
 	'   -flistall    Print all functions capable of being captured in ftrace\n'\
 	'   -summary dir Create a summary of tests in this dir [-genhtml builds missing html]\n'\
@@ -6399,8 +6486,8 @@ if __name__ == '__main__':
 	genhtml = False
 	cmd = ''
 	simplecmds = ['-sysinfo', '-modes', '-fpdt', '-flist', '-flistall',
-		'-devinfo', '-status', '-battery', '-xon', '-xoff', '-xstandby',
-		'-xsuspend', '-xinit', '-xreset', '-xstat', '-wifi']
+		'-devinfo', '-status', '-xon', '-xoff', '-xstandby', '-xsuspend',
+		'-xinit', '-xreset', '-xstat', '-wificheck', '-cmdinfo']
 	if '-f' in sys.argv:
 		sysvals.cgskip = sysvals.configFile('cgskip.txt')
 	# loop through the command line arguments
@@ -6462,8 +6549,15 @@ if __name__ == '__main__':
 			sysvals.usedevsrc = True
 		elif(arg == '-sync'):
 			sysvals.sync = True
+		elif(arg == '-wifi'):
+			sysvals.wifi = True
 		elif(arg == '-gzip'):
 			sysvals.gzip = True
+		elif(arg == '-info'):
+			try:
+				val = next(args)
+			except:
+				doError('-info requires one string argument', True)
 		elif(arg == '-rs'):
 			try:
 				val = next(args)
@@ -6555,10 +6649,14 @@ if __name__ == '__main__':
 			sysvals.cgexp = True
 		elif(arg == '-srgap'):
 			sysvals.srgap = 5
+		elif(arg == '-maxfail'):
+			sysvals.maxfail = getArgInt('-maxfail', args, 0, 1000000)
 		elif(arg == '-multi'):
-			sysvals.multitest['run'] = True
-			sysvals.multitest['count'] = getArgInt('-multi n d (exec count)', args, 2, 1000000)
-			sysvals.multitest['delay'] = getArgInt('-multi n d (delay between tests)', args, 0, 3600)
+			try:
+				c, d = next(args), next(args)
+			except:
+				doError('-multi requires two values', True)
+			sysvals.multiinit(c, d)
 		elif(arg == '-o'):
 			try:
 				val = next(args)
@@ -6655,13 +6753,6 @@ if __name__ == '__main__':
 		elif(cmd == 'fpdt'):
 			if not getFPDT(True):
 				ret = 1
-		elif(cmd == 'battery'):
-			out = getBattery()
-			if out:
-				pprint('AC Connect    : %s\nBattery Charge: %d' % out)
-			else:
-				pprint('no battery found')
-				ret = 1
 		elif(cmd == 'sysinfo'):
 			sysvals.printSystemInfo(True)
 		elif(cmd == 'devinfo'):
@@ -6679,13 +6770,15 @@ if __name__ == '__main__':
 			ret = displayControl(cmd[1:])
 		elif(cmd == 'xstat'):
 			pprint('Display Status: %s' % displayControl('stat').upper())
-		elif(cmd == 'wifi'):
-			out = sysvals.checkWifi()
-			if 'device' not in out:
-				pprint('WIFI interface not found')
+		elif(cmd == 'wificheck'):
+			dev = sysvals.checkWifi()
+			if dev:
+				print('%s is connected' % sysvals.wifiDetails(dev))
 			else:
-				for key in sorted(out):
-					pprint('%6s: %s' % (key.upper(), out[key]))
+				print('No wifi connection found')
+		elif(cmd == 'cmdinfo'):
+			for out in sysvals.cmdinfo(False, True):
+				print('[%s - %s]\n%s\n' % out)
 		sys.exit(ret)
 
 	# if instructed, re-analyze existing data files
@@ -6720,24 +6813,38 @@ if __name__ == '__main__':
 	setRuntimeSuspend(True)
 	if sysvals.display:
 		displayControl('init')
-	ret = 0
+	failcnt, ret = 0, 0
 	if sysvals.multitest['run']:
 		# run multiple tests in a separate subdirectory
 		if not sysvals.outdir:
-			s = 'suspend-x%d' % sysvals.multitest['count']
-			sysvals.outdir = datetime.now().strftime(s+'-%y%m%d-%H%M%S')
+			if 'time' in sysvals.multitest:
+				s = '-%dm' % sysvals.multitest['time']
+			else:
+				s = '-x%d' % sysvals.multitest['count']
+			sysvals.outdir = datetime.now().strftime('suspend-%y%m%d-%H%M%S'+s)
 		if not os.path.isdir(sysvals.outdir):
 			os.makedirs(sysvals.outdir)
+		sysvals.sudoUserchown(sysvals.outdir)
+		finish = datetime.now()
+		if 'time' in sysvals.multitest:
+			finish += timedelta(minutes=sysvals.multitest['time'])
 		for i in range(sysvals.multitest['count']):
-			if(i != 0):
+			sysvals.multistat(True, i, finish)
+			if i != 0 and sysvals.multitest['delay'] > 0:
 				pprint('Waiting %d seconds...' % (sysvals.multitest['delay']))
 				time.sleep(sysvals.multitest['delay'])
-			pprint('TEST (%d/%d) START' % (i+1, sysvals.multitest['count']))
 			fmt = 'suspend-%y%m%d-%H%M%S'
 			sysvals.testdir = os.path.join(sysvals.outdir, datetime.now().strftime(fmt))
-			ret = runTest(i+1)
-			pprint('TEST (%d/%d) COMPLETE' % (i+1, sysvals.multitest['count']))
-			sysvals.logmsg = ''
+			ret = runTest(i+1, True)
+			failcnt = 0 if not ret else failcnt + 1
+			if sysvals.maxfail > 0 and failcnt >= sysvals.maxfail:
+				pprint('Maximum fail count of %d reached, aborting multitest' % (sysvals.maxfail))
+				break
+			time.sleep(5)
+			sysvals.resetlog()
+			sysvals.multistat(False, i, finish)
+			if 'time' in sysvals.multitest and datetime.now() >= finish:
+				break
 		if not sysvals.skiphtml:
 			runSummary(sysvals.outdir, False, False)
 		sysvals.sudoUserchown(sysvals.outdir)
-- 
2.17.1

