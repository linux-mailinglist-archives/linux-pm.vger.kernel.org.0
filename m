Return-Path: <linux-pm+bounces-39643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C12CC5976
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 01:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CCE3042FE2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 00:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099A1DF75A;
	Wed, 17 Dec 2025 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUH2D8u7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBC1C3C1F;
	Wed, 17 Dec 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931032; cv=none; b=FIWOhuv3Cx/SQ6+aj+Nh9iEeeP6f21xyhDDW+yl1x8nheBKjwuJ1pUu9/sp5duFboNyeaWE3YapTp1GQlWphgzCL5Fp27/z0cUnLXDMBicirtTRQ389+6XX6UBW5hAJkHjhkEIRyDoXTXOnKqo/EIGBYNn3p2qMcKzreT+q9/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931032; c=relaxed/simple;
	bh=ua/41ss50qiv39p86CNBeel5ZZvebwEoD1Me0q+zuLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyH6rAb1R+HJKo8BfNj0IjBSkFaJlnXKIUH5m7uY9AhkTcJxogIW2PJ7W6+OhNxygANnM8u11eqyHq1ZA1VwvRyFSHES12RbvuYrAG9THARAqAOVIco/bIt6CSyMqxLqUAvsYNtabnsS2laEsME53Z6yNgwMCoVsSLfN5PmRFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUH2D8u7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765931030; x=1797467030;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ua/41ss50qiv39p86CNBeel5ZZvebwEoD1Me0q+zuLE=;
  b=IUH2D8u7DyA2p/Q9K8avCH04sZse5byFDt1aB2lPxwEOlLVV53Kfn06W
   Gj6OEru5AGzMZQDfLe7eCN9tEaRxQTf0H+6kZIpm9vuKuLIyoEBYm8hxR
   JRZuX+OWf5ICX2rRw64hrOItrmfrxfSZ4tTaMHIqceO+uNVHXOuhKmPDl
   eAwC+Y7IoHr+PTtXvirhoQ8kPu1sLKdDaEF+0n2lkovm5Lv+YtUjQUtAk
   n/1L9HAnlfI1uoJAFYaZ3+1a7BfM+6W6NZSCo4E5uBlsjYmFf7YcOkhHv
   B1eWjdwPwNnsc675J0e6dnkzptq2opF7n84diXhQzOgGARTR84rdW9C3x
   w==;
X-CSE-ConnectionGUID: EjEm6EclTYSzgmYabh0pow==
X-CSE-MsgGUID: uyUZHFsfRqWS/yRAlzFqMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="79228271"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="79228271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:47 -0800
X-CSE-ConnectionGUID: c0J2OKwnR2+uB+171nS1ZQ==
X-CSE-MsgGUID: d763PR6GQi604ItwKIRnWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="228858108"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:47 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] platform/x86/intel/pmc: Move LPM mode attributes to PMC
Date: Tue, 16 Dec 2025 16:23:39 -0800
Message-ID: <20251217002343.2289577-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217002343.2289577-1-xi.pardee@linux.intel.com>
References: <20251217002343.2289577-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move LPM modes attributes from the pmc_dev to the pmc
structure. LPM modes are PMC-specific and should be
stored within the pmc structure.

After the change, LPM mode information will be retrieved
and stored per PMC. The substate_requirements attribute
in debugfs will display the requirements for each enabled
LPM substate.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 39 ++++++++++++++++++---------
 drivers/platform/x86/intel/pmc/core.h | 15 +++++------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3e916228e7ed2..25f77a9dc42c5 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -783,7 +783,7 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 
 	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
 
-	pmc_for_each_mode(mode, pmcdev) {
+	pmc_for_each_mode(mode, pmc) {
 		seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
 			   adjust_lpm_residency(pmc, offset + (4 * mode), lpm_adj_x2));
 	}
@@ -838,10 +838,11 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
 					      enum header_type type)
 {
 	struct pmc_dev *pmcdev = s->private;
+	struct pmc *pmc = pmcdev->pmcs[pmc_index];
 	u8 mode;
 
 	seq_printf(s, "%40s |", "Element");
-	pmc_for_each_mode(mode, pmcdev)
+	pmc_for_each_mode(mode, pmc)
 		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
 
 	if (type == HEADER_STATUS) {
@@ -887,7 +888,7 @@ static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
 
 				counter = pmc_core_reg_read(pmc, offset);
 				seq_printf(s, "pmc%u: %34s |", pmc_idx, map->name);
-				pmc_for_each_mode(mode, pmcdev) {
+				pmc_for_each_mode(mode, pmc) {
 					bool required = *lpm_req_regs & BIT(mode);
 
 					seq_printf(s, " %9s |", required ? "Required" : " ");
@@ -961,7 +962,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			 * show an element if it's required for at least one of the
 			 * enabled low power modes
 			 */
-			pmc_for_each_mode(mode, pmcdev)
+			pmc_for_each_mode(mode, pmc)
 				req_mask |= lpm_req_regs[mp + (mode * num_maps)];
 
 			/* Get the last latched status for this map */
@@ -987,7 +988,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 				seq_printf(s, "pmc%d: %34s |", pmc_idx, map[i].name);
 
 				/* Loop over the enabled states and display if required */
-				pmc_for_each_mode(mode, pmcdev) {
+				pmc_for_each_mode(mode, pmc) {
 					bool required = lpm_req_regs[mp + (mode * num_maps)] &
 							bit_mask;
 					seq_printf(s, " %9s |", required ? "Required" : " ");
@@ -1077,7 +1078,7 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 		c10 = true;
 	}
 
-	pmc_for_each_mode(mode, pmcdev) {
+	pmc_for_each_mode(mode, pmc) {
 		if ((BIT(mode) & reg) && !c10)
 			seq_printf(s, " [%s]", pmc_lpm_modes[mode]);
 		else
@@ -1117,7 +1118,7 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	mode = sysfs_match_string(pmc_lpm_modes, buf);
 
 	/* Check string matches enabled mode */
-	pmc_for_each_mode(m, pmcdev)
+	pmc_for_each_mode(m, pmc)
 		if (mode == m)
 			break;
 
@@ -1213,9 +1214,8 @@ static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
 	return true;
 }
 
-void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
+static void pmc_core_pmc_get_low_power_modes(struct pmc_dev *pmcdev, struct pmc *pmc)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
 	u8 mode_order[LPM_MAX_NUM_MODES];
 	u32 lpm_pri;
@@ -1232,7 +1232,7 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 	 * Lower byte is enough to cover the number of lpm modes for all
 	 * platforms and hence mask the upper 3 bytes.
 	 */
-	pmcdev->num_lpm_modes = hweight32(lpm_en & 0xFF);
+	pmc->num_lpm_modes = hweight32(lpm_en & 0xFF);
 
 	/* Read 32 bit LPM_PRI register */
 	lpm_pri = pmc_core_reg_read(pmc, pmc->map->lpm_priority_offset);
@@ -1261,7 +1261,22 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 		if (!(BIT(mode) & lpm_en))
 			continue;
 
-		pmcdev->lpm_en_modes[i++] = mode;
+		pmc->lpm_en_modes[i++] = mode;
+	}
+}
+
+static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
+{
+	unsigned int pmc_idx;
+
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc;
+
+		pmc = pmcdev->pmcs[pmc_idx];
+		if (!pmc)
+			continue;
+
+		pmc_core_pmc_get_low_power_modes(pmcdev, pmc);
 	}
 }
 
@@ -1506,7 +1521,7 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
 		return -ENOMEM;
 
 	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
-	pmc_for_each_mode(mode, pmcdev) {
+	pmc_for_each_mode(mode, pmc) {
 		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
 		int m;
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ead2f33ed3ed5..118c8740ad3aa 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -423,6 +423,8 @@ struct pmc_info {
  *			specific attributes
  * @lpm_req_regs:	List of substate requirements
  * @ltr_ign:		Holds LTR ignore data while suspended
+ * @num_lpm_modes:	Count of enabled modes
+ * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  *
  * pmc contains info about one power management controller device.
  */
@@ -432,6 +434,8 @@ struct pmc {
 	const struct pmc_reg_map *map;
 	u32 *lpm_req_regs;
 	u32 ltr_ign;
+	u8 num_lpm_modes;
+	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
 };
 
 /**
@@ -446,8 +450,6 @@ struct pmc {
  * @pkgc_res_cnt:	Array of PKGC residency counters
  * @num_of_pkgc:	Number of PKGC
  * @s0ix_counter:	S0ix residency (step adjusted)
- * @num_lpm_modes:	Count of enabled modes
- * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  *
@@ -462,8 +464,6 @@ struct pmc_dev {
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
 	u64 s0ix_counter;
-	u8 num_lpm_modes;
-	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 
@@ -535,7 +535,6 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
-void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
 void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids);
 void pmc_core_set_device_d3(unsigned int device);
 
@@ -563,10 +562,10 @@ int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
 extern const struct file_operations pmc_core_substate_req_regs_fops;
 extern const struct file_operations pmc_core_substate_blk_req_fops;
 
-#define pmc_for_each_mode(mode, pmcdev)						\
+#define pmc_for_each_mode(mode, pmc)						\
 	for (unsigned int __i = 0, __cond;					\
-	     __cond = __i < (pmcdev)->num_lpm_modes,				\
-	     __cond && ((mode) = (pmcdev)->lpm_en_modes[__i]),			\
+	     __cond = __i < (pmc)->num_lpm_modes,				\
+	     __cond && ((mode) = (pmc)->lpm_en_modes[__i]),			\
 	     __cond;								\
 	     __i++)
 
-- 
2.43.0


