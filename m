Return-Path: <linux-pm+bounces-39540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D647CBD20F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 10:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D90B3009C3B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E220314A62;
	Mon, 15 Dec 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR+JFvlb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467631BC91
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790187; cv=none; b=M31msaAT1JYNWNXP0HHF2TAxROFTw6y4NcWuZKjp4W5nf6QqVGQzi3zrGZZ6alVL4WOxRmojt+KSGBifMCyb/VrWc9XpRR6rLqWZAPfhR0KIegGpqBAZNwt9+lhid7+KOR0t3qLTh1PMEbD4ufzp2DL9EIBBTGWsICsjHMv6d7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790187; c=relaxed/simple;
	bh=qxfPb4fUnJOrVfSKGaBVF6zQYZGXm8W8scRcV/HVEw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jj6oD81EOrbJZ4eu9UAmfn2QHZQZJjqK1PGP/ViBVtFWcBJXxqqoMkIZV0161EUY5rPr8lszzoPy647ZzJqpyo0ot17u0wbN2FiQLRehayqEkiITTDMQgpiRn+fYrzcq+IA4mYZBXF2wvqwuVaxJdPiyGVHvNvsO53IeHUVStT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR+JFvlb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765790185; x=1797326185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qxfPb4fUnJOrVfSKGaBVF6zQYZGXm8W8scRcV/HVEw8=;
  b=BR+JFvlbawg0kMfHKZ8VvRJnHmLcoPacU5weCRfuIK/0Fc7uYSHsC0Qi
   /qDroCIqlaPiQI4sw9CA9ecJezjEqJlvyUDYP1umxdjb+upHzulxpncWY
   QBSQ43gs4bsu9vuzhs+1xgE6ekQlovlWAANKjHeckTuoYmf+8ETAXASKg
   ctuw5UY6bUoi1GEupLFD+ApRK0d8aaw5X7NJu3JdfOApsH5Zm1tI4jKs2
   U0sXJw440O6L5PW4ZLLRCYNJi/ICM8L7bP9rFo0u21kbdzhww+j40VkIL
   9/8JfeXy6wdnoDTtDb6APRkt7udozJtjKdih2AcTtN5CJ9nYMwnRPeFao
   A==;
X-CSE-ConnectionGUID: 3hwF/caHSda9oUMhjjqCkw==
X-CSE-MsgGUID: eU3McpElRIO3h1sjSv3Huw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="79059410"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="79059410"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 01:16:24 -0800
X-CSE-ConnectionGUID: CV8+H6/iTHWTkSE+md12TA==
X-CSE-MsgGUID: 5DYV17Q4Q1GOyktJT2EpuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197720212"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa008.jf.intel.com with ESMTP; 15 Dec 2025 01:16:22 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] thermal: intel_pch: Drop explicit pci_set_drvdata(NULL) in remove
Date: Mon, 15 Dec 2025 14:43:52 +0530
Message-Id: <20251215091352.1250531-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses devm_kzalloc() for device allocation, making the
pci_set_drvdata(pdev, NULL) call in the remove path unnecessary.
The driver core clears drvdata automatically during device removal.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index fc326985796c..52e71af67dc6 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -269,7 +269,6 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 
 	thermal_zone_device_unregister(ptd->tzd);
 	iounmap(ptd->hw_base);
-	pci_set_drvdata(pdev, NULL);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.34.1


