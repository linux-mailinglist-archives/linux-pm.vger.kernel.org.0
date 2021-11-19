Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55064456976
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 06:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhKSFVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 00:21:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:43846 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhKSFVI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 00:21:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221237583"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="221237583"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 21:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="536999203"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2021 21:18:07 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ricardo.neri@intel.com, tim.c.chen@intel.com, peterz@infradead.org,
        Michael@MichaelLarabel.com, arjan@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: ITMT support for overclocked system
Date:   Thu, 18 Nov 2021 21:18:01 -0800
Message-Id: <20211119051801.1432724-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On systems with overclocking enabled, CPPC Highest Performance can be
hard coded to 0xff. In this case even if we have cores with different
highest performance, ITMT can't be enabled as the current implementation
depends on CPPC Highest Performance.

On such systems we can use MSR_HWP_CAPABILITIES maximum performance field
when CPPC.Highest Performance is 0xff.

Due to legacy reasons, we can't solely depend on MSR_HWP_CAPABILITIES as
in some older systems CPPC Highest Performance is the only way to identify
different performing cores.

Reported-by: Michael Larabel <Michael@MichaelLarabel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This patch was tested on one Alder Lake system by enabling Overclocking.
Once overclocking is enabled, we see
$cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf 
255 (P-Cores)
255 (P-Cores
...
...
255 (E-Cores)
255 (E-Cores)
The real max performance for CPUs on this system was
0x40 for P-cores and 0x26 for E-cores.
With this change applied we will see
$cat /proc/sys/kernel/sched_itmt_enabled 
1
The resultant ITMT priorities
for P-core 0x40, P-core HT sibling 0x10 and E-core 0x26

 drivers/cpufreq/intel_pstate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 815df3daae9d..3106e62ffb25 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -338,6 +338,8 @@ static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
 
 static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
 
+#define CPPC_MAX_PERF	U8_MAX
+
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 	struct cppc_perf_caps cppc_perf;
@@ -348,6 +350,14 @@ static void intel_pstate_set_itmt_prio(int cpu)
 	if (ret)
 		return;
 
+	/*
+	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
+	 * In this case we can't use CPPC.highest_perf to enable ITMT.
+	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
+	 */
+	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
+		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
+
 	/*
 	 * The priorities can be set regardless of whether or not
 	 * sched_set_itmt_support(true) has been called and it is valid to
-- 
2.31.1

