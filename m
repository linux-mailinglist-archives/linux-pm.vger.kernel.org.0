Return-Path: <linux-pm+bounces-38149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72238C67C78
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDE7B4E3C51
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C22EDD71;
	Tue, 18 Nov 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAkrccoG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC22E8B91
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448514; cv=none; b=uBVo8bMmReg79XO4YygJkwvbfFUi8HCURSjV1OjSmLUpfH+bnJUgmH6+IQwrLIvK1ELvSj41wBuUNzdyZOPw62fAchPaGaarlyXfHbwX/kQLXqoFV8ReoUQVi+W+D0QnuAvxjv+FJI83keZM+xP9sLwU5twPEoCAurb7+vh9nvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448514; c=relaxed/simple;
	bh=xoNVCpbe2HKyUwxbYlvmcHK0VvJJjxZpb8PtK4DxEMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FISuqD2bcty4QV+QU0gQtWHdAp1KmZw1i0nULdiCgq3yZa6gS8z8Nud9lib/xrV5RaZMwXPcvOxr0ZKJ11bJEBsLz4LiFPjM0izBRtTKy+CUDX7g8GtsImvtFjKaSlSvTPNkeI9yDPfDebnEf9Rqhn2NkqXdfhHhqD0e8rqFCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAkrccoG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763448513; x=1794984513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xoNVCpbe2HKyUwxbYlvmcHK0VvJJjxZpb8PtK4DxEMQ=;
  b=dAkrccoGpLgCBDnsHEi5EFBzqYfNFkHoNHVtbh/VY86/XtYdsIXDvnhF
   T9cu0J2KPt8IBD4KE56h3Q5aI2lNHm0FiIc9DNh7JrbqJyKWfK75JKhp+
   2FZPayifDfgi+wL/gS6oxPhVihAJ2i9LkSkOM+VNEqwUn2yN0BF7SLwLQ
   KFThkB7s3B4IGY+bTXESTlKpcqob9F5v7sYxYl158VGFT29uk2XJY9WkZ
   wORmRaueBH938qq1xAmqhAxnKRwfK1b0yJIS1suS1ocCicMnugtQoqAJl
   U7Us/JQVWlPiuCPdI1LsUk9T71sOZirytRJwjEdNf7VHRAhojsdIYgw4g
   w==;
X-CSE-ConnectionGUID: unbXHxy8Q++2SoN/fxwHJQ==
X-CSE-MsgGUID: IvNuT9UsSSqLmseqU4Z/ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65399013"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65399013"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:48:33 -0800
X-CSE-ConnectionGUID: w3SxkFaXQfucL2sC+XuJxg==
X-CSE-MsgGUID: 31+0VXTuQF23+qZpwv2EYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195135888"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2025 22:48:31 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpufreq: use cashed resolved frequency
Date: Tue, 18 Nov 2025 12:16:06 +0530
Message-Id: <20251118064606.2777035-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return a previously resolved frequency when the requested target
matches the policy cache to avoid repeated frequency-table lookups
This implementation reuses the existing cached_target_freq and
cached_resolved_idx fields maintained by __resolve_freq() and does not
introduce new state.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/cpufreq/cpufreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4472bb1ec83c..d90dcffac953 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -527,6 +527,15 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	unsigned int min = READ_ONCE(policy->min);
 	unsigned int max = READ_ONCE(policy->max);
 
+	/* If we recently resolved this target, return cached value.
+	 * This avoids repeated frequency table searches.
+	 */
+	if (likely(policy->cached_target_freq == target_freq &&
+		   policy->cached_resolved_idx != UINT_MAX &&
+		   policy->freq_table)) {
+		return policy->freq_table[policy->cached_resolved_idx].frequency;
+	}
+
 	/*
 	 * If this function runs in parallel with cpufreq_set_policy(), it may
 	 * read policy->min before the update and policy->max after the update
-- 
2.34.1


