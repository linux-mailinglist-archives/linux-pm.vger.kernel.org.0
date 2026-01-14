Return-Path: <linux-pm+bounces-40825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C70FFD1D8AE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC843300C981
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6E389441;
	Wed, 14 Jan 2026 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecfuO/5d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC038946D;
	Wed, 14 Jan 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382900; cv=none; b=PLhp1JwqotA+fcF+muGezc/lbF4aaHMRxoEU/lyfd/YnxvskDIXfeEli2i0vOo2JZ0E4wEE6U+1Dn/4iNKYtbeNH4YRwknV79wyGStyW2xB6t8BFp+0sqaOTpovK6QomG4He2r9D6m+7S1/zvKbU9K661BhGW1rl2K6HGdukYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382900; c=relaxed/simple;
	bh=Dx8wdyZ1+Rq3DObPX6zf0dh3NrSxxmnlPzpX3UXG2ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuW/xVsMIqzU5F0vP+xcrTYApVDxZOLmkLR3n566OhtqUqaE9Pm2w+NxpvVvSPNIZNFYivKMYhw4KrRvcNUhYNaAE/jVe0WpgiaUD7+C48bJirYvPeoUi6JXui2QkwLEu6hgZGwW7yNZ1HpChZl1E5U+5eY7u+ue/WqIqfo5wI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecfuO/5d; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768382896; x=1799918896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dx8wdyZ1+Rq3DObPX6zf0dh3NrSxxmnlPzpX3UXG2ec=;
  b=ecfuO/5dRkpgwF1TlfGQJAeQNeztu8iYklcdC8iIMq8taFqTrRvBIWoz
   1cVG9iHszaFeziAAAHsRR4aPzauL1If/MpoLdy0myBMaaobnamJY+xIpI
   96lel05ODueKo+0+aJYbfUpgGf93BzUDFqEqPSOrj6sNexH1d9B6OYEpo
   OwaYOw5f69DXV7OXuum+YiP+7PjhzKcVcForcELBgHuQzXpbXzPtVRIsc
   ktmmxtjmn0bVnC5f32VCRJBD720CJnKSSzeHRVSVH7mbBxV3EeVptwaBo
   VsXN3M923spJT/P/MzTA/S/DclmnXBtS4DMIifHrxAZK4OKCNormjDozd
   Q==;
X-CSE-ConnectionGUID: MuvMu5gvQSKhmeJv2MMMVQ==
X-CSE-MsgGUID: xBFWLKN1QUeS0BY8qQ+8RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87258424"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="87258424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:28:14 -0800
X-CSE-ConnectionGUID: bRaxQtijQleZaZYRzDl9dg==
X-CSE-MsgGUID: PoJBeXJ0T52sf7c7XXKeZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209474968"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jan 2026 01:28:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9737998; Wed, 14 Jan 2026 10:28:10 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v1 1/1] thermal: stm32: Use predefined HZ_PER_MHZ instead of a custom one
Date: Wed, 14 Jan 2026 10:28:08 +0100
Message-ID: <20260114092808.273695-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use predefined HZ_PER_MHZ instead of a custom one. No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thermal/st/stm_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 6e90eb9f414d..5d8170bfb382 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 
 #include "../thermal_hwmon.h"
 
@@ -76,7 +77,6 @@
 
 /* Constants */
 #define ADJUST			100
-#define ONE_MHZ			1000000
 #define POLL_TIMEOUT		5000
 #define STARTUP_TIME		40
 #define TS1_T0_VAL0		30000  /* 30 celsius */
@@ -205,7 +205,7 @@ static int stm_thermal_calibration(struct stm_thermal_sensor *sensor)
 		return -EINVAL;
 
 	prescaler = 0;
-	clk_freq /= ONE_MHZ;
+	clk_freq /= HZ_PER_MHZ;
 	if (clk_freq) {
 		while (prescaler <= clk_freq)
 			prescaler++;
-- 
2.50.1


