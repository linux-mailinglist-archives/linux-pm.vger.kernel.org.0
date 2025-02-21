Return-Path: <linux-pm+bounces-22674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E43A3FC86
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4F4866B98
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421021E091;
	Fri, 21 Feb 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/F8kzYq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5B21519F;
	Fri, 21 Feb 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156853; cv=none; b=ra9p/N8syArPWoFguyS6BtE58489JgksDP0RirK6G77YEHRc0Tfg3lrYg+hle5aO0t9pH5TkfyTUnJw5adiScMcJO+UWHSXEHg9d1Cr/V6dbDP1ADOkpuQZd/fRu6oe9g8miLXkTWZWF5R7iwnLlq1z/v03knRRpZm+gaoQxvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156853; c=relaxed/simple;
	bh=rmG5AJg763QuUwHiI4zIJ8TFRtKX3Nej46Hu42LYCJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUY4kA4HG96r51U85AaULmT5OjWPUQkjLegvXdY+deb3QoqPgTGeHW0cc6WiXDshjNSWraZnjjgSAcvyrS5639gWu+S9FrR+eM64deetFhHiN5re00oi9VxJDyEXpKzlBkim+LaeFwVRJHSLJetCw7Q2o5g/eqYiMhcETloa1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/F8kzYq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156852; x=1771692852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmG5AJg763QuUwHiI4zIJ8TFRtKX3Nej46Hu42LYCJw=;
  b=O/F8kzYqq9XbXFFt3Ccs1jdkG4RtvICVg1XegpzpnOclN5xlqs5ylJM7
   8UudnIVHSJZdM4zL2Ax0NBAnGvMoDMFKObVxNgjRN4IY6MHkLcsHGaDc5
   vSJnnTrgah+j5X8R3e1sQuZNw7ku5xyeFAf5s03UQzKzbxHnG+Sk4obdr
   vZs65VIz4YX5U9bkn46jBFVY7YQF2K88NRtUMLHa3N8IdGzj4ZO4mk+L7
   ys5LFmlyP89iSSLodiVRaCPqID+yCkdinLVR+fTOcRPy9ygf63SCY7wCQ
   XTrIDyJhQVwxFPCSLty0BRZaQ9UCil/FwJwpeNWz/oTiBXmDsL4ME3bqc
   w==;
X-CSE-ConnectionGUID: rU8n5a0kR7eQAcUgjx+xwg==
X-CSE-MsgGUID: W4fVIq/GSsieKJUZoZkx1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186900"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186900"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:11 -0800
X-CSE-ConnectionGUID: uFLbQYDzRbG6Tl+ZCmuyVw==
X-CSE-MsgGUID: Y7pxkfbeRduvsFwmi9IGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540628"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:07 -0800
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
Subject: [PATCH v1 06/13] ASoC: uniphier: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:26 +0530
Message-Id: <20250221165333.2780888-7-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/uniphier/aio-cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 470f129166a4..3224c11a527f 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -762,14 +762,10 @@ int uniphier_aio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip->num_plls = chip->chip_spec->num_plls;
-	chip->plls = devm_kcalloc(dev,
-				  chip->num_plls,
-				  sizeof(struct uniphier_aio_pll),
-				  GFP_KERNEL);
+	chip->plls = devm_kmemdup_array(dev, chip->chip_spec->plls, chip->num_plls,
+					sizeof(*chip->chip_spec->plls), GFP_KERNEL);
 	if (!chip->plls)
 		return -ENOMEM;
-	memcpy(chip->plls, chip->chip_spec->plls,
-	       sizeof(struct uniphier_aio_pll) * chip->num_plls);
 
 	for (i = 0; i < chip->num_aios; i++) {
 		struct uniphier_aio *aio = &chip->aios[i];
-- 
2.34.1


