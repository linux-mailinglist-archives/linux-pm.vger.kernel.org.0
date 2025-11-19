Return-Path: <linux-pm+bounces-38199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D554C6C8A3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F8D4F2504
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE122E5B2A;
	Wed, 19 Nov 2025 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6eGQzAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456222E54DA
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522008; cv=none; b=qk7ZsWh+Lh3i97grgZW1ReambckhrGamiNsWDnMG+7ZTh1e+uO5t6UyVdVkQUXYrydaKGk2iEnfaKahOI6+bSQZGvdatNYpeGq40GiT9Ui+Io6lR8V3k4DStRJ+g6tqcDCdNNsRxCDsswcdifaHqP7UozkOcmFn5Qj3BDFIsWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522008; c=relaxed/simple;
	bh=PdACyOJMlwVgsGcgxkxZcByg4iZsIQN8FWbn7/lFnrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AP6cKWFuvmzk4LS1YuC0J6Slua5XpnIY8DLGgBTE8Fv1GirXfxNrwNX9JW+P9kunAJxElPIcI1HWMazyf46psbZE6MSZeu4uS2WJQNdx89pc3TvIaifAWsUXjtmcydtghaObBgy59kaw5F7V+rtNx0nAKTC033wjNEDTLlFK9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6eGQzAG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522007; x=1795058007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PdACyOJMlwVgsGcgxkxZcByg4iZsIQN8FWbn7/lFnrY=;
  b=H6eGQzAGFqSSrSpou9sF+5ahz5XwBW6OhaYOoMew/+8YM4vwms6aV6GR
   VPJ/XziV72UXPx6sNWBVX117PM36lGYe33d+YxJ7NHCwImiEb4D2giDFI
   xhQq4bLZE60suM400kDVqEMzJLLGfYglErqgFE33fhJ11Hl8wK+YNIQU5
   SUZgi4NubUApijkVeN36vG5VYts3Bx2o8wfyiITh9ZjK7RsDvuvtv4H69
   79bxiCQSz4KPkWrs4wlxKiDId7cpGjeFSijcpngPCF7QEqcozo/pl1gpM
   e2z3+4fjDcWu7nxD7YiuIrMVzyWZBkrG15mR7K2H7v18vJkWd4xEqK0dY
   g==;
X-CSE-ConnectionGUID: GlsmIicaQhK95my+xwMesw==
X-CSE-MsgGUID: oo7TZEQzR4eVDy16Dt1mdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65715315"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65715315"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:13:27 -0800
X-CSE-ConnectionGUID: r91fKIYfTGKSqDUnokVZLA==
X-CSE-MsgGUID: T+Ud+W/lTfa1YAioBgK+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="195236379"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Nov 2025 19:13:24 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] cpufreq: ACPI: Replace udelay() with usleep_range()
Date: Wed, 19 Nov 2025 08:41:09 +0530
Message-Id: <20251119031109.134583-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() with usleep_range() in check_freqs() to allow
CPU scheduling during frequency polling. This change improves
system responsiveness and avoides busy-waiting.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
v2:
- Tighten sleep range to usleep_range(10, 15) to limit worst-case loop
  duration to 1.5ms, addressing reviewer concern about increased latency.
- Cleanup commit message

 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 083d8369a591..e73a66785d69 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -395,7 +395,7 @@ static unsigned int check_freqs(struct cpufreq_policy *policy,
 		cur_freq = extract_freq(policy, get_cur_val(mask, data));
 		if (cur_freq == freq)
 			return 1;
-		udelay(10);
+		usleep_range(10, 15);
 	}
 	return 0;
 }
-- 
2.34.1


