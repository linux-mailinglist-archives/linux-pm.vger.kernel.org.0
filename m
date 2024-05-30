Return-Path: <linux-pm+bounces-8429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2F8D4EE7
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C079D288D59
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220CF187550;
	Thu, 30 May 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6xAZ3UG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9921CAB0;
	Thu, 30 May 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082235; cv=none; b=rGYtSjWGrY/tHMTtQAq0JDBiZR7zohR0nnUAv0So/mYUvUfRUvrnCYTp81UxcRT8BQL3RodDqcN4I5zQUFpcCc8II3meVUEUfnwb1APhPE3x1mRzw7kvawnRy8aa/Ys5R4AczOJ4NYqkLBLQHbVE9fRJFWqwksKpjjjR4gOcJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082235; c=relaxed/simple;
	bh=1nmm7YiAoX/ocuW2WnnDnFAgCxIVQe6oLetLQWQBVw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UhVrnl+ay/FFVocWLTRXK2kaGYmT2tv31tdEQ0QcrM8iPF3oh5lF+L7JIvZ9NhnCUJt5iLqifrCY2UPAlVPwuT0TrwQWLJmAP/Mc1MT9y5lPoyaqN2Cn/WS02qo7Dx1iXyi3IlyRcomrlRVOAEfeHa/9rdgFnHfU6W3HddEplCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6xAZ3UG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717082234; x=1748618234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1nmm7YiAoX/ocuW2WnnDnFAgCxIVQe6oLetLQWQBVw0=;
  b=e6xAZ3UGP0+OFhoDl2GPwGvcw+BAFrjpPCIlp6KwGm1/7GOfRDCosJui
   C48mQMyuLLIb30EqcORoJHIQzIFccnKLnfLfaC8FaN9sdOMrHvFvMWlU8
   X3MWE2NMYEa8n7fAJq9rStIT7IN4lVdBI/f1axqIaH3Jhl60IGahx7i57
   HtrzzV5dip1Oq3rdOCfik2CP2XIhjqT3q8/cZfy/uuBEC2RkyWd2WiyI6
   iN8pA5IK/a7cSCkofSpbhw/e9Yduzzo3P354KfPEACWyqv7Bz2nyBMdDu
   l1sDpMLGdoruhOx0FXeT0nbl+GkUAPv9b9bTiMmdmYlxf3MJ44xtuZ2nj
   Q==;
X-CSE-ConnectionGUID: Mdud6dLUT3+HTvrv8Qooag==
X-CSE-MsgGUID: FORB/arqQiKnAkLy7YRfDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24696441"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="24696441"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:17:13 -0700
X-CSE-ConnectionGUID: YmSLElaNSsaNISLgVU6JTA==
X-CSE-MsgGUID: adjQl1brQ0mllVZN+NW0vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="36418618"
Received: from jianmeit-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.173.202])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:17:11 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	len.brown@intel.com
Subject: [PATCH] thermal: intel: intel_pch: Improve cooling log
Date: Thu, 30 May 2024 23:17:04 +0800
Message-Id: <20240530151704.282453-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_pch_thermal cooling mechanism currently only provides one of
the following final conclusions:
1. intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [48C]
2. intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C] after 30700 ms delay
3. intel_pch_thermal 0000:00:12.0: CPU-PCH is hot [60C] after 60000 ms delay. S0ix might fail
4. intel_pch_thermal 0000:00:12.0: Wakeup event detected, abort cooling

This does not provide sufficient context about what is happening,
especially for case 4.

Add one line log to indicate when PCH overheats and the cooling delay
has started.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index f5be2c389351..fc326985796c 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -298,6 +298,11 @@ static int intel_pch_thermal_suspend_noirq(struct device *device)
 	/* Get the PCH current temperature value */
 	pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 
+	if (pch_cur_temp >= pch_thr_temp)
+		dev_warn(&ptd->pdev->dev,
+			"CPU-PCH current temp [%dC] higher than the threshold temp [%dC], S0ix might fail. Start cooling...\n",
+			pch_cur_temp, pch_thr_temp);
+
 	/*
 	 * If current PCH temperature is higher than configured PCH threshold
 	 * value, run some delay loop with sleep to let the current temperature
-- 
2.34.1


