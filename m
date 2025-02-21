Return-Path: <linux-pm+bounces-22673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D0CA3FC42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300AA7AB6D4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDB21C9F3;
	Fri, 21 Feb 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoWAsGhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9821C9E6;
	Fri, 21 Feb 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156848; cv=none; b=UMQ8h1LPdVtBjI3K40Av0mmW36qSevhDZ+RINHkBAk3iRRfMhsQVTyeAnmnf7wyIDb/Px/5+rYtSNyQZDDJ8fgbktn19H93ZNgJXlwoWXMxzIGkAshU9ET21AQJFzXljxlEonfdLsfZL4ey0RtvLBstsNkQRzPO+Y2tT+hJ9XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156848; c=relaxed/simple;
	bh=9jklcU8zXeb2fq/kZyVr5PcF5WyfIGqHTEgky7Oh+0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApDTpA95duBNRG2SAn4m7cTab+kpWbI5HfFPO3i1eSY8xBtPv5Usj46YP4nsN7imrrA7DrLeF2XAz8Jokf1fP2jAO8zYZBz0j8OacIUZG/Z3lIaLFNLBFzTlseTynhkockSqtomXXltOBddXpFY98NIcM5Piod3XMzckD3jWfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoWAsGhu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156847; x=1771692847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jklcU8zXeb2fq/kZyVr5PcF5WyfIGqHTEgky7Oh+0o=;
  b=WoWAsGhuP6/2Lh47phpbgWoHvNLqExvq0mO65mTlSPg3Wb1+qQZRMceM
   2T2V+TyiW/tmp47GytdtBxduuuAOH3zB1Fbmc4ZyzBb+ZZEZ/5GtGSbF1
   Ye/U/OmILjFxm1G+zUz8Li1OCBb8agmb63hSgNJCMaS5H5gbir3FKtdGp
   wsyFA0OddQFGIknGrKmh0WZUejesuLXMbYAA09qBNCRPU+hkVra6v1aFW
   MR1fXKCYvwzAbX0DbVzRh9Al9xsbd3sitTeaf7PlXIcMlWLC+gh6i8jr/
   mPYJZ7c7beN8PbcTXa2AoJwPyBACACx037T55i6Z7tKdWFro8RU6CVbqq
   A==;
X-CSE-ConnectionGUID: M+pgTbQfRV2aQMXQIWLy1w==
X-CSE-MsgGUID: 3t/9KJSjRWSBD3Sk5jmF4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186874"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186874"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:06 -0800
X-CSE-ConnectionGUID: KofNoJmuS3KP29Y+QC55VQ==
X-CSE-MsgGUID: B5aI7AabSBenbXrk2uat+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540624"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:02 -0800
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
Subject: [PATCH v1 05/13] ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:25 +0530
Message-Id: <20250221165333.2780888-6-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/meson/axg-tdm-interface.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 09103eef2a97..421b5d719fb3 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -529,7 +529,6 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snd_soc_dai_driver *dai_drv;
 	struct axg_tdm_iface *iface;
-	int i;
 
 	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
 	if (!iface)
@@ -541,15 +540,11 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	 * We'll change the number of channel provided by DAI stream, so dpcm
 	 * channel merge can be done properly
 	 */
-	dai_drv = devm_kcalloc(dev, ARRAY_SIZE(axg_tdm_iface_dai_drv),
-			       sizeof(*dai_drv), GFP_KERNEL);
+	dai_drv = devm_kmemdup_array(dev, axg_tdm_iface_dai_drv, ARRAY_SIZE(axg_tdm_iface_dai_drv),
+				     sizeof(axg_tdm_iface_dai_drv[0]), GFP_KERNEL);
 	if (!dai_drv)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(axg_tdm_iface_dai_drv); i++)
-		memcpy(&dai_drv[i], &axg_tdm_iface_dai_drv[i],
-		       sizeof(*dai_drv));
-
 	/* Bit clock provided on the pad */
 	iface->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(iface->sclk))
-- 
2.34.1


