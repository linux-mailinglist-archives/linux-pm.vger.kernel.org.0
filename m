Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B816BD433
	for <lists+linux-pm@lfdr.de>; Thu, 16 Mar 2023 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjCPPnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Mar 2023 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCPPmw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2023 11:42:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646FDB7D93;
        Thu, 16 Mar 2023 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981325; x=1710517325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6P/tZjVC1lnvfNbEO4XXQP+XofAFgp1dk3oUgFmio7c=;
  b=Z/PXZOyptg2drst7pK/9n4puh/b5xhLW80dM0AVjfFNhgN1qVyqQnnDY
   YVn0ia2IFMCmYoXINxNp/f+I0buSdW8lM7Pgya1Jd8dDXi/reTObcZAc9
   F6YuIKxwkAzyqR/BEK72Q5yihUB3LZ6k3uJ+YI+ThYgowfYmWJsbHyAWu
   zWuy9VBHDxPc8iMNzdonbVSxz79I/V96dR8hy2HDUt4tORBmEUjUCFGRi
   5sy2MZstiwFzu3xkvs6rjr+qxJ7ntUnYkRXcAZ6yTvN0CkzZXdp1IwVDe
   Bsa3lSCNVXCNI2BriPB6LTJwNT57YAnE47oIjoUGrF/4M6UUf+TgQrqPJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571041"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571041"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267074"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267074"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:05 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 09/15] powercap/intel_rapl: Cleanup Power Limits support
Date:   Thu, 16 Mar 2023 23:38:35 +0800
Message-Id: <20230316153841.3666-10-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The same set of operations are shared by different Powert Limits,
including Power Limit get/set, Power Limit enable/disable, clamping
enable/disable, time window get/set, and max power get/set, etc.

But the same operation for different Power Limit has different
primitives because they use different registers/register bits.

A lot of dirty/duplicate code was introduced to handle this difference.

Introduce a universal way to issue Power Limit operations.
Instead of using hardcoded primitive name directly, use Power Limit id
+ operation type, and hide all the Power Limit difference details in a
central place, get_pl_prim(). Two helpers, rapl_read_pl_data() and
rapl_write_pl_data(), are introduced at the same time to simply the
code for issuing Power Limit operations.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 343 ++++++++++++---------------
 include/linux/intel_rapl.h           |   1 -
 2 files changed, 146 insertions(+), 198 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 0935a10b093e..3e9141dedc1d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -96,9 +96,67 @@ enum unit_type {
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
 #define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
 
-static const char pl1_name[] = "long_term";
-static const char pl2_name[] = "short_term";
-static const char pl4_name[] = "peak_power";
+static const char *pl_names[NR_POWER_LIMITS] = {
+	[POWER_LIMIT1] = "long_term",
+	[POWER_LIMIT2] = "short_term",
+	[POWER_LIMIT4] = "peak_power",
+};
+
+enum pl_prims {
+	PL_ENABLE,
+	PL_CLAMP,
+	PL_LIMIT,
+	PL_TIME_WINDOW,
+	PL_MAX_POWER,
+};
+
+static bool is_pl_valid(struct rapl_domain *rd, int pl)
+{
+	if (pl < POWER_LIMIT1 || pl > POWER_LIMIT4)
+		return false;
+	return rd->rpl[pl].name ? true : false;
+}
+
+static int get_pl_prim(int pl, enum pl_prims prim)
+{
+	switch (pl) {
+	case POWER_LIMIT1:
+		if (prim == PL_ENABLE)
+			return PL1_ENABLE;
+		if (prim == PL_CLAMP)
+			return PL1_CLAMP;
+		if (prim == PL_LIMIT)
+			return POWER_LIMIT1;
+		if (prim == PL_TIME_WINDOW)
+			return TIME_WINDOW1;
+		if (prim == PL_MAX_POWER)
+			return THERMAL_SPEC_POWER;
+		return -EINVAL;
+	case POWER_LIMIT2:
+		if (prim == PL_ENABLE)
+			return PL2_ENABLE;
+		if (prim == PL_CLAMP)
+			return PL2_CLAMP;
+		if (prim == PL_LIMIT)
+			return POWER_LIMIT2;
+		if (prim == PL_TIME_WINDOW)
+			return TIME_WINDOW2;
+		if (prim == PL_MAX_POWER)
+			return MAX_POWER;
+		return -EINVAL;
+	case POWER_LIMIT4:
+		if (prim == PL_LIMIT)
+			return POWER_LIMIT4;
+		if (prim == PL_ENABLE)
+			return PL4_ENABLE;
+		/* PL4 would be around two times PL2, use same prim as PL2. */
+		if (prim == PL_MAX_POWER)
+			return MAX_POWER;
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
 
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
@@ -155,6 +213,12 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			       enum rapl_primitives prim,
 			       unsigned long long value);
+static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
+			      enum pl_prims pl_prim,
+			      bool xlate, u64 *data);
+static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
+			       enum pl_prims pl_prim,
+			       unsigned long long value);
 static u64 rapl_unit_xlate(struct rapl_domain *rd,
 			   enum unit_type type, u64 value, int to_raw);
 static void package_power_limit_irq_save(struct rapl_package *rp);
@@ -222,7 +286,7 @@ static int find_nr_power_limit(struct rapl_domain *rd)
 	int i, nr_pl = 0;
 
 	for (i = 0; i < NR_POWER_LIMITS; i++) {
-		if (rd->rpl[i].name)
+		if (is_pl_valid(rd, i))
 			nr_pl++;
 	}
 
@@ -233,37 +297,34 @@ static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
 	struct rapl_defaults *rpd = get_rpd(rd->rp);
-
-	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
-		return -EACCES;
+	int ret;
 
 	cpus_read_lock();
-	rapl_write_data_raw(rd, PL1_ENABLE, mode);
-	if (rpd->set_floor_freq)
+	ret = rapl_write_pl_data(rd, POWER_LIMIT1, PL_ENABLE, mode);
+	if (!ret && rpd->set_floor_freq)
 		rpd->set_floor_freq(rd, mode);
 	cpus_read_unlock();
 
-	return 0;
+	return ret;
 }
 
 static int get_domain_enable(struct powercap_zone *power_zone, bool *mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
 	u64 val;
+	int ret;
 
 	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
 		*mode = false;
 		return 0;
 	}
 	cpus_read_lock();
-	if (rapl_read_data_raw(rd, PL1_ENABLE, true, &val)) {
-		cpus_read_unlock();
-		return -EIO;
-	}
-	*mode = val;
+	ret = rapl_read_pl_data(rd, POWER_LIMIT1, PL_ENABLE, true, &val);
+	if (!ret)
+		*mode = val;
 	cpus_read_unlock();
 
-	return 0;
+	return ret;
 }
 
 /* per RAPL domain ops, in the order of rapl_domain_type */
@@ -319,8 +380,8 @@ static int contraint_to_pl(struct rapl_domain *rd, int cid)
 {
 	int i, j;
 
-	for (i = 0, j = 0; i < NR_POWER_LIMITS; i++) {
-		if ((rd->rpl[i].name) && j++ == cid) {
+	for (i = POWER_LIMIT1, j = 0; i < NR_POWER_LIMITS; i++) {
+		if (is_pl_valid(rd, i) && j++ == cid) {
 			pr_debug("%s: index %d\n", __func__, i);
 			return i;
 		}
@@ -341,36 +402,11 @@ static int set_power_limit(struct powercap_zone *power_zone, int cid,
 	cpus_read_lock();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
-	if (id < 0) {
-		ret = id;
-		goto set_exit;
-	}
-
 	rp = rd->rp;
 
-	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
-		dev_warn(&power_zone->dev,
-			 "%s locked by BIOS, monitoring only\n", rd->name);
-		ret = -EACCES;
-		goto set_exit;
-	}
-
-	switch (rd->rpl[id].prim_id) {
-	case PL1_ENABLE:
-		rapl_write_data_raw(rd, POWER_LIMIT1, power_limit);
-		break;
-	case PL2_ENABLE:
-		rapl_write_data_raw(rd, POWER_LIMIT2, power_limit);
-		break;
-	case PL4_ENABLE:
-		rapl_write_data_raw(rd, POWER_LIMIT4, power_limit);
-		break;
-	default:
-		ret = -EINVAL;
-	}
+	ret = rapl_write_pl_data(rd, id, PL_LIMIT, power_limit);
 	if (!ret)
 		package_power_limit_irq_save(rp);
-set_exit:
 	cpus_read_unlock();
 	return ret;
 }
@@ -380,38 +416,17 @@ static int get_current_power_limit(struct powercap_zone *power_zone, int cid,
 {
 	struct rapl_domain *rd;
 	u64 val;
-	int prim;
 	int ret = 0;
 	int id;
 
 	cpus_read_lock();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
-	if (id < 0) {
-		ret = id;
-		goto get_exit;
-	}
 
-	switch (rd->rpl[id].prim_id) {
-	case PL1_ENABLE:
-		prim = POWER_LIMIT1;
-		break;
-	case PL2_ENABLE:
-		prim = POWER_LIMIT2;
-		break;
-	case PL4_ENABLE:
-		prim = POWER_LIMIT4;
-		break;
-	default:
-		cpus_read_unlock();
-		return -EINVAL;
-	}
-	if (rapl_read_data_raw(rd, prim, true, &val))
-		ret = -EIO;
-	else
+	ret = rapl_read_pl_data(rd, id, PL_LIMIT, true, &val);
+	if (!ret)
 		*data = val;
 
-get_exit:
 	cpus_read_unlock();
 
 	return ret;
@@ -427,23 +442,9 @@ static int set_time_window(struct powercap_zone *power_zone, int cid,
 	cpus_read_lock();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
-	if (id < 0) {
-		ret = id;
-		goto set_time_exit;
-	}
 
-	switch (rd->rpl[id].prim_id) {
-	case PL1_ENABLE:
-		rapl_write_data_raw(rd, TIME_WINDOW1, window);
-		break;
-	case PL2_ENABLE:
-		rapl_write_data_raw(rd, TIME_WINDOW2, window);
-		break;
-	default:
-		ret = -EINVAL;
-	}
+	ret = rapl_write_pl_data(rd, id, PL_TIME_WINDOW, window);
 
-set_time_exit:
 	cpus_read_unlock();
 	return ret;
 }
@@ -459,33 +460,11 @@ static int get_time_window(struct powercap_zone *power_zone, int cid,
 	cpus_read_lock();
 	rd = power_zone_to_rapl_domain(power_zone);
 	id = contraint_to_pl(rd, cid);
-	if (id < 0) {
-		ret = id;
-		goto get_time_exit;
-	}
 
-	switch (rd->rpl[id].prim_id) {
-	case PL1_ENABLE:
-		ret = rapl_read_data_raw(rd, TIME_WINDOW1, true, &val);
-		break;
-	case PL2_ENABLE:
-		ret = rapl_read_data_raw(rd, TIME_WINDOW2, true, &val);
-		break;
-	case PL4_ENABLE:
-		/*
-		 * Time window parameter is not applicable for PL4 entry
-		 * so assigining '0' as default value.
-		 */
-		val = 0;
-		break;
-	default:
-		cpus_read_unlock();
-		return -EINVAL;
-	}
+	ret = rapl_read_pl_data(rd, id, PL_TIME_WINDOW, true, &val);
 	if (!ret)
 		*data = val;
 
-get_time_exit:
 	cpus_read_unlock();
 
 	return ret;
@@ -505,36 +484,23 @@ static const char *get_constraint_name(struct powercap_zone *power_zone,
 	return NULL;
 }
 
-static int get_max_power(struct powercap_zone *power_zone, int id, u64 *data)
+static int get_max_power(struct powercap_zone *power_zone, int cid, u64 *data)
 {
 	struct rapl_domain *rd;
 	u64 val;
-	int prim;
 	int ret = 0;
+	int id;
 
 	cpus_read_lock();
 	rd = power_zone_to_rapl_domain(power_zone);
-	switch (rd->rpl[id].prim_id) {
-	case PL1_ENABLE:
-		prim = THERMAL_SPEC_POWER;
-		break;
-	case PL2_ENABLE:
-		prim = MAX_POWER;
-		break;
-	case PL4_ENABLE:
-		prim = MAX_POWER;
-		break;
-	default:
-		cpus_read_unlock();
-		return -EINVAL;
-	}
-	if (rapl_read_data_raw(rd, prim, true, &val))
-		ret = -EIO;
-	else
+	id = contraint_to_pl(rd, cid);
+
+	ret = rapl_read_pl_data(rd, id, PL_MAX_POWER, true, &val);
+	if (!ret)
 		*data = val;
 
 	/* As a generalization rule, PL4 would be around two times PL2. */
-	if (rd->rpl[id].prim_id == PL4_ENABLE)
+	if (id == POWER_LIMIT4)
 		*data = *data * 2;
 
 	cpus_read_unlock();
@@ -560,6 +526,7 @@ static void rapl_init_domains(struct rapl_package *rp)
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		unsigned int mask = rp->domain_map & (1 << i);
+		int t;
 
 		if (!mask)
 			continue;
@@ -577,17 +544,10 @@ static void rapl_init_domains(struct rapl_package *rp)
 
 		/* PL1 is supported by default */
 		rp->priv->limits[i] |= BIT(POWER_LIMIT1);
-		rd->rpl[0].prim_id = PL1_ENABLE;
-		rd->rpl[0].name = pl1_name;
 
-		if (rp->priv->limits[i] & BIT(POWER_LIMIT2)) {
-			rd->rpl[1].prim_id = PL2_ENABLE;
-			rd->rpl[1].name = pl2_name;
-		}
-
-		if (rp->priv->limits[i] & BIT(POWER_LIMIT4)) {
-			rd->rpl[2].prim_id = PL4_ENABLE;
-			rd->rpl[2].name = pl4_name;
+		for (t = POWER_LIMIT1; t < NR_POWER_LIMITS; t++) {
+			if (rp->priv->limits[i] & BIT(t))
+				rd->rpl[t].name = pl_names[t];
 		}
 
 		for (j = 0; j < RAPL_DOMAIN_REG_MAX; j++)
@@ -818,6 +778,33 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	return ret;
 }
 
+static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
+			      enum pl_prims pl_prim, bool xlate, u64 *data)
+{
+	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
+
+	if (!is_pl_valid(rd, pl))
+		return -EINVAL;
+
+	return rapl_read_data_raw(rd, prim, xlate, data);
+}
+
+static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
+			       enum pl_prims pl_prim,
+			       unsigned long long value)
+{
+	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
+
+	if (!is_pl_valid(rd, pl))
+		return -EINVAL;
+
+	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
+		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
+		return -EACCES;
+	}
+
+	return rapl_write_data_raw(rd, prim, value);
+}
 /*
  * Raw RAPL data stored in MSRs are in certain scales. We need to
  * convert them into standard units based on the units reported in
@@ -945,17 +932,16 @@ static void package_power_limit_irq_restore(struct rapl_package *rp)
 
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
 {
-	int nr_powerlimit = find_nr_power_limit(rd);
+	int i;
 
 	/* always enable clamp such that p-state can go below OS requested
 	 * range. power capping priority over guranteed frequency.
 	 */
-	rapl_write_data_raw(rd, PL1_CLAMP, mode);
+	rapl_write_pl_data(rd, POWER_LIMIT1, PL_CLAMP, mode);
 
-	/* some domains have pl2 */
-	if (nr_powerlimit > 1) {
-		rapl_write_data_raw(rd, PL2_ENABLE, mode);
-		rapl_write_data_raw(rd, PL2_CLAMP, mode);
+	for (i = POWER_LIMIT2; i < NR_POWER_LIMITS; i++) {
+		rapl_write_pl_data(rd, i, PL_ENABLE, mode);
+		rapl_write_pl_data(rd, i, PL_CLAMP, mode);
 	}
 }
 
@@ -1327,11 +1313,10 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
 		}
 	}
-	/* check if power limit MSR exists, otherwise domain is monitoring only */
-	for (i = 0; i < NR_POWER_LIMITS; i++) {
-		int prim = rd->rpl[i].prim_id;
 
-		if (rapl_read_data_raw(rd, prim, false, &val64))
+	/* check if power limit exists, otherwise domain is monitoring only */
+	for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+		if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
 			rd->rpl[i].name = NULL;
 	}
 }
@@ -1381,13 +1366,13 @@ void rapl_remove_package(struct rapl_package *rp)
 	package_power_limit_irq_restore(rp);
 
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
-		rapl_write_data_raw(rd, PL1_ENABLE, 0);
-		rapl_write_data_raw(rd, PL1_CLAMP, 0);
-		if (find_nr_power_limit(rd) > 1) {
-			rapl_write_data_raw(rd, PL2_ENABLE, 0);
-			rapl_write_data_raw(rd, PL2_CLAMP, 0);
-			rapl_write_data_raw(rd, PL4_ENABLE, 0);
+		int i;
+
+		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+			rapl_write_pl_data(rd, i, PL_ENABLE, 0);
+			rapl_write_pl_data(rd, i, PL_CLAMP, 0);
 		}
+
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			rd_package = rd;
 			continue;
@@ -1472,38 +1457,18 @@ static void power_limit_state_save(void)
 {
 	struct rapl_package *rp;
 	struct rapl_domain *rd;
-	int nr_pl, ret, i;
+	int ret, i;
 
 	cpus_read_lock();
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		if (!rp->power_zone)
 			continue;
 		rd = power_zone_to_rapl_domain(rp->power_zone);
-		nr_pl = find_nr_power_limit(rd);
-		for (i = 0; i < nr_pl; i++) {
-			switch (rd->rpl[i].prim_id) {
-			case PL1_ENABLE:
-				ret = rapl_read_data_raw(rd,
-						 POWER_LIMIT1, true,
+		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+			ret = rapl_read_pl_data(rd, i, PL_LIMIT, true,
 						 &rd->rpl[i].last_power_limit);
-				if (ret)
-					rd->rpl[i].last_power_limit = 0;
-				break;
-			case PL2_ENABLE:
-				ret = rapl_read_data_raw(rd,
-						 POWER_LIMIT2, true,
-						 &rd->rpl[i].last_power_limit);
-				if (ret)
-					rd->rpl[i].last_power_limit = 0;
-				break;
-			case PL4_ENABLE:
-				ret = rapl_read_data_raw(rd,
-						 POWER_LIMIT4, true,
-						 &rd->rpl[i].last_power_limit);
-				if (ret)
-					rd->rpl[i].last_power_limit = 0;
-				break;
-			}
+			if (ret)
+				rd->rpl[i].last_power_limit = 0;
 		}
 	}
 	cpus_read_unlock();
@@ -1513,33 +1478,17 @@ static void power_limit_state_restore(void)
 {
 	struct rapl_package *rp;
 	struct rapl_domain *rd;
-	int nr_pl, i;
+	int i;
 
 	cpus_read_lock();
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		if (!rp->power_zone)
 			continue;
 		rd = power_zone_to_rapl_domain(rp->power_zone);
-		nr_pl = find_nr_power_limit(rd);
-		for (i = 0; i < nr_pl; i++) {
-			switch (rd->rpl[i].prim_id) {
-			case PL1_ENABLE:
-				if (rd->rpl[i].last_power_limit)
-					rapl_write_data_raw(rd, POWER_LIMIT1,
-					    rd->rpl[i].last_power_limit);
-				break;
-			case PL2_ENABLE:
-				if (rd->rpl[i].last_power_limit)
-					rapl_write_data_raw(rd, POWER_LIMIT2,
-					    rd->rpl[i].last_power_limit);
-				break;
-			case PL4_ENABLE:
-				if (rd->rpl[i].last_power_limit)
-					rapl_write_data_raw(rd, POWER_LIMIT4,
-					    rd->rpl[i].last_power_limit);
-				break;
-			}
-		}
+		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
+			if (rd->rpl[i].last_power_limit)
+				rapl_write_pl_data(rd, i, PL_LIMIT,
+					       rd->rpl[i].last_power_limit);
 	}
 	cpus_read_unlock();
 }
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 856b739fd194..86cd06bbea0c 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -79,7 +79,6 @@ struct rapl_domain_data {
 
 struct rapl_power_limit {
 	struct powercap_zone_constraint *constraint;
-	int prim_id;		/* primitive ID used to enable */
 	struct rapl_domain *domain;
 	const char *name;
 	u64 last_power_limit;
-- 
2.25.1

