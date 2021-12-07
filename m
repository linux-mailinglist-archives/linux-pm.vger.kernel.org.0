Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF946B226
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 06:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhLGFW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 00:22:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:64154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhLGFW1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Dec 2021 00:22:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237724598"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237724598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 21:18:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="462165665"
Received: from rzhang1-workstation.sh.intel.com ([10.239.48.24])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 21:18:56 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, dana.alkattan@intel.com
Subject: [PATCH] powercap: intel_rapl: support different layout of Psys PowerLimit Register
Date:   Tue,  7 Dec 2021 21:17:34 +0800
Message-Id: <20211207131734.2607104-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On SPR, the Psys domain Power Limit Register has a different layout.

Enhance the code to support different Psys PL register layout.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reported-and-tested-by: Alkattan Dana <dana.alkattan@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 61 +++++++++++++++++++++++++++-
 include/linux/intel_rapl.h           |  6 +++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 7c0099e7a6d7..07611a00b78f 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -61,6 +61,20 @@
 #define PERF_STATUS_THROTTLE_TIME_MASK 0xffffffff
 #define PP_POLICY_MASK         0x1F
 
+/*
+ * SPR has different layout for Psys Domain PowerLimit registers.
+ * There are 17 bits of PL1 and PL2 instead of 15 bits.
+ * The Enable bits and TimeWindow bits are also shifted as a result.
+ */
+#define PSYS_POWER_LIMIT1_MASK       0x1FFFF
+#define PSYS_POWER_LIMIT1_ENABLE     BIT(17)
+
+#define PSYS_POWER_LIMIT2_MASK       (0x1FFFFULL<<32)
+#define PSYS_POWER_LIMIT2_ENABLE     BIT_ULL(49)
+
+#define PSYS_TIME_WINDOW1_MASK       (0x7FULL<<19)
+#define PSYS_TIME_WINDOW2_MASK       (0x7FULL<<51)
+
 /* Non HW constants */
 #define RAPL_PRIMITIVE_DERIVED       BIT(1)	/* not from raw data */
 #define RAPL_PRIMITIVE_DUMMY         BIT(2)
@@ -97,6 +111,7 @@ struct rapl_defaults {
 				    bool to_raw);
 	unsigned int dram_domain_energy_unit;
 	unsigned int psys_domain_energy_unit;
+	bool spr_psys_bits;
 };
 static struct rapl_defaults *rapl_defaults;
 
@@ -669,12 +684,51 @@ static struct rapl_primitive_info rpi[] = {
 			    RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
 	PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
 			    RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
+			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
+			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
+			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
+			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
+			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
+			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	/* non-hardware */
 	PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
 			    RAPL_PRIMITIVE_DERIVED),
 	{NULL, 0, 0, 0},
 };
 
+static enum rapl_primitives
+prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
+{
+	if (!rapl_defaults->spr_psys_bits)
+		return prim;
+
+	if (rd->id != RAPL_DOMAIN_PLATFORM)
+		return prim;
+
+	switch (prim) {
+	case POWER_LIMIT1:
+		return PSYS_POWER_LIMIT1;
+	case POWER_LIMIT2:
+		return PSYS_POWER_LIMIT2;
+	case PL1_ENABLE:
+		return PSYS_PL1_ENABLE;
+	case PL2_ENABLE:
+		return PSYS_PL2_ENABLE;
+	case TIME_WINDOW1:
+		return PSYS_TIME_WINDOW1;
+	case TIME_WINDOW2:
+		return PSYS_TIME_WINDOW2;
+	default:
+		return prim;
+	}
+}
+
 /* Read primitive data based on its related struct rapl_primitive_info.
  * if xlate flag is set, return translated data based on data units, i.e.
  * time, energy, and power.
@@ -692,7 +746,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 			      enum rapl_primitives prim, bool xlate, u64 *data)
 {
 	u64 value;
-	struct rapl_primitive_info *rp = &rpi[prim];
+	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
+	struct rapl_primitive_info *rp = &rpi[prim_fixed];
 	struct reg_action ra;
 	int cpu;
 
@@ -738,7 +793,8 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 			       enum rapl_primitives prim,
 			       unsigned long long value)
 {
-	struct rapl_primitive_info *rp = &rpi[prim];
+	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
+	struct rapl_primitive_info *rp = &rpi[prim_fixed];
 	int cpu;
 	u64 bits;
 	struct reg_action ra;
@@ -981,6 +1037,7 @@ static const struct rapl_defaults rapl_defaults_spr_server = {
 	.compute_time_window = rapl_compute_time_window_core,
 	.dram_domain_energy_unit = 15300,
 	.psys_domain_energy_unit = 1000000000,
+	.spr_psys_bits = true,
 };
 
 static const struct rapl_defaults rapl_defaults_byt = {
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 93780834fc8f..9f4b6f5b822f 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -58,6 +58,12 @@ enum rapl_primitives {
 	THROTTLED_TIME,
 	PRIORITY_LEVEL,
 
+	PSYS_POWER_LIMIT1,
+	PSYS_POWER_LIMIT2,
+	PSYS_PL1_ENABLE,
+	PSYS_PL2_ENABLE,
+	PSYS_TIME_WINDOW1,
+	PSYS_TIME_WINDOW2,
 	/* below are not raw primitive data */
 	AVERAGE_POWER,
 	NR_RAPL_PRIMITIVES,
-- 
2.27.0

