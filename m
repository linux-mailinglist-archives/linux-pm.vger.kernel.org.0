Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AEB71F200
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjFASbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjFASas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 14:30:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C11B8
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685644246; x=1717180246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y2t8/LIeUlBkDeRC1K4Q3OOvQDYIW/K1pQfYY1RRulw=;
  b=k0L0IRQ+FDd1MRXdbFlO4aXPdBggAk9u4ROrPwNzPc+i9SzgblTpY6Sa
   sdL1x+EHDXbELdje6k+126TA6MPmU9b/BrGZj5/Cs1o01x3IqB6WiYEMg
   /xAxT3sZJxMmw28cUh2gLnO9xdJ1uxBOxXUwbI5WjETeaTk2X7utg7gpa
   wZl6vOUuZSJkvLfNBff57YD7DxaGoz36WNUZNkD/2jaIPT7Rqyia3KmPw
   eWRYLBfqsisbIUV1iuAXEo1Ir85ic7UNf/1sncK+2znErqAXz93TYMZrh
   1AMe92GLHPXGKyT+E5dQW981KbsqCH3krmaOk+sz02cLGWnMnz0ceVzNO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383921645"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383921645"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657900926"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657900926"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:21 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 6/7] intel_idle: Add support for using intel_idle in a VM guest using just hlt
Date:   Thu,  1 Jun 2023 18:28:00 +0000
Message-Id: <20230601182801.2622044-7-arjan@linux.intel.com>
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

In a typical VM guest, the mwait instruction is not available, leaving only the
'hlt' instruction (which causes a VMEXIT to the host).

So currently, intel_idle will detect the lack of mwait, and fail
to initialize (after which another idle method would step in which will
just use hlt always).

By providing capability to do this with the intel_idle driver, we can
do better than this fallback. While this current change only gets us parity
to the existing behavior, later patches in this series will add new capabilities.

In order to do this, a simplified version of the initialization function
for VM guests is created, and this will be called if the CPU is recognized,
but mwait is not supported, and we're in a VM guest.

One thing to note is that the latency (and break even) of this C1 state
is higher than the typical bare metal C1 state. Because hlt causes a vmexit,
and the cost of vmexit + hypervisor overhead + vmenter is typically in the
order of upto 5 microseconds... even if the hypervisor does not actually
goes into a hardware power saving state.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 55c3e6ece3dd..c4929d8a35a4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1280,6 +1280,18 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state vmguest_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "HLT",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
+		.exit_latency = 5,
+		.target_residency = 10,
+		.enter = &intel_idle_hlt_irq, },
+	{
+		.enter = NULL }
+};
+
 static const struct idle_cpu idle_cpu_nehalem __initconst = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
@@ -2105,6 +2117,46 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
 		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
 }
 
+static int __init intel_idle_vminit(const struct x86_cpu_id *id)
+{
+	int retval;
+
+	cpuidle_state_table = vmguest_cstates;
+	skip_mwait_check = true; /* hypervisor hides mwait from us normally */
+
+	icpu = (const struct idle_cpu *)id->driver_data;
+
+	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
+		 boot_cpu_data.x86_model);
+
+	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
+	if (!intel_idle_cpuidle_devices)
+		return -ENOMEM;
+
+	intel_idle_cpuidle_driver_init(&intel_idle_driver);
+
+	retval = cpuidle_register_driver(&intel_idle_driver);
+	if (retval) {
+		struct cpuidle_driver *drv = cpuidle_get_driver();
+		printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
+		       drv ? drv->name : "none");
+		goto init_driver_fail;
+	}
+
+	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
+				   intel_idle_cpu_online, NULL);
+	if (retval < 0)
+		goto hp_setup_fail;
+
+	return 0;
+hp_setup_fail:
+	intel_idle_cpuidle_devices_uninit();
+	cpuidle_unregister_driver(&intel_idle_driver);
+init_driver_fail:
+	free_percpu(intel_idle_cpuidle_devices);
+	return retval;
+}
+
 static int __init intel_idle_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -2123,6 +2175,8 @@ static int __init intel_idle_init(void)
 	id = x86_match_cpu(intel_idle_ids);
 	if (id) {
 		if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+			if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+				return intel_idle_vminit(id);
 			pr_debug("Please enable MWAIT in BIOS SETUP\n");
 			return -ENODEV;
 		}
-- 
2.40.1

