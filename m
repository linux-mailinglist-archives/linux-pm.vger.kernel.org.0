Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F897172B48
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 23:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgB0Waw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 17:30:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42141 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgB0Waw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 17:30:52 -0500
Received: from 79.184.237.30.ipv4.supernova.orange.pl (79.184.237.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 030098619b2178ec; Thu, 27 Feb 2020 23:30:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: cpufreq: Move legacy driver documentation
Date:   Thu, 27 Feb 2020 23:30:48 +0100
Message-ID: <2064677.NQqUkctcim@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are three legacy driver documents in Documentation/cpu-freq/
that were added years ago and converting them each to the .rst
format is rather pointless, even though there is some value in
preserving them.  However, if they are preserved, they need to go
into the admin-guide part of cpufreq documentation where they belong
(at least to a certain extent).

To preserve them with minimum amount of changes and put them into the
right place, and make it possible to process them into HTML (and other
formats) along with the rest of the documentation, move them each
as a "literal text" block into a separate section of a single .rst
"wrapper" file under Documentation/admin-guide/pm/.

While at it, repair the PCC specification URL in one of them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq_drivers.rst |  274 +++++++++++++++++++++++
 Documentation/admin-guide/pm/working-state.rst   |    1 
 Documentation/cpu-freq/amd-powernow.txt          |   38 ---
 Documentation/cpu-freq/cpufreq-nforce2.txt       |   19 -
 Documentation/cpu-freq/pcc-cpufreq.txt           |  207 -----------------
 5 files changed, 275 insertions(+), 264 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/cpufreq_drivers.rst
===================================================================
--- /dev/null
+++ linux-pm/Documentation/admin-guide/pm/cpufreq_drivers.rst
@@ -0,0 +1,274 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================================
+Legacy Documentation of CPU Performance Scaling Drivers
+=======================================================
+
+Included below are historic documents describing assorted
+:doc:`CPU performance scaling <cpufreq>` drivers.  They are reproduced verbatim,
+with the original white space formatting and indentation preserved, except for
+the added leading space character in every line of text.
+
+
+AMD PowerNow! Drivers
+=====================
+
+::
+
+ PowerNow! and Cool'n'Quiet are AMD names for frequency
+ management capabilities in AMD processors. As the hardware
+ implementation changes in new generations of the processors,
+ there is a different cpu-freq driver for each generation.
+
+ Note that the driver's will not load on the "wrong" hardware,
+ so it is safe to try each driver in turn when in doubt as to
+ which is the correct driver.
+
+ Note that the functionality to change frequency (and voltage)
+ is not available in all processors. The drivers will refuse
+ to load on processors without this capability. The capability
+ is detected with the cpuid instruction.
+
+ The drivers use BIOS supplied tables to obtain frequency and
+ voltage information appropriate for a particular platform.
+ Frequency transitions will be unavailable if the BIOS does
+ not supply these tables.
+
+ 6th Generation: powernow-k6
+
+ 7th Generation: powernow-k7: Athlon, Duron, Geode.
+
+ 8th Generation: powernow-k8: Athlon, Athlon 64, Opteron, Sempron.
+ Documentation on this functionality in 8th generation processors
+ is available in the "BIOS and Kernel Developer's Guide", publication
+ 26094, in chapter 9, available for download from www.amd.com.
+
+ BIOS supplied data, for powernow-k7 and for powernow-k8, may be
+ from either the PSB table or from ACPI objects. The ACPI support
+ is only available if the kernel config sets CONFIG_ACPI_PROCESSOR.
+ The powernow-k8 driver will attempt to use ACPI if so configured,
+ and fall back to PST if that fails.
+ The powernow-k7 driver will try to use the PSB support first, and
+ fall back to ACPI if the PSB support fails. A module parameter,
+ acpi_force, is provided to force ACPI support to be used instead
+ of PSB support.
+
+
+``cpufreq-nforce2``
+===================
+
+::
+
+ The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 platforms.
+
+ This works better than on other platforms, because the FSB of the CPU
+ can be controlled independently from the PCI/AGP clock.
+
+ The module has two options:
+
+ 	fid: 	 multiplier * 10 (for example 8.5 = 85)
+ 	min_fsb: minimum FSB
+
+ If not set, fid is calculated from the current CPU speed and the FSB.
+ min_fsb defaults to FSB at boot time - 50 MHz.
+
+ IMPORTANT: The available range is limited downwards!
+            Also the minimum available FSB can differ, for systems
+            booting with 200 MHz, 150 should always work.
+
+
+``pcc-cpufreq``
+===============
+
+::
+
+ /*
+  *  pcc-cpufreq.txt - PCC interface documentation
+  *
+  *  Copyright (C) 2009 Red Hat, Matthew Garrett <mjg@redhat.com>
+  *  Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
+  *      Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
+  */
+
+
+ 			Processor Clocking Control Driver
+ 			---------------------------------
+
+ Contents:
+ ---------
+ 1.	Introduction
+ 1.1	PCC interface
+ 1.1.1	Get Average Frequency
+ 1.1.2	Set Desired Frequency
+ 1.2	Platforms affected
+ 2.	Driver and /sys details
+ 2.1	scaling_available_frequencies
+ 2.2	cpuinfo_transition_latency
+ 2.3	cpuinfo_cur_freq
+ 2.4	related_cpus
+ 3.	Caveats
+
+ 1. Introduction:
+ ----------------
+ Processor Clocking Control (PCC) is an interface between the platform
+ firmware and OSPM. It is a mechanism for coordinating processor
+ performance (ie: frequency) between the platform firmware and the OS.
+
+ The PCC driver (pcc-cpufreq) allows OSPM to take advantage of the PCC
+ interface.
+
+ OS utilizes the PCC interface to inform platform firmware what frequency the
+ OS wants for a logical processor. The platform firmware attempts to achieve
+ the requested frequency. If the request for the target frequency could not be
+ satisfied by platform firmware, then it usually means that power budget
+ conditions are in place, and "power capping" is taking place.
+
+ 1.1 PCC interface:
+ ------------------
+ The complete PCC specification is available here:
+ https://acpica.org/sites/acpica/files/Processor-Clocking-Control-v1p0.pdf
+
+ PCC relies on a shared memory region that provides a channel for communication
+ between the OS and platform firmware. PCC also implements a "doorbell" that
+ is used by the OS to inform the platform firmware that a command has been
+ sent.
+
+ The ACPI PCCH() method is used to discover the location of the PCC shared
+ memory region. The shared memory region header contains the "command" and
+ "status" interface. PCCH() also contains details on how to access the platform
+ doorbell.
+
+ The following commands are supported by the PCC interface:
+ * Get Average Frequency
+ * Set Desired Frequency
+
+ The ACPI PCCP() method is implemented for each logical processor and is
+ used to discover the offsets for the input and output buffers in the shared
+ memory region.
+
+ When PCC mode is enabled, the platform will not expose processor performance
+ or throttle states (_PSS, _TSS and related ACPI objects) to OSPM. Therefore,
+ the native P-state driver (such as acpi-cpufreq for Intel, powernow-k8 for
+ AMD) will not load.
+
+ However, OSPM remains in control of policy. The governor (eg: "ondemand")
+ computes the required performance for each processor based on server workload.
+ The PCC driver fills in the command interface, and the input buffer and
+ communicates the request to the platform firmware. The platform firmware is
+ responsible for delivering the requested performance.
+
+ Each PCC command is "global" in scope and can affect all the logical CPUs in
+ the system. Therefore, PCC is capable of performing "group" updates. With PCC
+ the OS is capable of getting/setting the frequency of all the logical CPUs in
+ the system with a single call to the BIOS.
+
+ 1.1.1 Get Average Frequency:
+ ----------------------------
+ This command is used by the OSPM to query the running frequency of the
+ processor since the last time this command was completed. The output buffer
+ indicates the average unhalted frequency of the logical processor expressed as
+ a percentage of the nominal (ie: maximum) CPU frequency. The output buffer
+ also signifies if the CPU frequency is limited by a power budget condition.
+
+ 1.1.2 Set Desired Frequency:
+ ----------------------------
+ This command is used by the OSPM to communicate to the platform firmware the
+ desired frequency for a logical processor. The output buffer is currently
+ ignored by OSPM. The next invocation of "Get Average Frequency" will inform
+ OSPM if the desired frequency was achieved or not.
+
+ 1.2 Platforms affected:
+ -----------------------
+ The PCC driver will load on any system where the platform firmware:
+ * supports the PCC interface, and the associated PCCH() and PCCP() methods
+ * assumes responsibility for managing the hardware clocking controls in order
+ to deliver the requested processor performance
+
+ Currently, certain HP ProLiant platforms implement the PCC interface. On those
+ platforms PCC is the "default" choice.
+
+ However, it is possible to disable this interface via a BIOS setting. In
+ such an instance, as is also the case on platforms where the PCC interface
+ is not implemented, the PCC driver will fail to load silently.
+
+ 2. Driver and /sys details:
+ ---------------------------
+ When the driver loads, it merely prints the lowest and the highest CPU
+ frequencies supported by the platform firmware.
+
+ The PCC driver loads with a message such as:
+ pcc-cpufreq: (v1.00.00) driver loaded with frequency limits: 1600 MHz, 2933
+ MHz
+
+ This means that the OPSM can request the CPU to run at any frequency in
+ between the limits (1600 MHz, and 2933 MHz) specified in the message.
+
+ Internally, there is no need for the driver to convert the "target" frequency
+ to a corresponding P-state.
+
+ The VERSION number for the driver will be of the format v.xy.ab.
+ eg: 1.00.02
+    ----- --
+     |    |
+     |    -- this will increase with bug fixes/enhancements to the driver
+     |-- this is the version of the PCC specification the driver adheres to
+
+
+ The following is a brief discussion on some of the fields exported via the
+ /sys filesystem and how their values are affected by the PCC driver:
+
+ 2.1 scaling_available_frequencies:
+ ----------------------------------
+ scaling_available_frequencies is not created in /sys. No intermediate
+ frequencies need to be listed because the BIOS will try to achieve any
+ frequency, within limits, requested by the governor. A frequency does not have
+ to be strictly associated with a P-state.
+
+ 2.2 cpuinfo_transition_latency:
+ -------------------------------
+ The cpuinfo_transition_latency field is 0. The PCC specification does
+ not include a field to expose this value currently.
+
+ 2.3 cpuinfo_cur_freq:
+ ---------------------
+ A) Often cpuinfo_cur_freq will show a value different than what is declared
+ in the scaling_available_frequencies or scaling_cur_freq, or scaling_max_freq.
+ This is due to "turbo boost" available on recent Intel processors. If certain
+ conditions are met the BIOS can achieve a slightly higher speed than requested
+ by OSPM. An example:
+
+ scaling_cur_freq	: 2933000
+ cpuinfo_cur_freq	: 3196000
+
+ B) There is a round-off error associated with the cpuinfo_cur_freq value.
+ Since the driver obtains the current frequency as a "percentage" (%) of the
+ nominal frequency from the BIOS, sometimes, the values displayed by
+ scaling_cur_freq and cpuinfo_cur_freq may not match. An example:
+
+ scaling_cur_freq	: 1600000
+ cpuinfo_cur_freq	: 1583000
+
+ In this example, the nominal frequency is 2933 MHz. The driver obtains the
+ current frequency, cpuinfo_cur_freq, as 54% of the nominal frequency:
+
+ 	54% of 2933 MHz = 1583 MHz
+
+ Nominal frequency is the maximum frequency of the processor, and it usually
+ corresponds to the frequency of the P0 P-state.
+
+ 2.4 related_cpus:
+ -----------------
+ The related_cpus field is identical to affected_cpus.
+
+ affected_cpus	: 4
+ related_cpus	: 4
+
+ Currently, the PCC driver does not evaluate _PSD. The platforms that support
+ PCC do not implement SW_ALL. So OSPM doesn't need to perform any coordination
+ to ensure that the same frequency is requested of all dependent CPUs.
+
+ 3. Caveats:
+ -----------
+ The "cpufreq_stats" module in its present form cannot be loaded and
+ expected to work with the PCC driver. Since the "cpufreq_stats" module
+ provides information wrt each P-state, it is not applicable to the PCC driver.
Index: linux-pm/Documentation/admin-guide/pm/working-state.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/working-state.rst
+++ linux-pm/Documentation/admin-guide/pm/working-state.rst
@@ -11,4 +11,5 @@ Working-State Power Management
    intel_idle
    cpufreq
    intel_pstate
+   cpufreq_drivers
    intel_epb
Index: linux-pm/Documentation/cpu-freq/amd-powernow.txt
===================================================================
--- linux-pm.orig/Documentation/cpu-freq/amd-powernow.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-
-PowerNow! and Cool'n'Quiet are AMD names for frequency
-management capabilities in AMD processors. As the hardware
-implementation changes in new generations of the processors,
-there is a different cpu-freq driver for each generation.
-
-Note that the driver's will not load on the "wrong" hardware,
-so it is safe to try each driver in turn when in doubt as to
-which is the correct driver.
-
-Note that the functionality to change frequency (and voltage)
-is not available in all processors. The drivers will refuse
-to load on processors without this capability. The capability
-is detected with the cpuid instruction.
-
-The drivers use BIOS supplied tables to obtain frequency and
-voltage information appropriate for a particular platform.
-Frequency transitions will be unavailable if the BIOS does
-not supply these tables.
-
-6th Generation: powernow-k6
-
-7th Generation: powernow-k7: Athlon, Duron, Geode.
-
-8th Generation: powernow-k8: Athlon, Athlon 64, Opteron, Sempron.
-Documentation on this functionality in 8th generation processors
-is available in the "BIOS and Kernel Developer's Guide", publication
-26094, in chapter 9, available for download from www.amd.com. 
-
-BIOS supplied data, for powernow-k7 and for powernow-k8, may be
-from either the PSB table or from ACPI objects. The ACPI support
-is only available if the kernel config sets CONFIG_ACPI_PROCESSOR.
-The powernow-k8 driver will attempt to use ACPI if so configured,
-and fall back to PST if that fails.
-The powernow-k7 driver will try to use the PSB support first, and
-fall back to ACPI if the PSB support fails. A module parameter,
-acpi_force, is provided to force ACPI support to be used instead 
-of PSB support.
Index: linux-pm/Documentation/cpu-freq/cpufreq-nforce2.txt
===================================================================
--- linux-pm.orig/Documentation/cpu-freq/cpufreq-nforce2.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-
-The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 platforms.
-
-This works better than on other platforms, because the FSB of the CPU
-can be controlled independently from the PCI/AGP clock.
-
-The module has two options:
-
-	fid: 	 multiplier * 10 (for example 8.5 = 85)
-	min_fsb: minimum FSB
-
-If not set, fid is calculated from the current CPU speed and the FSB.
-min_fsb defaults to FSB at boot time - 50 MHz.
-
-IMPORTANT: The available range is limited downwards!
-           Also the minimum available FSB can differ, for systems 
-           booting with 200 MHz, 150 should always work.
-
-
Index: linux-pm/Documentation/cpu-freq/pcc-cpufreq.txt
===================================================================
--- linux-pm.orig/Documentation/cpu-freq/pcc-cpufreq.txt
+++ /dev/null
@@ -1,207 +0,0 @@
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
-
-1. Introduction:
-----------------
-Processor Clocking Control (PCC) is an interface between the platform
-firmware and OSPM. It is a mechanism for coordinating processor
-performance (ie: frequency) between the platform firmware and the OS.
-
-The PCC driver (pcc-cpufreq) allows OSPM to take advantage of the PCC
-interface.
-
-OS utilizes the PCC interface to inform platform firmware what frequency the
-OS wants for a logical processor. The platform firmware attempts to achieve
-the requested frequency. If the request for the target frequency could not be
-satisfied by platform firmware, then it usually means that power budget
-conditions are in place, and "power capping" is taking place.
-
-1.1 PCC interface:
-------------------
-The complete PCC specification is available here:
-http://www.acpica.org/download/Processor-Clocking-Control-v1p0.pdf
-
-PCC relies on a shared memory region that provides a channel for communication
-between the OS and platform firmware. PCC also implements a "doorbell" that
-is used by the OS to inform the platform firmware that a command has been
-sent.
-
-The ACPI PCCH() method is used to discover the location of the PCC shared
-memory region. The shared memory region header contains the "command" and
-"status" interface. PCCH() also contains details on how to access the platform
-doorbell.
-
-The following commands are supported by the PCC interface:
-* Get Average Frequency
-* Set Desired Frequency
-
-The ACPI PCCP() method is implemented for each logical processor and is
-used to discover the offsets for the input and output buffers in the shared
-memory region.
-
-When PCC mode is enabled, the platform will not expose processor performance
-or throttle states (_PSS, _TSS and related ACPI objects) to OSPM. Therefore,
-the native P-state driver (such as acpi-cpufreq for Intel, powernow-k8 for
-AMD) will not load.
-
-However, OSPM remains in control of policy. The governor (eg: "ondemand")
-computes the required performance for each processor based on server workload.
-The PCC driver fills in the command interface, and the input buffer and
-communicates the request to the platform firmware. The platform firmware is
-responsible for delivering the requested performance.
-
-Each PCC command is "global" in scope and can affect all the logical CPUs in
-the system. Therefore, PCC is capable of performing "group" updates. With PCC
-the OS is capable of getting/setting the frequency of all the logical CPUs in
-the system with a single call to the BIOS.
-
-1.1.1 Get Average Frequency:
-----------------------------
-This command is used by the OSPM to query the running frequency of the
-processor since the last time this command was completed. The output buffer
-indicates the average unhalted frequency of the logical processor expressed as
-a percentage of the nominal (ie: maximum) CPU frequency. The output buffer
-also signifies if the CPU frequency is limited by a power budget condition.
-
-1.1.2 Set Desired Frequency:
-----------------------------
-This command is used by the OSPM to communicate to the platform firmware the
-desired frequency for a logical processor. The output buffer is currently
-ignored by OSPM. The next invocation of "Get Average Frequency" will inform
-OSPM if the desired frequency was achieved or not.
-
-1.2 Platforms affected:
------------------------
-The PCC driver will load on any system where the platform firmware:
-* supports the PCC interface, and the associated PCCH() and PCCP() methods
-* assumes responsibility for managing the hardware clocking controls in order
-to deliver the requested processor performance
-
-Currently, certain HP ProLiant platforms implement the PCC interface. On those
-platforms PCC is the "default" choice.
-
-However, it is possible to disable this interface via a BIOS setting. In
-such an instance, as is also the case on platforms where the PCC interface
-is not implemented, the PCC driver will fail to load silently.
-
-2. Driver and /sys details:
----------------------------
-When the driver loads, it merely prints the lowest and the highest CPU
-frequencies supported by the platform firmware.
-
-The PCC driver loads with a message such as:
-pcc-cpufreq: (v1.00.00) driver loaded with frequency limits: 1600 MHz, 2933
-MHz
-
-This means that the OPSM can request the CPU to run at any frequency in
-between the limits (1600 MHz, and 2933 MHz) specified in the message.
-
-Internally, there is no need for the driver to convert the "target" frequency
-to a corresponding P-state.
-
-The VERSION number for the driver will be of the format v.xy.ab.
-eg: 1.00.02
-   ----- --
-    |    |
-    |    -- this will increase with bug fixes/enhancements to the driver
-    |-- this is the version of the PCC specification the driver adheres to
-
-
-The following is a brief discussion on some of the fields exported via the
-/sys filesystem and how their values are affected by the PCC driver:
-
-2.1 scaling_available_frequencies:
-----------------------------------
-scaling_available_frequencies is not created in /sys. No intermediate
-frequencies need to be listed because the BIOS will try to achieve any
-frequency, within limits, requested by the governor. A frequency does not have
-to be strictly associated with a P-state.
-
-2.2 cpuinfo_transition_latency:
--------------------------------
-The cpuinfo_transition_latency field is 0. The PCC specification does
-not include a field to expose this value currently.
-
-2.3 cpuinfo_cur_freq:
----------------------
-A) Often cpuinfo_cur_freq will show a value different than what is declared
-in the scaling_available_frequencies or scaling_cur_freq, or scaling_max_freq.
-This is due to "turbo boost" available on recent Intel processors. If certain
-conditions are met the BIOS can achieve a slightly higher speed than requested
-by OSPM. An example:
-
-scaling_cur_freq	: 2933000
-cpuinfo_cur_freq	: 3196000
-
-B) There is a round-off error associated with the cpuinfo_cur_freq value.
-Since the driver obtains the current frequency as a "percentage" (%) of the
-nominal frequency from the BIOS, sometimes, the values displayed by
-scaling_cur_freq and cpuinfo_cur_freq may not match. An example:
-
-scaling_cur_freq	: 1600000
-cpuinfo_cur_freq	: 1583000
-
-In this example, the nominal frequency is 2933 MHz. The driver obtains the
-current frequency, cpuinfo_cur_freq, as 54% of the nominal frequency:
-
-	54% of 2933 MHz = 1583 MHz
-
-Nominal frequency is the maximum frequency of the processor, and it usually
-corresponds to the frequency of the P0 P-state.
-
-2.4 related_cpus:
------------------
-The related_cpus field is identical to affected_cpus.
-
-affected_cpus	: 4
-related_cpus	: 4
-
-Currently, the PCC driver does not evaluate _PSD. The platforms that support
-PCC do not implement SW_ALL. So OSPM doesn't need to perform any coordination
-to ensure that the same frequency is requested of all dependent CPUs.
-
-3. Caveats:
------------
-The "cpufreq_stats" module in its present form cannot be loaded and
-expected to work with the PCC driver. Since the "cpufreq_stats" module
-provides information wrt each P-state, it is not applicable to the PCC driver.



