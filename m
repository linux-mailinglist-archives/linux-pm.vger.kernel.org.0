Return-Path: <linux-pm+bounces-39644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43980CC5979
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 01:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D829304BDA2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A81E9919;
	Wed, 17 Dec 2025 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N28Tdx+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99C1C84DC;
	Wed, 17 Dec 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931032; cv=none; b=qqu8S6W0XffKjRlqC/4d9tCJ13Shr0zkjxWSCe770cR1M59bFnTMtjEtLj1D1gKqywGHHkG3pdRKghVBJQkIRfe+ijSsuyzqm/9ZJb4S2R8onkeVxPGjxvWOrugUEe8h2mRzCEFjGBUHfzkTEfyhs1vmubdP4sl7Sgux/4f28jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931032; c=relaxed/simple;
	bh=G0AeP2SFXAa2SNhN9cTIs+I4Bt40fCIyaD+Z0SVkcwI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNcQIuJd3a7z4ZEGTUF/XVWNVSeS+MDQ4Uz4bOOfn3259rR0w+g8YwIbWbviZQPfe/l/0EJKede2CsfrQteB/MnsW0xacOe81SxzeE0P/SbqcuXUqAUF2sXfpLHRZhs+qX02pQ8ZYJvbCoJthCCvFzDvtDoFJSpjediU+y6rFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N28Tdx+a; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765931031; x=1797467031;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=G0AeP2SFXAa2SNhN9cTIs+I4Bt40fCIyaD+Z0SVkcwI=;
  b=N28Tdx+alW01L9WKB/Elq9gA0Wvwu+lOKpES0jegydnSyHO5xEyZdmqI
   OjL808ca4Ak0oClqMS3FPZ48NZhF+Ux7+I17zEt9N8xPXwA0VYin4jjZI
   wxpeRHMqk5ptW7Otj5S0C3JKquRtRRcaVat8fBmhdkpYFeI8b6OA8V3l+
   zSQl5PDR5mrr28DtcRwJzs12syUjX29HS54AZlcZYjU1nlNylRVF0RoxA
   /UdyDuHN0qbVZEGXnTz95u7039+OnB9KeSsbWcTns+C8RiIsuj+cfzIuX
   BwaKQyGxGypfZbmDqtmot3o6vjk7IidCF7yZ9WG0XvGXzlstjLqGjYVeH
   A==;
X-CSE-ConnectionGUID: 5pTAtgq8QH209AxNkEaHSw==
X-CSE-MsgGUID: /uLmijwcROahqo2PphSOqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="79228274"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="79228274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:48 -0800
X-CSE-ConnectionGUID: sOAJaPA3T3KK+tkO8tDtog==
X-CSE-MsgGUID: x3MAgS5NTk+FvHkJokSWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="228858110"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:48 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/3] platform/x86/intel/pmc: Enable substate residencies for multiple PMCs
Date: Tue, 16 Dec 2025 16:23:40 -0800
Message-ID: <20251217002343.2289577-4-xi.pardee@linux.intel.com>
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

Enable substate residencies support for multiple PMCs. Previously
substate residencies were shown only for the primary PMC. This
change enables substate residencies for all available PMCs.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 25f77a9dc42c5..1f84d5ef47458 100644
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


