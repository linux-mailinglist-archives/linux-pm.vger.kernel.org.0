Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479CE1CE5C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfENRyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 13:54:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:60697 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfENRyE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 13:54:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 10:54:02 -0700
X-ExtLoop1: 1
Received: from unknown (HELO technocore.fios-router.home) ([10.254.92.80])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 10:54:02 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH 3/3] pm-graph 5.4 config and other files
Date:   Tue, 14 May 2019 10:53:59 -0700
Message-Id: <57b0452892640a336779036b7636b8c2cc46e3c4.1557855894.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Config/man page/README files:
- include the README in the pm-graph folder
- add more detail to the example config to describe more options
- update the sleepgraph man page to document the new arguments

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/README             | 552 ++++++++++++++++++++++++++++++++
 tools/power/pm-graph/config/example.cfg |  26 ++
 tools/power/pm-graph/sleepgraph.8       |  16 +-
 3 files changed, 592 insertions(+), 2 deletions(-)
 create mode 100644 tools/power/pm-graph/README

diff --git a/tools/power/pm-graph/README b/tools/power/pm-graph/README
new file mode 100644
index 000000000000..58a5591e3951
--- /dev/null
+++ b/tools/power/pm-graph/README
@@ -0,0 +1,552 @@
+                     p m - g r a p h
+
+   pm-graph: suspend/resume/boot timing analysis tools
+    Version: 5.4
+     Author: Todd Brandt <todd.e.brandt@intel.com>
+  Home Page: https://01.org/pm-graph
+
+ Report bugs/issues at bugzilla.kernel.org Tools/pm-graph
+	- https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
+
+ Full documentation available online & in man pages
+	- Getting Started:
+	  https://01.org/pm-graph/documentation/getting-started
+
+	- Config File Format:
+	  https://01.org/pm-graph/documentation/3-config-file-format
+
+	- upstream version in git:
+	  https://github.com/intel/pm-graph/
+
+ Table of Contents
+	- Overview
+	- Setup
+	- Usage
+		- Basic Usage
+		- Dev Mode Usage
+		- Proc Mode Usage
+	- Configuration Files
+		- Usage Examples
+		- Config File Options
+	- Custom Timeline Entries
+		- Adding/Editing Timeline Functions
+		- Adding/Editing Dev Timeline Source Functions
+		- Verifying your Custom Functions
+	- Testing on consumer linux Operating Systems
+		- Android
+
+------------------------------------------------------------------
+|                          OVERVIEW                              |
+------------------------------------------------------------------
+
+ This tool suite is designed to assist kernel and OS developers in optimizing
+ their linux stack's suspend/resume & boot time. Using a kernel image built
+ with a few extra options enabled, the tools will execute a suspend or boot,
+ and will capture dmesg and ftrace data. This data is transformed into a set of
+ timelines and a callgraph to give a quick and detailed view of which devices
+ and kernel processes are taking the most time in suspend/resume & boot.
+
+------------------------------------------------------------------
+|                            SETUP                               |
+------------------------------------------------------------------
+
+    These packages are required to execute the scripts
+       - python
+       - python-requests
+
+       Ubuntu:
+          sudo apt-get install python python-requests
+
+       Fedora:
+          sudo dnf install python python-requests
+
+    The tools can most easily be installed via git clone and make install
+
+    $> git clone http://github.com/intel/pm-graph.git
+    $> cd pm-graph
+    $> sudo make install
+    $> man sleepgraph ; man bootgraph
+
+    Setup involves some minor kernel configuration
+
+    The following kernel build options are required for all kernels:
+        CONFIG_DEVMEM=y
+        CONFIG_PM_DEBUG=y
+        CONFIG_PM_SLEEP_DEBUG=y
+        CONFIG_FTRACE=y
+        CONFIG_FUNCTION_TRACER=y
+        CONFIG_FUNCTION_GRAPH_TRACER=y
+        CONFIG_KPROBES=y
+        CONFIG_KPROBES_ON_FTRACE=y
+
+	In kernel 3.15.0, two patches were upstreamed which enable the
+        v3.0 behavior. These patches allow the tool to read all the
+        data from trace events instead of from dmesg. You can enable
+        this behavior on earlier kernels with these patches:
+
+        (kernel/pre-3.15/enable_trace_events_suspend_resume.patch)
+        (kernel/pre-3.15/enable_trace_events_device_pm_callback.patch)
+
+	If you're using a kernel older than 3.15.0, the following
+        additional kernel parameters are required:
+        (e.g. in file /etc/default/grub)
+        GRUB_CMDLINE_LINUX_DEFAULT="... initcall_debug log_buf_len=32M ..."
+
+	If you're using a kernel older than 3.11-rc2, the following simple
+		patch must be applied to enable ftrace data:
+        in file: kernel/power/suspend.c
+        in function: int suspend_devices_and_enter(suspend_state_t state)
+        remove call to "ftrace_stop();"
+        remove call to "ftrace_start();"
+
+        There is a patch which does this for kernel v3.8.0:
+        (kernel/pre-3.11-rc2/enable_ftrace_in_suspendresume.patch)
+
+
+
+------------------------------------------------------------------
+|                            USAGE                               |
+------------------------------------------------------------------
+
+Basic Usage
+___________
+
+ 1) First configure a kernel using the instructions from the previous sections.
+    Then build, install, and boot with it.
+ 2) Open up a terminal window and execute the mode list command:
+
+	%> sudo ./sleepgraph.py -modes
+		['freeze', 'mem', 'disk']
+
+ Execute a test using one of the available power modes, e.g. mem (S3):
+
+	%> sudo ./sleepgraph.py -m mem -rtcwake 15
+
+		or with a config file
+
+	%> sudo ./sleepgraph.py -config config/suspend.cfg
+
+ When the system comes back you'll see the script finishing up and
+ creating the output files in the test subdir. It generates output
+ files in subdirectory: suspend-mmddyy-HHMMSS. The ftrace file can
+ be used to regenerate the html timeline with different options
+
+     HTML output:                    <hostname>_<mode>.html
+     raw dmesg output:               <hostname>_<mode>_dmesg.txt
+     raw ftrace output:              <hostname>_<mode>_ftrace.txt
+
+ View the html in firefox or chrome.
+
+
+Dev Mode Usage
+______________
+
+ Developer mode adds information on low level source calls to the timeline.
+ The tool sets kprobes on all delay and mutex calls to see which devices
+ are waiting for something and when. It also sets a suite of kprobes on
+ subsystem dependent calls to better fill out the timeline.
+
+ The tool will also expose kernel threads that don't normally show up in the
+ timeline. This is useful in discovering dependent threads to get a better
+ idea of what each device is waiting for. For instance, the scsi_eh thread,
+ a.k.a. scsi resume error handler, is what each SATA disk device waits for
+ before it can continue resume.
+
+ The timeline will be much larger if run with dev mode, so it can be useful
+ to set the -mindev option to clip out any device blocks that are too small
+ to see easily. The following command will give a nice dev mode run:
+
+ %> sudo ./sleepgraph.py -m mem -rtcwake 15 -mindev 1 -dev
+
+	or with a config file
+
+ %> sudo ./sleepgraph.py -config config/suspend-dev.cfg
+
+
+Proc Mode Usage
+_______________
+
+ Proc mode adds user process info to the timeline. This is done in a manner
+ similar to the bootchart utility, which graphs init processes and their
+ execution as the system boots. This tool option does the same thing but for
+ the period before and after suspend/resume.
+
+ In order to see any process info, there needs to be some delay before or
+ after resume since processes are frozen in suspend_prepare and thawed in
+ resume_complete. The predelay and postdelay args allow you to do this. It
+ can also be useful to run in x2 mode with an x2 delay, this way you can
+ see process activity before and after resume, and in between two
+ successive suspend/resumes.
+
+ The command can be run like this:
+
+ %> sudo ./sleepgraph.py -m mem -rtcwake 15 -x2 -x2delay 1000 -predelay 1000 -postdelay 1000 -proc
+
+	or with a config file
+
+ %> sudo ./sleepgraph.py -config config/suspend-proc.cfg
+
+
+------------------------------------------------------------------
+|                    CONFIGURATION FILES                         |
+------------------------------------------------------------------
+
+ Since 4.0 we've moved to using config files in lieu of command line options.
+ The config folder contains a collection of typical use cases.
+ There are corresponding configs for other power modes:
+
+	Simple suspend/resume with basic timeline (mem/freeze/standby)
+		config/suspend.cfg
+		config/freeze.cfg
+		config/standby.cfg
+
+	Dev mode suspend/resume with dev timeline (mem/freeze/standby)
+		config/suspend-dev.cfg
+		config/freeze-dev.cfg
+		config/standby-dev.cfg
+
+	Simple suspend/resume with timeline and callgraph (mem/freeze/standby)
+		config/suspend-callgraph.cfg
+		config/freeze-callgraph.cfg
+		config/standby-callgraph.cfg
+
+	Sample proc mode x2 run using mem suspend
+		config/suspend-x2-proc.cfg
+
+	Sample for editing timeline funcs (moves internal functions into config)
+		config/custom-timeline-functions.cfg
+
+	Sample debug config for serio subsystem
+		config/debug-serio-suspend.cfg
+
+
+Usage Examples
+______________
+
+ Run a simple mem suspend:
+ %> sudo ./sleepgraph.py -config config/suspend.cfg
+
+ Run a mem suspend with callgraph data:
+ %> sudo ./sleepgraph.py -config config/suspend-callgraph.cfg
+
+ Run a mem suspend with dev mode detail:
+ %> sudo ./sleepgraph.py -config config/suspend-dev.cfg
+
+
+Config File Options
+___________________
+
+ [Settings]
+
+ # Verbosity: print verbose messages (def: false)
+ verbose: false
+
+ # Suspend Mode: e.g. standby, mem, freeze, disk (def: mem)
+ mode: mem
+
+ # Output Directory Format: {hostname}, {date}, {time} give current values
+ output-dir: suspend-{hostname}-{date}-{time}
+
+ # Automatic Wakeup: use rtcwake to wakeup after X seconds (def: infinity)
+ rtcwake: 15
+
+ # Add Logs: add the dmesg and ftrace log to the html output (def: false)
+ addlogs: false
+
+ # Sus/Res Gap: insert a gap between sus & res in the timeline (def: false)
+ srgap: false
+
+ # Custom Command: Command to execute in lieu of suspend (def: "")
+ command: echo mem > /sys/power/state
+
+ # Proc mode: graph user processes and cpu usage in the timeline (def: false)
+ proc: false
+
+ # Dev mode: graph source functions in the timeline (def: false)
+ dev: false
+
+ # Suspend/Resume x2: run 2 suspend/resumes back to back (def: false)
+ x2: false
+
+ # x2 Suspend Delay: time delay between the two test runs in ms (def: 0 ms)
+ x2delay: 0
+
+ # Pre Suspend Delay: nclude an N ms delay before (1st) suspend (def: 0 ms)
+ predelay: 0
+
+ # Post Resume Delay: include an N ms delay after (last) resume (def: 0 ms)
+ postdelay: 0
+
+ # Min Device Length: graph only dev callbacks longer than min (def: 0.001 ms)
+ mindev: 0.001
+
+ # Callgraph: gather ftrace callgraph data on all timeline events (def: false)
+ callgraph: false
+
+ # Expand Callgraph: pre-expand the callgraph treeviews in html (def: false)
+ expandcg: false
+
+ # Min Callgraph Length: show callgraphs only if longer than min (def: 1 ms)
+ mincg: 1
+
+ # Timestamp Precision: number of sig digits in timestamps (0:S, [3:ms], 6:us)
+ timeprec: 3
+
+ # Device Filter: show only devs whose name/driver includes one of these strings
+ devicefilter: _cpu_up,_cpu_down,i915,usb
+
+ # Override default timeline entries:
+ # Do not use the internal default functions for timeline entries (def: false)
+ # Set this to true if you intend to only use the ones defined in the config
+ override-timeline-functions: true
+
+ # Override default dev timeline entries:
+ # Do not use the internal default functions for dev timeline entries (def: false)
+ # Set this to true if you intend to only use the ones defined in the config
+ override-dev-timeline-functions: true
+
+ # Call Loop Max Gap (dev mode only)
+ # merge loops of the same call if each is less than maxgap apart (def: 100us)
+ callloop-maxgap: 0.0001
+
+ # Call Loop Max Length (dev mode only)
+ # merge loops of the same call if each is less than maxlen in length (def: 5ms)
+ callloop-maxlen: 0.005
+
+------------------------------------------------------------------
+|                   CUSTOM TIMELINE ENTRIES                      |
+------------------------------------------------------------------
+
+Adding or Editing Timeline Functions
+____________________________________
+
+ The tool uses an array of function names to fill out empty spaces in the
+ timeline where device callbacks don't appear. For instance, in suspend_prepare
+ the tool adds the sys_sync and freeze_processes calls as virtual device blocks
+ in the timeline to show you where the time is going. These calls should fill
+ the timeline with contiguous data so that most kernel execution is covered.
+
+ It is possible to add new function calls to the timeline by adding them to
+ the config. It's also possible to copy the internal timeline functions into
+ the config so that you can override and edit them. Place them in the
+ timeline_functions_ARCH section with the name of your architecture appended.
+ i.e. for x86_64: [timeline_functions_x86_64]
+
+ Use the override-timeline-functions option if you only want to use your
+ custom calls, or leave it false to append them to the internal ones.
+
+ This section includes a list of functions (set using kprobes) which use both
+ symbol data and function arg data. The args are pulled directly from the
+ stack using this architecture's registers and stack formatting. Each entry
+ can include up to four pieces of info: The function name, a format string,
+ an argument list, and a color. But only a function name is required.
+
+ For a full example config, see config/custom-timeline-functions.cfg. It pulls
+ all the internal timeline functions into the config and allows you to edit
+ them.
+
+  Entry format:
+
+    function: format{fn_arg1}_{fn_arg2} fn_arg1 fn_arg2 ... [color=purple]
+
+  Required Arguments:
+
+    function: The symbol name for the function you want probed, this is the
+              minimum required for an entry, it will show up as the function
+              name with no arguments.
+
+        example: _cpu_up:
+
+  Optional Arguments:
+
+    format: The format to display the data on the timeline in. Use braces to
+            enclose the arg names.
+
+        example: CPU_ON[{cpu}]
+
+    color: The color of the entry block in the timeline. The default color is
+           transparent, so the entry shares the phase color. The color is an
+           html color string, either a word, or an RGB.
+
+        example: [color=#CC00CC]
+
+    arglist: A list of arguments from registers/stack addresses. See URL:
+             https://www.kernel.org/doc/Documentation/trace/kprobetrace.txt
+
+        example: cpu=%di:s32
+
+ Here is a full example entry. It displays cpu resume calls in the timeline
+ in orange. They will appear as CPU_ON[0], CPU_ON[1], etc.
+
+  [timeline_functions_x86_64]
+  _cpu_up: CPU_ON[{cpu}] cpu=%di:s32 [color=orange]
+
+
+Adding or Editing Dev Mode Timeline Source Functions
+____________________________________________________
+
+ In dev mode, the tool uses an array of function names to monitor source
+ execution within the timeline entries.
+
+ The function calls are displayed inside the main device/call blocks in the
+ timeline. However, if a function call is not within a main timeline event,
+ it will spawn an entirely new event named after the caller's kernel thread.
+ These asynchronous kernel threads will populate in a separate section
+ beneath the main device/call section.
+
+ The tool has a set of hard coded calls which focus on the most common use
+ cases: msleep, udelay, schedule_timeout, mutex_lock_slowpath, etc. These are
+ the functions that add a hardcoded time delay to the suspend/resume path.
+ The tool also includes some common functions native to important
+ subsystems: ata, i915, and ACPI, etc.
+
+ It is possible to add new function calls to the dev timeline by adding them
+ to the config. It's also possible to copy the internal dev timeline
+ functions into the config so that you can override and edit them. Place them
+ in the dev_timeline_functions_ARCH section with the name of your architecture
+ appended. i.e. for x86_64: [dev_timeline_functions_x86_64]
+
+ Use the override-dev-timeline-functions option if you only want to use your
+ custom calls, or leave it false to append them to the internal ones.
+
+ The format is the same as the timeline_functions_x86_64 section. It's a
+ list of functions (set using kprobes) which use both symbol data and function
+ arg data. The args are pulled directly from the stack using this
+ architecture's registers and stack formatting. Each entry can include up
+ to four pieces of info: The function name, a format string, an argument list,
+ and a color. But only the function name is required.
+
+ For a full example config, see config/custom-timeline-functions.cfg. It pulls
+ all the internal dev timeline functions into the config and allows you to edit
+ them.
+
+ Here is a full example entry. It displays the ATA port reset calls as
+ ataN_port_reset in the timeline. This is where most of the SATA disk resume
+ time goes, so it can be helpful to see the low level call.
+
+  [dev_timeline_functions_x86_64]
+  ata_eh_recover: ata{port}_port_reset port=+36(%di):s32 [color=#CC00CC]
+
+
+Verifying your custom functions
+_______________________________
+
+ Once you have a set of functions (kprobes) defined, it can be useful to
+ perform a quick check to see if you formatted them correctly and if the system
+ actually supports them. To do this, run the tool with your config file
+ and the -status option. The tool will go through all the kprobes (both
+ custom and internal if you haven't overridden them) and actually attempts
+ to set them in ftrace. It will then print out success or fail for you.
+
+ Note that kprobes which don't actually exist in the kernel won't stop the
+ tool, they just wont show up.
+
+ For example:
+
+ sudo ./sleepgraph.py -config config/custom-timeline-functions.cfg -status
+ Checking this system (myhostname)...
+    have root access: YES
+    is sysfs mounted: YES
+    is "mem" a valid power mode: YES
+    is ftrace supported: YES
+    are kprobes supported: YES
+    timeline data source: FTRACE (all trace events found)
+    is rtcwake supported: YES
+    verifying timeline kprobes work:
+         _cpu_down: YES
+         _cpu_up: YES
+         acpi_pm_finish: YES
+         acpi_pm_prepare: YES
+         freeze_kernel_threads: YES
+         freeze_processes: YES
+         sys_sync: YES
+         thaw_processes: YES
+    verifying dev kprobes work:
+         __const_udelay: YES
+         __mutex_lock_slowpath: YES
+         acpi_os_stall: YES
+         acpi_ps_parse_aml: YES
+         intel_opregion_init: NO
+         intel_opregion_register: NO
+         intel_opregion_setup: NO
+         msleep: YES
+         schedule_timeout: YES
+         schedule_timeout_uninterruptible: YES
+         usleep_range: YES
+
+
+------------------------------------------------------------------
+|           TESTING ON CONSUMER LINUX OPERATING SYSTEMS          |
+------------------------------------------------------------------
+
+Android
+_______
+
+ The easiest way to execute on an android device is to run the android.sh
+ script on the device, then pull the ftrace log back to the host and run
+ sleepgraph.py on it.
+
+ Here are the steps:
+
+ [download and install the tool on the device]
+
+	host%> wget https://raw.githubusercontent.com/intel/pm-graph/master/tools/android.sh
+	host%> adb connect 192.168.1.6
+	host%> adb root
+	# push the script to a writeable location
+	host%> adb push android.sh /sdcard/
+
+ [check whether the tool will run on your device]
+
+	host%> adb shell
+	dev%> cd /sdcard
+	dev%> sh android.sh status
+		host    : asus_t100
+		kernel  : 3.14.0-i386-dirty
+		modes   : freeze mem
+		rtcwake : supported
+		ftrace  : supported
+		trace events {
+		    suspend_resume: found
+		    device_pm_callback_end: found
+		    device_pm_callback_start: found
+		}
+	# the above is what you see on a system that's properly patched
+
+ [execute the suspend]
+
+	# NOTE: The suspend will only work if the screen isn't timed out,
+	# so you have to press some keys first to wake it up b4 suspend)
+	dev%> sh android.sh suspend mem
+	------------------------------------
+	Suspend/Resume timing test initiated
+	------------------------------------
+	hostname   : asus_t100
+	kernel     : 3.14.0-i386-dirty
+	mode       : mem
+	ftrace out : /mnt/shell/emulated/0/ftrace.txt
+	dmesg out  : /mnt/shell/emulated/0/dmesg.txt
+	log file   : /mnt/shell/emulated/0/log.txt
+	------------------------------------
+	INITIALIZING FTRACE........DONE
+	STARTING FTRACE
+	SUSPEND START @ 21:24:02 (rtcwake in 10 seconds)
+	<adb connection will now terminate>
+
+ [retrieve the data from the device]
+
+	# I find that you have to actually kill the adb process and
+	# reconnect sometimes in order for the connection to work post-suspend
+	host%> adb connect 192.168.1.6
+	# (required) get the ftrace data, this is the most important piece
+	host%> adb pull /sdcard/ftrace.txt
+	# (optional) get the dmesg data, this is for debugging
+	host%> adb pull /sdcard/dmesg.txt
+	# (optional) get the log, which just lists some test times for comparison
+	host%> adb pull /sdcard/log.txt
+
+ [create an output html file using sleepgraph.py]
+
+	host%> sleepgraph.py -ftrace ftrace.txt
+
+ You should now have an output.html with the android data, enjoy!
diff --git a/tools/power/pm-graph/config/example.cfg b/tools/power/pm-graph/config/example.cfg
index 05b2efb9bb54..1ef3eb9383fa 100644
--- a/tools/power/pm-graph/config/example.cfg
+++ b/tools/power/pm-graph/config/example.cfg
@@ -98,12 +98,34 @@ postdelay: 0
 # graph only devices longer than min in the timeline (default: 0.001 ms)
 mindev: 0.001
 
+# Call Loop Max Gap (dev mode only)
+# merge loops of the same call if each is less than maxgap apart (def: 100us)
+callloop-maxgap: 0.0001
+
+# Call Loop Max Length (dev mode only)
+# merge loops of the same call if each is less than maxlen in length (def: 5ms)
+callloop-maxlen: 0.005
+
+# Override default timeline entries:
+# Do not use the internal default functions for timeline entries (def: false)
+# Set this to true if you intend to only use the ones defined in the config
+override-timeline-functions: true
+
+# Override default dev timeline entries:
+# Do not use the internal default functions for dev timeline entries (def: false)
+# Set this to true if you intend to only use the ones defined in the config
+override-dev-timeline-functions: true
+
 # ---- Debug Options ----
 
 # Callgraph
 # gather detailed ftrace callgraph data on all timeline events (default: false)
 callgraph: false
 
+# Max graph depth
+# limit the callgraph trace to this depth (default: 0 = all)
+maxdepth: 2
+
 # Callgraph phase filter
 # Only enable callgraphs for one phase, i.e. resume_noirq (default: all)
 cgphase: suspend
@@ -131,3 +153,7 @@ timeprec: 6
 # Add kprobe functions to the timeline
 # Add functions to the timeline from a text file (default: no-action)
 # fadd: file.txt
+
+# Ftrace buffer size
+# Set trace buffer size to N kilo-bytes (default: all of free memory up to 3GB)
+# bufsize: 1000
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 24a2e7d0ae63..9648be644d5f 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -53,6 +53,11 @@ disable rtcwake and require a user keypress to resume.
 Add the dmesg and ftrace logs to the html output. They will be viewable by
 clicking buttons in the timeline.
 .TP
+\fB-turbostat\fR
+Use turbostat to execute the command in freeze mode (default: disabled). This
+will provide turbostat output in the log which will tell you which actual
+power modes were entered.
+.TP
 \fB-result \fIfile\fR
 Export a results table to a text file for parsing.
 .TP
@@ -121,6 +126,10 @@ be created in a new subdirectory with a summary page: suspend-xN-{date}-{time}.
 Use ftrace to create device callgraphs (default: disabled). This can produce
 very large outputs, i.e. 10MB - 100MB.
 .TP
+\fB-ftop\fR
+Use ftrace on the top level call: "suspend_devices_and_enter" only (default: disabled).
+This option implies -f and creates a single callgraph covering all of suspend/resume.
+.TP
 \fB-maxdepth \fIlevel\fR
 limit the callgraph trace depth to \fIlevel\fR (default: 0=all). This is
 the best way to limit the output size when using callgraphs via -f.
@@ -138,8 +147,8 @@ which are barely visible in the timeline.
 The value is a float: e.g. 0.001 represents 1 us.
 .TP
 \fB-cgfilter \fI"func1,func2,..."\fR
-Reduce callgraph output in the timeline by limiting it to a list of calls. The
-argument can be a single function name or a comma delimited list.
+Reduce callgraph output in the timeline by limiting it certain devices. The
+argument can be a single device name or a comma delimited list.
 (default: none)
 .TP
 \fB-cgskip \fIfile\fR
@@ -183,6 +192,9 @@ Print out the contents of the ACPI Firmware Performance Data Table.
 \fB-battery\fR
 Print out battery status and current charge.
 .TP
+\fB-wifi\fR
+Print out wifi status and connection details.
+.TP
 \fB-xon/-xoff/-xstandby/-xsuspend\fR
 Test xset by attempting to switch the display to the given mode. This
 is the same command which will be issued by \fB-display \fImode\fR.
-- 
2.14.1

