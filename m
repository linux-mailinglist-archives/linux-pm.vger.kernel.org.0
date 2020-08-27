Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A515254957
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgH0P1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 11:27:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61776 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgH0P1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 11:27:47 -0400
Received: from 89-64-89-85.dynamic.chello.pl (89.64.89.85) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 4acbb2b275e3550f; Thu, 27 Aug 2020 17:27:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v3 5/5] cpufreq: intel_pstate: Free memory only when turning off
Date:   Thu, 27 Aug 2020 17:27:26 +0200
Message-ID: <6183373.v6t3ZZ7XD0@kreacher>
In-Reply-To: <2240881.fzTuzKk6Gz@kreacher>
References: <2240881.fzTuzKk6Gz@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

When intel_pstate switches the operation mode from "active" to
"passive" or the other way around, freeing its data structures
representing CPUs and allocating them again from scratch is not
necessary and wasteful.  Moreover, if these data structures are
preserved, the cached HWP Request MSR value from there may be
written to the MSR to start with to reinitialize it and help to
restore the EPP value set previously (it is set to 0xFF when CPUs
go offline to allow their SMT siblings to use the full range of
EPP values and that also happens when the driver gets unregistered).

Accordingly, modify the driver to only do a full cleanup on driver
object registration errors and when its status is changed to "off"
via sysfs and to write the cached HWP Request MSR value back to
the MSR on CPU init if the data structure representing the given
CPU is still there.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Rearrange intel_pstate_init_cpu() to restore some of the previous
       behavior of it to retain the current active-mode EPP management.

v2 -> v3:
   * Rebase (it was [4/5] previously).

---
 drivers/cpufreq/intel_pstate.c | 53 +++++++++++++---------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a265ccbcbbd7..259de3c0e658 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2116,25 +2116,27 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 		all_cpu_data[cpunum] = cpu;
 
-		cpu->epp_default = -EINVAL;
-		cpu->epp_powersave = -EINVAL;
-	}
+		cpu->cpu = cpunum;
 
-	cpu = all_cpu_data[cpunum];
+		cpu->epp_default = -EINVAL;
 
-	cpu->cpu = cpunum;
+		if (hwp_active) {
+			const struct x86_cpu_id *id;
 
-	if (hwp_active) {
-		const struct x86_cpu_id *id;
+			intel_pstate_hwp_enable(cpu);
 
-		intel_pstate_hwp_enable(cpu);
-		cpu->epp_policy = 0;
-
-		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
-		if (id && intel_pstate_acpi_pm_profile_server())
-			hwp_boost = true;
+			id = x86_match_cpu(intel_pstate_hwp_boost_ids);
+			if (id && intel_pstate_acpi_pm_profile_server())
+				hwp_boost = true;
+		}
+	} else if (hwp_active) {
+		wrmsrl_on_cpu(cpunum, MSR_HWP_REQUEST,
+			      READ_ONCE(cpu->hwp_req_cached));
 	}
 
+	cpu->epp_powersave = -EINVAL;
+	cpu->epp_policy = 0;
+
 	intel_pstate_get_cpu_pstates(cpu);
 
 	pr_debug("controlling: cpu %d\n", cpunum);
@@ -2728,9 +2730,6 @@ static void intel_pstate_driver_cleanup(void)
 	}
 	put_online_cpus();
 
-	if (intel_pstate_driver == &intel_pstate)
-		intel_pstate_sysfs_hide_hwp_dynamic_boost();
-
 	intel_pstate_driver = NULL;
 }
 
@@ -2756,14 +2755,6 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 	return 0;
 }
 
-static int intel_pstate_unregister_driver(void)
-{
-	cpufreq_unregister_driver(intel_pstate_driver);
-	intel_pstate_driver_cleanup();
-
-	return 0;
-}
-
 static ssize_t intel_pstate_show_status(char *buf)
 {
 	if (!intel_pstate_driver)
@@ -2775,8 +2766,6 @@ static ssize_t intel_pstate_show_status(char *buf)
 
 static int intel_pstate_update_status(const char *buf, size_t size)
 {
-	int ret;
-
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
 			return -EINVAL;
@@ -2784,7 +2773,8 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 		if (hwp_active)
 			return -EBUSY;
 
-		return intel_pstate_unregister_driver();
+		cpufreq_unregister_driver(intel_pstate_driver);
+		intel_pstate_driver_cleanup();
 	}
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
@@ -2792,9 +2782,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 			if (intel_pstate_driver == &intel_pstate)
 				return 0;
 
-			ret = intel_pstate_unregister_driver();
-			if (ret)
-				return ret;
+			cpufreq_unregister_driver(intel_pstate_driver);
 		}
 
 		return intel_pstate_register_driver(&intel_pstate);
@@ -2805,9 +2793,8 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 			if (intel_pstate_driver == &intel_cpufreq)
 				return 0;
 
-			ret = intel_pstate_unregister_driver();
-			if (ret)
-				return ret;
+			cpufreq_unregister_driver(intel_pstate_driver);
+			intel_pstate_sysfs_hide_hwp_dynamic_boost();
 		}
 
 		return intel_pstate_register_driver(&intel_cpufreq);
-- 
2.26.2




