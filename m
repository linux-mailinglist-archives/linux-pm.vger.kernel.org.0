Return-Path: <linux-pm+bounces-38154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F7C686D6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 10:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79AF7343959
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBF63002BC;
	Tue, 18 Nov 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6fGK+6/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899651D88AC
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456773; cv=none; b=HQODvw1YYatYwiiJwVmfr6iKbs4sKTCz64clCMK8MFw8ExLMY8vxA5R5jr51KpcS78cmpFHHnS7jhAaI50Qcgc2tcNsocC3MwNe3NeWLGG0qHOxHrPyRkFVy04hkJ2KJPE3JIVZXfZraG/U4/VRWN+tZNjFXsrlZG/EmS6PcItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456773; c=relaxed/simple;
	bh=hqiN40hv3YoJTO+huq6Fxpazzjl9MzPYAbZ4MKib+54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxExe5A9GiBrTRfxheMH4Rt39CIfGGsYiIuWqjXtW4RmZWz15MjmfPjiKQ/5j50IgFPXxTs5ODZU4rXB8fbzwBDSFrjTeD7fmKyhv3U2+FRC7huB/AK0HwNbDMf5VOMZUkBYJhCyAya2gd/bUcf/m0jf6Kv3pxAA46/Luf5jGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6fGK+6/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763456771; x=1794992771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hqiN40hv3YoJTO+huq6Fxpazzjl9MzPYAbZ4MKib+54=;
  b=Y6fGK+6/RmFWmZooFg7ahHThnqMYs1xpvxIu7CfW3zCyHOCJSmBZAVA4
   q+BZpFx+xVS7/oxVEYQKzy+bFpweW7eaaxd/Eh09q7Iee/XNE9oiMPP8v
   pO3KMWDfdHFhznyfUHeUrYJDhZENIv31Rf6CUfwCKHX4CnDEIa6xgVtX4
   E1LfYHmRyG631SjKXZTICi4ZaTTJQQXIdY/J+ghepUa7ozvrlgeaVbLFi
   /Z8gMcEFYHq5MKF3NKjXLfd08t/o+CG7x9nPZzjtGpydsbEprqT8g7NU8
   VxOuw9YUFHNRtJeLsacB1K2WuutEjCiKO76CAIhgTxWcuX9leRDyCDBHB
   g==;
X-CSE-ConnectionGUID: j4bD3a4MR/iapZOe7a7ung==
X-CSE-MsgGUID: 7vkF2O8GSRWLY17sKb08eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82863042"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="82863042"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 01:06:11 -0800
X-CSE-ConnectionGUID: QIMWSaXVRZK1OFtZ77+JGg==
X-CSE-MsgGUID: po380k59ShmTlFLdcjtWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214096762"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2025 01:06:09 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpufreq: Skip scheduling when update work is pending
Date: Tue, 18 Nov 2025 14:33:54 +0530
Message-Id: <20251118090354.118553-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid scheduling cpufreq policy update work when it's already
pending by checking work_pending() before schedule_work(). This
reduces unnecessary work queue churn and scheduling overhead under
frequent notifier events.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/cpufreq/cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d90dcffac953..49300cedd8d0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1222,7 +1222,8 @@ static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
 {
 	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
 
-	schedule_work(&policy->update);
+	if (!work_pending(&policy->update))
+		schedule_work(&policy->update);
 	return 0;
 }
 
@@ -1231,7 +1232,8 @@ static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
 {
 	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
 
-	schedule_work(&policy->update);
+	if (!work_pending(&policy->update))
+		schedule_work(&policy->update);
 	return 0;
 }
 
@@ -1841,7 +1843,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 			return policy->cur;
 
 		cpufreq_out_of_sync(policy, new_freq);
-		if (update)
+		if (update && !work_pending(&policy->update))
 			schedule_work(&policy->update);
 	}
 
-- 
2.34.1


