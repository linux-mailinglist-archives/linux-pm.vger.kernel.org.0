Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F745FBE5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfGDQfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 12:35:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:33048 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfGDQfI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:35:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480551"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:35:06 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 11/13] intel_rapl: support two power limits for every RAPL domain
Date:   Fri,  5 Jul 2019 00:34:43 +0800
Message-Id: <1562258085-3165-12-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RAPL MSR interface supports 2 power limits for package domain, and 1 power
limit for other domains, while RAPL MMIO interface supports 2 power limits
for both package and dram domains.
And when 2 power limits are supported, the FW_LOCK bit is in bit 63 of the
register, instead of bit 31.

Remove the assumption that only pakcage domain supports 2 power limits.
And allow the RAPL interface driver to specify the number of power limits
supported, for every single RAPL domain it owns..

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 72 +++++++++++++-----------------------
 drivers/powercap/intel_rapl_msr.c    |  1 +
 include/linux/intel_rapl.h           |  2 +
 3 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index d648411..b6e1d33 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -38,8 +38,8 @@
 #define POWER_LIMIT2_MASK       (0x7FFFULL<<32)
 #define POWER_LIMIT2_ENABLE     BIT_ULL(47)
 #define POWER_LIMIT2_CLAMP      BIT_ULL(48)
-#define POWER_PACKAGE_LOCK      BIT_ULL(63)
-#define POWER_PP_LOCK           BIT(31)
+#define POWER_HIGH_LOCK         BIT_ULL(63)
+#define POWER_LOW_LOCK          BIT(31)
 
 #define TIME_WINDOW1_MASK       (0x7FULL<<17)
 #define TIME_WINDOW2_MASK       (0x7FULL<<49)
@@ -513,60 +513,38 @@ static const struct powercap_zone_constraint_ops constraint_ops = {
 /* called after domain detection and package level data are set */
 static void rapl_init_domains(struct rapl_package *rp)
 {
-	int i;
+	enum rapl_domain_type i;
+	enum rapl_domain_reg_id j;
 	struct rapl_domain *rd = rp->domains;
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		unsigned int mask = rp->domain_map & (1 << i);
 
-		rd->regs[RAPL_DOMAIN_REG_LIMIT] =
-		    rp->priv->regs[i][RAPL_DOMAIN_REG_LIMIT];
-		rd->regs[RAPL_DOMAIN_REG_STATUS] =
-		    rp->priv->regs[i][RAPL_DOMAIN_REG_STATUS];
-		rd->regs[RAPL_DOMAIN_REG_PERF] =
-		    rp->priv->regs[i][RAPL_DOMAIN_REG_PERF];
-		rd->regs[RAPL_DOMAIN_REG_POLICY] =
-		    rp->priv->regs[i][RAPL_DOMAIN_REG_POLICY];
-		rd->regs[RAPL_DOMAIN_REG_INFO] =
-		    rp->priv->regs[i][RAPL_DOMAIN_REG_INFO];
-
-		switch (mask) {
-		case BIT(RAPL_DOMAIN_PACKAGE):
-			rd->name = rapl_domain_names[RAPL_DOMAIN_PACKAGE];
-			rd->id = RAPL_DOMAIN_PACKAGE;
-			rd->rpl[0].prim_id = PL1_ENABLE;
-			rd->rpl[0].name = pl1_name;
+		if (!mask)
+			continue;
+
+		rd->rp = rp;
+		rd->name = rapl_domain_names[i];
+		rd->id = i;
+		rd->rpl[0].prim_id = PL1_ENABLE;
+		rd->rpl[0].name = pl1_name;
+		/* some domain may support two power limits */
+		if (rp->priv->limits[i] == 2) {
 			rd->rpl[1].prim_id = PL2_ENABLE;
 			rd->rpl[1].name = pl2_name;
-			break;
-		case BIT(RAPL_DOMAIN_PP0):
-			rd->name = rapl_domain_names[RAPL_DOMAIN_PP0];
-			rd->id = RAPL_DOMAIN_PP0;
-			rd->rpl[0].prim_id = PL1_ENABLE;
-			rd->rpl[0].name = pl1_name;
-			break;
-		case BIT(RAPL_DOMAIN_PP1):
-			rd->name = rapl_domain_names[RAPL_DOMAIN_PP1];
-			rd->id = RAPL_DOMAIN_PP1;
-			rd->rpl[0].prim_id = PL1_ENABLE;
-			rd->rpl[0].name = pl1_name;
-			break;
-		case BIT(RAPL_DOMAIN_DRAM):
-			rd->name = rapl_domain_names[RAPL_DOMAIN_DRAM];
-			rd->id = RAPL_DOMAIN_DRAM;
-			rd->rpl[0].prim_id = PL1_ENABLE;
-			rd->rpl[0].name = pl1_name;
+		}
+
+		for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
+			rd->regs[j] = rp->priv->regs[i][j];
+
+		if (i == RAPL_DOMAIN_DRAM) {
 			rd->domain_energy_unit =
 			    rapl_defaults->dram_domain_energy_unit;
 			if (rd->domain_energy_unit)
 				pr_info("DRAM domain energy unit %dpj\n",
 					rd->domain_energy_unit);
-			break;
-		}
-		if (mask) {
-			rd->rp = rp;
-			rd++;
 		}
+		rd++;
 	}
 }
 
@@ -613,7 +591,7 @@ static struct rapl_primitive_info rpi[] = {
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(FW_LOCK, POWER_PP_LOCK, 31,
+	PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
@@ -675,9 +653,9 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	cpu = rd->rp->lead_cpu;
 
-	/* special-case package domain, which uses a different bit */
-	if (prim == FW_LOCK && rd->id == RAPL_DOMAIN_PACKAGE) {
-		rp->mask = POWER_PACKAGE_LOCK;
+	/* domain with 2 limits has different bit */
+	if (prim == FW_LOCK && rd->rp->priv->limits[rd->id] == 2) {
+		rp->mask = POWER_HIGH_LOCK;
 		rp->shift = 63;
 	}
 	/* non-hardware data are collected by the polling thread */
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 6cd8a8f..bc14a45 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -41,6 +41,7 @@ static struct rapl_if_priv rapl_msr_priv = {
 		MSR_DRAM_POWER_LIMIT, MSR_DRAM_ENERGY_STATUS, MSR_DRAM_PERF_STATUS, 0, MSR_DRAM_POWER_INFO },
 	.regs[RAPL_DOMAIN_PLATFORM] = {
 		MSR_PLATFORM_POWER_LIMIT, MSR_PLATFORM_ENERGY_STATUS, 0, 0, 0},
+	.limits[RAPL_DOMAIN_PACKAGE] = 2,
 };
 
 /* Handles CPU hotplug on multi-socket systems.
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 649e199..0c179d9 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -104,6 +104,7 @@ struct reg_action {
  * @pcap_rapl_online:		CPU hotplug state for each RAPL interface.
  * @reg_unit:			Register for getting energy/power/time unit.
  * @regs:			Register sets for different RAPL Domains.
+ * @limits:			Number of power limits supported by each domain.
  * @read_raw:			Callback for reading RAPL interface specific
  *				registers.
  * @write_raw:			Callback for writing RAPL interface specific
@@ -115,6 +116,7 @@ struct rapl_if_priv {
 	enum cpuhp_state pcap_rapl_online;
 	u64 reg_unit;
 	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
+	int limits[RAPL_DOMAIN_MAX];
 	int (*read_raw)(int cpu, struct reg_action *ra);
 	int (*write_raw)(int cpu, struct reg_action *ra);
 };
-- 
2.7.4

