Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01B96E713D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 04:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDSCox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 22:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjDSCov (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 22:44:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635A7ABA;
        Tue, 18 Apr 2023 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872283; x=1713408283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SPz+xDEeT073N0THIzgLr+n8kb2lKaRW7/h+Zhd+WqU=;
  b=IeBryx6ioTAghlIedKMiLnAFNB9vhmpnXlvsiOehjUL23Hi9W0QYSHX2
   8OaMR8r7nH8kn1TJZxJol2rIOYNcl1K5X52EycZkvJFHSWTKyoPjGZknU
   4erDOW9zOZVok5hieftS2TZNTASup7cE2xOs/z4Cu8RWh/6VPR4f/CjET
   7cu9ncLPfVJczhMdbpI7svX9GbKZNovP3g3Hl2vDe1F8/QGtzBenr3xns
   VBX1WtBe8a3DoAsLbytrA/N1gDq22KKcb0uVQvIjs28/30H6rvZaJSRQB
   IhmEvck3Z3PejLEn/vkeA7p6ZcQZP0YvMj2yZZ9jq/ExYON3IU3crtD8X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215291"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215291"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478022"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478022"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:40 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 05/15] powercap/intel_rapl: Support per domain energy/power/time unit
Date:   Wed, 19 Apr 2023 10:44:09 +0800
Message-Id: <20230419024419.324436-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419024419.324436-1-rui.zhang@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RAPL MSR/MMIO Interface has package scope unit register but some RAPL
domains like Dram/Psys may use a fixed energy unit value instead of the
default unit value on certain platforms.
RAPL TPMI Interface supports per domain unit register.

For the above reasons, add support for per domain unit register and per
domain energy/power/time unit.

When per domain unit register is not available, use the package scope
unit register as the per domain unit register for each RAPL domain so
that this change is transparent to MSR/MMIO Interface.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 128 +++++++++++++++------------
 include/linux/intel_rapl.h           |   8 +-
 2 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 267ec36b1649..3625d4466cb3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -105,9 +105,9 @@ static const char pl4_name[] = "peak_power";
 
 struct rapl_defaults {
 	u8 floor_freq_reg_addr;
-	int (*check_unit)(struct rapl_package *rp, int cpu);
+	int (*check_unit)(struct rapl_domain *rd, int cpu);
 	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
-	u64 (*compute_time_window)(struct rapl_package *rp, u64 val,
+	u64 (*compute_time_window)(struct rapl_domain *rd, u64 val,
 				    bool to_raw);
 	unsigned int dram_domain_energy_unit;
 	unsigned int psys_domain_energy_unit;
@@ -557,7 +557,6 @@ static void rapl_init_domains(struct rapl_package *rp)
 	enum rapl_domain_type i;
 	enum rapl_domain_reg_id j;
 	struct rapl_domain *rd = rp->domains;
-	struct rapl_defaults *defaults = get_defaults(rp);
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		unsigned int mask = rp->domain_map & (1 << i);
@@ -596,24 +595,6 @@ static void rapl_init_domains(struct rapl_package *rp)
 		for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
 			rd->regs[j] = rp->priv->regs[i][j];
 
-		switch (i) {
-		case RAPL_DOMAIN_DRAM:
-			rd->domain_energy_unit =
-			    defaults->dram_domain_energy_unit;
-			if (rd->domain_energy_unit)
-				pr_info("DRAM domain energy unit %dpj\n",
-					rd->domain_energy_unit);
-			break;
-		case RAPL_DOMAIN_PLATFORM:
-			rd->domain_energy_unit =
-			    defaults->psys_domain_energy_unit;
-			if (rd->domain_energy_unit)
-				pr_info("Platform domain energy unit %dpj\n",
-					rd->domain_energy_unit);
-			break;
-		default:
-			break;
-		}
 		rd++;
 	}
 }
@@ -622,24 +603,19 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 			   u64 value, int to_raw)
 {
 	u64 units = 1;
-	struct rapl_package *rp = rd->rp;
-	struct rapl_defaults *defaults = get_defaults(rp);
+	struct rapl_defaults *defaults = get_defaults(rd->rp);
 	u64 scale = 1;
 
 	switch (type) {
 	case POWER_UNIT:
-		units = rp->power_unit;
+		units = rd->power_unit;
 		break;
 	case ENERGY_UNIT:
 		scale = ENERGY_UNIT_SCALE;
-		/* per domain unit takes precedence */
-		if (rd->domain_energy_unit)
-			units = rd->domain_energy_unit;
-		else
-			units = rp->energy_unit;
+		units = rd->energy_unit;
 		break;
 	case TIME_UNIT:
-		return defaults->compute_time_window(rp, value, to_raw);
+		return defaults->compute_time_window(rd, value, to_raw);
 	case ARBITRARY_UNIT:
 	default:
 		return value;
@@ -857,58 +833,58 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
  * power unit : microWatts  : Represented in milliWatts by default
  * time unit  : microseconds: Represented in seconds by default
  */
-static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
+static int rapl_check_unit_core(struct rapl_domain *rd, int cpu)
 {
 	struct reg_action ra;
 	u32 value;
 
-	ra.reg = rp->priv->reg_unit;
+	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rp->priv->read_raw(cpu, &ra)) {
+	if (rd->rp->priv->read_raw(cpu, &ra)) {
 		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
-		       rp->priv->reg_unit, cpu);
+			ra.reg, cpu);
 		return -ENODEV;
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rp->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
+	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rp->power_unit = 1000000 / (1 << value);
+	rd->power_unit = 1000000 / (1 << value);
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rp->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Core CPU %s energy=%dpJ, time=%dus, power=%duW\n",
-		 rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
+		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
 
 	return 0;
 }
 
-static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
+static int rapl_check_unit_atom(struct rapl_domain *rd, int cpu)
 {
 	struct reg_action ra;
 	u32 value;
 
-	ra.reg = rp->priv->reg_unit;
+	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rp->priv->read_raw(cpu, &ra)) {
+	if (rd->rp->priv->read_raw(cpu, &ra)) {
 		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
-		       rp->priv->reg_unit, cpu);
+			ra.reg, cpu);
 		return -ENODEV;
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rp->energy_unit = ENERGY_UNIT_SCALE * 1 << value;
+	rd->energy_unit = ENERGY_UNIT_SCALE * 1 << value;
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rp->power_unit = (1 << value) * 1000;
+	rd->power_unit = (1 << value) * 1000;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rp->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Atom %s energy=%dpJ, time=%dus, power=%duW\n",
-		 rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
+		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
 
 	return 0;
 }
@@ -1011,7 +987,7 @@ static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 		       defaults->floor_freq_reg_addr, mdata);
 }
 
-static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
+static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
 					 bool to_raw)
 {
 	u64 f, y;		/* fraction and exp. used for time unit */
@@ -1023,12 +999,12 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
 	if (!to_raw) {
 		f = (value & 0x60) >> 5;
 		y = value & 0x1f;
-		value = (1 << y) * (4 + f) * rp->time_unit / 4;
+		value = (1 << y) * (4 + f) * rd->time_unit / 4;
 	} else {
-		if (value < rp->time_unit)
+		if (value < rd->time_unit)
 			return 0;
 
-		do_div(value, rp->time_unit);
+		do_div(value, rd->time_unit);
 		y = ilog2(value);
 
 		/*
@@ -1044,7 +1020,7 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
 	return value;
 }
 
-static u64 rapl_compute_time_window_atom(struct rapl_package *rp, u64 value,
+static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 					 bool to_raw)
 {
 	/*
@@ -1052,9 +1028,9 @@ static u64 rapl_compute_time_window_atom(struct rapl_package *rp, u64 value,
 	 * where time_unit is default to 1 sec. Never 0.
 	 */
 	if (!to_raw)
-		return (value) ? value * rp->time_unit : rp->time_unit;
+		return (value) ? value * rd->time_unit : rd->time_unit;
 
-	value = div64_u64(value, rp->time_unit);
+	value = div64_u64(value, rd->time_unit);
 
 	return value;
 }
@@ -1299,6 +1275,40 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 	return 0;
 }
 
+/*
+ * Get per domain energy/power/time unit.
+ * RAPL Interfaces without per domain unit register will use the package
+ * scope unit register to set per domain units.
+ */
+static int rapl_get_domain_unit(struct rapl_domain *rd)
+{
+	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	int ret;
+
+	if (!rd->regs[RAPL_DOMAIN_REG_UNIT]) {
+		if (!rd->rp->priv->reg_unit) {
+			pr_err("No valid Unit register found\n");
+			return -ENODEV;
+		}
+		rd->regs[RAPL_DOMAIN_REG_UNIT] = rd->rp->priv->reg_unit;
+	}
+
+	if (!defaults->check_unit) {
+		pr_err("missing .check_unit() callback\n");
+		return -ENODEV;
+	}
+
+	ret = defaults->check_unit(rd, rd->rp->lead_cpu);
+	if (ret)
+		return ret;
+
+	if (rd->id == RAPL_DOMAIN_DRAM && defaults->dram_domain_energy_unit)
+		rd->energy_unit = defaults->dram_domain_energy_unit;
+	if (rd->id == RAPL_DOMAIN_PLATFORM && defaults->psys_domain_energy_unit)
+		rd->energy_unit = defaults->psys_domain_energy_unit;
+	return 0;
+}
+
 /*
  * Check if power limits are available. Two cases when they are not available:
  * 1. Locked by BIOS, in this case we still provide read-only access so that
@@ -1359,8 +1369,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 
 	rapl_init_domains(rp);
 
-	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++)
+	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
+		rapl_get_domain_unit(rd);
 		rapl_detect_powerlimit(rd);
+	}
 
 	return 0;
 }
@@ -1418,7 +1430,6 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
-	struct rapl_defaults *defaults;
 	int ret;
 
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
@@ -1442,9 +1453,8 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
 			 topology_physical_package_id(cpu));
 
-	defaults = get_defaults(rp);
 	/* check if the package contains valid domains */
-	if (rapl_detect_domains(rp, cpu) || defaults->check_unit(rp, cpu)) {
+	if (rapl_detect_domains(rp, cpu)) {
 		ret = -ENODEV;
 		goto err_free_package;
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index f51e2df7130e..936fb8c3082c 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -30,6 +30,7 @@ enum rapl_domain_reg_id {
 	RAPL_DOMAIN_REG_POLICY,
 	RAPL_DOMAIN_REG_INFO,
 	RAPL_DOMAIN_REG_PL4,
+	RAPL_DOMAIN_REG_UNIT,
 	RAPL_DOMAIN_REG_MAX,
 };
 
@@ -96,7 +97,9 @@ struct rapl_domain {
 	struct rapl_power_limit rpl[NR_POWER_LIMITS];
 	u64 attr_map;		/* track capabilities */
 	unsigned int state;
-	unsigned int domain_energy_unit;
+	unsigned int power_unit;
+	unsigned int energy_unit;
+	unsigned int time_unit;
 	struct rapl_package *rp;
 };
 
@@ -143,9 +146,6 @@ struct rapl_package {
 	unsigned int id;	/* logical die id, equals physical 1-die systems */
 	unsigned int nr_domains;
 	unsigned long domain_map;	/* bit map of active domains */
-	unsigned int power_unit;
-	unsigned int energy_unit;
-	unsigned int time_unit;
 	struct rapl_domain *domains;	/* array of domains, sized at runtime */
 	struct powercap_zone *power_zone;	/* keep track of parent zone */
 	unsigned long power_limit_irq;	/* keep track of package power limit
-- 
2.25.1

