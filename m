Return-Path: <linux-pm+bounces-39536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF50CBC940
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 06:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9389300DCA7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 05:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72C2505A5;
	Mon, 15 Dec 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVx6PZrm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E7250C06
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765777694; cv=none; b=sPeAhHblrcRB6Ub39YM2yAKZ3JIzUrykqZhaCFQ3fAv+N1rocF3sJB6j8423WvPZSobY1cwH0P8+ysS+n6MczFV0YQy4uz1PY2beLzca7JCxtHsmAVNhqil7Fct6+GxOxLbDYTw1KUhFlWKWcRnk+R212JYRr6QwWOEe4h1RnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765777694; c=relaxed/simple;
	bh=CyyTiELZohCKnCtL1twP6tb+oLDfdVdvqpyW7LeeJoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SCwcnpRCW69c9AduYeyurDVzr1ovkfKIDXDmnGy+nQIY8ND8PPk3OTziDgeh+6/tM0n2A9NSJ+ME/8WXUms8Y6CcByaN+wlNADTN0A6vOIP7MmdsxAE9I8TxMjFfmjcmrYnTepJVziKpYzOMBTlF3y4Ji2UPFx/jKZcbJQCUQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVx6PZrm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765777693; x=1797313693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CyyTiELZohCKnCtL1twP6tb+oLDfdVdvqpyW7LeeJoo=;
  b=AVx6PZrm3eFYTyzLCTFoDITVTBQaf3d3pvDp7cxUozl51XSaB8n8h2H0
   Xwkk1gT+CF6KWN8nZI8QBHfcSmNC4Nse9cXW6uYCak3Q35oVszNkd6lgs
   X6hWIZKFgveAjTSE64Yuv1kzu8TXi30siwjmvHkZ3/FDzxXMEs9pOa7L7
   1bQQ+Xp9VEjAA/6IYdnqbRuJI1xXsSUYImboDvZUktfgxJ1EX5l588/bz
   nxT9np8088Rh4DCfhzbDEPHtVRgiydC/XYiqLcReMupVgBuHdSouOE06t
   vcKaXLZxXf9dYeuJ7FBVVT0V9ciiiiQEMrGSFEZvvc1GyLDYWT5OJmgpA
   Q==;
X-CSE-ConnectionGUID: 1KI52UpPS++ZUj+K78HqDQ==
X-CSE-MsgGUID: Wp2JCw8AQMeOUtJU+adu/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71525025"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="71525025"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 21:48:12 -0800
X-CSE-ConnectionGUID: cay8P3qvRfyVfYUoDyD7pA==
X-CSE-MsgGUID: WV/1aKTDSxqhtFerMIHNjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197531286"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 14 Dec 2025 21:48:09 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] thermal: int340x: Fix sysfs group leak on DLVR registration failure
Date: Mon, 15 Dec 2025 11:15:38 +0530
Message-Id: <20251215054538.3483331-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DLVR sysfs group creation fails in proc_thermal_rfim_add(),
the function returns immediately without cleaning up the FIVR
group that may have been created earlier.

Add proper error unwinding to remove the FIVR group before
returning failure.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_rfim.c   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 589a3a71f0c4..ba88d878c998 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -466,8 +466,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 			break;
 		}
 		ret = sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
-		if (ret)
+		if (ret) {
+			if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
+				sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 			return ret;
+		}
 	}
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
-- 
2.34.1


