Return-Path: <linux-pm+bounces-39642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE5CC596D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 01:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C58302FA3C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 00:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9151D416E;
	Wed, 17 Dec 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIHSh90J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECE1A239A;
	Wed, 17 Dec 2025 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931030; cv=none; b=ZsVhC8uPV+jR/Wf2o6+e877JnLrnb//nJyhs2oQDi/5v1BaGlT0BRc4fHD9C4XudtznGOfuFsTi7TTRTaEVGK0C4/hn9/7kKtQcBTLM6eduDfbM/+90/JvRUMVCv3QzQEuukooq6zlcpGsKFUOJlUI0zapfq6YIoQZdeQpH6ByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931030; c=relaxed/simple;
	bh=fwT3FfJe5cZVbh12Zu6qCiTMEbUhXFs2R7qaaACn0v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2KvRIm+cN9/OIT8Fq5k9loRJ21zeinNzX65zGU4hN1TP8VhXnJM+AMzpjcMy2jBBxj05o2YwYe7NGLaRGQm82b59LqvwZpTYfNVOC2royTtGSZfGl2LIFr2IPGKVHDVT5Ko4iuDkfOyivI0fwFsFSjuLAIXtIKLTzqNpEr1DPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIHSh90J; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765931028; x=1797467028;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fwT3FfJe5cZVbh12Zu6qCiTMEbUhXFs2R7qaaACn0v0=;
  b=hIHSh90JcH1JA6m8H5SD9/UOW2QqTm3pmKjNZJdy8QveJqhWznqXaAB8
   3VEKpadlWOzed2+d6pY49yWZFMQ0tYqIEbyoxtcSrQpeRf1cDfbSdoEll
   1hpGho+tnsjOQWRfMcMG+V1/tM53OIvoEYybe1UttEM6x9cptB/+272/L
   1hrzIW6md5v/0E/n06PX5jVJRgAX0qxY9vl2brGftPitnwHOWzZfIz14V
   tSbkfg/xVjU/BmnQ3JGMshC0eIHJhcaac4GbjXmcthCetUhviz1HPBT05
   Uf1/h5acwbPDzfs8C9nSzvzcZMlGzrABkHGhfMX0Ioybo7/gH+J1VuzoJ
   Q==;
X-CSE-ConnectionGUID: kmWUneiESvG6R2RaPfJ/gw==
X-CSE-MsgGUID: 9HmW45Q0Qg+0nJBmVLvi8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="79228267"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="79228267"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:47 -0800
X-CSE-ConnectionGUID: i/xaGfCPQPKtKzyacYqVbw==
X-CSE-MsgGUID: VL0Onb8PS2uklqLtuucRfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="228858106"
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
Subject: [PATCH 1/3] platform/x86/intel/pmc: Change LPM mode fields to u8
Date: Tue, 16 Dec 2025 16:23:38 -0800
Message-ID: <20251217002343.2289577-2-xi.pardee@linux.intel.com>
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

Change the datatypes pf num_lpm_modes and lpm_en_modes[] from int
to u8. The u8 type is more appropriate and improves the readability
and maintainability of the code.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 18 ++++++++++--------
 drivers/platform/x86/intel/pmc/core.h |  4 ++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7d7ae8a40b0ec..3e916228e7ed2 100644
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
@@ -1490,8 +1492,8 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
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


