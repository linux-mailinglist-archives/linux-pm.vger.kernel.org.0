Return-Path: <linux-pm+bounces-40511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E1D066F4
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 23:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C92B3025A7E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195432AAB3;
	Thu,  8 Jan 2026 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eftQSMiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DF35966;
	Thu,  8 Jan 2026 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911509; cv=none; b=bZeX30UFrTJEafDcXtpDOVXMfrwUgatb81Rg04zeadmXyYheaFE23y/IHSt2UcESel1/XQmrO/IALds0Zkv62X0WuHRZkiQ/skbVLade6nZgw2v5zOeHFQLG2kZ9aKgjwOI5KVSSYBLqZgDm9RLuJ4yg6CYi8QiQuzwU0HEaF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911509; c=relaxed/simple;
	bh=+cpqOpKKayvNELwmB46zus2fqxt9ZvIEwZvPVnAPvZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9E1ZPc2EiJZlhFhYl8iD5rT896JX0yrnXbZKjETMaOiO3YFc64AuSDswHvdLtaFnXfDSsxYwbi4Hflty7+Ccs7og+lxvuZ0xnvKBXwMwkr1ZVVUMcVjtETiMQU2WqsUdtaz1a0ckVp8vpudnmOqznRvxX2yXwhiin74YKGDAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eftQSMiz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767911508; x=1799447508;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+cpqOpKKayvNELwmB46zus2fqxt9ZvIEwZvPVnAPvZM=;
  b=eftQSMizrEUa+WCHgvSlNuxS7pducxpri1UlMyvGPhqQFggdJ3L7rx9n
   GgqPnyQWvUUzWW+Dztjgwhr86RkM561ZSSmEMAARIhft+L/eigg13WR+4
   FC025gsthqHTjwaGZi42QdPJfAxt3/3jbJhYNKT60w8CzWMaa5XcugN6V
   I1eCmco082ePerxzFLsYsBvKm5kRxnxthN7r+zHFLeYd+qEREcvBtCpd1
   nKYC4NkZgtslWLWgA2sCOtHGpsSWUxYwjUHeMUTzsp2P3Y0htx40zOHaK
   8MX49EfJJxmN5lLGAcGrrxYKcDVmNoHrleMGQwu5Ak2KWz5mIZGpafwVY
   Q==;
X-CSE-ConnectionGUID: gGrqI3WgQaS0XqpSdkxnDQ==
X-CSE-MsgGUID: BmrAa9ktQfaVl/eUFB1vvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69349134"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69349134"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:47 -0800
X-CSE-ConnectionGUID: azXCWjoNT8S30FrFDwY1xA==
X-CSE-MsgGUID: f1oHu6qQQ8uabjgMWh4TTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207797171"
Received: from msatwood-mobl.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.109.238])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:47 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86/intel/pmc: Change LPM mode fields to u8
Date: Thu,  8 Jan 2026 14:31:39 -0800
Message-ID: <20260108223144.504267-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108223144.504267-1-xi.pardee@linux.intel.com>
References: <20260108223144.504267-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the datatypes of num_lpm_modes and lpm_en_modes[] from int
to u8. The u8 type is more appropriate and improves the readability
and maintainability of the code.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 23 +++++++++++++----------
 drivers/platform/x86/intel/pmc/core.h |  4 ++--
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7d7ae8a40b0ec..c55149f226671 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -779,7 +779,7 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
 	u32 offset = pmc->map->lpm_residency_offset;
-	int mode;
+	u8 mode;
 
 	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
 
@@ -838,7 +838,7 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
 					      enum header_type type)
 {
 	struct pmc_dev *pmcdev = s->private;
-	int mode;
+	u8 mode;
 
 	seq_printf(s, "%40s |", "Element");
 	pmc_for_each_mode(mode, pmcdev)
@@ -880,7 +880,7 @@ static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
 			const struct pmc_bit_map *map;
 
 			for (map = maps[r_idx]; map->name; map++) {
-				int mode;
+				u8 mode;
 
 				if (!map->blk)
 					continue;
@@ -953,7 +953,8 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			u32 lpm_status;
 			u32 lpm_status_live;
 			const struct pmc_bit_map *map;
-			int mode, i, len = 32;
+			int i, len = 32;
+			u8 mode;
 
 			/*
 			 * Capture the requirements and create a mask so that we only
@@ -1065,7 +1066,7 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	bool c10;
 	u32 reg;
-	int mode;
+	u8 mode;
 
 	reg = pmc_core_reg_read(pmc, pmc->map->lpm_sts_latch_en_offset);
 	if (reg & LPM_STS_LATCH_MODE) {
@@ -1097,8 +1098,9 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	bool clear = false, c10 = false;
 	unsigned char buf[8];
-	int m, mode;
+	int mode;
 	u32 reg;
+	u8 m;
 
 	if (count > sizeof(buf) - 1)
 		return -EINVAL;
@@ -1218,8 +1220,9 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 	u8 mode_order[LPM_MAX_NUM_MODES];
 	u32 lpm_pri;
 	u32 lpm_en;
+	u8 mode;
 	unsigned int i;
-	int mode, p;
+	int p;
 
 	/* Use LPM Maps to indicate support for substates */
 	if (!pmc->map->lpm_num_maps)
@@ -1254,7 +1257,7 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 	 */
 	i = 0;
 	for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
-		int mode = pri_order[p];
+		u8 mode = pri_order[p];
 
 		if (!(BIT(mode) & lpm_en))
 			continue;
@@ -1490,8 +1493,8 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
 {
 	const u8 *lpm_indices;
 	int num_maps, mode_offset = 0;
-	int ret, mode;
-	int lpm_size;
+	int ret, lpm_size;
+	u8 mode;
 
 	lpm_indices = pmc->map->lpm_reg_index;
 	num_maps = pmc->map->lpm_num_maps;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 272fb4f57f346..ead2f33ed3ed5 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -462,8 +462,8 @@ struct pmc_dev {
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
 	u64 s0ix_counter;
-	int num_lpm_modes;
-	int lpm_en_modes[LPM_MAX_NUM_MODES];
+	u8 num_lpm_modes;
+	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 
-- 
2.43.0


