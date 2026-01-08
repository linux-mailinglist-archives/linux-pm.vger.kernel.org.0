Return-Path: <linux-pm+bounces-40513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0BFD06706
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 23:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E96305CA05
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666692E973F;
	Thu,  8 Jan 2026 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1hVunBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7543328B47;
	Thu,  8 Jan 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911517; cv=none; b=LZ7LkeAgypcCNLoakonmyRcZDA71qYmwxWTm6ABA9VM2a9tkBi8HtXAdvVNL+KDgod1nX3teRhLi4BCU687sX2ubZGaa9SygN6TdD8Af1ZGT6R8WyVv2YdskluHA3VkdKYRD76MnFKG4f6k54ILqWrW0U0AgUmCPgmXE2b3ePOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911517; c=relaxed/simple;
	bh=0lBEK4teYjecOWHdNu31/h/DoDfdjToKVpoAzDUe6g8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+nLqjdZyJYMXZFc/2l+4W0WSQMt8UnH37o4o6f6Ck7pBJM9FY/VjpiIaOES7PGgvp5lZw8otc97rAQPc3aNcj6RHTKIk0Mch2dkq7l9HvUpWZJd/cbtUC0KLvH63vCEWfLnY+W3EyAOGtnQLlY11qeIaOIH4YoP8Dk5vWWj1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1hVunBA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767911509; x=1799447509;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0lBEK4teYjecOWHdNu31/h/DoDfdjToKVpoAzDUe6g8=;
  b=S1hVunBA0CHrcMSHoAoC35eRlnvGhDCePeISzf2uc33heGo05aiUMbNd
   QPeaTKpTZFRRuPwdWTWbA9I3g7k7krw8BUvR+TR0xW+wRqKiN4z3dhVWN
   q3q+ZhRSZIaxJuri/yXlI/sTRCkdG9oE4IoyNEkBRKdLq+OHSIrjIQtTB
   utkl/4Ga5HDRG4d9MWDj4X3W72PPD4SupZuDedgKo7hVMd+pzuYXHTxDt
   96E6QSY8bu69BEVz5HMeUqXvtrQ3F8RbFFK+BAvqHRaJraTN3Yy72VnTg
   PpHxI4pPHKRKcvsPd+PDcFDBlGIOKiMA4/xkAVFPthOktj6bF8qJ+v7zy
   w==;
X-CSE-ConnectionGUID: Kx17tRxrS/WOINhqcL97sA==
X-CSE-MsgGUID: 6CyF9u/kSp6ZAtnPw+gj7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69349138"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69349138"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:48 -0800
X-CSE-ConnectionGUID: Qtq3saRGT92ESmSln7rsjQ==
X-CSE-MsgGUID: tA4wN3dISQGUDVuG3805jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207797173"
Received: from msatwood-mobl.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.109.238])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:48 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86/intel/pmc: Enable substate residencies for multiple PMCs
Date: Thu,  8 Jan 2026 14:31:41 -0800
Message-ID: <20260108223144.504267-4-xi.pardee@linux.intel.com>
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

Enable substate residencies support for multiple PMCs. Previously
substate residencies were shown only for the primary PMC. This
change enables substate residencies for all available PMCs.

The output of substate_residencies with this patch will be similar
to this:
pmc0   Substate       Residency
         S0i2.0               0
         S0i2.1               0
         S0i2.2               0
pmc1   Substate       Residency
         S0i2.0               0
         S0i2.1               0
         S0i2.2               0
pmc2   Substate       Residency
         S0i2.0               0

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index c76934ad7bf1d..e16f9630b908c 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -776,16 +776,26 @@ static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
 static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
-	u32 offset = pmc->map->lpm_residency_offset;
-	u8 mode;
+	unsigned int pmc_idx;
+
+	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		int lpm_adj_x2;
+		struct pmc *pmc;
+		u32 offset;
+		u8 mode;
 
-	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
+		pmc = pmcdev->pmcs[pmc_idx];
+		if (!pmc)
+			continue;
 
-	pmc_for_each_mode(mode, pmc) {
-		seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
-			   adjust_lpm_residency(pmc, offset + (4 * mode), lpm_adj_x2));
+		lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
+		offset = pmc->map->lpm_residency_offset;
+
+		seq_printf(s, "pmc%u %10s %15s\n", pmc_idx, "Substate", "Residency");
+		pmc_for_each_mode(mode, pmc) {
+			seq_printf(s, "%15s %15llu\n", pmc_lpm_modes[mode],
+				   adjust_lpm_residency(pmc, offset + (4 * mode), lpm_adj_x2));
+		}
 	}
 
 	return 0;
-- 
2.43.0


