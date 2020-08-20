Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5224C374
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgHTQjM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 12:39:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41938 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgHTQjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 12:39:11 -0400
Received: from 89-64-87-57.dynamic.chello.pl (89.64.87.57) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 48e50a6e30a2fd8e; Thu, 20 Aug 2020 18:39:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 4/4] cpufreq: intel_pstate: Free memory only when turning off
Date:   Thu, 20 Aug 2020 18:38:40 +0200
Message-ID: <5545992.MujegtMJko@kreacher>
In-Reply-To: <2283366.Lr8yYYnyev@kreacher>
References: <2283366.Lr8yYYnyev@kreacher>
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
 drivers/cpufreq/intel_pstate.c | 51 +++++++++++++---------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index aca0587b176f..a7c6491f2b4a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2091,30 +2091,32 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 	cpu = all_cpu_data[cpunum];
 
-	if (!cpu) {
+	if (cpu) {
+		if (hwp_active)
+			wrmsrl_on_cpu(cpunum, MSR_HWP_REQUEST,
+				      cpu->hwp_req_cached);
+	} else {
 		cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
 		if (!cpu)
 			return -ENOMEM;
 
 		all_cpu_data[cpunum] = cpu;
 
+		cpu->cpu = cpunum;
+
 		cpu->epp_default = -EINVAL;
 		cpu->epp_powersave = -EINVAL;
 		cpu->epp_saved = -EINVAL;
-	}
-
-	cpu = all_cpu_data[cpunum];
 
-	cpu->cpu = cpunum;
+		if (hwp_active) {
+			const struct x86_cpu_id *id;
 
-	if (hwp_active) {
-		const struct x86_cpu_id *id;
+			intel_pstate_hwp_enable(cpu);
 
-		intel_pstate_hwp_enable(cpu);
-
-		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
-		if (id && intel_pstate_acpi_pm_profile_server())
-			hwp_boost = true;
+			id = x86_match_cpu(intel_pstate_hwp_boost_ids);
+			if (id && intel_pstate_acpi_pm_profile_server())
+				hwp_boost = true;
+		}
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
@@ -2701,9 +2703,6 @@ static void intel_pstate_driver_cleanup(void)
 	}
 	put_online_cpus();
 
-	if (intel_pstate_driver == &intel_pstate)
-		intel_pstate_sysfs_hide_hwp_dynamic_boost();
-
 	intel_pstate_driver = NULL;
 }
 
@@ -2729,14 +2728,6 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
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
@@ -2748,8 +2739,6 @@ static ssize_t intel_pstate_show_status(char *buf)
 
 static int intel_pstate_update_status(const char *buf, size_t size)
 {
-	int ret;
-
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
 			return -EINVAL;
@@ -2757,7 +2746,8 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 		if (hwp_active)
 			return -EBUSY;
 
-		return intel_pstate_unregister_driver();
+		cpufreq_unregister_driver(intel_pstate_driver);
+		intel_pstate_driver_cleanup();
 	}
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
@@ -2765,9 +2755,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 			if (intel_pstate_driver == &intel_pstate)
 				return 0;
 
-			ret = intel_pstate_unregister_driver();
-			if (ret)
-				return ret;
+			cpufreq_unregister_driver(intel_pstate_driver);
 		}
 
 		return intel_pstate_register_driver(&intel_pstate);
@@ -2778,9 +2766,8 @@ static int intel_pstate_update_status(const char *buf, size_t size)
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




