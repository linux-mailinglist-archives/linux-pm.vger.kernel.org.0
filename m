Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB38593AC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 07:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfF1Fuf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 01:50:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:54821 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfF1Fuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 01:50:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 22:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,426,1557212400"; 
   d="scan'208";a="167664543"
Received: from gangcao-mobl2.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.174.16])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2019 22:50:32 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 01/13] intel_rapl: use reg instead of msr
Date:   Fri, 28 Jun 2019 13:50:17 +0800
Message-Id: <1561701029-3415-2-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To support both MSR and MMIO Interface, use 'reg' to discribe RAPL
registers instead of 'msr'.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 98 +++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 8692f6b..45d5f22 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -83,13 +83,13 @@ enum rapl_domain_type {
 	RAPL_DOMAIN_MAX,
 };
 
-enum rapl_domain_msr_id {
-	RAPL_DOMAIN_MSR_LIMIT,
-	RAPL_DOMAIN_MSR_STATUS,
-	RAPL_DOMAIN_MSR_PERF,
-	RAPL_DOMAIN_MSR_POLICY,
-	RAPL_DOMAIN_MSR_INFO,
-	RAPL_DOMAIN_MSR_MAX,
+enum rapl_domain_reg_id {
+	RAPL_DOMAIN_REG_LIMIT,
+	RAPL_DOMAIN_REG_STATUS,
+	RAPL_DOMAIN_REG_PERF,
+	RAPL_DOMAIN_REG_POLICY,
+	RAPL_DOMAIN_REG_INFO,
+	RAPL_DOMAIN_REG_MAX,
 };
 
 /* per domain data, some are optional */
@@ -154,7 +154,7 @@ struct rapl_package;
 struct rapl_domain {
 	const char *name;
 	enum rapl_domain_type id;
-	int msrs[RAPL_DOMAIN_MSR_MAX];
+	int regs[RAPL_DOMAIN_REG_MAX];
 	struct powercap_zone power_zone;
 	struct rapl_domain_data rdd;
 	struct rapl_power_limit rpl[NR_POWER_LIMITS];
@@ -216,7 +216,7 @@ struct rapl_primitive_info {
 	const char *name;
 	u64 mask;
 	int shift;
-	enum rapl_domain_msr_id id;
+	enum rapl_domain_reg_id id;
 	enum unit_type unit;
 	u32 flag;
 };
@@ -642,11 +642,11 @@ static void rapl_init_domains(struct rapl_package *rp)
 		case BIT(RAPL_DOMAIN_PACKAGE):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PACKAGE];
 			rd->id = RAPL_DOMAIN_PACKAGE;
-			rd->msrs[0] = MSR_PKG_POWER_LIMIT;
-			rd->msrs[1] = MSR_PKG_ENERGY_STATUS;
-			rd->msrs[2] = MSR_PKG_PERF_STATUS;
-			rd->msrs[3] = 0;
-			rd->msrs[4] = MSR_PKG_POWER_INFO;
+			rd->regs[0] = MSR_PKG_POWER_LIMIT;
+			rd->regs[1] = MSR_PKG_ENERGY_STATUS;
+			rd->regs[2] = MSR_PKG_PERF_STATUS;
+			rd->regs[3] = 0;
+			rd->regs[4] = MSR_PKG_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			rd->rpl[1].prim_id = PL2_ENABLE;
@@ -655,33 +655,33 @@ static void rapl_init_domains(struct rapl_package *rp)
 		case BIT(RAPL_DOMAIN_PP0):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PP0];
 			rd->id = RAPL_DOMAIN_PP0;
-			rd->msrs[0] = MSR_PP0_POWER_LIMIT;
-			rd->msrs[1] = MSR_PP0_ENERGY_STATUS;
-			rd->msrs[2] = 0;
-			rd->msrs[3] = MSR_PP0_POLICY;
-			rd->msrs[4] = 0;
+			rd->regs[0] = MSR_PP0_POWER_LIMIT;
+			rd->regs[1] = MSR_PP0_ENERGY_STATUS;
+			rd->regs[2] = 0;
+			rd->regs[3] = MSR_PP0_POLICY;
+			rd->regs[4] = 0;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			break;
 		case BIT(RAPL_DOMAIN_PP1):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PP1];
 			rd->id = RAPL_DOMAIN_PP1;
-			rd->msrs[0] = MSR_PP1_POWER_LIMIT;
-			rd->msrs[1] = MSR_PP1_ENERGY_STATUS;
-			rd->msrs[2] = 0;
-			rd->msrs[3] = MSR_PP1_POLICY;
-			rd->msrs[4] = 0;
+			rd->regs[0] = MSR_PP1_POWER_LIMIT;
+			rd->regs[1] = MSR_PP1_ENERGY_STATUS;
+			rd->regs[2] = 0;
+			rd->regs[3] = MSR_PP1_POLICY;
+			rd->regs[4] = 0;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			break;
 		case BIT(RAPL_DOMAIN_DRAM):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_DRAM];
 			rd->id = RAPL_DOMAIN_DRAM;
-			rd->msrs[0] = MSR_DRAM_POWER_LIMIT;
-			rd->msrs[1] = MSR_DRAM_ENERGY_STATUS;
-			rd->msrs[2] = MSR_DRAM_PERF_STATUS;
-			rd->msrs[3] = 0;
-			rd->msrs[4] = MSR_DRAM_POWER_INFO;
+			rd->regs[0] = MSR_DRAM_POWER_LIMIT;
+			rd->regs[1] = MSR_DRAM_ENERGY_STATUS;
+			rd->regs[2] = MSR_DRAM_PERF_STATUS;
+			rd->regs[3] = 0;
+			rd->regs[4] = MSR_DRAM_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			rd->domain_energy_unit =
@@ -736,37 +736,37 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 static struct rapl_primitive_info rpi[] = {
 	/* name, mask, shift, msr index, unit divisor */
 	PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-				RAPL_DOMAIN_MSR_STATUS, ENERGY_UNIT, 0),
+				RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
-				RAPL_DOMAIN_MSR_LIMIT, POWER_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
-				RAPL_DOMAIN_MSR_LIMIT, POWER_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(FW_LOCK, POWER_PP_LOCK, 31,
-				RAPL_DOMAIN_MSR_LIMIT, ARBITRARY_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
-				RAPL_DOMAIN_MSR_LIMIT, ARBITRARY_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
-				RAPL_DOMAIN_MSR_LIMIT, ARBITRARY_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
-				RAPL_DOMAIN_MSR_LIMIT, ARBITRARY_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
-				RAPL_DOMAIN_MSR_LIMIT, ARBITRARY_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
-				RAPL_DOMAIN_MSR_LIMIT, TIME_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
-				RAPL_DOMAIN_MSR_LIMIT, TIME_UNIT, 0),
+				RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, POWER_INFO_THERMAL_SPEC_MASK,
-				0, RAPL_DOMAIN_MSR_INFO, POWER_UNIT, 0),
+				0, RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
-				RAPL_DOMAIN_MSR_INFO, POWER_UNIT, 0),
+				RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
-				RAPL_DOMAIN_MSR_INFO, POWER_UNIT, 0),
+				RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, POWER_INFO_MAX_TIME_WIN_MASK, 48,
-				RAPL_DOMAIN_MSR_INFO, TIME_UNIT, 0),
+				RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
 	PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
-				RAPL_DOMAIN_MSR_PERF, TIME_UNIT, 0),
+				RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
-				RAPL_DOMAIN_MSR_POLICY, ARBITRARY_UNIT, 0),
+				RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
 	/* non-hardware */
 	PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
 				RAPL_PRIMITIVE_DERIVED),
@@ -798,7 +798,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	if (!rp->name || rp->flag & RAPL_PRIMITIVE_DUMMY)
 		return -EINVAL;
 
-	msr = rd->msrs[rp->id];
+	msr = rd->regs[rp->id];
 	if (!msr)
 		return -EINVAL;
 
@@ -874,7 +874,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 
 	memset(&ma, 0, sizeof(ma));
 
-	ma.msr_no = rd->msrs[rp->id];
+	ma.msr_no = rd->regs[rp->id];
 	ma.clear_mask = rp->mask;
 	ma.set_mask = bits;
 
@@ -1282,8 +1282,8 @@ static int __init rapl_register_psys(void)
 
 	rd->name = rapl_domain_names[RAPL_DOMAIN_PLATFORM];
 	rd->id = RAPL_DOMAIN_PLATFORM;
-	rd->msrs[0] = MSR_PLATFORM_POWER_LIMIT;
-	rd->msrs[1] = MSR_PLATFORM_ENERGY_STATUS;
+	rd->regs[0] = MSR_PLATFORM_POWER_LIMIT;
+	rd->regs[1] = MSR_PLATFORM_ENERGY_STATUS;
 	rd->rpl[0].prim_id = PL1_ENABLE;
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
-- 
2.7.4

