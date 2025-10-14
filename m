Return-Path: <linux-pm+bounces-36100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C3FBDB716
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 23:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB43F188AFDC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41530DD36;
	Tue, 14 Oct 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv7ZAW43"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF830C361;
	Tue, 14 Oct 2025 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478386; cv=none; b=B8mw7GJZlZ614Y72mTKafnQUHXtUghLtP/NxElwR4JuPvVzaDQwjm0lCI+vDpGsGW6CrNcsV4UWxBHE0ssJuHvpPAGobMPaJek88j7zeQAYpT4SVc0PwxtseimxkQb/X0utD6u577TiW/IriSA4k+F7C6KUvOAP8Am6lYbBbRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478386; c=relaxed/simple;
	bh=p2g/tJjRyuZFSh1hclU2AexMGaoebNnOPKOozgwzPXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWtOcf+Dt0XcVJbnS9PSjOIl8caecL17A+DLe3TrYkEHDJPIRzd5LgzzMYcIcJGKOEa4+Wq0AmWHAb13c4Fy7YQUbEkAw/mQ/BjR7dsw6jrfS08P/Sn+TEoN/WQEXb5IhV+BisrTnH8Te0qGJb9ZfdH9uDQaTx8IiWwgfxvKoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv7ZAW43; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478385; x=1792014385;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=p2g/tJjRyuZFSh1hclU2AexMGaoebNnOPKOozgwzPXk=;
  b=Gv7ZAW43rDmFD/GJaJIda86V6h4U3LDs4NOMrFxNhYSMwd1BXY3xlJAj
   Lqx/sIVyhjOp5nOwyNWZbGA0e/t1eJcHQ3VJn9/7uVtiEG8c1mOhbGAo4
   ZeZHrAp5snYNAQGgA/Eii1jDVcnlWjtWdT/7MJN6Bc8ZA7FpDRKcGTZHM
   mFCHo/4WeB8cLLA2ZhNquv/mZ92mnx7PFioRdA3Q7zypDqusooKC/iNc+
   A1OmmJ/Jfu8BdyHHdMfjaOAk3Wyb/LWhEdCK5Ah2XIECLQ/8/0I3EE0lK
   PDWN05D4JmNSLB58XKfWmnuQ/BBD9Itk1nSS/0PxrmeWseLX4PC1fHiO+
   g==;
X-CSE-ConnectionGUID: tYU2SAf7T1iOBZVLhizMWA==
X-CSE-MsgGUID: IckvZRJbRUuchaSpg4UVxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62682454"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62682454"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:23 -0700
X-CSE-ConnectionGUID: 0UUfWkU3QtWDkkzSWWkojQ==
X-CSE-MsgGUID: 9d2sIrRnQU6Zn3MFo4sWow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187300352"
Received: from kcaccard-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:22 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/6] platform/x86:intel/pmc: Rename PMC index variable to pmc_idx
Date: Tue, 14 Oct 2025 14:45:32 -0700
Message-ID: <20251014214548.629023-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014214548.629023-1-xi.pardee@linux.intel.com>
References: <20251014214548.629023-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename all PMC index variables to pmc_idx in core.c. This improves
code readability and consistency.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 108 +++++++++++++-------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b6d45289eb84d..18a5aa073637a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -311,20 +311,20 @@ static inline u8 pmc_core_reg_read_byte(struct pmc *pmc, int offset)
 }
 
 static void pmc_core_display_map(struct seq_file *s, int index, int idx, int ip,
-				 int pmc_index, u8 pf_reg, const struct pmc_bit_map **pf_map)
+				 int pmc_idx, u8 pf_reg, const struct pmc_bit_map **pf_map)
 {
 	seq_printf(s, "PMC%d:PCH IP: %-2d - %-32s\tState: %s\n",
-		   pmc_index, ip, pf_map[idx][index].name,
+		   pmc_idx, ip, pf_map[idx][index].name,
 		   pf_map[idx][index].bit_mask & pf_reg ? "Off" : "On");
 }
 
 static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	unsigned int i;
+	unsigned int pmc_idx;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 		const struct pmc_bit_map **maps;
 		u8 pf_regs[PPFEAR_MAX_NUM_ENTRIES];
 		unsigned int index, iter, idx, ip = 0;
@@ -342,7 +342,7 @@ static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 		for (idx = 0; maps[idx]; idx++) {
 			for (index = 0; maps[idx][index].name &&
 			     index < pmc->map->ppfear_buckets * 8; ip++, index++)
-				pmc_core_display_map(s, index, idx, ip, i,
+				pmc_core_display_map(s, index, idx, ip, pmc_idx,
 						     pf_regs[index / 8], maps);
 		}
 	}
@@ -471,7 +471,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 	struct pmc *pmc;
 	const struct pmc_reg_map *map;
 	u32 reg;
-	unsigned int pmc_index;
+	unsigned int pmc_idx;
 	int ltr_index;
 
 	ltr_index = value;
@@ -479,8 +479,8 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 	 * is based on the contiguous indexes from ltr_show output.
 	 * pmc index and ltr index needs to be calculated from it.
 	 */
-	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index >= 0; pmc_index++) {
-		pmc = pmcdev->pmcs[pmc_index];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs) && ltr_index >= 0; pmc_idx++) {
+		pmc = pmcdev->pmcs[pmc_idx];
 
 		if (!pmc)
 			continue;
@@ -497,10 +497,10 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 		ltr_index = ltr_index - (map->ltr_ignore_max + 2) - 1;
 	}
 
-	if (pmc_index >= ARRAY_SIZE(pmcdev->pmcs) || ltr_index < 0)
+	if (pmc_idx >= ARRAY_SIZE(pmcdev->pmcs) || ltr_index < 0)
 		return -EINVAL;
 
-	pr_debug("ltr_ignore for pmc%d: ltr_index:%d\n", pmc_index, ltr_index);
+	pr_debug("ltr_ignore for pmc%d: ltr_index:%d\n", pmc_idx, ltr_index);
 
 	guard(mutex)(&pmcdev->lock);
 
@@ -635,14 +635,14 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 	u64 decoded_snoop_ltr, decoded_non_snoop_ltr, val;
 	u32 ltr_raw_data, scale;
 	u16 snoop_ltr, nonsnoop_ltr;
-	unsigned int i, index, ltr_index = 0;
+	unsigned int pmc_idx, index, ltr_index = 0;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
 		struct pmc *pmc;
 		const struct pmc_bit_map *map;
 		u32 ltr_ign_reg;
 
-		pmc = pmcdev->pmcs[i];
+		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
 			continue;
 
@@ -676,7 +676,7 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 			}
 
 			seq_printf(s, "%d\tPMC%d:%-32s\tLTR: RAW: 0x%-16x\tNon-Snoop(ns): %-16llu\tSnoop(ns): %-16llu\tLTR_IGNORE: %d\n",
-				   ltr_index, i, map[index].name, ltr_raw_data,
+				   ltr_index, pmc_idx, map[index].name, ltr_raw_data,
 				   decoded_non_snoop_ltr,
 				   decoded_snoop_ltr, ltr_ign_data);
 			ltr_index++;
@@ -689,15 +689,15 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	unsigned int pmcidx;
+	unsigned int pmc_idx;
 
-	for (pmcidx = 0; pmcidx < ARRAY_SIZE(pmcdev->pmcs); pmcidx++) {
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); pmc_idx++) {
 		const struct pmc_bit_map **maps;
 		unsigned int arr_size, r_idx;
 		u32 offset, counter;
 		struct pmc *pmc;
 
-		pmc = pmcdev->pmcs[pmcidx];
+		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
 			continue;
 		maps = pmc->map->s0ix_blocker_maps;
@@ -711,7 +711,7 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
 				if (!map->blk)
 					continue;
 				counter = pmc_core_reg_read(pmc, offset);
-				seq_printf(s, "PMC%d:%-30s %-30d\n", pmcidx,
+				seq_printf(s, "PMC%d:%-30s %-30d\n", pmc_idx,
 					   map->name, counter);
 				offset += map->blk * S0IX_BLK_SIZE;
 			}
@@ -723,13 +723,13 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
 
 static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
 {
-	unsigned int i;
+	unsigned int pmc_idx;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); pmc_idx++) {
 		struct pmc *pmc;
 		u32 ltr_ign;
 
-		pmc = pmcdev->pmcs[i];
+		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
 			continue;
 
@@ -750,12 +750,12 @@ static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
 
 static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
 {
-	unsigned int i;
+	unsigned int pmc_idx;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); pmc_idx++) {
 		struct pmc *pmc;
 
-		pmc = pmcdev->pmcs[i];
+		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
 			continue;
 
@@ -794,10 +794,10 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_res);
 static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	unsigned int i;
+	unsigned int pmc_idx;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 		const struct pmc_bit_map **maps;
 		u32 offset;
 
@@ -805,7 +805,7 @@ static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 			continue;
 		maps = pmc->map->lpm_sts;
 		offset = pmc->map->lpm_status_offset;
-		pmc_core_lpm_display(pmc, NULL, s, offset, i, "STATUS", maps);
+		pmc_core_lpm_display(pmc, NULL, s, offset, pmc_idx, "STATUS", maps);
 	}
 
 	return 0;
@@ -815,10 +815,10 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_sts_regs);
 static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	unsigned int i;
+	unsigned int pmc_idx;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 		const struct pmc_bit_map **maps;
 		u32 offset;
 
@@ -826,7 +826,7 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 			continue;
 		maps = pmc->map->lpm_sts;
 		offset = pmc->map->lpm_live_status_offset;
-		pmc_core_lpm_display(pmc, NULL, s, offset, i, "LIVE_STATUS", maps);
+		pmc_core_lpm_display(pmc, NULL, s, offset, pmc_idx, "LIVE_STATUS", maps);
 	}
 
 	return 0;
@@ -919,11 +919,11 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 	u32 sts_offset;
 	u32 sts_offset_live;
 	u32 *lpm_req_regs;
-	unsigned int mp, pmc_index;
+	unsigned int mp, pmc_idx;
 	int num_maps;
 
-	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); ++pmc_index) {
-		struct pmc *pmc = pmcdev->pmcs[pmc_index];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 		const struct pmc_bit_map **maps;
 
 		if (!pmc)
@@ -944,7 +944,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			continue;
 
 		/* Display the header */
-		pmc_core_substate_req_header_show(s, pmc_index, HEADER_STATUS);
+		pmc_core_substate_req_header_show(s, pmc_idx, HEADER_STATUS);
 
 		/* Loop over maps */
 		for (mp = 0; mp < num_maps; mp++) {
@@ -982,7 +982,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 				}
 
 				/* Display the element name in the first column */
-				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
+				seq_printf(s, "pmc%d: %34s |", pmc_idx, map[i].name);
 
 				/* Loop over the enabled states and display if required */
 				pmc_for_each_mode(mode, pmcdev) {
@@ -1568,7 +1568,7 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *
 {
 	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
 	struct telem_endpoint *ep;
-	unsigned int i;
+	unsigned int pmc_idx;
 	u32 guid;
 	int ret;
 
@@ -1576,10 +1576,10 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *
 	if (!pcidev)
 		return -ENODEV;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
 		struct pmc *pmc;
 
-		pmc = pmcdev->pmcs[i];
+		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
 			continue;
 
@@ -1611,7 +1611,7 @@ static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16
 	return NULL;
 }
 
-static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_index)
+static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
 
 {
 	struct pmc_ssram_telemetry pmc_ssram_telemetry;
@@ -1619,7 +1619,7 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_index)
 	struct pmc *pmc;
 	int ret;
 
-	ret = pmc_ssram_telemetry_get_pmc_info(pmc_index, &pmc_ssram_telemetry);
+	ret = pmc_ssram_telemetry_get_pmc_info(pmc_idx, &pmc_ssram_telemetry);
 	if (ret)
 		return ret;
 
@@ -1627,7 +1627,7 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_index)
 	if (!map)
 		return -ENODEV;
 
-	pmc = pmcdev->pmcs[pmc_index];
+	pmc = pmcdev->pmcs[pmc_idx];
 	/* Memory for primary PMC has been allocated */
 	if (!pmc) {
 		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
@@ -1644,7 +1644,7 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_index)
 		return -ENOMEM;
 	}
 
-	pmcdev->pmcs[pmc_index] = pmc;
+	pmcdev->pmcs[pmc_idx] = pmc;
 
 	return 0;
 }
@@ -1716,8 +1716,8 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	return 0;
 
 unmap_regbase:
-	for (unsigned int i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+	for (unsigned int pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 
 		if (pmc && pmc->regbase)
 			iounmap(pmc->regbase);
@@ -1810,10 +1810,10 @@ static void pmc_core_do_dmi_quirks(struct pmc *pmc)
 static void pmc_core_clean_structure(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
-	unsigned int i;
+	unsigned int pmc_idx;
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 
 		if (pmc && pmc->regbase)
 			iounmap(pmc->regbase);
@@ -1973,7 +1973,7 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
 	int offset = pmc->map->lpm_status_offset;
-	unsigned int i;
+	unsigned int pmc_idx, i;
 
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
@@ -2011,13 +2011,13 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	if (pmc->map->slps0_dbg_maps)
 		pmc_core_slps0_display(pmc, dev, NULL);
 
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_idx];
 
 		if (!pmc)
 			continue;
 		if (pmc->map->lpm_sts)
-			pmc_core_lpm_display(pmc, dev, NULL, offset, i, "STATUS", maps);
+			pmc_core_lpm_display(pmc, dev, NULL, offset, pmc_idx, "STATUS", maps);
 	}
 
 	return 0;
-- 
2.43.0


