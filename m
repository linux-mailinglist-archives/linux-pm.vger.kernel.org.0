Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340FF5BE67E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Sep 2022 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiITM4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Sep 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiITM4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2022 08:56:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C1D6152
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663678546; x=1695214546;
  h=from:to:cc:subject:date:message-id;
  bh=o9Ez7TClJZ4ittYm50XTkMlhXRH2Rw9adhYMWQ9yaIQ=;
  b=lkVVcMl7xmmBORBUQ/d3UhyOMaFxCpzv1vD4RcyDJxT30TXzTJbZtc97
   ilYUNfrcHletOLo6Or3SHaJkgIKd0Eo/1EYGcr2ToKoiTn3HqUxrcBTRM
   B8F/vEgSZLnsCFP4uGuMjTHJfLOzRT5nrhqE2+c6dxYeRZOCip5WhpOdJ
   PXbezSI6C220/shfT+G6ptjqJHIMj+j7gOOT4oeFAINFKbkz8ybHJfHPD
   0sQ0+v9idFSMhRpgmnIf1hz6SdIQo0ULDzNzemdVM7y3+E9XV08T6+wme
   BQi06TP2YVQAmJ1WXIF1xzc6v1Ye/HTig8Aw2d3DPjUkSTGI5qsafH6xh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="300503700"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="300503700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="649574712"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2022 05:55:40 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, vinay.kumar@intel.com,
        baieswara.reddy.sagili@intel.com, rui.zhang@intel.com
Subject: [PATCH] intel_idle: Add AlderLake-N support
Date:   Tue, 20 Sep 2022 20:58:48 +0800
Message-Id: <20220920125848.32635-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to ther other AlderLake platforms, the C1 and C1E states on
ADL-N are mutually exclusive. Only one of them can be enabled at a time.
C1E is preferred on ADL-N for better energy efficiency.

C6S is also supported on this platform. Its latency is far bigger than
C6, but really close to C8 (PC8), thus it is not exposed as a separate
state.

Suggested-by: Baieswara Reddy Sagili <baieswara.reddy.sagili@intel.com>
Suggested-by: Vinay Kumar <vinay.kumar@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3e101719689a..8d56b06ddca4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -928,6 +928,51 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state adl_n_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 2,
+		.target_residency = 4,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 195,
+		.target_residency = 585,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C8",
+		.desc = "MWAIT 0x40",
+		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 260,
+		.target_residency = 1040,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C10",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 660,
+		.target_residency = 1980,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C1",
@@ -1309,6 +1354,10 @@ static const struct idle_cpu idle_cpu_adl_l __initconst = {
 	.state_table = adl_l_cstates,
 };
 
+static const struct idle_cpu idle_cpu_adl_n __initconst = {
+	.state_table = adl_n_cstates,
+};
+
 static const struct idle_cpu idle_cpu_spr __initconst = {
 	.state_table = spr_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1379,6 +1428,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&idle_cpu_adl_n),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
@@ -1816,6 +1866,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		break;
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_ALDERLAKE_N:
 		adl_idle_state_table_update();
 		break;
 	}
-- 
2.25.1

