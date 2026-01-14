Return-Path: <linux-pm+bounces-40826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751BD1D974
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4F6307F71A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A33816E0;
	Wed, 14 Jan 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFt9BeDg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B437F73D;
	Wed, 14 Jan 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383082; cv=none; b=Oq95RFkQF523Bp1w9AHuD3pnSHu6KXhH0iKxCh27qOzrx8HaGGfdnzDzy/7wxw3l3uR5hi4T7o9iP9I9GLuZfDpRDbWgH20Gak5oYyth8SWM/+t1NMIPyfrd1IH13ZgRzwVYK+rEl6e7LbwyAQ9yFYUmRzdCaJEWpx59ExIQf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383082; c=relaxed/simple;
	bh=W1Bmt89v8Pf6UMerRTXvTJxOGZ7dEWv16CN3Pc4CY/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2WIBTHtygTL2XFgSyrXRpq4kz83tJy8/yPcIlUoDHIXnRe/zUBo1C5pPlsBbTApywr0qtFQK/LaGevJQ1fJqwDsfChCCTH81UBGiiWqvBDT+78lE9dEgksx8BH1pZ2NtyizPAjyqPPh/lYuqc9N7LAJwqQSHZGJ7XH9Vqi3jH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFt9BeDg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768383081; x=1799919081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W1Bmt89v8Pf6UMerRTXvTJxOGZ7dEWv16CN3Pc4CY/g=;
  b=VFt9BeDgq/6m87eCy8DVcmyLieltByfFE675i2WM8J+fpU8+6eEsv/Ru
   spU/QHAqucCsvjziFf+YrmuJ0x+ls3KZi3WG6OaUzfQQXYI07UKgpLwot
   bJnGfNhHcEICrMnI0tcv4qZa/ipU8i8He4A0+atkJWwOG3aVNTylMHxFw
   d3Ipox9iJf2ymK1d1ZEZuyBOoaA8O5a0fv0BqMRdZ4hXPNcwjgEA3rScw
   Nb+6Ho+DFlKRkcqHgDz3BfR0OraRlP9CCDBmA4WCeTnL5Sq88hXCdBBkj
   I0+c19VMdO3D0ZyY2j52clccExSOjhGv38tyTtIGi12FAqVLN+M7pUyx0
   w==;
X-CSE-ConnectionGUID: NH7GSLfJT7afpjWUXDRz0Q==
X-CSE-MsgGUID: Q3wfpD3vQ2m4USR5WKnCTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69598036"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69598036"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:31:21 -0800
X-CSE-ConnectionGUID: h0py1DpxTKGFzLrVpVOOEw==
X-CSE-MsgGUID: mZZSu3bNQyuoS2MOVHX5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="235345839"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 14 Jan 2026 01:31:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0F03A98; Wed, 14 Jan 2026 10:31:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PM/devfreq: Remove unneeded casting for HZ_PER_KHZ
Date: Wed, 14 Jan 2026 10:31:15 +0100
Message-ID: <20260114093115.276818-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HZ_PER_KHZ is defined as UL (unsigned long), no need to repeat that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/devfreq/devfreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 00979f2e0e27..51eb67fba44b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -146,10 +146,9 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
 					     DEV_PM_QOS_MIN_FREQUENCY);
 	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
 					     DEV_PM_QOS_MAX_FREQUENCY);
-	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
+	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
 	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
-		*max_freq = min(*max_freq,
-				(unsigned long)HZ_PER_KHZ * qos_max_freq);
+		*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
 
 	/* Apply constraints from OPP interface */
 	*max_freq = clamp(*max_freq, devfreq->scaling_min_freq, devfreq->scaling_max_freq);
-- 
2.50.1


