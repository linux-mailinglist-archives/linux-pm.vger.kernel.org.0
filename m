Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF23A346
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2019 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfFIC37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 22:29:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfFIC1c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 22:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+CVB+nZIeP9AAj716+OJK3qxsVdmhNkJNeEUnRiAb0I=; b=uHlcXgqF4APHmdh93SdRVUgv7G
        3SxsHN811sOwwXU+98IkDRboyByWzxZARyNwb5+vDXtswASleMedbFzxzNmHJnIKxanlPQfHgwQ5Y
        i96u6puO2tP3MIWRs4d2Lcg+Vt9pw7orxiHqILwYMWTUKQJ2sdRq32YV6wXSCF3On62kbqq8RMCWf
        fp/jRYeyyTpjbwT5XCyAAxqucj2lgzN8n3U/Cvo74o50xphOmcDqRVSUWC74j9NLODTVTqBs+cjSo
        g1+rAVF8PUsdd8Iai2Rc0lGUw9cEvvRNeOeso8KRuHI3w+vjs3ieB2sxshuGn9iQP/pg9MWxag4gz
        uv8seH1Q==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mj-0o; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYK-0000IY-V7; Sat, 08 Jun 2019 23:27:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 07/33] docs: cpu-freq: convert docs to ReST and rename to *.rst
Date:   Sat,  8 Jun 2019 23:26:57 -0300
Message-Id: <e8cb6d826e691a34996b6812851461b6000442e8.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{amd-powernow.txt => amd-powernow.rst}    |  11 +-
 Documentation/cpu-freq/{core.txt => core.rst} |  66 +++---
 .../{cpu-drivers.txt => cpu-drivers.rst}      | 217 +++++++++---------
 ...pufreq-nforce2.txt => cpufreq-nforce2.rst} |  12 +-
 .../{cpufreq-stats.txt => cpufreq-stats.rst}  | 141 ++++++------
 .../cpu-freq/{index.txt => index.rst}         |  44 ++--
 .../{pcc-cpufreq.txt => pcc-cpufreq.rst}      | 102 ++++----
 drivers/cpufreq/Kconfig.x86                   |   2 +-
 8 files changed, 302 insertions(+), 293 deletions(-)
 rename Documentation/cpu-freq/{amd-powernow.txt => amd-powernow.rst} (91%)
 rename Documentation/cpu-freq/{core.txt => core.rst} (67%)
 rename Documentation/cpu-freq/{cpu-drivers.txt => cpu-drivers.rst} (57%)
 rename Documentation/cpu-freq/{cpufreq-nforce2.txt => cpufreq-nforce2.rst} (65%)
 rename Documentation/cpu-freq/{cpufreq-stats.txt => cpufreq-stats.rst} (31%)
 rename Documentation/cpu-freq/{index.txt => index.rst} (37%)
 rename Documentation/cpu-freq/{pcc-cpufreq.txt => pcc-cpufreq.rst} (80%)

diff --git a/Documentation/cpu-freq/amd-powernow.txt b/Documentation/cpu-freq/amd-powernow.rst
similarity index 91%
rename from Documentation/cpu-freq/amd-powernow.txt
rename to Documentation/cpu-freq/amd-powernow.rst
index 254da155fa47..50b2c45c3a2c 100644
--- a/Documentation/cpu-freq/amd-powernow.txt
+++ b/Documentation/cpu-freq/amd-powernow.rst
@@ -1,3 +1,7 @@
+=============================
+AMD powernow driver specifics
+=============================
+
 
 PowerNow! and Cool'n'Quiet are AMD names for frequency
 management capabilities in AMD processors. As the hardware
@@ -23,16 +27,19 @@ not supply these tables.
 7th Generation: powernow-k7: Athlon, Duron, Geode.
 
 8th Generation: powernow-k8: Athlon, Athlon 64, Opteron, Sempron.
+
 Documentation on this functionality in 8th generation processors
 is available in the "BIOS and Kernel Developer's Guide", publication
-26094, in chapter 9, available for download from www.amd.com. 
+26094, in chapter 9, available for download from www.amd.com.
 
 BIOS supplied data, for powernow-k7 and for powernow-k8, may be
 from either the PSB table or from ACPI objects. The ACPI support
 is only available if the kernel config sets CONFIG_ACPI_PROCESSOR.
+
 The powernow-k8 driver will attempt to use ACPI if so configured,
 and fall back to PST if that fails.
+
 The powernow-k7 driver will try to use the PSB support first, and
 fall back to ACPI if the PSB support fails. A module parameter,
-acpi_force, is provided to force ACPI support to be used instead 
+acpi_force, is provided to force ACPI support to be used instead
 of PSB support.
diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.rst
similarity index 67%
rename from Documentation/cpu-freq/core.txt
rename to Documentation/cpu-freq/core.rst
index 073f128af5a7..c719e3cb700c 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.rst
@@ -1,31 +1,22 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
+================================================================
+General description of the CPUFreq core and of CPUFreq notifiers
+================================================================
 
+Authors:
+  - Dominik Brodowski  <linux@brodo.de>
+  - David Kimdon <dwhedon@debian.org>
+  - Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+  - Viresh Kumar <viresh.kumar@linaro.org>
 
-		         L i n u x    C P U F r e q
 
-			  C P U F r e q    C o r e
+.. Contents:
 
-
-		    Dominik Brodowski  <linux@brodo.de>
-		     David Kimdon <dwhedon@debian.org>
-		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-		   Viresh Kumar <viresh.kumar@linaro.org>
-
-
-
-   Clock scaling allows you to change the clock speed of the CPUs on the
-    fly. This is a nice method to save battery power, because the lower
-            the clock speed, the less power the CPU consumes.
-
-
-Contents:
----------
-1.  CPUFreq core and interfaces
-2.  CPUFreq notifiers
-3.  CPUFreq Table Generation with Operating Performance Point (OPP)
+  1.  CPUFreq core and interfaces
+  2.  CPUFreq notifiers
+  3.  CPUFreq Table Generation with Operating Performance Point (OPP)
 
 1. General Information
-=======================
+======================
 
 The CPUFreq core code is located in drivers/cpufreq/cpufreq.c. This
 cpufreq code offers a standardized interface for the CPUFreq
@@ -60,18 +51,18 @@ transition notifiers.
 These are notified when a new policy is intended to be set. Each
 CPUFreq policy notifier is called twice for a policy transition:
 
-1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
-    they see a need for this - may it be thermal considerations or
-    hardware limitations.
+1) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
+   they see a need for this - may it be thermal considerations or
+   hardware limitations.
 
-2.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
-   - if two hardware drivers failed to agree on a new policy before this
+2) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy -
+   if two hardware drivers failed to agree on a new policy before this
    stage, the incompatible hardware shall be shut down, and the user
    informed of this.
 
 The phase is specified in the second argument to the notifier.
 
-The third argument, a void *pointer, points to a struct cpufreq_policy
+The third argument, a `void *` pointer, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
 frequencies (in kHz) of the new policy).
 
@@ -88,23 +79,27 @@ CPUFREQ_POSTCHANGE.
 
 The third argument is a struct cpufreq_freqs with the following
 values:
-cpu	- number of the affected CPU
-old	- old frequency
-new	- new frequency
-flags	- flags of the cpufreq driver
+
+======= ===========================
+cpu	number of the affected CPU
+old	old frequency
+new	new frequency
+flags	flags of the cpufreq driver
+======= ===========================
 
 3. CPUFreq Table Generation with Operating Performance Point (OPP)
 ==================================================================
 For details about OPP, see Documentation/power/opp.txt
 
-dev_pm_opp_init_cpufreq_table -
+dev_pm_opp_init_cpufreq_table
 	This function provides a ready to use conversion routine to translate
 	the OPP layer's internal information about the available frequencies
 	into a format readily providable to cpufreq.
 
 	WARNING: Do not use this function in interrupt context.
 
-	Example:
+	Example::
+
 	 soc_pm_init()
 	 {
 		/* Do things */
@@ -117,4 +112,5 @@ dev_pm_opp_init_cpufreq_table -
 	NOTE: This function is available only if CONFIG_CPU_FREQ is enabled in
 	addition to CONFIG_PM_OPP.
 
-dev_pm_opp_free_cpufreq_table - Free up the table allocated by dev_pm_opp_init_cpufreq_table
+dev_pm_opp_free_cpufreq_table
+	Free up the table allocated by dev_pm_opp_init_cpufreq_table
diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.rst
similarity index 57%
rename from Documentation/cpu-freq/cpu-drivers.txt
rename to Documentation/cpu-freq/cpu-drivers.rst
index 6e353d00cdc6..9cc2559bc34b 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -1,35 +1,25 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
-
-
-		         L i n u x    C P U F r e q
-
-			   C P U   D r i v e r s 
-
-		       - information for developers -
-
-
-		    Dominik Brodowski  <linux@brodo.de>
-		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-		   Viresh Kumar <viresh.kumar@linaro.org>
-
-
-
-   Clock scaling allows you to change the clock speed of the CPUs on the
-    fly. This is a nice method to save battery power, because the lower
-            the clock speed, the less power the CPU consumes.
-
-
-Contents:
----------
-1.   What To Do?
-1.1  Initialization
-1.2  Per-CPU Initialization
-1.3  verify
-1.4  target/target_index or setpolicy?
-1.5  target/target_index
-1.6  setpolicy
-1.7  get_intermediate and target_intermediate
-2.   Frequency Table Helpers
+===============================================
+How to implement a new cpufreq processor driver
+===============================================
+
+.. information for developers
+
+Authors:
+  - Dominik Brodowski  <linux@brodo.de>
+  - Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+.. Contents:
+
+   1.   What To Do?
+   1.1  Initialization
+   1.2  Per-CPU Initialization
+   1.3  verify
+   1.4  target/target_index or setpolicy?
+   1.5  target/target_index
+   1.6  setpolicy
+   1.7  get_intermediate and target_intermediate
+   2.   Frequency Table Helpers
 
 
 
@@ -46,59 +36,73 @@ on what is necessary:
 
 First of all, in an __initcall level 7 (module_init()) or later
 function check whether this kernel runs on the right CPU and the right
-chipset. If so, register a struct cpufreq_driver with the CPUfreq core
-using cpufreq_register_driver()
+chipset. If so, register a `struct cpufreq_driver` with the CPUfreq core
+using `cpufreq_register_driver()`
 
-What shall this struct cpufreq_driver contain? 
+What shall this `struct cpufreq_driver` contain?
 
- .name - The name of this driver.
+.name
+  The name of this driver.
 
- .init - A pointer to the per-policy initialization function.
+.init
+  A pointer to the per-policy initialization function.
 
- .verify - A pointer to a "verification" function.
+.verify
+  A pointer to a "verification" function.
 
- .setpolicy _or_ .fast_switch _or_ .target _or_ .target_index - See
- below on the differences.
+.setpolicy **or** .fast_switch **or** .target **or** .target_index
+  See below on the differences.
 
 And optionally
 
- .flags - Hints for the cpufreq core.
+.flags
+  Hints for the cpufreq core.
 
- .driver_data - cpufreq driver specific data.
+.driver_data
+  cpufreq driver specific data.
 
- .resolve_freq - Returns the most appropriate frequency for a target
- frequency. Doesn't change the frequency though.
+.resolve_freq
+  Returns the most appropriate frequency for a target
+  frequency. Doesn't change the frequency though.
 
- .get_intermediate and target_intermediate - Used to switch to stable
- frequency while changing CPU frequency.
+.get_intermediate and target_intermediate
+  Used to switch to stable frequency while changing CPU frequency.
 
- .get - Returns current frequency of the CPU.
+.get
+  Returns current frequency of the CPU.
 
- .bios_limit - Returns HW/BIOS max frequency limitations for the CPU.
+.bios_limit
+  Returns HW/BIOS max frequency limitations for the CPU.
 
- .exit - A pointer to a per-policy cleanup function called during
- CPU_POST_DEAD phase of cpu hotplug process.
+.exit
+  A pointer to a per-policy cleanup function called during
+  CPU_POST_DEAD phase of cpu hotplug process.
 
- .stop_cpu - A pointer to a per-policy stop function called during
- CPU_DOWN_PREPARE phase of cpu hotplug process.
+.stop_cpu
+  A pointer to a per-policy stop function called during
+  CPU_DOWN_PREPARE phase of cpu hotplug process.
 
- .suspend - A pointer to a per-policy suspend function which is called
- with interrupts disabled and _after_ the governor is stopped for the
- policy.
+.suspend
+  A pointer to a per-policy suspend function which is called with
+  interrupts disabled and **after** the governor is stopped for the policy.
 
- .resume - A pointer to a per-policy resume function which is called
- with interrupts disabled and _before_ the governor is started again.
+.resume
+  A pointer to a per-policy resume function which is called
+  with interrupts disabled and **before** the governor is started again.
 
- .ready - A pointer to a per-policy ready function which is called after
- the policy is fully initialized.
+.ready
+  A pointer to a per-policy ready function which is called after
+  the policy is fully initialized.
 
- .attr - A pointer to a NULL-terminated list of "struct freq_attr" which
- allow to export values to sysfs.
+.attr
+  A pointer to a NULL-terminated list of `struct freq_attr` which
+  allow to export values to sysfs.
 
- .boost_enabled - If set, boost frequencies are enabled.
+.boost_enabled
+  If set, boost frequencies are enabled.
 
- .set_boost - A pointer to a per-policy function to enable/disable boost
- frequencies.
+.set_boost
+  A pointer to a per-policy function to enable/disable boost frequencies.
 
 
 1.2 Per-CPU Initialization
@@ -108,37 +112,42 @@ Whenever a new CPU is registered with the device model, or after the
 cpufreq driver registers itself, the per-policy initialization function
 cpufreq_driver.init is called if no cpufreq policy existed for the CPU.
 Note that the .init() and .exit() routines are called only once for the
-policy and not for each CPU managed by the policy. It takes a struct
-cpufreq_policy *policy as argument. What to do now?
+policy and not for each CPU managed by the policy. It takes a `struct
+cpufreq_policy *policy` as argument. What to do now?
 
 If necessary, activate the CPUfreq support on your CPU.
 
 Then, the driver must fill in the following values:
 
-policy->cpuinfo.min_freq _and_
-policy->cpuinfo.max_freq -	the minimum and maximum frequency 
-				(in kHz) which is supported by 
-				this CPU
-policy->cpuinfo.transition_latency   the time it takes on this CPU to
-				switch between two frequencies in
-				nanoseconds (if appropriate, else
-				specify CPUFREQ_ETERNAL)
-
-policy->cur			The current operating frequency of
-				this CPU (if appropriate)
-policy->min, 
-policy->max, 
-policy->policy and, if necessary,
-policy->governor		must contain the "default policy" for
-				this CPU. A few moments later,
-				cpufreq_driver.verify and either
-				cpufreq_driver.setpolicy or
-				cpufreq_driver.target/target_index is called
-				with these values.
-policy->cpus			Update this with the masks of the
-				(online + offline) CPUs that do DVFS
-				along with this CPU (i.e.  that share
-				clock/voltage rails with it).
++---------------------------------------+--------------------------------------+
+| policy->cpuinfo.min_freq **and**	|				       |
+| policy->cpuinfo.max_freq		| the minimum and maximum frequency    |
+| 					| (in kHz) which is supported by       |
+| 					| this CPU			       |
++---------------------------------------+--------------------------------------+
+| policy->cpuinfo.transition_latency	| the time it takes on this CPU to     |
+| 					| switch between two frequencies in    |
+| 					| nanoseconds (if appropriate, else    |
+| 					| specify CPUFREQ_ETERNAL)	       |
++---------------------------------------+--------------------------------------+
+| policy->cur				| The current operating frequency of   |
+| 					| this CPU (if appropriate)	       |
++---------------------------------------+--------------------------------------+
+| policy->min,				|				       |
+| policy->max,				|				       |
+| policy->policy and, if necessary,	|				       |
+| policy->governor			| must contain the "default policy"    |
+| 					| for this CPU. A few moments later,   |
+| 					| cpufreq_driver.verify and either     |
+| 					| cpufreq_driver.setpolicy or	       |
+| 					| cpufreq_driver.target/target_index   |
+| 					| is called with these values.	       |
++---------------------------------------+--------------------------------------+
+| policy->cpus				| Update this with the masks of the    |
+| 					| (online + offline) CPUs that do DVFS |
+| 					| along with this CPU (i.e. that share |
+| 					| clock/voltage rails with it).	       |
++---------------------------------------+--------------------------------------+
 
 For setting some of these values (cpuinfo.min[max]_freq, policy->min[max]), the
 frequency table helpers might be helpful. See the section 2 for more information
@@ -151,8 +160,8 @@ on them.
 When the user decides a new policy (consisting of
 "policy,governor,min,max") shall be set, this policy must be validated
 so that incompatible values can be corrected. For verifying these
-values cpufreq_verify_within_limits(struct cpufreq_policy *policy,
-unsigned int min_freq, unsigned int max_freq) function might be helpful.
+values `cpufreq_verify_within_limits(struct cpufreq_policy *policy,
+unsigned int min_freq, unsigned int max_freq)` function might be helpful.
 See section 2 for details on frequency table helpers.
 
 You need to make sure that at least one valid frequency (or operating
@@ -163,7 +172,7 @@ policy->max first, and only if this is no solution, decrease policy->min.
 1.4 target or target_index or setpolicy or fast_switch?
 -------------------------------------------------------
 
-Most cpufreq drivers or even most cpu frequency scaling algorithms 
+Most cpufreq drivers or even most cpu frequency scaling algorithms
 only allow the CPU frequency to be set to predefined fixed values. For
 these, you use the ->target(), ->target_index() or ->fast_switch()
 callbacks.
@@ -175,8 +184,8 @@ limits on their own. These shall use the ->setpolicy() callback.
 1.5. target/target_index
 ------------------------
 
-The target_index call has two arguments: struct cpufreq_policy *policy,
-and unsigned int index (into the exposed frequency table).
+The target_index call has two arguments: `struct cpufreq_policy *policy`,
+and `unsigned int index` (into the exposed frequency table).
 
 The CPUfreq driver must set the new frequency when called here. The
 actual frequency must be determined by freq_table[index].frequency.
@@ -184,10 +193,10 @@ actual frequency must be determined by freq_table[index].frequency.
 It should always restore to earlier frequency (i.e. policy->restore_freq) in
 case of errors, even if we switched to intermediate frequency earlier.
 
-Deprecated:
+Deprecated
 ----------
-The target call has three arguments: struct cpufreq_policy *policy,
-unsigned int target_frequency, unsigned int relation.
+The target call has three arguments: `struct cpufreq_policy *policy`,
+`unsigned int target_frequency`, `unsigned int relation`.
 
 The CPUfreq driver must set the new frequency when called here. The
 actual frequency must be determined using the following rules:
@@ -210,14 +219,14 @@ Not all drivers are expected to implement it, as sleeping from within
 this callback isn't allowed. This callback must be highly optimized to
 do switching as fast as possible.
 
-This function has two arguments: struct cpufreq_policy *policy and
-unsigned int target_frequency.
+This function has two arguments: `struct cpufreq_policy *policy` and
+`unsigned int target_frequency`.
 
 
 1.7 setpolicy
 -------------
 
-The setpolicy call only takes a struct cpufreq_policy *policy as
+The setpolicy call only takes a `struct cpufreq_policy *policy` as
 argument. You need to set the lower limit of the in-processor or
 in-chipset dynamic frequency switching to policy->min, the upper limit
 to policy->max, and -if supported- select a performance-oriented
@@ -278,10 +287,10 @@ table.
 
 cpufreq_for_each_valid_entry(pos, table) - iterates over all entries,
 excluding CPUFREQ_ENTRY_INVALID frequencies.
-Use arguments "pos" - a cpufreq_frequency_table * as a loop cursor and
-"table" - the cpufreq_frequency_table * you want to iterate over.
+Use arguments "pos" - a `cpufreq_frequency_table *` as a loop cursor and
+"table" - the `cpufreq_frequency_table *` you want to iterate over.
 
-For example:
+For example::
 
 	struct cpufreq_frequency_table *pos, *driver_freq_table;
 
diff --git a/Documentation/cpu-freq/cpufreq-nforce2.txt b/Documentation/cpu-freq/cpufreq-nforce2.rst
similarity index 65%
rename from Documentation/cpu-freq/cpufreq-nforce2.txt
rename to Documentation/cpu-freq/cpufreq-nforce2.rst
index babce1315026..d40700bd5083 100644
--- a/Documentation/cpu-freq/cpufreq-nforce2.txt
+++ b/Documentation/cpu-freq/cpufreq-nforce2.rst
@@ -1,3 +1,6 @@
+=================================
+nVidia nForce2 platform specifics
+=================================
 
 The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 platforms.
 
@@ -6,14 +9,15 @@ can be controlled independently from the PCI/AGP clock.
 
 The module has two options:
 
+        ======== ======================================
 	fid: 	 multiplier * 10 (for example 8.5 = 85)
 	min_fsb: minimum FSB
+        ======== ======================================
 
 If not set, fid is calculated from the current CPU speed and the FSB.
 min_fsb defaults to FSB at boot time - 50 MHz.
 
-IMPORTANT: The available range is limited downwards!
-           Also the minimum available FSB can differ, for systems 
+IMPORTANT:
+           The available range is limited downwards!
+           Also the minimum available FSB can differ, for systems
            booting with 200 MHz, 150 should always work.
-
-
diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.rst
similarity index 31%
rename from Documentation/cpu-freq/cpufreq-stats.txt
rename to Documentation/cpu-freq/cpufreq-stats.rst
index 14378cecb172..3e33712b496e 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.rst
@@ -1,21 +1,20 @@
+==========================================
+General description of sysfs cpufreq stats
+==========================================
 
-     CPU frequency and voltage scaling statistics in the Linux(TM) kernel
+.. information for users
 
 
-             L i n u x    c p u f r e q - s t a t s   d r i v e r
+Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
-                       - information for users -
-
-
-             Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
-
-Contents
-1. Introduction
-2. Statistics Provided (with example)
-3. Configuring cpufreq-stats
+.. Contents
+   1. Introduction
+   2. Statistics Provided (with example)
+   3. Configuring cpufreq-stats
 
 
 1. Introduction
+===============
 
 cpufreq-stats is a driver that provides CPU frequency statistics for each CPU.
 These statistics are provided in /sysfs as a bunch of read_only interfaces. This
@@ -28,6 +27,7 @@ that may be running on your CPU. So, it will work with any cpufreq_driver.
 
 
 2. Statistics Provided (with example)
+=====================================
 
 cpufreq stats provides following statistics (explained in detail below).
 -  time_in_state
@@ -39,78 +39,79 @@ All the statistics will be from the time the stats driver has been inserted
 statistic is done. Obviously, stats driver will not have any information
 about the frequency transitions before the stats driver insertion.
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # ls -l
-total 0
-drwxr-xr-x  2 root root    0 May 14 16:06 .
-drwxr-xr-x  3 root root    0 May 14 15:58 ..
---w-------  1 root root 4096 May 14 16:06 reset
--r--r--r--  1 root root 4096 May 14 16:06 time_in_state
--r--r--r--  1 root root 4096 May 14 16:06 total_trans
--r--r--r--  1 root root 4096 May 14 16:06 trans_table
---------------------------------------------------------------------------------
+::
 
--  reset
-Write-only attribute that can be used to reset the stat counters. This can be
-useful for evaluating system behaviour under different governors without the
-need for a reboot.
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # ls -l
+    total 0
+    drwxr-xr-x  2 root root    0 May 14 16:06 .
+    drwxr-xr-x  3 root root    0 May 14 15:58 ..
+    --w-------  1 root root 4096 May 14 16:06 reset
+    -r--r--r--  1 root root 4096 May 14 16:06 time_in_state
+    -r--r--r--  1 root root 4096 May 14 16:06 total_trans
+    -r--r--r--  1 root root 4096 May 14 16:06 trans_table
 
--  time_in_state
-This gives the amount of time spent in each of the frequencies supported by
-this CPU. The cat output will have "<frequency> <time>" pair in each line, which
-will mean this CPU spent <time> usertime units of time at <frequency>. Output
-will have one line for each of the supported frequencies. usertime units here 
-is 10mS (similar to other time exported in /proc).
+reset
+  Write-only attribute that can be used to reset the stat counters. This can be
+  useful for evaluating system behaviour under different governors without the
+  need for a reboot.
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat time_in_state 
-3600000 2089
-3400000 136
-3200000 34
-3000000 67
-2800000 172488
---------------------------------------------------------------------------------
+time_in_state
+  This gives the amount of time spent in each of the frequencies supported by
+  this CPU. The cat output will have "<frequency> <time>" pair in each line,
+  which will mean this CPU spent <time> usertime units of time at <frequency>.
+  Output will have one line for each of the supported frequencies. usertime
+  units here is 10mS (similar to other time exported in /proc).
 
+::
 
--  total_trans
-This gives the total number of frequency transitions on this CPU. The cat 
-output will have a single count which is the total number of frequency
-transitions.
+  <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat time_in_state
+  3600000 2089
+  3400000 136
+  3200000 34
+  3000000 67
+  2800000 172488
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat total_trans
-20
---------------------------------------------------------------------------------
 
--  trans_table
-This will give a fine grained information about all the CPU frequency
-transitions. The cat output here is a two dimensional matrix, where an entry
-<i,j> (row i, column j) represents the count of number of transitions from 
-Freq_i to Freq_j. Freq_i rows and Freq_j columns follow the sorting order in
-which the driver has provided the frequency table initially to the cpufreq core
-and so can be sorted (ascending or descending) or unsorted.  The output here
-also contains the actual freq values for each row and column for better
-readability.
+total_trans
+  This gives the total number of frequency transitions on this CPU. The cat
+  output will have a single count which is the total number of frequency
+  transitions.
 
-If the transition table is bigger than PAGE_SIZE, reading this will
-return an -EFBIG error.
+::
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
-   From  :    To
-         :   3600000   3400000   3200000   3000000   2800000 
-  3600000:         0         5         0         0         0 
-  3400000:         4         0         2         0         0 
-  3200000:         0         1         0         2         0 
-  3000000:         0         0         1         0         3 
-  2800000:         0         0         0         2         0 
---------------------------------------------------------------------------------
+  <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat total_trans
+  20
 
+trans_table
+  This will give a fine grained information about all the CPU frequency
+  transitions. The cat output here is a two dimensional matrix, where an entry
+  <i,j> (row i, column j) represents the count of number of transitions from
+  Freq_i to Freq_j. Freq_i rows and Freq_j columns follow the sorting order in
+  which the driver has provided the frequency table initially to the cpufreq
+  core and so can be sorted (ascending or descending) or unsorted.  The output
+  here also contains the actual freq values for each row and column for better
+  readability.
+
+  If the transition table is bigger than PAGE_SIZE, reading this will
+  return an -EFBIG error.
+
+::
+
+  <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
+     From  :    To
+           :   3600000   3400000   3200000   3000000   2800000
+    3600000:         0         5         0         0         0
+    3400000:         4         0         2         0         0
+    3200000:         0         1         0         2         0
+    3000000:         0         0         1         0         3
+    2800000:         0         0         0         2         0
 
 3. Configuring cpufreq-stats
+============================
 
-To configure cpufreq-stats in your kernel
-Config Main Menu
+To configure cpufreq-stats in your kernel::
+
+   Config Main Menu
 	Power management options (ACPI, APM)  --->
 		CPU Frequency scaling  --->
 			[*] CPU Frequency scaling
diff --git a/Documentation/cpu-freq/index.txt b/Documentation/cpu-freq/index.rst
similarity index 37%
rename from Documentation/cpu-freq/index.txt
rename to Documentation/cpu-freq/index.rst
index c15e75386a05..10e6c05f60f6 100644
--- a/Documentation/cpu-freq/index.txt
+++ b/Documentation/cpu-freq/index.rst
@@ -1,39 +1,35 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
+:orphan:
 
+==============================================================
+CPU frequency and voltage scaling code in the Linux(TM) kernel
+==============================================================
 
-		         L i n u x    C P U F r e q
 
+Author: Dominik Brodowski  <linux@brodo.de>
 
 
+Clock scaling allows you to change the clock speed of the CPUs on the
+fly. This is a nice method to save battery power, because the lower
+the clock speed, the less power the CPU consumes.
 
-		    Dominik Brodowski  <linux@brodo.de>
 
+.. toctree::
+    :maxdepth: 1
 
+    core
+    cpufreq-stats
+    cpu-drivers
 
-   Clock scaling allows you to change the clock speed of the CPUs on the
-    fly. This is a nice method to save battery power, because the lower
-            the clock speed, the less power the CPU consumes.
+    amd-powernow
+    cpufreq-nforce2
+    pcc-cpufreq
 
+.. only::  subproject and html
 
+   Indices
+   =======
 
-Documents in this directory:
-----------------------------
-
-amd-powernow.txt -	AMD powernow driver specific file.
-
-core.txt	-	General description of the CPUFreq core and
-			of CPUFreq notifiers.
-
-cpu-drivers.txt -	How to implement a new cpufreq processor driver.
-
-cpufreq-nforce2.txt -	nVidia nForce2 platform specific file.
-
-cpufreq-stats.txt -	General description of sysfs cpufreq stats.
-
-index.txt	-	File index, Mailing list and Links (this document)
-
-pcc-cpufreq.txt -	PCC cpufreq driver specific file.
-
+   * :ref:`genindex`
 
 Mailing List
 ------------
diff --git a/Documentation/cpu-freq/pcc-cpufreq.txt b/Documentation/cpu-freq/pcc-cpufreq.rst
similarity index 80%
rename from Documentation/cpu-freq/pcc-cpufreq.txt
rename to Documentation/cpu-freq/pcc-cpufreq.rst
index 9e3c3b33514c..d846a36536e4 100644
--- a/Documentation/cpu-freq/pcc-cpufreq.txt
+++ b/Documentation/cpu-freq/pcc-cpufreq.rst
@@ -1,45 +1,38 @@
-/*
- *  pcc-cpufreq.txt - PCC interface documentation
- *
- *  Copyright (C) 2009 Red Hat, Matthew Garrett <mjg@redhat.com>
- *  Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
- *      Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or NON
- *  INFRINGEMENT. See the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-
-
-			Processor Clocking Control Driver
-			---------------------------------
-
-Contents:
----------
-1.	Introduction
-1.1	PCC interface
-1.1.1   Get Average Frequency
-1.1.2	Set Desired Frequency
-1.2	Platforms affected
-2.	Driver and /sys details
-2.1	scaling_available_frequencies
-2.2	cpuinfo_transition_latency
-2.3	cpuinfo_cur_freq
-2.4	related_cpus
-3.	Caveats
+==========================================================
+Processor Clocking Control Driver cpufreq driver specifics
+==========================================================
+
+
+.. pcc-cpufreq.txt - PCC interface documentation
+
+    Copyright (C) 2009 Red Hat, Matthew Garrett <mjg@redhat.com>
+    Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
+        Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
+
+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+
+    This program is distributed in the hope that it will be useful, but
+    WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or NON
+    INFRINGEMENT. See the GNU General Public License for more details.
+
+
+.. Contents:
+   1.	Introduction
+   1.1	PCC interface
+   1.1.1  Get Average Frequency
+   1.1.2  Set Desired Frequency
+   1.2	Platforms affected
+   2.	Driver and /sys details
+   2.1	scaling_available_frequencies
+   2.2	cpuinfo_transition_latency
+   2.3	cpuinfo_cur_freq
+   2.4	related_cpus
+   3.	Caveats
 
 1. Introduction:
 ----------------
@@ -72,6 +65,7 @@ memory region. The shared memory region header contains the "command" and
 doorbell.
 
 The following commands are supported by the PCC interface:
+
 * Get Average Frequency
 * Set Desired Frequency
 
@@ -140,7 +134,9 @@ Internally, there is no need for the driver to convert the "target" frequency
 to a corresponding P-state.
 
 The VERSION number for the driver will be of the format v.xy.ab.
-eg: 1.00.02
+eg::
+
+   1.00.02
    ----- --
     |    |
     |    -- this will increase with bug fixes/enhancements to the driver
@@ -168,21 +164,21 @@ A) Often cpuinfo_cur_freq will show a value different than what is declared
 in the scaling_available_frequencies or scaling_cur_freq, or scaling_max_freq.
 This is due to "turbo boost" available on recent Intel processors. If certain
 conditions are met the BIOS can achieve a slightly higher speed than requested
-by OSPM. An example:
+by OSPM. An example::
 
-scaling_cur_freq	: 2933000
-cpuinfo_cur_freq	: 3196000
+	scaling_cur_freq	: 2933000
+	cpuinfo_cur_freq	: 3196000
 
 B) There is a round-off error associated with the cpuinfo_cur_freq value.
 Since the driver obtains the current frequency as a "percentage" (%) of the
 nominal frequency from the BIOS, sometimes, the values displayed by
-scaling_cur_freq and cpuinfo_cur_freq may not match. An example:
+scaling_cur_freq and cpuinfo_cur_freq may not match. An example::
 
-scaling_cur_freq	: 1600000
-cpuinfo_cur_freq	: 1583000
+	scaling_cur_freq	: 1600000
+	cpuinfo_cur_freq	: 1583000
 
 In this example, the nominal frequency is 2933 MHz. The driver obtains the
-current frequency, cpuinfo_cur_freq, as 54% of the nominal frequency:
+current frequency, cpuinfo_cur_freq, as 54% of the nominal frequency::
 
 	54% of 2933 MHz = 1583 MHz
 
@@ -191,10 +187,10 @@ corresponds to the frequency of the P0 P-state.
 
 2.4 related_cpus:
 -----------------
-The related_cpus field is identical to affected_cpus.
+The related_cpus field is identical to affected_cpus:
 
-affected_cpus	: 4
-related_cpus	: 4
+	affected_cpus	: 4
+	related_cpus	: 4
 
 Currently, the PCC driver does not evaluate _PSD. The platforms that support
 PCC do not implement SW_ALL. So OSPM doesn't need to perform any coordination
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index dfa6457deaf6..336a295fac4c 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -25,7 +25,7 @@ config X86_PCC_CPUFREQ
 	  This driver adds support for the PCC interface.
 
 	  For details, take a look at:
-	  <file:Documentation/cpu-freq/pcc-cpufreq.txt>.
+	  <file:Documentation/cpu-freq/pcc-cpufreq.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcc-cpufreq.
-- 
2.21.0

