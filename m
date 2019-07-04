Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769A85FBDC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGDQe5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 12:34:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:33035 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfGDQe4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480490"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:34:54 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 05/13] intel_rapl: abstract register address
Date:   Fri,  5 Jul 2019 00:34:37 +0800
Message-Id: <1562258085-3165-6-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSR and MMIO RAPL interface have different sets of registers, thus the
RAPL register address should be obtained from interface specific
structure, i.e. struct rapl_if_private, instead.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 73 +++++++++++++++++++------------------------
 include/linux/intel_rapl.h    |  4 +++
 2 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index e05d92d..9f22aed 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -76,7 +76,19 @@ enum unit_type {
 };
 
 /* private data for RAPL MSR Interface */
-static struct rapl_if_priv rapl_msr_priv;
+static struct rapl_if_priv rapl_msr_priv = {
+	.reg_unit = MSR_RAPL_POWER_UNIT,
+	.regs[RAPL_DOMAIN_PACKAGE] = {
+		MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS, MSR_PKG_PERF_STATUS, 0, MSR_PKG_POWER_INFO },
+	.regs[RAPL_DOMAIN_PP0] = {
+		MSR_PP0_POWER_LIMIT, MSR_PP0_ENERGY_STATUS, 0, MSR_PP0_POLICY, 0 },
+	.regs[RAPL_DOMAIN_PP1] = {
+		MSR_PP1_POWER_LIMIT, MSR_PP1_ENERGY_STATUS, 0, MSR_PP1_POLICY, 0 },
+	.regs[RAPL_DOMAIN_DRAM] = {
+		MSR_DRAM_POWER_LIMIT, MSR_DRAM_ENERGY_STATUS, MSR_DRAM_PERF_STATUS, 0, MSR_DRAM_POWER_INFO },
+	.regs[RAPL_DOMAIN_PLATFORM] = {
+		MSR_PLATFORM_POWER_LIMIT, MSR_PLATFORM_ENERGY_STATUS, 0, 0, 0},
+};
 
 /* per domain data, some are optional */
 #define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
@@ -541,15 +553,17 @@ static void rapl_init_domains(struct rapl_package *rp)
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		unsigned int mask = rp->domain_map & (1 << i);
+
+		rd->regs[RAPL_DOMAIN_REG_LIMIT] = rp->priv->regs[i][RAPL_DOMAIN_REG_LIMIT];
+		rd->regs[RAPL_DOMAIN_REG_STATUS] = rp->priv->regs[i][RAPL_DOMAIN_REG_STATUS];
+		rd->regs[RAPL_DOMAIN_REG_PERF] = rp->priv->regs[i][RAPL_DOMAIN_REG_PERF];
+		rd->regs[RAPL_DOMAIN_REG_POLICY] = rp->priv->regs[i][RAPL_DOMAIN_REG_POLICY];
+		rd->regs[RAPL_DOMAIN_REG_INFO] = rp->priv->regs[i][RAPL_DOMAIN_REG_INFO];
+
 		switch (mask) {
 		case BIT(RAPL_DOMAIN_PACKAGE):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PACKAGE];
 			rd->id = RAPL_DOMAIN_PACKAGE;
-			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PKG_POWER_LIMIT;
-			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PKG_ENERGY_STATUS;
-			rd->regs[RAPL_DOMAIN_REG_PERF] = MSR_PKG_PERF_STATUS;
-			rd->regs[RAPL_DOMAIN_REG_POLICY] = 0;
-			rd->regs[RAPL_DOMAIN_REG_INFO] = MSR_PKG_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			rd->rpl[1].prim_id = PL2_ENABLE;
@@ -558,33 +572,18 @@ static void rapl_init_domains(struct rapl_package *rp)
 		case BIT(RAPL_DOMAIN_PP0):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PP0];
 			rd->id = RAPL_DOMAIN_PP0;
-			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PP0_POWER_LIMIT;
-			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PP0_ENERGY_STATUS;
-			rd->regs[RAPL_DOMAIN_REG_PERF] = 0;
-			rd->regs[RAPL_DOMAIN_REG_POLICY] = MSR_PP0_POLICY;
-			rd->regs[RAPL_DOMAIN_REG_INFO] = 0;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			break;
 		case BIT(RAPL_DOMAIN_PP1):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PP1];
 			rd->id = RAPL_DOMAIN_PP1;
-			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PP1_POWER_LIMIT;
-			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PP1_ENERGY_STATUS;
-			rd->regs[RAPL_DOMAIN_REG_PERF] = 0;
-			rd->regs[RAPL_DOMAIN_REG_POLICY] = MSR_PP1_POLICY;
-			rd->regs[RAPL_DOMAIN_REG_INFO] = 0;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			break;
 		case BIT(RAPL_DOMAIN_DRAM):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_DRAM];
 			rd->id = RAPL_DOMAIN_DRAM;
-			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_DRAM_POWER_LIMIT;
-			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_DRAM_ENERGY_STATUS;
-			rd->regs[RAPL_DOMAIN_REG_PERF] = MSR_DRAM_PERF_STATUS;
-			rd->regs[RAPL_DOMAIN_REG_POLICY] = 0;
-			rd->regs[RAPL_DOMAIN_REG_INFO] = MSR_DRAM_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			rd->domain_energy_unit =
@@ -806,9 +805,9 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 	u64 msr_val;
 	u32 value;
 
-	if (rdmsrl_safe_on_cpu(cpu, MSR_RAPL_POWER_UNIT, &msr_val)) {
+	if (rdmsrl_safe_on_cpu(cpu, rp->priv->reg_unit, &msr_val)) {
 		pr_err("Failed to read power unit MSR 0x%x on CPU %d, exit.\n",
-			MSR_RAPL_POWER_UNIT, cpu);
+			rp->priv->reg_unit, cpu);
 		return -ENODEV;
 	}
 
@@ -832,9 +831,9 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	u64 msr_val;
 	u32 value;
 
-	if (rdmsrl_safe_on_cpu(cpu, MSR_RAPL_POWER_UNIT, &msr_val)) {
+	if (rdmsrl_safe_on_cpu(cpu, rp->priv->reg_unit, &msr_val)) {
 		pr_err("Failed to read power unit MSR 0x%x on CPU %d, exit.\n",
-			MSR_RAPL_POWER_UNIT, cpu);
+			rp->priv->reg_unit, cpu);
 		return -ENODEV;
 	}
 	value = (msr_val & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
@@ -1173,10 +1172,10 @@ static int __init rapl_register_psys(void)
 	struct powercap_zone *power_zone;
 	u64 val;
 
-	if (rdmsrl_safe_on_cpu(0, MSR_PLATFORM_ENERGY_STATUS, &val) || !val)
+	if (rdmsrl_safe_on_cpu(0, rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS], &val) || !val)
 		return -ENODEV;
 
-	if (rdmsrl_safe_on_cpu(0, MSR_PLATFORM_POWER_LIMIT, &val) || !val)
+	if (rdmsrl_safe_on_cpu(0, rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT], &val) || !val)
 		return -ENODEV;
 
 	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
@@ -1185,8 +1184,8 @@ static int __init rapl_register_psys(void)
 
 	rd->name = rapl_domain_names[RAPL_DOMAIN_PLATFORM];
 	rd->id = RAPL_DOMAIN_PLATFORM;
-	rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PLATFORM_POWER_LIMIT;
-	rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PLATFORM_ENERGY_STATUS;
+	rd->regs[RAPL_DOMAIN_REG_LIMIT] = rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT];
+	rd->regs[RAPL_DOMAIN_REG_STATUS] = rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS];
 	rd->rpl[0].prim_id = PL1_ENABLE;
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
@@ -1218,23 +1217,17 @@ static int __init rapl_register_powercap(void)
 	return 0;
 }
 
-static int rapl_check_domain(int cpu, int domain)
+static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 {
-	unsigned msr;
+	u32 reg;
 	u64 val = 0;
 
 	switch (domain) {
 	case RAPL_DOMAIN_PACKAGE:
-		msr = MSR_PKG_ENERGY_STATUS;
-		break;
 	case RAPL_DOMAIN_PP0:
-		msr = MSR_PP0_ENERGY_STATUS;
-		break;
 	case RAPL_DOMAIN_PP1:
-		msr = MSR_PP1_ENERGY_STATUS;
-		break;
 	case RAPL_DOMAIN_DRAM:
-		msr = MSR_DRAM_ENERGY_STATUS;
+		reg = rp->priv->regs[domain][RAPL_DOMAIN_REG_STATUS];
 		break;
 	case RAPL_DOMAIN_PLATFORM:
 		/* PSYS(PLATFORM) is not a CPU domain, so avoid printng error */
@@ -1246,7 +1239,7 @@ static int rapl_check_domain(int cpu, int domain)
 	/* make sure domain counters are available and contains non-zero
 	 * values, otherwise skip it.
 	 */
-	if (rdmsrl_safe_on_cpu(cpu, msr, &val) || !val)
+	if (rdmsrl_safe_on_cpu(cpu, reg, &val) || !val)
 		return -ENODEV;
 
 	return 0;
@@ -1293,7 +1286,7 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		/* use physical package id to read counters */
-		if (!rapl_check_domain(cpu, i)) {
+		if (!rapl_check_domain(cpu, i, rp)) {
 			rp->domain_map |= 1 << i;
 			pr_info("Found RAPL domain %s\n", rapl_domain_names[i]);
 		}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 7bf1683e4..ec2c9e8 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -95,11 +95,15 @@ struct rapl_domain {
  * @platform_rapl_domain:	Optional. Some RAPL interface may have platform
  *				level RAPL control.
  * @pcap_rapl_online:		CPU hotplug state for each RAPL interface.
+ * @reg_unit:			Register for getting energy/power/time unit.
+ * @regs:			Register sets for different RAPL Domains.
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
 	struct rapl_domain *platform_rapl_domain;
 	enum cpuhp_state pcap_rapl_online;
+	u32 reg_unit;
+	u32 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.7.4

