Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75262196631
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgC1M60 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 08:58:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58417 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1M60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 08:58:26 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9c4c29803feb8bf4; Sat, 28 Mar 2020 13:58:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Use passive mode by default without HWP
Date:   Sat, 28 Mar 2020 13:57:48 +0100
Message-ID: <2988949.NgUrjYMkJj@kreacher>
In-Reply-To: <2016232.ihCVsphvri@kreacher>
References: <2016232.ihCVsphvri@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After recent changes allowing scale-invariant utilization to be
used on x86, the schedutil governor on top of intel_pstate in the
passive mode should be on par with (or better than) the active mode
"powersave" algorithm of intel_pstate on systems in which
hardware-managed P-states (HWP) are not used, so it should not be
necessary to use the internal scaling algorithm in those cases.

Accordingly, modify intel_pstate to start in the passive mode by
default if the processor at hand does not support HWP of if the driver
is requested to avoid using HWP through the kernel command line.

Among other things, that will allow utilization clamps and the
support for RT/DL tasks in the schedutil governor to be utilized on
systems in which intel_pstate is used.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 32 ++++++++++++++++-----------
 drivers/cpufreq/intel_pstate.c                |  3 ++-
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index ad392f3aee06..39d80bc29ccd 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -62,9 +62,10 @@ on the capabilities of the processor.
 Active Mode
 -----------
 
-This is the default operation mode of ``intel_pstate``.  If it works in this
-mode, the ``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq``
-policies contains the string "intel_pstate".
+This is the default operation mode of ``intel_pstate`` for processors with
+hardware-managed P-states (HWP) support.  If it works in this mode, the
+``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq`` policies
+contains the string "intel_pstate".
 
 In this mode the driver bypasses the scaling governors layer of ``CPUFreq`` and
 provides its own scaling algorithms for P-state selection.  Those algorithms
@@ -138,12 +139,13 @@ internal P-state selection logic to be less performance-focused.
 Active Mode Without HWP
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-This is the default operation mode for processors that do not support the HWP
-feature.  It also is used by default with the ``intel_pstate=no_hwp`` argument
-in the kernel command line.  However, in this mode ``intel_pstate`` may refuse
-to work with the given processor if it does not recognize it.  [Note that
-``intel_pstate`` will never refuse to work with any processor with the HWP
-feature enabled.]
+This operation mode is optional for processors that do not support the HWP
+feature or when the ``intel_pstate=no_hwp`` argument is passed to the kernel in
+the command line.  The active mode is used in those cases if the
+``intel_pstate=active`` argument is passed to the kernel in the command line.
+In this mode ``intel_pstate`` may refuse to work with processors that are not
+recognized by it.  [Note that ``intel_pstate`` will never refuse to work with
+any processor with the HWP feature enabled.]
 
 In this mode ``intel_pstate`` registers utilization update callbacks with the
 CPU scheduler in order to run a P-state selection algorithm, either
@@ -188,10 +190,14 @@ is not set.
 Passive Mode
 ------------
 
-This mode is used if the ``intel_pstate=passive`` argument is passed to the
-kernel in the command line (it implies the ``intel_pstate=no_hwp`` setting too).
-Like in the active mode without HWP support, in this mode ``intel_pstate`` may
-refuse to work with the given processor if it does not recognize it.
+This is the default operation mode of ``intel_pstate`` for processors without
+hardware-managed P-states (HWP) support.  It is always used if the
+``intel_pstate=passive`` argument is passed to the kernel in the command line
+regardless of whether or not the given processor supports HWP.  [Note that the
+``intel_pstate=no_hwp`` setting implies ``intel_pstate=passive`` if it is used
+without ``intel_pstate=active``.]  Like in the active mode without HWP support,
+in this mode ``intel_pstate`` may refuse to work with processors that are not
+recognized by it.
 
 If the driver works in this mode, the ``scaling_driver`` policy attribute in
 ``sysfs`` for all ``CPUFreq`` policies contains the string "intel_cpufreq".
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d2297839374d..b24a5c5ec4f9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2769,6 +2769,8 @@ static int __init intel_pstate_init(void)
 		pr_info("Invalid MSRs\n");
 		return -ENODEV;
 	}
+	/* Without HWP start in the passive mode. */
+	default_driver = &intel_cpufreq;
 
 hwp_cpu_matched:
 	/*
@@ -2814,7 +2816,6 @@ static int __init intel_pstate_setup(char *str)
 	if (!strcmp(str, "disable")) {
 		no_load = 1;
 	} else if (!strcmp(str, "passive")) {
-		pr_info("Passive mode enabled\n");
 		default_driver = &intel_cpufreq;
 		no_hwp = 1;
 	}
-- 
2.16.4




