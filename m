Return-Path: <linux-pm+bounces-17591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E68F9CD5F9
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 04:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80E42802BC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926B156962;
	Fri, 15 Nov 2024 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzJ12OFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6B1547CA;
	Fri, 15 Nov 2024 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642122; cv=none; b=mQtIWPXO1GLmnIrVi1tdoCmMCFibCVerABH20bBJnixT4LYGEePnbfqOzk+V2Vq/f90LeW4+6/JDW0uYmVFoCH6Ld47kH2RRWVXXEHEk+CkVhRVdMha6mOfebQacuKPmh8VYw4Yiq02DnMScMohbIm/GwfYXyw5x2O1kgdfOSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642122; c=relaxed/simple;
	bh=Y/o5+BJKVt2usIAMwP1fN2hdjv9O5BMZe4WYxPWg1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1j1MYoN/5YQoBNlgmt6BpMIOGXkZp0VqurSSNfG5zgqy56ifd6rNvq2PZnxSjDbGBdwLwaopQ2SSobl5nijtKb/IrIrtkmtudEl5jPLIXehsmbA1iOKN9H0OlDRAJkI4VpKwXeI0FPNVTTnr/IhLlUPrIg7OiqdVIQveRUQ+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzJ12OFn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731642120; x=1763178120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/o5+BJKVt2usIAMwP1fN2hdjv9O5BMZe4WYxPWg1pk=;
  b=jzJ12OFnpHAG2BjHjc0CfeIrC8qZ/8zaWAzAoT0sIcGQnPFADuc0rpvX
   e/fwroLYYdPZbtkmSiABf4IIGLMuoxkBJx2T0DFLzr6lTDIkbV4hPfkwO
   IltEVbemZhdMvqHdQye2jb3m5lC4PLQmkLuRceFTps/kjqf789BNzSvnu
   jmu0qKmqmNHZ7uBguPZhrIzHMuvNiJdNhAqGqkYsdmxr7ma1BPPQv2PqO
   WTsWGw16hmbovx/ARqz4DjHgraVfaw/HvtX8LZUXSAtFDkU0SajSyuuH5
   CY7cAE4o5CaAUN71dR3uUZku+yOxiBFT2gGQ7v8Wt+lrNAafOTRlnWDYu
   g==;
X-CSE-ConnectionGUID: q6ixvuXiRkCu3999HugbBQ==
X-CSE-MsgGUID: wBl2J4JUS4CF3J+A/b0yPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42149955"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="42149955"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 12:02:28 -0800
X-CSE-ConnectionGUID: JucirM5UTIyoYR5xKAi19w==
X-CSE-MsgGUID: Nu8QWjBaQ++mSJtEJheNuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88079100"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmviesa007.fm.intel.com with ESMTP; 14 Nov 2024 12:02:28 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] thermal: int3400: Fix display of current_uuid for active policy
Date: Thu, 14 Nov 2024 12:02:13 -0800
Message-ID: <20241114200213.422303-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the current_uuid attribute is set to active policy UUID, reading
back the same attribute is displaying uuid as "INVALID" instead of active
policy UUID on some platforms before Ice Lake.

In platforms before Ice Lake, firmware provides list of supported thermal
policies. In this case user space can select any of the supported thermal
policy via a write to attribute "current_uuid".

With the 'commit c7ff29763989 ("thermal: int340x: Update OS policy
capability handshake")', OS policy handshake is updated to support
Ice Lake and later platforms. But this treated priv->current_uuid_index=0
as invalid. This priv->current_uuid_index=0 is for active policy.
Only priv->current_uuid_index=-1 is invalid.

Fix this issue by treating priv->current_uuid_index=0 as valid.

Fixes: c7ff29763989 ("thermal: int340x: Update OS policy capability handshake")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: stable@vger.kernel.org # 5.18+
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index b0c0f0ffdcb0..f547d386ae80 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -137,7 +137,7 @@ static ssize_t current_uuid_show(struct device *dev,
 	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
 	int i, length = 0;
 
-	if (priv->current_uuid_index > 0)
+	if (priv->current_uuid_index >= 0)
 		return sprintf(buf, "%s\n",
 			       int3400_thermal_uuids[priv->current_uuid_index]);
 
-- 
2.47.0


