Return-Path: <linux-pm+bounces-22675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93EA3FC8E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0F867F42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1D8221D92;
	Fri, 21 Feb 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq9xKU3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D022069F;
	Fri, 21 Feb 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156858; cv=none; b=OaLJFvJnTdCZPUvP6CL/jLbzjZaoN+5ftA4JMTib7meSg5oOZSYeoORTNH06xHyGYWwyiNLKs7OT0NrCw4y8gCtvrQaI/LYuFbfMB/wV9nEl25a41mgBcS3aTCIfZQHl9CMqPGagQMxkU+COs6b23uD5YadALP4QzC/A41AUjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156858; c=relaxed/simple;
	bh=HeIObMwwsPv28EZYhOje+axVBZQHbbM4wdz9ML54dVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lX3Vau/Ukz/x1KKbykJ9c5o9a0ONBg0WdFrSbHRhQIbeaRs7a3A4Q3+wje+LeHxoxLRwAfGmgvtt4Rl5hHLgorqV8pDDoe6CoV7csBWQ8eBxmOmGEcnnA58qshkfO3vCbpu57Io64uU8GTuSyGhk8VU9QxpjpK0V1z3VFBVJ9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq9xKU3W; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156857; x=1771692857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeIObMwwsPv28EZYhOje+axVBZQHbbM4wdz9ML54dVc=;
  b=Tq9xKU3WEzptcJTa25IewSiuQ19tsagsNhGkefLcQksr/D9fZoMjtIgF
   DSXhb08RHbyaSxs0UFa9Xv8qaE2c0uK8/vwbiTkfkr1dmeKwsog6DVjBR
   G0G0gcjW8RI6INCIm9KKwIh0/vS1XnU12qsCyLBfSP9aVSrj8si5aIZll
   Whc3YDFfsjqvO3mLwzfkiIu/jO7stU14rFyt02DiP/g5CGtIvcedmu/Yw
   3Ml3nEIQf968+wQhIk1KLfcjRTQDp5MMS9SZ0n57iSi9VyCEyTb2eUQbu
   WI1d31xdJxLmDAKJO9lfFCgYYxfvQ8RtCO+0OTdFXD6QW5iLZtpFDCWTj
   w==;
X-CSE-ConnectionGUID: E0Ntl9avSUW73eUCjF7XMw==
X-CSE-MsgGUID: lpIpfIUNTjmkv+zETnpw1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186936"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186936"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:17 -0800
X-CSE-ConnectionGUID: SYd9pcKhTxKXRhNfh0fgqA==
X-CSE-MsgGUID: uMXT3x5vQC+C/56ksK6yZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540633"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:12 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	deller@gmx.de,
	andriy.shevchenko@linux.intel.com,
	sre@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	jdmason@kudzu.us,
	fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:27 +0530
Message-Id: <20250221165333.2780888-8-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup() and devm_kmemdup_array() which are
more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/video/fbdev/pxafb.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4aa84853e31a..21fba33918c6 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2239,26 +2239,21 @@ static int pxafb_probe(struct platform_device *dev)
 
 	ret = -ENOMEM;
 	pdata = dev_get_platdata(&dev->dev);
-	inf = devm_kmalloc(&dev->dev, sizeof(*inf), GFP_KERNEL);
-	if (!inf)
-		goto failed;
-
 	if (pdata) {
-		*inf = *pdata;
-		inf->modes =
-			devm_kmalloc_array(&dev->dev, pdata->num_modes,
-					   sizeof(inf->modes[0]), GFP_KERNEL);
+		inf = devm_kmemdup(&dev->dev, pdata, sizeof(*pdata), GFP_KERNEL);
+		if (!inf)
+			goto failed;
+
+		inf->modes = devm_kmemdup_array(&dev->dev, pdata->modes, pdata->num_modes,
+						sizeof(*pdata->modes), GFP_KERNEL);
 		if (!inf->modes)
 			goto failed;
-		for (i = 0; i < inf->num_modes; i++)
-			inf->modes[i] = pdata->modes[i];
 	} else {
 		inf = of_pxafb_of_mach_info(&dev->dev);
+		if (IS_ERR_OR_NULL(inf))
+			goto failed;
 	}
 
-	if (IS_ERR_OR_NULL(inf))
-		goto failed;
-
 	ret = pxafb_parse_options(&dev->dev, g_options, inf);
 	if (ret < 0)
 		goto failed;
-- 
2.34.1


