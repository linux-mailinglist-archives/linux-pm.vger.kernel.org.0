Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4367E71F206
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjFASbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjFASar (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 14:30:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610151B9
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685644246; x=1717180246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7iBLJ8cWDJrTQv0o3e2MbK1UDlcv/vN12Fvbh88Azo=;
  b=a59LSMRu8Ki2v7YqCgNHDI2ndlRlccRsrxZHYFud76muADSLC6Hv8MWH
   86iUW1FNT4Nyb8racBTFf4LCK6POTNPEBRI68zf9oriuTmtwjM808UxoD
   lJvedjnCFPRzHxE/EFtvaFAhJftMRnRCycsxWtvC3h3u6CUeW6FK70KP6
   5XwS7jnuPATyTz3dKLdMHk4cKnOv3IIe5LjTigKNO1eXS/BWEfolmfXeG
   6tYTXfnbur7sUUL79atTeTWnnHSskVPBF4Qvhpc62wboqADrL0Nxjwi1i
   wmQ1h1dMtKGV7/Scdywum/+6Zmciht8lRtNi1fvlPUkFaHRnswXMDF/z4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383921647"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383921647"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657900932"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657900932"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:22 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 7/7] intel_idle: Add a "Long HLT" C1 state for the VM guest mode
Date:   Thu,  1 Jun 2023 18:28:01 +0000
Message-Id: <20230601182801.2622044-8-arjan@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601182801.2622044-1-arjan@linux.intel.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan.van.de.ven@intel.com>

intel_idle will, for the bare metal case, usually have one or more deep
power states that have the CPUIDLE_FLAG_TLB_FLUSHED flag set. When
a state with this flag is selected by the cpuidle framework, it will also
flush the TLBs as part of entering this state. The benefit of doing this is
that the kernel does not need to wake the cpu out of this deep power state
just to flush the TLBs... for which the latency can be very high due to
the exit latency of deep power states.

In a VM guest currently, this benefit of avoiding the wakeup does not exist,
while the problem (long exit latency) is even more severe. Linux will need
to wake up a vCPU (causing the host to either come out of a deep C state,
or the VMM to have to deschedule something else to schedule the vCPU) which
can take a very long time.. adding a lot of latency to tlb flush operations
(including munmap and others).

To solve this, add a "Long HLT" C state to the state table for the VM guest
case that has the CPUIDLE_FLAG_TLB_FLUSHED flag set.  The result of that is
that for long idle periods (where the VMM is likely to do things that cause
large latency) the cpuidle framework will flush the TLBs (and avoid the
wakeups), while for short/quick idle durations, the existing behavior is
retained.

Now, there is still only "hlt" available in the guest, but for long idle,
the host can go to a deeper state (say C6).  There is a reasonable debate
one can have to what to set for the exit_latency and break even point for
this "Long HLT" state.  The good news is that intel_idle has these values
available for the underlying CPU (even when mwait is not exposed).  The
solution thus is to just use the latency and break even of the deepest state
from the bare metal CPU.  This is under the assumption that this is a pretty
reasonable estimate of what the VMM would do to cause latency.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c4929d8a35a4..e056e1ec64a9 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1288,6 +1288,13 @@ static struct cpuidle_state vmguest_cstates[] __initdata = {
 		.exit_latency = 5,
 		.target_residency = 10,
 		.enter = &intel_idle_hlt_irq, },
+	{
+		.name = "C1L",
+		.desc = "Long HLT",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 5,
+		.target_residency = 200,
+		.enter = &intel_idle_hlt, },
 	{
 		.enter = NULL }
 };
@@ -2117,6 +2124,44 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
 		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
 }
 
+/*
+ * Match up the latency and break even point of the bare metal (cpu based)
+ * states with the deepest VM available state.
+ *
+ * We only want to do this for the deepest state, the ones that has
+ * the TLB_FLUSHED flag set on the .
+ *
+ * All our short idle states are dominated by vmexit/vmenter latencies,
+ * not the underlying hardware latencies so we keep our values for these.
+ */
+static void matchup_vm_state_with_baremetal(void)
+{
+	int cstate;
+
+	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
+		int matching_cstate;
+
+		if (intel_idle_max_cstate_reached(cstate))
+			break;
+
+		if (!cpuidle_state_table[cstate].enter &&
+		    !cpuidle_state_table[cstate].enter_s2idle)
+			break;
+
+		if (!(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_TLB_FLUSHED))
+			continue;
+
+		for (matching_cstate = 0; matching_cstate < CPUIDLE_STATE_MAX; ++matching_cstate) {
+			if (icpu->state_table[matching_cstate].exit_latency > cpuidle_state_table[cstate].exit_latency) {
+				cpuidle_state_table[cstate].exit_latency = icpu->state_table[matching_cstate].exit_latency;
+				cpuidle_state_table[cstate].target_residency = icpu->state_table[matching_cstate].target_residency;
+			}
+		}
+
+	}
+}
+
+
 static int __init intel_idle_vminit(const struct x86_cpu_id *id)
 {
 	int retval;
@@ -2133,6 +2178,15 @@ static int __init intel_idle_vminit(const struct x86_cpu_id *id)
 	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
 
+	/*
+	 * We don't know exactly what the host will do when we go idle, but as a worst estimate
+	 * we can assume that the exit latency of the deepest host state will be hit for our
+	 * deep (long duration) guest idle state.
+	 * The same logic applies to the break even point for the long duration guest idle state.
+	 * So lets copy these two properties from the table we found for the host CPU type.
+	 */
+	matchup_vm_state_with_baremetal();
+
 	intel_idle_cpuidle_driver_init(&intel_idle_driver);
 
 	retval = cpuidle_register_driver(&intel_idle_driver);
-- 
2.40.1

