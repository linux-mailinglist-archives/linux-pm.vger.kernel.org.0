Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4F2039E2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgFVOse (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 10:48:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:7073 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgFVOsd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jun 2020 10:48:33 -0400
IronPort-SDR: vbjJC/HrIYkYvGXUI/RKF6MMPcR/P+zAkLcc/IjVOAsdWiGoYi97nLSph67B5FJ8TSNByAUeBw
 jRn5DDjEWCPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="143736030"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="143736030"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 07:48:33 -0700
IronPort-SDR: gXVwZgXqlUlrEgyf71Ry1rsCcFcgP45Tdt4rc6n4P5nZuCJ/VexqLfezrAL1HuGlfgWpEsEMPC
 uKXL2bL5lfWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="478477846"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2020 07:48:30 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rjw@rjwysocki.net, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, srinivas.pandruvada@linux.intel.com,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: Add Power Limit4 support
Date:   Mon, 22 Jun 2020 20:24:53 +0530
Message-Id: <1592837693-24814-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add power limit4 (PL4) support for only mobile processor peak power.
This is similar to VR Icc-Max limit, but works on Power instead of current.
This limit should be used in order to protect the system from instantaneous
power draw.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/powercap/intel_rapl_common.c |   52 ++++++++++++++++++++++++++++++++--
 drivers/powercap/intel_rapl_msr.c    |   15 ++++++++++
 include/linux/intel_rapl.h           |    5 +++-
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index eb328655bc01..8dad17fd4abb 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -42,6 +42,8 @@
 #define POWER_HIGH_LOCK         BIT_ULL(63)
 #define POWER_LOW_LOCK          BIT(31)
 
+#define POWER_LIMIT4_MASK		0x1FFF
+
 #define TIME_WINDOW1_MASK       (0x7FULL<<17)
 #define TIME_WINDOW2_MASK       (0x7FULL<<49)
 
@@ -85,6 +87,7 @@ enum unit_type {
 
 static const char pl1_name[] = "long_term";
 static const char pl2_name[] = "short_term";
+static const char pl4_name[] = "peak_power";
 
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
@@ -340,6 +343,9 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
 	case PL2_ENABLE:
 		rapl_write_data_raw(rd, POWER_LIMIT2, power_limit);
 		break;
+	case PL4_ENABLE:
+		rapl_write_data_raw(rd, POWER_LIMIT4, power_limit);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -374,6 +380,9 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
 	case PL2_ENABLE:
 		prim = POWER_LIMIT2;
 		break;
+	case PL4_ENABLE:
+		prim = POWER_LIMIT4;
+		break;
 	default:
 		put_online_cpus();
 		return -EINVAL;
@@ -443,6 +452,12 @@ static int get_time_window(struct powercap_zone *power_zone, int cid,
 	case PL2_ENABLE:
 		ret = rapl_read_data_raw(rd, TIME_WINDOW2, true, &val);
 		break;
+	case PL4_ENABLE:
+		/* Time window parameter is not applicable for PL4 entry
+		 * so assigining '0' as default value.
+		 */
+		val = 0;
+		break;
 	default:
 		put_online_cpus();
 		return -EINVAL;
@@ -486,6 +501,9 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
 	case PL2_ENABLE:
 		prim = MAX_POWER;
 		break;
+	case PL4_ENABLE:
+		prim = MAX_POWER;
+		break;
 	default:
 		put_online_cpus();
 		return -EINVAL;
@@ -495,6 +513,10 @@ static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
 	else
 		*data = val;
 
+	/* As a generalization rule, PL4 would be around two times PL2. */
+	if (rd->rpl[id].prim_id == PL4_ENABLE)
+		*data = *data * 2;
+
 	put_online_cpus();
 
 	return ret;
@@ -527,12 +549,21 @@ static void rapl_init_domains(struct rapl_package *rp)
 		rd->id = i;
 		rd->rpl[0].prim_id = PL1_ENABLE;
 		rd->rpl[0].name = pl1_name;
-		/* some domain may support two power limits */
-		if (rp->priv->limits[i] == 2) {
+
+		/* The PL2 power domain is applicable for limits two
+		 * and limits three
+		 */
+		if (rp->priv->limits[i] >= 2) {
 			rd->rpl[1].prim_id = PL2_ENABLE;
 			rd->rpl[1].name = pl2_name;
 		}
 
+		/* Enable PL4 domain if the total power limits are three */
+		if (rp->priv->limits[i] == 3) {
+			rd->rpl[2].prim_id = PL4_ENABLE;
+			rd->rpl[2].name = pl4_name;
+		}
+
 		for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
 			rd->regs[j] = rp->priv->regs[i][j];
 
@@ -590,6 +621,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
+				RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
 	PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
@@ -600,6 +633,8 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
+				RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
 	PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
@@ -1254,6 +1289,7 @@ void rapl_remove_package(struct rapl_package *rp)
 		if (find_nr_power_limit(rd) > 1) {
 			rapl_write_data_raw(rd, PL2_ENABLE, 0);
 			rapl_write_data_raw(rd, PL2_CLAMP, 0);
+			rapl_write_data_raw(rd, PL4_ENABLE, 0);
 		}
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			rd_package = rd;
@@ -1362,6 +1398,13 @@ static void power_limit_state_save(void)
 				if (ret)
 					rd->rpl[i].last_power_limit = 0;
 				break;
+			case PL4_ENABLE:
+				ret = rapl_read_data_raw(rd,
+						 POWER_LIMIT4, true,
+						 &rd->rpl[i].last_power_limit);
+				if (ret)
+					rd->rpl[i].last_power_limit = 0;
+				break;
 			}
 		}
 	}
@@ -1392,6 +1435,11 @@ static void power_limit_state_restore(void)
 					rapl_write_data_raw(rd, POWER_LIMIT2,
 					    rd->rpl[i].last_power_limit);
 				break;
+			case PL4_ENABLE:
+				if (rd->rpl[i].last_power_limit)
+					rapl_write_data_raw(rd, POWER_LIMIT4,
+					    rd->rpl[i].last_power_limit);
+				break;
 			}
 		}
 	}
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index d5487965bdfe..83c76454623e 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -28,6 +28,7 @@
 
 /* Local defines */
 #define MSR_PLATFORM_POWER_LIMIT	0x0000065C
+#define MSR_VR_CURRENT_CONFIG		0x00000601
 
 /* private data for RAPL MSR Interface */
 static struct rapl_if_priv rapl_msr_priv = {
@@ -123,13 +124,27 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 	return ra->err;
 }
 
+/* List of verified CPUs. */
+static const struct x86_cpu_id pl4_support_ids[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
+	{}
+};
+
 static int rapl_msr_probe(struct platform_device *pdev)
 {
 	int ret;
+	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
 
 	rapl_msr_priv.read_raw = rapl_msr_read_raw;
 	rapl_msr_priv.write_raw = rapl_msr_write_raw;
 
+	if (id) {
+		rapl_msr_priv.limits[RAPL_DOMAIN_PACKAGE] = 3;
+		rapl_msr_priv.regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
+			MSR_VR_CURRENT_CONFIG;
+		pr_info("PL4 support detected.\n");
+	}
+
 	rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
 	if (IS_ERR(rapl_msr_priv.control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index efb3ce892c20..3582176a1eca 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -29,6 +29,7 @@ enum rapl_domain_reg_id {
 	RAPL_DOMAIN_REG_PERF,
 	RAPL_DOMAIN_REG_POLICY,
 	RAPL_DOMAIN_REG_INFO,
+	RAPL_DOMAIN_REG_PL4,
 	RAPL_DOMAIN_REG_MAX,
 };
 
@@ -38,12 +39,14 @@ enum rapl_primitives {
 	ENERGY_COUNTER,
 	POWER_LIMIT1,
 	POWER_LIMIT2,
+	POWER_LIMIT4,
 	FW_LOCK,
 
 	PL1_ENABLE,		/* power limit 1, aka long term */
 	PL1_CLAMP,		/* allow frequency to go below OS request */
 	PL2_ENABLE,		/* power limit 2, aka short term, instantaneous */
 	PL2_CLAMP,
+	PL4_ENABLE,		/* power limit 4, aka max peak power */
 
 	TIME_WINDOW1,		/* long term */
 	TIME_WINDOW2,		/* short term */
@@ -65,7 +68,7 @@ struct rapl_domain_data {
 	unsigned long timestamp;
 };
 
-#define NR_POWER_LIMITS (2)
+#define NR_POWER_LIMITS (3)
 struct rapl_power_limit {
 	struct powercap_zone_constraint *constraint;
 	int prim_id;		/* primitive ID used to enable */
-- 
1.7.9.5

